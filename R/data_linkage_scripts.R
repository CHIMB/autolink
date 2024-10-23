# Define the abstract class (interface)
LinkageMethod <- R6::R6Class("LinkageMethod",
                             public = list(
                               run_iteration = function(left_dataset, right_dataset, linkage_metadata_db, iteration_id, algorithm_id, extra_parameters) {
                                 stop("This is an abstract method and should be implemented by a subclass.")
                               }
                             )
)

# Default package linkage class.
Reclin2Linkage <- R6::R6Class("Reclin2Linkage",
                              inherit = LinkageMethod,
  public = list(
    run_iteration = function(left_dataset, right_dataset, linkage_metadata_db, iteration_id, algorithm_id, extra_parameters) {
      # Get the linkage technique to determine whether this is a deterministic or probabilistic pass
      linkage_technique <- get_linkage_technique(linkage_metadata_db, iteration_id)
      if (linkage_technique == "P") {
        # We are running a probabilistic pass of this linkage algorithm using the 'reclin2' package

        # Capture the number of records going into this pass. This will serve as the denominator for the pass-wise linkage rate
        linkage_rate_denominator <- nrow(left_dataset)

        # Get the blocking keys
        blocking_keys_df <- get_blocking_keys(linkage_metadata_db, iteration_id)

        # Get the matching keys
        matching_keys_df <- get_matching_keys(linkage_metadata_db, iteration_id)

        # Rename the fields of our blocking keys so that they match in both datasets
        for(row_num in 1:nrow(blocking_keys_df)){
          # Get the current row
          row <- blocking_keys_df[row_num,]

          # Get the left dataset field name (what we'll be renaming to)
          left_dataset_field_name <- row$left_dataset_field

          # Get the right dataset field name (what's being renamed)
          right_dataset_field_name <- row$right_dataset_field

          # Rename the right dataset field to match the field it's going to be matching with
          names(right_dataset)[names(right_dataset) == right_dataset_field_name] <- left_dataset_field_name
        }

        # Rename the fields of our matching keys so that they match in both datasets
        for(row_num in 1:nrow(matching_keys_df)){
          # Get the current row
          row <- matching_keys_df[row_num,]

          # Get the left dataset field name (what we'll be renaming to)
          left_dataset_field_name <- row$left_dataset_field

          # Get the right dataset field name (what's being renamed)
          right_dataset_field_name <- row$right_dataset_field

          # Rename the right dataset field to match the field it's going to be matching with
          names(right_dataset)[names(right_dataset) == right_dataset_field_name] <- left_dataset_field_name
        }

        # Go through the blocking variables, applying the linkage rules to each,
        # and storing the columns we'll be using to block on
        blocking_keys <- c() # Holds the blocking keys

        # Integer variance keys wont be put into the blocking keys vector immediately
        # as due to the error variance, we're allowing for many pair combinations
        integer_variance_keys <- list()
        for(row_num in 1:nrow(blocking_keys_df)){
          # Get the current row
          row <- blocking_keys_df[row_num,]

          # Get the linkage rules for the current row
          linkage_rules_json <- row$linkage_rules

          # Make sure linkage rules aren't NA
          if(!is.na(linkage_rules_json)){
            # Convert the linkage rules from JSON to R readable.
            linkage_rules <- jsonlite::fromJSON(linkage_rules_json)

            # One of our linkage rules is to select an alternative field value from a blocking field
            if("alternate_field_value" %in% names(linkage_rules)){
              # Get the field we are blocking on
              dataset_field <- row$left_dataset_field

              # Get the number of splits we expect to do
              num_of_splits <- linkage_rules$alternate_field_value

              # Create some vectors for storing the split name fields (left and right)
              name_split_left <- vector("list", num_of_splits + 1)
              name_split_left[[1]] <- left_dataset[[dataset_field]]
              name_split_right <- vector("list", num_of_splits + 1)
              name_split_right[[1]] <- right_dataset[[dataset_field]]

              # Loop until we reach the split field we want
              for(split_num in 1:num_of_splits){
                # Clean up by trimming white space
                name_split_left[[split_num]] <- trimws(name_split_left[[split_num]], "both")

                # Split the name in half and store the results
                split <- str_split_fixed(name_split_left[[split_num]], ' ', n = 2)
                name_split_left[[split_num]] <- split[,1]
                name_split_left[[split_num+1]] <- split[,2]

                # Clean up by trimming white space
                name_split_right[[split_num]] <- trimws(name_split_right[[split_num]], "both")

                # Split the name in half and store the results
                split <- str_split_fixed(name_split_right[[split_num]], ' ', n = 2)
                name_split_right[[split_num]] <- split[,1]
                name_split_right[[split_num+1]] <- split[,2]
              }

              # After we finish splitting, return the LAST value since we split
              alternate_field_left  <- name_split_left[[num_of_splits]]
              alternate_field_right <- name_split_right[[num_of_splits]]

              # Put the alternate values back into the datasets
              left_dataset[[dataset_field]] <- alternate_field_left
              right_dataset[[dataset_field]] <- alternate_field_right

              # Clean up after ourselves
              rm(name_split_left)
              rm(name_split_right)
              gc()

              # Add to our list of blocking keys
              blocking_keys <- append(blocking_keys, dataset_field)
            }

            # Another linkage rules is to allow for slight error in date field records
            if("integer_value_variance" %in% names(linkage_rules)){
              # Get the variance value to know how many possibilities to consider
              integer_variance <- linkage_rules$integer_value_variance

              # Get the field we will be adding and subtracting from
              dataset_field <- row$left_dataset_field

              # Dynamically create a vector called "variance_field_names_" + dataset_field.
              variance_vector_name <- paste0("variance_field_names_", dataset_field)

              # We can add it to the list of pairs by doing
              integer_variance_keys[[variance_vector_name]] <- c()

              # Add the original integer value to the list
              integer_variance_keys[[variance_vector_name]][1] <- dataset_field

              # Run a loop as many times as the "integer_variance" value
              for(curr_num in 1:integer_variance){
                # Start by getting the dataset field we're taking the variance of
                dataset_values <- left_dataset[[dataset_field]]

                # Deal with the minus values first
                minus_col_name <- paste0(dataset_field, "_minus_", curr_num)
                minus_vals <- ifelse(dataset_values - curr_num >= 1,
                                     dataset_values - curr_num, dataset_values)

                # Now get the plus values after
                plus_col_name <- paste0(dataset_field, "_plus_", curr_num)
                plus_vals <- ifelse(dataset_values + curr_num <= 31,
                                    dataset_values + curr_num, dataset_values)

                # Add the minus vals as a new column to the left dataset
                left_dataset[[minus_col_name]] <- minus_vals

                # Add the plus vals as a new column to the left dataset
                left_dataset[[plus_col_name]] <- plus_vals

                # To make sure blocking behaves properly, we'll also duplicate the values of the right dataset
                right_dataset[[minus_col_name]] <- right_dataset[[dataset_field]]
                right_dataset[[plus_col_name]]  <- right_dataset[[dataset_field]]

                # Add both column names to the list we're storing
                next_index <- length(integer_variance_keys[[variance_vector_name]]) + 1
                integer_variance_keys[[variance_vector_name]][next_index]   <- minus_col_name
                integer_variance_keys[[variance_vector_name]][next_index+1] <- plus_col_name

              }
            }

            # Linkage rule to substring things like names to be initials, first 5 characters, etc
            if("substring_length" %in% names(linkage_rules)){
              # Get the field(s) we'll be taking a substring of
              dataset_field <- row$left_dataset_field

              # Get the end index (length of substring we're taking)
              end_index <- linkage_rules$substring_length

              # Substring both datasets to contain the characters indexed from 1 -> end_index
              left_dataset[[dataset_field]] <- stringr::str_sub(left_dataset[[dataset_field]], 1, end_index)
              right_dataset[[dataset_field]] <- stringr::str_sub(right_dataset[[dataset_field]], 1, end_index)

              # Store this field name as one of our blocking fields
              blocking_keys <- append(blocking_keys, dataset_field)
            }

            # The last linkage rule for standardizing names to use the most common spelling of that name
            if("standardize_names" %in% names(linkage_rules)){
              # Get the field(s) we'll be standardizing
              dataset_field <- row$left_dataset_field

              # Get the standardized name for both datasets by calling the helper function
              standardized_names_left <- ifelse(!is.na(get_standardized_names(linkage_metadata_db, iteration_id, left_dataset[[dataset_field]])),
                                                get_standardized_names(linkage_metadata_db, iteration_id, left_dataset[[dataset_field]]), left_dataset[[dataset_field]])
              standardized_names_right <- ifelse(!is.na(get_standardized_names(linkage_metadata_db, iteration_id, right_dataset[[dataset_field]])),
                                                 get_standardized_names(linkage_metadata_db, iteration_id, right_dataset[[dataset_field]]), right_dataset[[dataset_field]])

              # Place the standardized names back into the dataset
              left_dataset[[dataset_field]] <- standardized_names_left
              right_dataset[[dataset_field]] <- standardized_names_right

              # Store this field name as one of our blocking fields
              blocking_keys <- append(blocking_keys, dataset_field)
            }
          }
          else{
            # Otherwise, just keep note of this field being a blocking field
            blocking_keys <- append(blocking_keys, row$left_dataset_field)
          }
        }

        # Now, we'll make a list of all the pairs of blocking keys we'd like to try
        blocking_keys_pairs <- list()

        # Now we'll add vectors to this list which are all possible pairs to block on
        if(length(integer_variance_keys) > 0){
          # Get the data frame of all combinations by calling "expand.grid()" on the columns
          integer_variance_combinations_df <- expand.grid(integer_variance_keys)

          # For each combination, we'll create a new vector of blocking keys, and keep a list of them
          for(row_num in 1:nrow(integer_variance_combinations_df)){
            # Get the current row as a vector
            variance_fields <- as.vector(unname(unlist(integer_variance_combinations_df[row_num,])))

            # Create a new pair
            blocking_pair <- append(blocking_keys, variance_fields)

            # Save the pair to our list of blocking pairs
            blocking_keys_pairs[[paste0("blocking_pair_", row_num)]] <- blocking_pair

            # Clean up
            rm(blocking_pair)
            gc()
          }
        }
        else{
          # Save the pair to our list of blocking pairs
          blocking_keys_pairs[["blocking_pair_1"]] <- blocking_keys
        }

        #----------------------------------------------------------------------#

        # Now that we have all the blocking and matching keys, we'll get
        # started on the pairs, beginning with blocking keys

        #-- STEP 1: GENERATE PAIRS --#
        # Block on our first pair of keys, and if we have any more, then bind the rest
        linkage_pairs <- pair_blocking(left_dataset, right_dataset, on = blocking_keys_pairs[[1]])

        # If there are more than 1 pair of keys, bind the rest
        if (length(blocking_keys_pairs) > 1) {
          # Loop through the remaining pairs starting from the second one
          for (i in 2:length(blocking_keys_pairs)) {
            blocking_keys <- blocking_keys_pairs[[i]]

            # Use the reclin2 pair_blocking function
            curr_blocking_pair <- pair_blocking(left_dataset, right_dataset, on = blocking_keys)

            # Bind the new pair to the existing pairs
            linkage_pairs <- rbind(linkage_pairs, curr_blocking_pair)

            # Clean up
            rm(curr_blocking_pair)
            gc()
          }
        }
        #----------------------------#

        #-- STEP 2: COMPARE PAIRS --#
        # For the matching keys, we'll move everything into a vector, and keep track of all the comparison rules
        matching_keys <- c()
        comparison_rules_list <- list()
        for(row_num in 1:nrow(matching_keys_df)){
          # Get the current row
          row <- matching_keys_df[row_num,]

          # Get the linkage rules for the current row
          linkage_rules_json <- row$linkage_rules

          # Make sure linkage rules aren't NA
          if(!is.na(linkage_rules_json)){
            # Convert the linkage rules from JSON to R readable.
            linkage_rules <- jsonlite::fromJSON(linkage_rules_json)

            # One of our linkage rules is to select an alternative field value from a blocking field
            if("alternate_field_value" %in% names(linkage_rules)){
              # Get the field we are blocking on
              dataset_field <- row$left_dataset_field

              # Get the number of splits we expect to do
              num_of_splits <- linkage_rules$alternate_field_value

              # Create some vectors for storing the split name fields (left and right)
              name_split_left <- vector("list", num_of_splits + 1)
              name_split_left[[1]] <- left_dataset[[dataset_field]]
              name_split_right <- vector("list", num_of_splits + 1)
              name_split_right[[1]] <- right_dataset[[dataset_field]]

              # Loop until we reach the split field we want
              for(split_num in 1:num_of_splits){
                # Clean up by trimming white space
                name_split_left[[split_num]] <- trimws(name_split_left[[split_num]], "both")

                # Split the name in half and store the results
                split <- str_split_fixed(name_split_left[[split_num]], ' ', n = 2)
                name_split_left[[split_num]] <- split[,1]
                name_split_left[[split_num+1]] <- split[,2]

                # Clean up by trimming white space
                name_split_right[[split_num]] <- trimws(name_split_right[[split_num]], "both")

                # Split the name in half and store the results
                split <- str_split_fixed(name_split_right[[split_num]], ' ', n = 2)
                name_split_right[[split_num]] <- split[,1]
                name_split_right[[split_num+1]] <- split[,2]
              }

              # After we finish splitting, return the LAST value since we split
              alternate_field_left  <- name_split_left[[num_of_splits]]
              alternate_field_right <- name_split_right[[num_of_splits]]

              # Put the alternate values back into the datasets
              left_dataset[[dataset_field]] <- alternate_field_left
              right_dataset[[dataset_field]] <- alternate_field_right

              # Clean up after ourselves
              rm(name_split_left)
              rm(name_split_right)
              gc()

              # Store this field name as one of our matching fields
              matching_keys <- append(matching_keys, dataset_field)
            }

            # Linkage rule to substring things like names to be initials, first 5 characters, etc
            if("substring_length" %in% names(linkage_rules)){
              # Get the field(s) we'll be taking a substring of
              dataset_field <- row$left_dataset_field

              # Get the end index (length of substring we're taking)
              end_index <- linkage_rules$substring_length

              # Substring both datasets to contain the characters indexed from 1 -> end_index
              left_dataset[[dataset_field]] <- stringr::str_sub(left_dataset[[dataset_field]], 1, end_index)
              right_dataset[[dataset_field]] <- stringr::str_sub(right_dataset[[dataset_field]], 1, end_index)

              # Store this field name as one of our matching fields
              matching_keys <- append(matching_keys, dataset_field)
            }

            # The last linkage rule for standardizing names to use the most common spelling of that name
            if("standardize_names" %in% names(linkage_rules)){
              # Get the field(s) we'll be standardizing
              dataset_field <- row$left_dataset_field

              # Get the standardized name for both datasets by calling the helper function
              standardized_names_left <- ifelse(!is.na(get_standardized_names(linkage_metadata_db, iteration_id, left_dataset[[dataset_field]])),
                                                get_standardized_names(linkage_metadata_db, iteration_id, left_dataset[[dataset_field]]), left_dataset[[dataset_field]])
              standardized_names_right <- ifelse(!is.na(get_standardized_names(linkage_metadata_db, iteration_id, right_dataset[[dataset_field]])),
                                                 get_standardized_names(linkage_metadata_db, iteration_id, right_dataset[[dataset_field]]), right_dataset[[dataset_field]])

              # Place the standardized names back into the dataset
              left_dataset[[dataset_field]] <- standardized_names_left
              right_dataset[[dataset_field]] <- standardized_names_right

              # Store this field name as one of our matching fields
              matching_keys <- append(matching_keys, dataset_field)
            }
          }
          else{
            # Otherwise, just keep note of this field being a matching field
            matching_keys <- append(matching_keys, row$left_dataset_field)
          }

          # Get the comparison rules for the current row
          comparison_rules_json <- row$comparison_rules

          # Make sure the linkage rules aren't NA
          if(!is.na(comparison_rules_json)){
            comparison_rules <- jsonlite::fromJSON(comparison_rules_json)

            # Get the field we'll apply the comparison rules to
            dataset_field <- row$left_dataset_field

            # Based on the comparison rule, map it to the appropriate function
            if("jw_score" %in% names(comparison_rules)){
              # "jw_score" uses the Reclin2 cmp_jarowinkler function, so get the value
              threshold <- comparison_rules[["jw_score"]]

              # Keep track of this comparison rule
              # (NOT SURE IF THIS WORKS YET, IF NOT, TRY SOMETHING SIMILAR TO as.formula()?)
              comparison_rules_list[[dataset_field]] <- reclin2::cmp_jarowinkler(threshold)
            }
            else if ("numeric_tolerance" %in% names(comparison_rules)){
              # custom "error tolerance" function
              numeric_error_tolerance <- function(tolerance){
                function(x , y){
                  if(!missing(x) && !missing(y)){
                    return(abs(x - y) <= tolerance)
                  }
                  else{
                    return(FALSE)
                  }
                }
              }

              # Get the tolerance value
              tolerance <- comparison_rules[["numeric_tolerance"]]

              # Keep track of this comparison rule
              comparison_rules_list[[dataset_field]] <- numeric_error_tolerance(tolerance)
            }
          }
        }

        # Now, we'll move onto the matching keys, using the compare_pairs() function from reclin2
        if(length(comparison_rules_list) > 0){
          compare_pairs(linkage_pairs, on = matching_keys,
                        comparators = comparison_rules_list, inplace=TRUE)
        }
        else{
          compare_pairs(linkage_pairs, on = matching_keys,
                        inplace=TRUE)
        }
        #---------------------------#

        #-- STEP 3: SCORE PAIRS --#
        # Before running an EM algorithm, we'll start by creating a formula for it
        linkage_formula <- as.formula(paste("~", paste(matching_keys, collapse = " + ")))

        # After compare_pairs(), we'll run an EM algorithm on the linkage pairs
        em_pairs <- suppressWarnings(problink_em(linkage_formula, data = linkage_pairs))

        # Afterwards, we'll score the pair using type = "all" to get all score types
        linkage_pairs <- predict(em_pairs, pairs = linkage_pairs, type = "all", add = TRUE)
        #-------------------------#

        #-- STEP 4: SELECT PAIRS --#
        # Would we like to grab the ground truth variables and see if they match for the algorithm?
        # # Attach a variable showing if R PHIN matches SAMIN PHIN
        # pairs <- compare_vars(pairs, "truth", on_x = "id", on_y = "id")
        # table(pairs$truth, pairs$threshold)

        # Get the acceptance threshold for this iteration
        acceptance_threshold <- get_acceptence_thresholds(linkage_metadata_db, iteration_id)

        # Select pairs using the user defined acceptance thresholds
        if("posterior_threshold" %in% names(acceptance_threshold)){
          posterior_threshold <- acceptance_threshold[["posterior_threshold"]]
          # Filter out rows with NA in 'mpost'
          linkage_pairs <- linkage_pairs[!is.na(linkage_pairs$mpost), ]
          select_greedy(linkage_pairs, variable = "selected", score = "mpost", threshold = posterior_threshold, include_ties = TRUE, inplace = TRUE)
          #select_threshold(linkage_pairs, variable = "selected", score = "mpost", threshold = posterior_threshold, include_ties = TRUE, inplace = TRUE) #IF WE WANT DUPES
        }else if ("match_weight" %in% names(acceptance_threshold)){
          linkage_weight <- acceptance_threshold[["match_weight"]]
          select_greedy(linkage_pairs, variable = "selected", score = "weight", threshold = linkage_weight, include_ties = TRUE, inplace = TRUE)
          #select_threshold(linkage_pairs, variable = "selected", score = "weight", threshold = linkage_weight, include_ties = TRUE, inplace = TRUE) #IF WE WANT DUPES
        }
        else{
          # Create a list of plots and captions that we'll return
          plot_list <- list()
          plot_caps_list <- c()

          # Get the pass name
          iteration_name <- get_iteration_name(linkage_metadata_db, iteration_id)

          # Create the first plot of all candidate pair records
          candidate_weights_plot <- ggplot(linkage_pairs, mapping = aes(weight)) +
            geom_histogram(binwidth = 0.05, fill = "gray", colour = "black") +
            labs(x = "Weight", y = "Frequency") +
            theme_minimal(base_size = 8) +
            # Set the entire background white with a black border
            theme(
              plot.background = element_rect(fill = "white", color = "black", size = 1),
              panel.background = element_rect(fill = "white", color = "black"),
              panel.grid = element_blank(), # Remove gridlines
              axis.line = element_line(color = "black"), # Black axis lines
              axis.ticks = element_line(color = "black"),
              legend.background = element_rect(fill = "white", color = "black"),
              legend.position = "bottom"
            )
          algorithm_name <- get_algorithm_name(linkage_metadata_db, algorithm_id)
          iteration_name <- get_iteration_name(linkage_metadata_db, iteration_id)
          plot_list[["candidate_weights_plot"]] <- candidate_weights_plot
          caption <- paste0("Weight distribution of ", trimws(iteration_name), "'s unlinked pairs for ", algorithm_name, ".")
          plot_caps_list <- append(plot_caps_list, caption)

          # Create the second plot of the subset of candidate pair records (IF GROUND TRUTH IS PROVIDED)
          ground_truth_df <- get_ground_truth_fields(linkage_metadata_db, algorithm_id)
          if(nrow(ground_truth_df) > 0){
            # Rename the fields of our ground truth keys so that they match in both datasets
            for(row_num in 1:nrow(ground_truth_df)){
              # Get the current row
              row <- ground_truth_df[row_num,]

              # Get the left dataset field name (what we'll be renaming to)
              left_dataset_field_name <- row$left_dataset_field

              # Get the right dataset field name (what's being renamed)
              right_dataset_field_name <- row$right_dataset_field

              # Rename the right dataset field to match the field it's going to be matching with
              names(right_dataset)[names(right_dataset) == right_dataset_field_name] <- left_dataset_field_name
            }

            # Get the left fields
            left_ground_truth_fields <- ground_truth_df$left_dataset_field

            # Get the right fields
            right_ground_truth_fields <- ground_truth_df$right_dataset_field

            # Compare variables to get the truth
            linkage_pairs <- compare_vars(linkage_pairs, variable = "truth", on_x = left_ground_truth_fields, on_y = right_ground_truth_fields)

            # Filter out pairs with missing ground truth
            linkage_pairs_non_missing <- linkage_pairs[!is.na(linkage_pairs$truth),] # Works for now, more testing should be done

            # Add a "Match Type" column to identify what we color the plot as
            linkage_pairs_non_missing$match_type <- ifelse(linkage_pairs_non_missing$truth == TRUE, "Match", "Miss")

            # Create the histogram, coloring based on match type
            candidate_weights_plot_gt <- ggplot(linkage_pairs_non_missing, aes(x = weight, fill = match_type)) +
              geom_histogram(binwidth = 0.05, position = "stack", alpha = 0.8) +
              scale_fill_manual(values = c("Miss" = "red", "Match" = "blue"), name = "Selection Status") +
              labs(x = "Weight", y = "Frequency") +
              theme_minimal(base_size = 8) +
              # Set the entire background white with a black border
              theme(
                plot.background = element_rect(fill = "white", color = "black", size = 1),
                panel.background = element_rect(fill = "white", color = "black"),
                panel.grid = element_blank(), # Remove gridlines
                axis.line = element_line(color = "black"), # Black axis lines
                axis.ticks = element_line(color = "black"),
                legend.background = element_rect(fill = "white", color = "black"),
                legend.position = "bottom"
              )
            algorithm_name <- get_algorithm_name(linkage_metadata_db, algorithm_id)
            iteration_name <- get_iteration_name(linkage_metadata_db, iteration_id)
            ground_truth_fields <- paste(get_ground_truth_fields(linkage_metadata_db, algorithm_id)$left_dataset_field, collapse = ", ")
            caption <- paste0("Weight distribution of ", trimws(iteration_name), "'s unlinked pairs for ", algorithm_name, " with the coloured ",
                               "matching and non-matching ground truth fields (", ground_truth_fields, ").")
            plot_list[["candidate_weights_plot_ground_truth"]] <- candidate_weights_plot_gt
            plot_caps_list <- append(plot_caps_list, caption)
          }

          # Create a list of return parameters
          return_list <- list()

          ### Get the linked indices
          return_list[["linked_indices"]] <- NA

          ### Returned the greedy select dataset
          return_list[["unlinked_dataset_pairs"]] <- linkage_pairs

          ### Returned the plot list
          return_list[["threshold_plots"]] <- plot_list

          ### Returned the plot captions
          return_list[["plot_captions"]] <- plot_caps_list
          return(return_list)
        }

        # Now, if a ground truth is provided get the ground truth variables to calculate specificity later on
        ground_truth_df <- get_ground_truth_fields(linkage_metadata_db, algorithm_id)
        has_ground_truth <- FALSE
        if(nrow(ground_truth_df) > 0){
          has_ground_truth <- TRUE
          # Rename the fields of our ground truth keys so that they match in both datasets
          for(row_num in 1:nrow(ground_truth_df)){
            # Get the current row
            row <- ground_truth_df[row_num,]

            # Get the left dataset field name (what we'll be renaming to)
            left_dataset_field_name <- row$left_dataset_field

            # Get the right dataset field name (what's being renamed)
            right_dataset_field_name <- row$right_dataset_field

            # Rename the right dataset field to match the field it's going to be matching with
            names(right_dataset)[names(right_dataset) == right_dataset_field_name] <- left_dataset_field_name
          }

          # Get the left fields
          left_ground_truth_fields <- ground_truth_df$left_dataset_field

          # Get the right fields
          right_ground_truth_fields <- ground_truth_df$right_dataset_field

          # Compare variables to get the truth
          linkage_pairs <- compare_vars(linkage_pairs, variable = "truth", on_x = left_ground_truth_fields, on_y = right_ground_truth_fields)
        }
        #--------------------------#

        #-- STEP 5: LINK THE PAIRS --#
        # Call the link() function to finally get our linked dataset
        linked_dataset <- link(linkage_pairs, selection = "selected", keep_from_pairs = c(".x", ".y", "weight", "mpost"))

        # Attach the linkage name/pass name to the records for easier identification later
        stage_name <- get_iteration_name(linkage_metadata_db, iteration_id)
        linked_dataset <- cbind(linked_dataset, stage=stage_name)
        #----------------------------#

        #-- STEP 6: RETURN VALUES --#
        # Create a list of all the data we will be returning
        return_list <- list()

        # Create a list for plots and captions
        plot_list <- list()
        plot_caps_list <- c()

        ### Get the linked indices
        linked_indices <- linked_dataset$.x
        return_list[["linked_indices"]] <- linked_indices

        ### Returned the greedy select dataset
        return_list[["unlinked_dataset_pairs"]] <- linkage_pairs

        ### Return specificity variables if ground truth was provided
        if(has_ground_truth){
          # Create the specificity table
          specificity_table <- table(linkage_pairs$truth, linkage_pairs$selected)

          # Extract TP, TN, FP, FN
          TP <- specificity_table["TRUE", "TRUE"]  # True Positives
          TN <- specificity_table["FALSE", "FALSE"]  # True Negatives
          FP <- specificity_table["FALSE", "TRUE"]  # False Positives
          FN <- specificity_table["TRUE", "FALSE"]  # False Negatives

          # Create a named vector
          results_vector <- c(TP = TP, TN = TN, FP = FP, FN = FN)

          # Store the results vector
          return_list[["performance_measure_variables"]] <- results_vector
        }

        ### Return the unmodified linked dataset
        return_list[["linked_dataset"]] <- linked_dataset

        ### Create the data frame of the fields to be returned
        output_fields <- get_linkage_output_fields(linkage_metadata_db, algorithm_id)

        # Create a vector of field names with '.x' suffix to retain
        fields_to_keep <- paste0(output_fields$field_name, ".x")

        # Append the stage to keep
        fields_to_keep <- append(fields_to_keep, "stage")

        # Select only those columns from linked_dataset that match the fields_to_keep
        filtered_data <- linked_dataset %>% select(all_of(fields_to_keep))

        # Rename the fields with suffix '.x' to have it removed.
        filtered_data <- filtered_data %>% rename_with(~ gsub("\\.x$", "", .), ends_with(".x"))

        # Store the filtered data for return
        return_list[["output_linkage_df"]] <- filtered_data

        ### Plot the decision boundary and performance results
        # Get the pass name
        iteration_name <- get_iteration_name(linkage_metadata_db, iteration_id)

        # Use mutate to create a factor variable with custom labels for 'selected'
        linkage_pairs <- linkage_pairs %>%
          mutate(selected_label = factor(selected, levels = c(FALSE, TRUE), labels = c("Miss", "Match")))

        #-- Visualize histogram after threshold is applied --#

        # Get the acceptance threshold
        acceptance_threshold <- get_acceptence_thresholds(linkage_metadata_db, iteration_id)

        # Get the acceptance threshold value
        if("posterior_threshold" %in% names(acceptance_threshold)){
          acceptance_threshold <- acceptance_threshold[["posterior_threshold"]]
          # Create a histogram of the posterior thresholds with the decision boundary
          decision_boundary <- ggplot(linkage_pairs, aes(x = mpost, fill = selected_label)) +
            geom_histogram(binwidth = 0.05, position = "stack", alpha = 0.8) +
            scale_fill_manual(values = c("Miss" = "red", "Match" = "blue"), name = "Selection Status") +
            labs(x = "Weight", y = "Frequency") +
            geom_vline(aes(xintercept = acceptance_threshold, linetype = "Acceptance Threshold"),
                       color = "black", size = 0.6) +
            scale_linetype_manual(values = c("Acceptance Threshold" = "dashed"), name = "") +
            guides(linetype = guide_legend(override.aes = list(size = 0.5))) +  # Adjust line size in legend
            theme_minimal(base_size = 8) +
            # Set the entire background white with a black border
            theme(
              plot.background = element_rect(fill = "white", color = "black", size = 1),
              panel.background = element_rect(fill = "white", color = "black"),
              panel.grid = element_blank(), # Remove gridlines
              axis.line = element_line(color = "black"), # Black axis lines
              axis.ticks = element_line(color = "black"),
              legend.background = element_rect(fill = "white", color = "black"),
              legend.position = "bottom"
            )
          algorithm_name <- get_algorithm_name(linkage_metadata_db, algorithm_id)
          ground_truth_fields <- paste(get_ground_truth_fields(linkage_metadata_db, algorithm_id)$left_dataset_field, collapse = ", ")
          caption <- paste0("Posterior distribution of ", trimws(iteration_name), "'s linked pairs for ", algorithm_name, " with the selected posterior acceptance threshold",
                            " of ", acceptance_threshold, ".")
          plot_list[["decision_boundary_plot"]] <- decision_boundary
          plot_caps_list <- append(plot_caps_list, caption)

          ### Return the plot list
          return_list[["threshold_plots"]] <- plot_list

          ### Returned the plot captions
          return_list[["plot_captions"]] <- plot_caps_list
        }
        else if ("match_weight" %in% names(acceptance_threshold)){
          acceptance_threshold <- acceptance_threshold[["match_weight"]]
          # Create a histogram of the weights with the decision boundary
          decision_boundary <- ggplot(linkage_pairs, aes(x = weight, fill = selected_label)) +
            geom_histogram(binwidth = 0.05, position = "stack", alpha = 0.8) +
            scale_fill_manual(values = c("Miss" = "red", "Match" = "blue"), name = "Selection Status") +
            labs(x = "Weight", y = "Frequency") +
            geom_vline(aes(xintercept = acceptance_threshold, linetype = "Acceptance Threshold"),
                       color = "black", size = 0.6) +
            scale_linetype_manual(values = c("Acceptance Threshold" = "dashed"), name = "") +
            guides(linetype = guide_legend(override.aes = list(size = 0.5))) +  # Adjust line size in legend
            theme_minimal(base_size = 8) +
            # Set the entire background white with a black border
            theme(
              plot.background = element_rect(fill = "white", color = "black", size = 1),
              panel.background = element_rect(fill = "white", color = "black"),
              panel.grid = element_blank(), # Remove gridlines
              axis.line = element_line(color = "black"), # Black axis lines
              axis.ticks = element_line(color = "black"),
              legend.background = element_rect(fill = "white", color = "black"),
              legend.position = "bottom"
            )
          algorithm_name <- get_algorithm_name(linkage_metadata_db, algorithm_id)
          ground_truth_fields <- paste(get_ground_truth_fields(linkage_metadata_db, algorithm_id)$left_dataset_field, collapse = ", ")
          caption <- paste0("Weight distribution of ", trimws(iteration_name), "'s linked pairs for ", algorithm_name, " with the selected weight acceptance threshold",
                            " of ", acceptance_threshold, ".")
          plot_list[["decision_boundary_plot"]] <- decision_boundary
          plot_caps_list <- append(plot_caps_list, caption)

          ### Return the plot list
          return_list[["threshold_plots"]] <- plot_list

          ### Returned the plot captions
          return_list[["plot_captions"]] <- plot_caps_list
        }

        ### Return our list of return values
        return(return_list)
        #--------------------------#


      } else if (linkage_technique == "D") {
        # We are running a deterministic pass of this linkage algorithm using the 'reclin2' package

        # Capture the number of records going into this pass. This will serve as the denominator for the pass-wise linkage rate
        linkage_rate_denominator <- nrow(left_dataset)

        # Get the blocking keys
        blocking_keys_df <- get_blocking_keys(linkage_metadata_db, iteration_id)

        # Get the matching keys
        matching_keys_df <- get_matching_keys(linkage_metadata_db, iteration_id)

        # Rename the fields of our blocking keys so that they match in both datasets
        for(row_num in 1:nrow(blocking_keys_df)){
          # Get the current row
          row <- blocking_keys_df[row_num,]

          # Get the left dataset field name (what we'll be renaming to)
          left_dataset_field_name <- row$left_dataset_field

          # Get the right dataset field name (what's being renamed)
          right_dataset_field_name <- row$right_dataset_field

          # Rename the right dataset field to match the field it's going to be matching with
          names(right_dataset)[names(right_dataset) == right_dataset_field_name] <- left_dataset_field_name
        }

        # Rename the fields of our matching keys so that they match in both datasets
        for(row_num in 1:nrow(matching_keys_df)){
          # Get the current row
          row <- matching_keys_df[row_num,]

          # Get the left dataset field name (what we'll be renaming to)
          left_dataset_field_name <- row$left_dataset_field

          # Get the right dataset field name (what's being renamed)
          right_dataset_field_name <- row$right_dataset_field

          # Rename the right dataset field to match the field it's going to be matching with
          names(right_dataset)[names(right_dataset) == right_dataset_field_name] <- left_dataset_field_name
        }

        # Go through the blocking variables, applying the linkage rules to each,
        # and storing the columns we'll be using to block on
        blocking_keys <- c() # Holds the blocking keys

        # Integer variance keys wont be put into the blocking keys vector immediately
        # as due to the error variance, we're allowing for many pair combinations
        integer_variance_keys <- list()
        for(row_num in 1:nrow(blocking_keys_df)){
          # Get the current row
          row <- blocking_keys_df[row_num,]

          # Get the linkage rules for the current row
          linkage_rules_json <- row$linkage_rules

          # Make sure linkage rules aren't NA
          if(!is.na(linkage_rules_json)){
            # Convert the linkage rules from JSON to R readable.
            linkage_rules <- jsonlite::fromJSON(linkage_rules_json)

            # One of our linkage rules is to select an alternative field value from a blocking field
            if("alternate_field_value" %in% names(linkage_rules)){
              # Get the field we are blocking on
              dataset_field <- row$left_dataset_field

              # Get the number of splits we expect to do
              num_of_splits <- linkage_rules$alternate_field_value

              # Create some vectors for storing the split name fields (left and right)
              name_split_left <- vector("list", num_of_splits + 1)
              name_split_left[[1]] <- left_dataset[[dataset_field]]
              name_split_right <- vector("list", num_of_splits + 1)
              name_split_right[[1]] <- right_dataset[[dataset_field]]

              # Loop until we reach the split field we want
              for(split_num in 1:num_of_splits){
                # Clean up by trimming white space
                name_split_left[[split_num]] <- trimws(name_split_left[[split_num]], "both")

                # Split the name in half and store the results
                split <- str_split_fixed(name_split_left[[split_num]], ' ', n = 2)
                name_split_left[[split_num]] <- split[,1]
                name_split_left[[split_num+1]] <- split[,2]

                # Clean up by trimming white space
                name_split_right[[split_num]] <- trimws(name_split_right[[split_num]], "both")

                # Split the name in half and store the results
                split <- str_split_fixed(name_split_right[[split_num]], ' ', n = 2)
                name_split_right[[split_num]] <- split[,1]
                name_split_right[[split_num+1]] <- split[,2]
              }

              # After we finish splitting, return the LAST value since we split
              alternate_field_left  <- name_split_left[[num_of_splits]]
              alternate_field_right <- name_split_right[[num_of_splits]]

              # Put the alternate values back into the datasets
              left_dataset[[dataset_field]] <- alternate_field_left
              right_dataset[[dataset_field]] <- alternate_field_right

              # Clean up after ourselves
              rm(name_split_left)
              rm(name_split_right)
              gc()

              # Add to our list of blocking keys
              blocking_keys <- append(blocking_keys, dataset_field)
            }

            # Another linkage rules is to allow for slight error in date field records
            if("integer_value_variance" %in% names(linkage_rules)){
              # Get the variance value to know how many possibilities to consider
              integer_variance <- linkage_rules$integer_value_variance

              # Get the field we will be adding and subtracting from
              dataset_field <- row$left_dataset_field

              # Dynamically create a vector called "variance_field_names_" + dataset_field.
              variance_vector_name <- paste0("variance_field_names_", dataset_field)

              # We can add it to the list of pairs by doing
              integer_variance_keys[[variance_vector_name]] <- c()

              # Add the original integer value to the list
              integer_variance_keys[[variance_vector_name]][1] <- dataset_field

              # Run a loop as many times as the "integer_variance" value
              for(curr_num in 1:integer_variance){
                # Start by getting the dataset field we're taking the variance of
                dataset_values <- left_dataset[[dataset_field]]

                # Deal with the minus values first
                minus_col_name <- paste0(dataset_field, "_minus_", curr_num)
                minus_vals <- ifelse(dataset_values - curr_num >= 1,
                                     dataset_values - curr_num, dataset_values)

                # Now get the plus values after
                plus_col_name <- paste0(dataset_field, "_plus_", curr_num)
                plus_vals <- ifelse(dataset_values + curr_num <= 31,
                                    dataset_values + curr_num, dataset_values)

                # Add the minus vals as a new column to the left dataset
                left_dataset[[minus_col_name]] <- minus_vals

                # Add the plus vals as a new column to the left dataset
                left_dataset[[plus_col_name]] <- plus_vals

                # To make sure blocking behaves properly, we'll also duplicate the values of the right dataset
                right_dataset[[minus_col_name]] <- right_dataset[[dataset_field]]
                right_dataset[[plus_col_name]]  <- right_dataset[[dataset_field]]

                # Add both column names to the list we're storing
                next_index <- length(integer_variance_keys[[variance_vector_name]]) + 1
                integer_variance_keys[[variance_vector_name]][next_index]   <- minus_col_name
                integer_variance_keys[[variance_vector_name]][next_index+1] <- plus_col_name

              }
            }

            # Linkage rule to substring things like names to be initials, first 5 characters, etc
            if("substring_length" %in% names(linkage_rules)){
              # Get the field(s) we'll be taking a substring of
              dataset_field <- row$left_dataset_field

              # Get the end index (length of substring we're taking)
              end_index <- linkage_rules$substring_length

              # Substring both datasets to contain the characters indexed from 1 -> end_index
              left_dataset[[dataset_field]] <- stringr::str_sub(left_dataset[[dataset_field]], 1, end_index)
              right_dataset[[dataset_field]] <- stringr::str_sub(right_dataset[[dataset_field]], 1, end_index)

              # Store this field name as one of our blocking fields
              blocking_keys <- append(blocking_keys, dataset_field)
            }

            # The last linkage rule for standardizing names to use the most common spelling of that name
            if("standardize_names" %in% names(linkage_rules)){
              # Get the field(s) we'll be standardizing
              dataset_field <- row$left_dataset_field

              # Get the standardized name for both datasets by calling the helper function
              standardized_names_left <- ifelse(!is.na(get_standardized_names(linkage_metadata_db, iteration_id, left_dataset[[dataset_field]])),
                                                get_standardized_names(linkage_metadata_db, iteration_id, left_dataset[[dataset_field]]), left_dataset[[dataset_field]])
              standardized_names_right <- ifelse(!is.na(get_standardized_names(linkage_metadata_db, iteration_id, right_dataset[[dataset_field]])),
                                                 get_standardized_names(linkage_metadata_db, iteration_id, right_dataset[[dataset_field]]), right_dataset[[dataset_field]])

              # Place the standardized names back into the dataset
              left_dataset[[dataset_field]] <- standardized_names_left
              right_dataset[[dataset_field]] <- standardized_names_right

              # Store this field name as one of our blocking fields
              blocking_keys <- append(blocking_keys, dataset_field)
            }
          }
          else{
            # Otherwise, just keep note of this field being a blocking field
            blocking_keys <- append(blocking_keys, row$left_dataset_field)
          }
        }

        # Now, we'll make a list of all the pairs of blocking keys we'd like to try
        blocking_keys_pairs <- list()

        # Now we'll add vectors to this list which are all possible pairs to block on
        if(length(integer_variance_keys) > 0){
          # Get the data frame of all combinations by calling "expand.grid()" on the columns
          integer_variance_combinations_df <- expand.grid(integer_variance_keys)

          # For each combination, we'll create a new vector of blocking keys, and keep a list of them
          for(row_num in 1:nrow(integer_variance_combinations_df)){
            # Get the current row as a vector
            variance_fields <- as.vector(unname(unlist(integer_variance_combinations_df[row_num,])))

            # Create a new pair
            blocking_pair <- append(blocking_keys, variance_fields)

            # Save the pair to our list of blocking pairs
            blocking_keys_pairs[[paste0("blocking_pair_", row_num)]] <- blocking_pair

            # Clean up
            rm(blocking_pair)
            gc()
          }
        }
        else{
          # Save the pair to our list of blocking pairs
          blocking_keys_pairs[["blocking_pair_1"]] <- blocking_keys
        }

        #----------------------------------------------------------------------#

        # Now that we have all the blocking and matching keys, we'll get
        # started on the pairs, beginning with blocking keys

        #-- STEP 1: GENERATE PAIRS --#

        # Block on our first pair of keys, and if we have any more, then bind the rest
        linkage_pairs <- pair_blocking(left_dataset, right_dataset, on = blocking_keys_pairs[[1]])

        # If there are more than 1 pair of keys, bind the rest
        if (length(blocking_keys_pairs) > 1) {
          # Loop through the remaining pairs starting from the second one
          for (i in 2:length(blocking_keys_pairs)) {
            blocking_keys <- blocking_keys_pairs[[i]]

            # Use the reclin2 pair_blocking function
            curr_blocking_pair <- pair_blocking(left_dataset, right_dataset, on = blocking_keys)

            # Bind the new pair to the existing pairs
            linkage_pairs <- rbind(linkage_pairs, curr_blocking_pair)

            # Clean up
            rm(curr_blocking_pair)
            gc()
          }
        }
        #----------------------------#

        #-- STEP 2: COMPARE PAIRS --#

        # For the matching keys, we'll move everything into a vector, and keep track of all the comparison rules
        matching_keys <- c()
        comparison_rules_list <- list()
        for(row_num in 1:nrow(matching_keys_df)){
          # Get the current row
          row <- matching_keys_df[row_num,]

          # Get the linkage rules for the current row
          linkage_rules_json <- row$linkage_rules

          # Make sure linkage rules aren't NA
          if(!is.na(linkage_rules_json)){
            # Convert the linkage rules from JSON to R readable.
            linkage_rules <- jsonlite::fromJSON(linkage_rules_json)

            # One of our linkage rules is to select an alternative field value from a blocking field
            if("alternate_field_value" %in% names(linkage_rules)){
              # Get the field we are blocking on
              dataset_field <- row$left_dataset_field

              # Get the number of splits we expect to do
              num_of_splits <- linkage_rules$alternate_field_value

              # Create some vectors for storing the split name fields (left and right)
              name_split_left <- vector("list", num_of_splits + 1)
              name_split_left[[1]] <- left_dataset[[dataset_field]]
              name_split_right <- vector("list", num_of_splits + 1)
              name_split_right[[1]] <- right_dataset[[dataset_field]]

              # Loop until we reach the split field we want
              for(split_num in 1:num_of_splits){
                # Clean up by trimming white space
                name_split_left[[split_num]] <- trimws(name_split_left[[split_num]], "both")

                # Split the name in half and store the results
                split <- str_split_fixed(name_split_left[[split_num]], ' ', n = 2)
                name_split_left[[split_num]] <- split[,1]
                name_split_left[[split_num+1]] <- split[,2]

                # Clean up by trimming white space
                name_split_right[[split_num]] <- trimws(name_split_right[[split_num]], "both")

                # Split the name in half and store the results
                split <- str_split_fixed(name_split_right[[split_num]], ' ', n = 2)
                name_split_right[[split_num]] <- split[,1]
                name_split_right[[split_num+1]] <- split[,2]
              }

              # After we finish splitting, return the LAST value since we split
              alternate_field_left  <- name_split_left[[num_of_splits]]
              alternate_field_right <- name_split_right[[num_of_splits]]

              # Put the alternate values back into the datasets
              left_dataset[[dataset_field]] <- alternate_field_left
              right_dataset[[dataset_field]] <- alternate_field_right

              # Clean up after ourselves
              rm(name_split_left)
              rm(name_split_right)
              gc()

              # Store this field name as one of our matching fields
              matching_keys <- append(matching_keys, dataset_field)
            }

            # Linkage rule to substring things like names to be initials, first 5 characters, etc
            if("substring_length" %in% names(linkage_rules)){
              # Get the field(s) we'll be taking a substring of
              dataset_field <- row$left_dataset_field

              # Get the end index (length of substring we're taking)
              end_index <- linkage_rules$substring_length

              # Substring both datasets to contain the characters indexed from 1 -> end_index
              left_dataset[[dataset_field]] <- stringr::str_sub(left_dataset[[dataset_field]], 1, end_index)
              right_dataset[[dataset_field]] <- stringr::str_sub(right_dataset[[dataset_field]], 1, end_index)

              # Store this field name as one of our matching fields
              matching_keys <- append(matching_keys, dataset_field)
            }

            # The last linkage rule for standardizing names to use the most common spelling of that name
            if("standardize_names" %in% names(linkage_rules)){
              # Get the field(s) we'll be standardizing
              dataset_field <- row$left_dataset_field

              # Get the standardized name for both datasets by calling the helper function
              standardized_names_left <- ifelse(!is.na(get_standardized_names(linkage_metadata_db, iteration_id, left_dataset[[dataset_field]])),
                                                get_standardized_names(linkage_metadata_db, iteration_id, left_dataset[[dataset_field]]), left_dataset[[dataset_field]])
              standardized_names_right <- ifelse(!is.na(get_standardized_names(linkage_metadata_db, iteration_id, right_dataset[[dataset_field]])),
                                                 get_standardized_names(linkage_metadata_db, iteration_id, right_dataset[[dataset_field]]), right_dataset[[dataset_field]])

              # Place the standardized names back into the dataset
              left_dataset[[dataset_field]] <- standardized_names_left
              right_dataset[[dataset_field]] <- standardized_names_right

              # Store this field name as one of our matching fields
              matching_keys <- append(matching_keys, dataset_field)
            }
          }
          else{
            # Otherwise, just keep note of this field being a matching field
            matching_keys <- append(matching_keys, row$left_dataset_field)
          }

          # Get the comparison rules for the current row
          comparison_rules_json <- row$comparison_rules

          # Make sure the linkage rules aren't NA
          if(!is.na(comparison_rules_json)){
            comparison_rules <- jsonlite::fromJSON(comparison_rules_json)

            # Get the field we'll apply the comparison rules to
            dataset_field <- row$left_dataset_field

            # Based on the comparison rule, map it to the appropriate function
            if("jw_score" %in% names(comparison_rules)){
              # "jw_score" uses the Reclin2 cmp_jarowinkler function, so get the value
              threshold <- comparison_rules[["jw_score"]]

              # Keep track of this comparison rule
              # (NOT SURE IF THIS WORKS YET, IF NOT, TRY SOMETHING SIMILAR TO as.formula()?)
              comparison_rules_list[[dataset_field]] <- reclin2::cmp_jarowinkler(threshold)
            }
            else if ("numeric_tolerance" %in% names(comparison_rules)){
              # custom "error tolerance" function
              numeric_error_tolerance <- function(tolerance){
                function(x , y){
                  if(!missing(x) && !missing(y)){
                    return(abs(x - y) <= tolerance)
                  }
                  else{
                    return(FALSE)
                  }
                }
              }

              # Get the tolerance value
              tolerance <- comparison_rules[["numeric_tolerance"]]

              # Keep track of this comparison rule
              comparison_rules_list[[dataset_field]] <- numeric_error_tolerance(tolerance)
            }
          }
        }

        # Now, we'll move onto the matching keys, using the compare_pairs() function from reclin2
        if(length(comparison_rules_list) > 0){
          compare_pairs(linkage_pairs, on = matching_keys,
                        comparators = comparison_rules_list, inplace=TRUE)
        }
        else{
          compare_pairs(linkage_pairs, on = matching_keys, inplace=TRUE)
        }
        #---------------------------#

        #-- STEP 3: SCORE PAIRS --#
        # Since this is a deterministic pass, we'll use the 'score_simple()' function instead
        # of creating an EM algorithm
        #score_simple(linkage_pairs, "score", on = matching_keys, inplace = T) #v1
        score_simple(linkage_pairs, "score", on = matching_keys, w1 = 1, inplace = T) #v2
        #-------------------------#

        #-- STEP 4: SELECT PAIRS --#
        # There is no need for a user defined acceptance rule since it is a deterministic pass
        # which means our threshold for "score" is just 1 (either it links or it doesn't)
        #select_greedy(linkage_pairs, "selected", "score", threshold = 1, include_ties = TRUE, inplace = TRUE) #v1
        select_greedy(linkage_pairs, "selected", "score", threshold = length(matching_keys), include_ties = T, inplace = T) #v2
        #select_threshold(linkage_pairs, variable = "selected", score = "score", threshold = length(matching_keys), include_ties = TRUE, inplace = TRUE) #IF WE WANT DUPES
        #--------------------------#

        #-- STEP 5: LINK THE PAIRS --#
        # Call the link() function to finally get our linked dataset
        linked_dataset <- link(linkage_pairs, selection = "selected", keep_from_pairs = c(".x", ".y", "score"))

        # Attach the linkage name/pass name to the records for easier identification later
        stage_name <- get_iteration_name(linkage_metadata_db, iteration_id)
        linked_dataset <- cbind(linked_dataset, stage=stage_name)
        #----------------------------#

        #-- STEP 6: RETURN VALUES --#
        # Create a list of all the data we will be returning
        return_list <- list()

        ### Get the linked indicies
        linked_indices <- linked_dataset$.x
        return_list[["linked_indices"]] <- linked_indices

        ### Return the unmodified linked dataset
        return_list[["linked_dataset"]] <- linked_dataset

        ### Create the data frame of the fields to be returned
        output_fields <- get_linkage_output_fields(linkage_metadata_db, algorithm_id)

        # Create a vector of field names with '.x' suffix to retain
        fields_to_keep <- paste0(output_fields$field_name, ".x")

        # Create a vector of fields names with '.x' that will be renamed
        fields_to_rename <- fields_to_keep

        # Append the stage to keep
        fields_to_keep <- append(fields_to_keep, "stage")

        # Select only those columns from linked_dataset that match the fields_to_keep
        filtered_data <- linked_dataset %>% select(all_of(fields_to_keep))

        # Rename the fields with suffix '.x' to have it removed.
        filtered_data <- filtered_data %>% rename_with(~ gsub("\\.x$", "", .), ends_with(".x"))

        # Store the filtered data for return
        return_list[["output_linkage_df"]] <- filtered_data

        ### Return our list of return values
        return(return_list)
        #--------------------------#
      }
    }
  )
)

run_main_linkage <- function(left_dataset_file, right_dataset_file, linkage_metadata_file, algorithm_ids, extra_parameters){
  # Error handling to ensure inputs were provided
  #----#
  if(is.na(left_dataset_file) || is.na(right_dataset_file) || is.null(left_dataset_file) ||
     is.null(right_dataset_file) || !file.exists(left_dataset_file) || !file.exists(right_dataset_file)){
    dbDisconnect(linkage_metadata_db)
    stop("Error: Invalid Datasets were provided.")
  }

  if(anyNA(algorithm_ids) || is.null(algorithm_ids) || !is.numeric(algorithm_ids)){
    dbDisconnect(linkage_metadata_db)
    stop("Error: Invalid Algorithm ID was provided.")
  }

  if(!is.list(extra_parameters)){
    dbDisconnect(linkage_metadata_db)
    stop("Error: Extra parameters should be provided as a list.")
  }

  if(is.na(linkage_metadata_file) || is.null(linkage_metadata_file) || !file.exists(linkage_metadata_file) || file_ext(linkage_metadata_file) != "sqlite"){
    dbDisconnect(linkage_metadata_db)
    stop("Error: Invalid linkage metadata file provided.")
  }
  #----#

  ### Step 1: Connect to the linkage metadata file
  #----
  linkage_metadata_db <- dbConnect(RSQLite::SQLite(), linkage_metadata_file)
  #----

  # Create lists and data frames for storing ALL algorithm summaries, performance measures, and table data
  #----
  linked_data_list                <- list()
  linked_data_algorithm_names     <- c()
  linkage_algorithm_summary_list  <- list()
  linkage_algorithm_footnote_list <- list()
  intermediate_performance_measures_df <- data.frame(
    algorithm_name = character(),
    positive_predictive_value = numeric(),
    negative_predictive_value = numeric(),
    sensitivity = numeric(),
    specificity = numeric(),
    f1_score = numeric(),
    linkage_rate = numeric()
  )
  # Apply labels to the performance measures data frame
  label(intermediate_performance_measures_df$algorithm_name) <- "Algorithm Name"
  label(intermediate_performance_measures_df$positive_predictive_value) <- "PPV"
  label(intermediate_performance_measures_df$negative_predictive_value) <- "NPV"
  label(intermediate_performance_measures_df$sensitivity) <- "Sensitivity"
  label(intermediate_performance_measures_df$specificity) <- "Specificity"
  label(intermediate_performance_measures_df$f1_score) <- "F1-Score"
  label(intermediate_performance_measures_df$linkage_rate) <- "Linkage Rate"
  #----


  # For Steps 2-5, we'll run each of our algorithms
  for(algorithm_id in algorithm_ids){
    # List of plots and captions
    algorithm_plots <- c()
    plot_captions   <- c()

    ### Step 2: Get the iteration IDs using the selected algorithm ID
    #----
    iterations_query <- dbSendQuery(linkage_metadata_db, 'SELECT * FROM linkage_iterations
                                                        WHERE algorithm_id = $id AND enabled = 1
                                                        ORDER BY iteration_num asc;')
    dbBind(iterations_query, list(id=algorithm_id))
    iterations_df <- dbFetch(iterations_query)
    dbClearResult(iterations_query)

    # Error check, make sure an algorithm with this ID exists
    if(nrow(iterations_df) <= 0){
      dbDisconnect(linkage_metadata_db)
      stop("Error: No iterations found under the provided algorithm, verify that iterations exist and try running again.")
    }
    #----

    ### Step 3: Load in and verify both datasets
    #----
    # For the left data set, read the dataset code, grab its fields
    left_file_name <- basename(left_dataset_file)
    left_split_file_name <- unlist(strsplit(left_file_name, "[[:punct:]]"))
    left_dataset_code <- left_split_file_name[1]

    get_fields_query_left <- paste("SELECT field_name FROM datasets ds
                                  JOIN dataset_fields dsf on dsf.dataset_id = ds.dataset_id
                                  WHERE dataset_code = ? AND enabled_for_linkage = 1")
    left_dataset_fields_statement <- dbSendQuery(linkage_metadata_db, get_fields_query_left)
    dbBind(left_dataset_fields_statement, list(left_dataset_code))
    left_dataset_fields <- dbFetch(left_dataset_fields_statement)
    dbClearResult(left_dataset_fields_statement)

    # For the right dataset, read the dataset code, grab its fields
    right_file_name <- basename(right_dataset_file)
    right_split_file_name <- unlist(strsplit(right_file_name, "[[:punct:]]"))
    right_dataset_code <- right_split_file_name[1]

    get_fields_query_right <- paste("SELECT field_name FROM datasets ds
                                   JOIN dataset_fields dsf on dsf.dataset_id = ds.dataset_id
                                   WHERE dataset_code = ? AND enabled_for_linkage = 1")
    right_dataset_fields_statement <- dbSendQuery(linkage_metadata_db, get_fields_query_right)
    dbBind(right_dataset_fields_statement, list(right_dataset_code))
    right_dataset_fields <- dbFetch(right_dataset_fields_statement)
    dbClearResult(right_dataset_fields_statement)

    # Read in the left and right dataset
    left_dataset <- tryCatch({
      df <- load_linkage_file(left_dataset_file)
      df
    },
    error = function(e){
      dbDisconnect(linkage_metadata_db)
      stop("Error: Invalid Left Dataset File.")
    })

    right_dataset <- tryCatch({
      df <- load_linkage_file(right_dataset_file)
      df
    },
    error = function(e){
      dbDisconnect(linkage_metadata_db)
      stop("Error: Invalid Right Dataset File.")
    })

    # Verify that the column names of the loaded dataset match whats stored in the datasets
    left_dataset_column_diff     <- setdiff(left_dataset_fields$field_name, colnames(left_dataset))
    left_dataset_column_diff_alt <- setdiff(colnames(left_dataset), left_dataset_fields$field_name)
    if(length(left_dataset_column_diff) > 0 || length(left_dataset_column_diff_alt) > 0){
      dbDisconnect(linkage_metadata_db)
      stop("Error: Columns Do Not Match In Left Dataset.")
    }

    right_dataset_column_diff     <- setdiff(right_dataset_fields$field_name, colnames(right_dataset))
    right_dataset_column_diff_alt <- setdiff(colnames(right_dataset), right_dataset_fields$field_name)
    if(length(right_dataset_column_diff) > 0 || length(right_dataset_column_diff_alt) > 0){
      dbDisconnect(linkage_metadata_db)
      stop("Error: Columns Do Not Match In Right Dataset.")
    }
    #----

    ### Step 4: For each iteration ID loop through and perform data linkage
    #----
    # Print a message to specify which algorithm we're in
    algorithm_name <- dbGetQuery(linkage_metadata_db, paste0("SELECT * from linkage_algorithms where algorithm_id = ", algorithm_id))$algorithm_name
    tryCatch({
      showNotification(paste0("Beginning Linkage for ", algorithm_name), type = "warning", closeButton = FALSE)
    },
    error = function(e){
      print(paste0("Beginning Linkage for ", algorithm_name))
    })

    # Keep a value for the number of values that are linked
    linkage_rate_cumulative_numer <- 0
    linkage_rate_cumulative_denom <- nrow(left_dataset)

    # Keep a data frame of all passes for algorithm summary
    algo_summary <- data.frame(
      pass = character(),
      linkage_implementation = character(),
      blocking_variables = character(),
      matching_variables = character(),
      acceptance_threshold = character(),
      linkage_rate_pass = character(),
      linkage_rate_total = character()
    )
    algo_summary_footnotes <- c()

    # Keep a vector of performance measure values
    performance_measures <- c(TP = 0, TN = 0, FP = 0, FN = 0)

    # Keep a data frame of all passes for final output
    output_df <- data.frame()
    for(row_num in 1:nrow(iterations_df)){
      # Get the current row
      row <- iterations_df[row_num,]

      # Get the current iteration priority
      curr_iteration_priority <- row$iteration_num

      # Get the current iteration_id
      curr_iteration_id <- row$iteration_id

      # Get the current iteration_name
      curr_iteration_name <- row$iteration_name

      # Get the implementation class name to decide which linkage implementation to call
      implementation_name <- get_implementation_name(linkage_db = linkage_metadata_db, iteration_id = curr_iteration_id)

      # Retrieve the class definition from the implementation name string
      class_obj <- get(implementation_name)

      # Instantiate the class object
      linkage_implementation <- class_obj$new()

      # Track start time so that we may make note of how long each pass takes
      start_time = proc.time()

      # Print a message to indicate we're beginning this pass
      tryCatch({
        showNotification(paste0("Beginning Linkage pass (", curr_iteration_name, ")"), type = "warning", closeButton = FALSE)
      },
      error = function(e){
        print(paste0("Beginning Linkage pass (", curr_iteration_name, ")"))
      })

      # Call the run_iteration method implemented by the desired class
      results <- linkage_implementation$run_iteration(left_dataset, right_dataset, linkage_metadata_db, curr_iteration_id, algorithm_id, extra_parameters)

      # Track the end time time and get the difference
      end_time = proc.time()

      # Format the time difference to two decimal places
      formatted_time <- format(round((end_time - start_time)[3], 3), nsmall = 3)

      # Print a success message for linking record pairs
      tryCatch({
        showNotification(paste0(curr_iteration_name, " using the ", implementation_name, " class finished in ", formatted_time, " seconds"), type = "warning", closeButton = FALSE)
      },
      error = function(e){
        print(paste0(curr_iteration_name, " using the ", implementation_name, " class finished in ", formatted_time, " seconds"))
      })

      ### STORE INFORMATION FOR ALGORITHM SUMMARY
      # Get the implementation name
      linkage_method <- get_linkage_technique(linkage_metadata_db, curr_iteration_id)
      linkage_method_desc <- get_linkage_technique_description(linkage_metadata_db, curr_iteration_id)
      linkage_footnote <- paste0(linkage_method, ' = ', linkage_method_desc)
      algo_summary_footnotes <- append(algo_summary_footnotes, linkage_footnote)
      algo_summary_footnotes <- unique(algo_summary_footnotes)

      # Get the blocking variables
      blocking_fields_df <- get_blocking_keys(linkage_metadata_db, curr_iteration_id)
      blocking_fields <- paste(blocking_fields_df$left_dataset_field, collapse = ", ")

      # Get the matching variables
      matching_query <- paste('SELECT field_name, comparison_rule_id FROM matching_variables
                              JOIN dataset_fields on field_id = left_dataset_field_id
                              WHERE iteration_id =', curr_iteration_id)
      matching_df <- dbGetQuery(linkage_metadata_db, matching_query)

      # Loop through each matching variable to get its comparison methods
      for(j in 1:nrow(matching_df)){
        # Get the comparison_rule_id for this row
        comparison_rule_id <- matching_df$comparison_rule_id[j]
        if(nrow(matching_df) > 0 && !is.na(comparison_rule_id)){
          # Query to get the acceptance method name from the comparison_rules table
          method_query <- paste('SELECT method_name FROM comparison_rules cr
                             JOIN comparison_methods cm on cr.comparison_method_id = cm.comparison_method_id
                             WHERE comparison_rule_id =', comparison_rule_id)
          method_name <- dbGetQuery(linkage_metadata_db, method_query)$method_name

          # Query to get the associated parameters for the comparison_rule_id
          params_query <- paste('SELECT parameter FROM comparison_rules_parameters WHERE comparison_rule_id =', comparison_rule_id)
          params_df <- dbGetQuery(linkage_metadata_db, params_query)

          # Combine the parameters into a string
          params_str <- paste(params_df$parameter, collapse = ", ")

          # Create the final string "method_name (key1=value1, key2=value2)"
          method_with_params <- paste0(" - ", method_name, " (", params_str, ")")

          # Replace the comparison_rule_id with the method and parameters string
          matching_df$field_name[j] <- paste0(matching_df$field_name[j], method_with_params)
        }
      }

      matching_fields <- paste(matching_df$field_name, collapse = ", ")

      # Get the acceptance threshold
      acceptance_query <- paste('SELECT * FROM linkage_iterations
                               WHERE iteration_id =', curr_iteration_id,
                                'ORDER BY iteration_num ASC;')
      acceptance_df <- dbGetQuery(linkage_metadata_db, acceptance_query)
      acceptance_rule_id <- acceptance_df$acceptance_rule_id
      acceptance_threshold <- ""

      if (nrow(acceptance_df) > 0 && !is.na(acceptance_rule_id)) {
        # Query to get the acceptance method name from the acceptance_rules table
        method_query <- paste('SELECT method_name FROM acceptance_rules ar
                             JOIN acceptance_methods am on ar.acceptance_method_id = am.acceptance_method_id
                             WHERE acceptance_rule_id =', acceptance_rule_id)
        method_name <- dbGetQuery(linkage_metadata_db, method_query)$method_name

        # Query to get the associated parameters for the acceptance_rule_id
        params_query <- paste('SELECT parameter FROM acceptance_rules_parameters WHERE acceptance_rule_id =', acceptance_rule_id)
        params_df <- dbGetQuery(linkage_metadata_db, params_query)

        # Combine the parameters into a string
        params_str <- paste(params_df$parameter, collapse = ", ")

        # Create the final string "method_name (key1=value1, key2=value2)"
        method_with_params <- paste0(method_name, " (", params_str, ")")

        # Replace the acceptance_rule_id with the method and parameters string
        acceptance_threshold <- method_with_params
      }

      # Get the linked indices
      linked_indices <- results[["linked_indices"]]
      linked_indices <- unique(linked_indices)

      # Get the linkage rate for the pass
      linkage_rate_pass_numer <- ifelse(anyNA(linked_indices), 0, length(linked_indices))
      linkage_rate_pass_denom <- nrow(left_dataset)
      linkage_rate_pass       <- (linkage_rate_pass_numer/linkage_rate_pass_denom) * 100

      # Get the cumulative linkage rate
      linkage_rate_cumulative_numer <- linkage_rate_cumulative_numer + linkage_rate_pass_numer
      linkage_rate_cumulative <- (linkage_rate_cumulative_numer/linkage_rate_cumulative_denom) * 100

      # Create a data frame for the current passes summary
      curr_algo_summary <- data.frame(
        pass = row_num,
        linkage_implementation = linkage_method,
        blocking_variables = blocking_fields,
        matching_variables = matching_fields,
        acceptance_threshold = acceptance_threshold,
        linkage_rate_pass = linkage_rate_pass,
        linkage_rate_cumulative = linkage_rate_cumulative
      )

      # Bind this to our full algorithm summary
      algo_summary <- rbind(algo_summary, curr_algo_summary)

      ### RESULT 1: Linked Indices (Removed the rows that were linked)
      if(!anyNA(linked_indices)){
        left_dataset <- suppressWarnings(left_dataset[-linked_indices, ])
      }

      ### RESULT 2: Unlinked dataset pairs for exportation
      if(("output_unlinked_iteration_pairs" %in% names(extra_parameters) && extra_parameters[["output_unlinked_iteration_pairs"]] == TRUE) &&
         "linkage_output_folder" %in% names(extra_parameters) && "unlinked_dataset_pairs" %in% names(results)){
        # Get the output directory
        output_dir <- extra_parameters[["linkage_output_folder"]]

        # Get the algorithm name
        df <- dbGetQuery(linkage_metadata_db, paste0('SELECT * FROM linkage_algorithms WHERE algorithm_id = ', algorithm_id))
        algorithm_name <- stri_replace_all_regex(df$algorithm_name, " ", "")

        # Define base file name
        base_filename <- paste0(algorithm_name, '_', curr_iteration_name, '_unlinked_pairs')

        # Start with the base file name
        full_filename <- file.path(output_dir, paste0(base_filename, ".csv"))
        counter <- 1

        # While the file exists, append a number and keep checking
        while (file.exists(full_filename)) {
          full_filename <- file.path(output_dir, paste0(base_filename, " (", counter, ")", ".csv"))
          counter <- counter + 1
        }

        # Save the .CSV file
        full_filename <- stri_replace_all_regex(full_filename, "\\\\", "/")
        fwrite(results[["unlinked_dataset_pairs"]], file = full_filename, append = TRUE)

        # Specify that the file was successfully written
        print(paste0("Linkage data saved as: ", full_filename))
      }

      ### RESULT 3: Linked Dataset for Exportation
      if(("output_linkage_iterations" %in% names(extra_parameters) && extra_parameters[["output_linkage_iterations"]] == TRUE) &&
         "linkage_output_folder" %in% names(extra_parameters) && "linked_dataset" %in% names(results)){
        # Get the output directory
        output_dir <- extra_parameters[["linkage_output_folder"]]

        # Get the algorithm name
        df <- dbGetQuery(linkage_metadata_db, paste0('SELECT * FROM linkage_algorithms WHERE algorithm_id = ', algorithm_id))
        algorithm_name <- stri_replace_all_regex(df$algorithm_name, " ", "")

        # Define base file name
        base_filename <- paste0(algorithm_name, '_', curr_iteration_name, '_linkage_results')

        # Start with the base file name
        full_filename <- file.path(output_dir, paste0(base_filename, ".csv"))
        counter <- 1

        # While the file exists, append a number and keep checking
        while (file.exists(full_filename)) {
          full_filename <- file.path(output_dir, paste0(base_filename, " (", counter, ")", ".csv"))
          counter <- counter + 1
        }

        # Save the .CSV file
        full_filename <- stri_replace_all_regex(full_filename, "\\\\", "/")
        fwrite(results[["linked_dataset"]], file = full_filename, append = TRUE)

        # Specify that the file was successfully written
        print(paste0("Linkage data saved as: ", full_filename))
      }

      ### RESULT 4: Linkage Report Output Data Frame
      # If the output_df is NA, then no pass has been completed, otherwise, bind the rows
      if(nrow(output_df) <= 0 && !anyNA(linked_indices)){
        output_df <- results[["output_linkage_df"]]
      }else if(!anyNA(linked_indices)){
        output_df <- rbind(output_df, results[["output_linkage_df"]])
      }

      ### RESULT 5: Ground Truth Performance Measure Variables
      if("performance_measure_variables" %in% names(results)){
        # Get the performance measure values
        iteration_performance_measures <- results[["performance_measure_variables"]]

        # Append the performance measure variables to the overall values
        performance_measures[1] <- performance_measures[1] + iteration_performance_measures[1]
        performance_measures[2] <- performance_measures[2] + iteration_performance_measures[2]
        performance_measures[3] <- performance_measures[3] + iteration_performance_measures[3]
        performance_measures[4] <- performance_measures[4] + iteration_performance_measures[4]
      }

      ### RESULT 6: Save/Export Plots
      if(("generate_threshold_plots" %in% names(extra_parameters) && extra_parameters[["generate_threshold_plots"]] == TRUE) &&
         "linkage_output_folder" %in% names(extra_parameters) && "threshold_plots" %in% names(results)){
        # For each of the saved plots, save them as PNGs to the output folder
        for(plot_name in names(results[["threshold_plots"]])){
          # Get the plot object using the plot name
          plot <- results[["threshold_plots"]][[plot_name]]

          # Get the output directory
          output_dir <- extra_parameters[["linkage_output_folder"]]

          # Get the algorithm name
          df <- dbGetQuery(linkage_metadata_db, paste0('SELECT * FROM linkage_algorithms WHERE algorithm_id = ', algorithm_id))
          algorithm_name <- stri_replace_all_regex(df$algorithm_name, " ", "")

          # Define base file name
          base_filename <- paste0(algorithm_name, '_', curr_iteration_name, '_', plot_name)

          # Start with the base file name
          full_filename <- file.path(output_dir, paste0(base_filename, ".png"))
          counter <- 1

          # While the file exists, append a number and keep checking
          while (file.exists(full_filename)) {
            full_filename <- file.path(output_dir, paste0(base_filename, " (", counter, ")", ".png"))
            counter <- counter + 1
          }

          # Save the ggplot
          full_filename <- stri_replace_all_regex(full_filename, "\\\\", "/")
          ggsave(filename = full_filename, plot = plot, width = 6, height = 4)

          # Specify that the file was successfully written
          print(paste0("Linkage Plot Saved As: ", full_filename))

          # Save the plot output file and caption
          algorithm_plots <- append(algorithm_plots, full_filename)
        }
        # Save the captions afterwards
        captions <- results[["plot_captions"]]
        plot_captions <- append(plot_captions, captions)
      }
    }
    #----

    ### Step 5: Add unlinked data to the output data frame
    #----
    # Add a new column that specifies that these rows didn't link
    left_dataset <- cbind(left_dataset, stage="UNLINKED")

    # Get the columns to keep
    output_fields  <- get_linkage_output_fields(linkage_metadata_db, algorithm_id)
    fields_to_keep <- output_fields$field_name
    fields_to_keep  <- append(fields_to_keep, "stage")

    # Keep the output fields specified by the user
    left_dataset <- subset(left_dataset, select = fields_to_keep)

    # Bind what's left of the left dataset to the output data frame
    output_df <- rbind(output_df, left_dataset)

    # Change the stage values to be the linkage indicator
    output_df <- output_df %>% mutate(link_indicator = ifelse(stage == "UNLINKED",0,1))

    # Apply Labels to the output data frame
    for(row_num in 1:nrow(output_fields)){
      # Get the field to apply a label to
      dataset_field <- output_fields$field_name[row_num]

      # Get the label to apply
      dataset_label <- output_fields$dataset_label[row_num]

      # Apply the label to the field
      label(output_df[[dataset_field]]) <- dataset_label
    }

    # Apply a label to the link Indicator
    label(output_df[["stage"]]) <- "Passes"

    # Edit the output data frame by applying cutoffs to variables that may have many different values
    output_df <- apply_output_cutoffs(linkage_metadata_db, algorithm_id, output_df)

    # Relabel the algo summary
    label(algo_summary$pass) <- "Pass"
    label(algo_summary$linkage_rate_pass) <- "Within Pass Linkage Rate (%)"
    label(algo_summary$acceptance_threshold) <- "Acceptance Threshold"
    label(algo_summary$blocking_variables) <- "Blocking Scheme"
    label(algo_summary$matching_variables) <- "Matching Criteria"
    label(algo_summary$linkage_implementation) <- "Linkage Technique"
    label(algo_summary$linkage_rate_cumulative) <- "Cumulative Linkage Rate (%)"
    #----

    ### Step 6: Save performance measures, linkage rates, auditing information and whatever
    ###         we may need to the database and export data for linkage reports if asked
    #----
    performance_measures_df <- data.frame()
    # Try to calculate and export the performance measures
    if(("calculate_performance_measures" %in% names(extra_parameters) && extra_parameters[["calculate_performance_measures"]] == TRUE) &&
       "linkage_output_folder" %in% names(extra_parameters)){

      # Grab the performance measure variables
      TP <- performance_measures[[1]]
      TN <- performance_measures[[2]]
      FP <- performance_measures[[3]]
      FN <- performance_measures[[4]]

      # Calculate the PPV
      PPV <- (TP/(TP + FP)) * 100

      # Calculate the NPV
      NPV <- (TN/(TN + FN)) * 100

      # Sensitivity
      SENS <- (TP/(TP + FN)) * 100

      # Specificity
      SPEC <- (TN/(TN + FP)) * 100

      # F1-Score
      F1_SCORE <- (TP/(TP + (0.5 * (FP + FN)))) * 100

      # FDR (False Discover Rate) WE CAN CHOOSE TO ADD IT LATER
      #FDR <- (FP/(FP + TP)) * 100

      # FOR (False Omission Rate) WE CAN CHOOSE TO ADD IT LATER
      #FOR <- (FN/(FN + TN)) * 100

      # Calculate the linkage rate
      linkage_rate <- (linkage_rate_cumulative_numer/linkage_rate_cumulative_denom) * 100

      # Get the algorithm name
      df <- dbGetQuery(linkage_metadata_db, paste0('SELECT * FROM linkage_algorithms WHERE algorithm_id = ', algorithm_id))
      algorithm_name <- df$algorithm_name

      # Make sure all the values are good, otherwise replace them with invalid numbers
      PPV <- ifelse(is.na(PPV), 0, PPV)
      NPV <- ifelse(is.na(NPV), 0, NPV)
      SENS <- ifelse(is.na(SENS), 0, SENS)
      SPEC <- ifelse(is.na(SPEC), 0, SPEC)
      F1_SCORE <- ifelse(is.na(F1_SCORE), 0, F1_SCORE)

      # Create a performance measures data frame to store all the information
      performance_measures_df <- data.frame(
        algorithm_name = algorithm_name,
        positive_predictive_value = PPV,
        negative_predictive_value = NPV,
        sensitivity = SENS,
        specificity = SPEC,
        f1_score = F1_SCORE,
        linkage_rate = linkage_rate
      )

      # Apply labels to the performance measures data frame
      label(performance_measures_df$algorithm_name) <- "Algorithm Name"
      label(performance_measures_df$positive_predictive_value) <- "PPV"
      label(performance_measures_df$negative_predictive_value) <- "NPV"
      label(performance_measures_df$sensitivity) <- "Sensitivity"
      label(performance_measures_df$specificity) <- "Specificity"
      label(performance_measures_df$f1_score) <- "F1-Score"
      label(performance_measures_df$linkage_rate) <- "Linkage Rate"

      # Get the output directory
      output_dir <- extra_parameters[["linkage_output_folder"]]

      # Get the algorithm name
      df <- dbGetQuery(linkage_metadata_db, paste0('SELECT * FROM linkage_algorithms WHERE algorithm_id = ', algorithm_id))
      algorithm_name <- stri_replace_all_regex(df$algorithm_name, " ", "")

      # Define base file name
      base_filename <- paste0(algorithm_name, '_linkage_performance_measures')

      # Start with the base file name
      full_filename <- file.path(output_dir, paste0(base_filename, ".csv"))
      counter <- 1

      # While the file exists, append a number and keep checking
      while (file.exists(full_filename)) {
        full_filename <- file.path(output_dir, paste0(base_filename, " (", counter, ")", ".csv"))
        counter <- counter + 1
      }

      # Save the .CSV file
      full_filename <- stri_replace_all_regex(full_filename, "\\\\", "/")
      fwrite(performance_measures_df, file = full_filename, append = TRUE)

      # Print a success message
      print(paste0("Performance measures have been exported to: ", full_filename))
    }

    # Try to create report using the output data frame if the user wanted to
    if(("linkage_report_type" %in% names(extra_parameters) && extra_parameters[["linkage_report_type"]] == 3) &&
       "linkage_output_folder" %in% names(extra_parameters) && "data_linker" %in% names(extra_parameters)){
      # Get the output directory
      output_dir <- extra_parameters[["linkage_output_folder"]]
      tryCatch({
        # Get the algorithm name
        df <- dbGetQuery(linkage_metadata_db, paste0('SELECT * FROM linkage_algorithms WHERE algorithm_id = ', algorithm_id))
        algorithm_name <- df$algorithm_name

        # Get the datasets used for this algorithm
        query <- "SELECT
                    dalg.algorithm_id,
                    dleft.dataset_name AS left_dataset_name,
                    dright.dataset_name AS right_dataset_name
                FROM
                    linkage_algorithms dalg
                JOIN
                    datasets dleft ON dalg.dataset_id_left = dleft.dataset_id
                JOIN
                    datasets dright ON dalg.dataset_id_right = dright.dataset_id
                WHERE
                    dalg.algorithm_id = ?"

        # Get the datasets for this algorithm to get the left and right dataset names
        datasets <- dbGetQuery(linkage_metadata_db, query, params = list(algorithm_id))

        # Get the username
        username <- extra_parameters[["data_linker"]]

        # Get the output variables that we'll be using
        strata_vars <- colnames(output_df)
        strata_vars <- strata_vars[! strata_vars %in% c('stage')] # Drop the 'stage'/'Passes' field

        # Load the 'linkrep' library and generate a linkage quality report
        library("linkrep")

        ### Verify the performance measures info is valid
        ground_truth_df <- get_ground_truth_fields(linkage_metadata_db, algorithm_id)
        ground_truth_fields <- paste(ground_truth_df$left_dataset_field, collapse = ", ")
        performance_measures_footnotes <- c("PPV = Positive predictive value, NPV = Negative predictive value.")
        if(nrow(performance_measures_df) <= 0){
          performance_measures_df <- NULL
          performance_measures_footnotes <- NULL
          ground_truth_fields <- NULL
        }

        ### Verify the plot information is valid
        if(length(algorithm_plots) <= 0 || length(plot_captions) <= 0){
          algorithm_plots <- NULL
          plot_captions <- NULL
        }

        ### If we considered other algorithms, add them to the report appendix
        # Create a list of our considered algorithms
        considered_algo_summary_list           <- list()
        considered_algo_summary_footnotes_list <- list()
        considered_algo_summary_table_names    <- c()

        # Get the algorithms enabled for testing
        enabled_algorithms <- dbGetQuery(linkage_metadata_db, 'SELECT algorithm_id FROM linkage_algorithms
                                                               WHERE enabled_for_testing = 1 AND enabled = 0
                                                               ORDER BY algorithm_id ASC')$algorithm_id

        # Loop through each algorithm and create a table for its iterations
        for(tested_algorithm_id in enabled_algorithms){
          # Create an empty algorithm summary for binding
          considered_algo_summary <- data.frame(
            pass = character(),
            linkage_implementation = character(),
            blocking_variables = character(),
            matching_variables = character(),
            acceptance_threshold = character()
          )
          considered_algo_summary_footnotes <- c()

          # Get the algorithm name
          considered_algorithm_name <- get_algorithm_name(linkage_metadata_db, tested_algorithm_id)
          considered_algo_summary_table_names <- append(considered_algo_summary_table_names, considered_algorithm_name)

          # Get the list of iteration IDs for the current algorithm
          enabled_iterations <- dbGetQuery(linkage_metadata_db, paste0('SELECT iteration_id FROM linkage_iterations
                                                                 WHERE algorithm_id = ', tested_algorithm_id,
                                                               ' ORDER by iteration_id ASC'))$iteration_id

          # Set a variable for counting the current pass
          curr_pass <- 1

          # Loop through each iteration ID to make our algorithm summary
          for(tested_iteration_id in enabled_iterations){
            # Get the implementation name
            linkage_method <- get_linkage_technique(linkage_metadata_db, tested_iteration_id)
            linkage_method_desc <- get_linkage_technique_description(linkage_metadata_db, tested_iteration_id)
            linkage_footnote <- paste0(linkage_method, ' = ', linkage_method_desc)
            considered_algo_summary_footnotes <- append(considered_algo_summary_footnotes, linkage_footnote)
            considered_algo_summary_footnotes <- unique(considered_algo_summary_footnotes)

            # Get the blocking variables
            blocking_fields_df <- get_blocking_keys(linkage_metadata_db, tested_iteration_id)
            blocking_fields <- paste(blocking_fields_df$left_dataset_field, collapse = ", ")

            # Get the matching variables
            matching_query <- paste('SELECT field_name, comparison_rule_id FROM matching_variables
                              JOIN dataset_fields on field_id = left_dataset_field_id
                              WHERE iteration_id =', tested_iteration_id)
            matching_df <- dbGetQuery(linkage_metadata_db, matching_query)

            # Loop through each matching variable to get its comparison methods
            for(j in 1:nrow(matching_df)){
              # Get the comparison_rule_id for this row
              comparison_rule_id <- matching_df$comparison_rule_id[j]
              if(nrow(matching_df) > 0 && !is.na(comparison_rule_id)){
                # Query to get the acceptance method name from the comparison_rules table
                method_query <- paste('SELECT method_name FROM comparison_rules cr
                             JOIN comparison_methods cm on cr.comparison_method_id = cm.comparison_method_id
                             WHERE comparison_rule_id =', comparison_rule_id)
                method_name <- dbGetQuery(linkage_metadata_db, method_query)$method_name

                # Query to get the associated parameters for the comparison_rule_id
                params_query <- paste('SELECT parameter FROM comparison_rules_parameters WHERE comparison_rule_id =', comparison_rule_id)
                params_df <- dbGetQuery(linkage_metadata_db, params_query)

                # Combine the parameters into a string
                params_str <- paste(params_df$parameter, collapse = ", ")

                # Create the final string "method_name (key1=value1, key2=value2)"
                method_with_params <- paste0(" - ", method_name, " (", params_str, ")")

                # Replace the comparison_rule_id with the method and parameters string
                matching_df$field_name[j] <- paste0(matching_df$field_name[j], method_with_params)
              }
            }

            matching_fields <- paste(matching_df$field_name, collapse = ", ")

            # Get the acceptance threshold
            acceptance_query <- paste('SELECT * FROM linkage_iterations
                               WHERE iteration_id =', tested_iteration_id,
                                      'ORDER BY iteration_num ASC;')
            acceptance_df <- dbGetQuery(linkage_metadata_db, acceptance_query)
            acceptance_rule_id <- acceptance_df$acceptance_rule_id
            acceptance_threshold <- ""

            # Make the rules more readable
            if (nrow(acceptance_df) > 0 && !is.na(acceptance_rule_id)) {
              # Query to get the acceptance method name from the acceptance_rules table
              method_query <- paste('SELECT method_name FROM acceptance_rules ar
                             JOIN acceptance_methods am on ar.acceptance_method_id = am.acceptance_method_id
                             WHERE acceptance_rule_id =', acceptance_rule_id)
              method_name <- dbGetQuery(linkage_metadata_db, method_query)$method_name

              # Query to get the associated parameters for the acceptance_rule_id
              params_query <- paste('SELECT parameter FROM acceptance_rules_parameters WHERE acceptance_rule_id =', acceptance_rule_id)
              params_df <- dbGetQuery(linkage_metadata_db, params_query)

              # Combine the parameters into a string
              params_str <- paste(params_df$parameter, collapse = ", ")

              # Create the final string "method_name (key1=value1, key2=value2)"
              method_with_params <- paste0(method_name, " (", params_str, ")")

              # Replace the acceptance_rule_id with the method and parameters string
              acceptance_threshold <- method_with_params
            }

            # Create a data frame for the current passes summary
            temp_algo_summary <- data.frame(
              pass = as.integer(curr_pass),
              linkage_implementation = linkage_method,
              blocking_variables = blocking_fields,
              matching_variables = matching_fields,
              acceptance_threshold = acceptance_threshold
            )

            # Bind this summary
            considered_algo_summary <- rbind(considered_algo_summary, temp_algo_summary)

            # Update the current pass
            curr_pass <- curr_pass + 1
          }

          # Label the considered algorithm summary
          label(considered_algo_summary$pass)                   <- "Pass"
          label(considered_algo_summary$linkage_implementation) <- "Linkage Technique"
          label(considered_algo_summary$blocking_variables)     <- "Blocking Scheme"
          label(considered_algo_summary$matching_variables)     <- "Matching Criteria"
          label(considered_algo_summary$acceptance_threshold)   <- "Acceptance Threshold"

          # Once we finish this considered algorithm summary, save it to a list
          considered_algo_summary_list[[length(considered_algo_summary_list)+1]] <- considered_algo_summary
          considered_algo_summary_footnotes_list[[length(considered_algo_summary_footnotes_list)+1]] <- considered_algo_summary_footnotes
        }

        # Finally, if we don't have any enabled algorithms, set the input values to NULL
        if(length(considered_algo_summary_list) <= 0 || length (considered_algo_summary_footnotes_list) <= 0 || length(considered_algo_summary_table_names) <= 0){
          considered_algo_summary_footnotes_list <- NULL
          considered_algo_summary_list <- NULL
          considered_algo_summary_table_names <- NULL
        }

        # Generate the linkage quality report
        final_linkage_quality_report(output_df, algorithm_name, "", datasets$left_dataset_name,
                                     paste0("the ", datasets$right_dataset_name), output_dir, username, "datalink (Record Linkage)",
                                     "link_indicator", strata_vars, strata_vars, save_linkage_rate = F,
                                     algorithm_summary_data = algo_summary, algorithm_summary_tbl_footnotes = algo_summary_footnotes,
                                     performance_measures_data = performance_measures_df, performance_measures_tbl_footnotes = performance_measures_footnotes,
                                     ground_truth = ground_truth_fields,
                                     threshold_plots = algorithm_plots, threshold_plot_captions = plot_captions,
                                     considered_algorithm_summary_data = considered_algo_summary_list, considered_algorithm_summary_tbl_footnotes = considered_algo_summary_footnotes_list,
                                     considered_algorithm_summary_table_names = considered_algo_summary_table_names,
                                     R_version = as.character(getRversion()), linkrep_package_version = as.character(packageVersion("linkrep")))

        # # REPORT FOR REQUIRED DATA, PERFORMANCES MEASURES, AND NO PLOTS
        # if(nrow(performance_measures_df) >= 0){
        #   final_linkage_quality_report(output_df, algorithm_name, "", datasets$left_dataset_name,
        #                          paste0("the ", datasets$right_dataset_name), output_dir, username, "datalink (Record Linkage)",
        #                          "link_indicator", strata_vars, strata_vars, save_linkage_rate = F, algorithm_summary_data = algo_summary,
        #                          algorithm_summary_tbl_footnotes = algo_summary_footnotes,
        #                          R_version = as.character(getRversion()), linkrep_package_version = as.character(packageVersion("linkrep")))
        # }
        # # REPORT FOR REQUIRED DATA, NO PERFORMANCES MEASURES, AND NO PLOTS
        # else{
        #   performance_measures_footnotes <- c("PPV = Positive predictive value, NPV = Negative predictive value.")
        #   ground_truth_df <- get_ground_truth_fields(linkage_metadata_db, algorithm_id)
        #   ground_truth_fields <- paste(ground_truth_df$left_dataset_field, collapse = ", ")
        #   final_linkage_quality_report(output_df, algorithm_name, "", datasets$left_dataset_name,
        #                          paste0("the ", datasets$right_dataset_name), output_dir, username, "datalink (Record Linkage)",
        #                          "link_indicator", strata_vars, strata_vars, save_linkage_rate = F,
        #                          algorithm_summary_data = algo_summary, algorithm_summary_tbl_footnotes = algo_summary_footnotes,
        #                          performance_measures_data = performance_measures_df, performance_measures_tbl_footnotes = performance_measures_footnotes,
        #                          ground_truth = ground_truth_fields,
        #                          R_version = as.character(getRversion()), linkrep_package_version = as.character(packageVersion("linkrep")))
        # }
        detach("package:linkrep", unload = TRUE)
      },
      error = function(e){
        detach("package:linkrep", unload = TRUE)
        print(geterrmessage())
        # If we failed to generate a linkage report, write to a csv file instead
        print("Error: Unable to generate linkage report, saving output data frame to specified output folder.")

        # Get the algorithm name
        df <- dbGetQuery(linkage_metadata_db, paste0('SELECT * FROM linkage_algorithms WHERE algorithm_id = ', algorithm_id))
        algorithm_name <- stri_replace_all_regex(df$algorithm_name, " ", "")

        # Define base file name
        base_filename <- paste0(algorithm_name, '_complete_linkage_results')

        # Start with the base file name
        full_filename <- file.path(output_dir, paste0(base_filename, ".csv"))
        counter <- 1

        # While the file exists, append a number and keep checking
        while (file.exists(full_filename)) {
          full_filename <- file.path(output_dir, paste0(base_filename, " (", counter, ")", ".csv"))
          counter <- counter + 1
        }

        # Save the .CSV file
        full_filename <- stri_replace_all_regex(full_filename, "\\\\", "/")
        fwrite(output_df, file = full_filename, append = TRUE)

        # Print a success message
        print(paste0("Linkage report data has been exported to: ", full_filename))
      })
    }
    else if ("linkage_report_type" %in% names(extra_parameters) && extra_parameters[["linkage_report_type"]] == 1){
      # Get the output directory
      output_dir <- extra_parameters[["linkage_output_folder"]]

      # Get the algorithm name
      df <- dbGetQuery(linkage_metadata_db, paste0('SELECT * FROM linkage_algorithms WHERE algorithm_id = ', algorithm_id))
      algorithm_name <- stri_replace_all_regex(df$algorithm_name, " ", "")

      # Define base file name
      base_filename <- paste0(algorithm_name, '_complete_linkage_results')

      # Start with the base file name
      full_filename <- file.path(output_dir, paste0(base_filename, ".csv"))
      counter <- 1

      # While the file exists, append a number and keep checking
      while (file.exists(full_filename)) {
        full_filename <- file.path(output_dir, paste0(base_filename, " (", counter, ")", ".csv"))
        counter <- counter + 1
      }

      # Save the .CSV file
      full_filename <- stri_replace_all_regex(full_filename, "\\\\", "/")
      fwrite(output_df, file = full_filename, append = TRUE)

      # Print a success message
      print(paste0("Linkage report data has been exported to: ", full_filename))
    }

    # Try to export an algorithm summary
    if(("generate_algorithm_summary" %in% names(extra_parameters) && extra_parameters[["generate_algorithm_summary"]] == TRUE) &&
       "linkage_output_folder" %in% names(extra_parameters)){
      # Get the output directory
      output_dir <- extra_parameters[["linkage_output_folder"]]

      # Get the algorithm name
      df <- dbGetQuery(linkage_metadata_db, paste0('SELECT * FROM linkage_algorithms WHERE algorithm_id = ', algorithm_id))
      algorithm_name <- stri_replace_all_regex(df$algorithm_name, " ", "")

      # Define base file name
      base_filename <- paste0(algorithm_name, '_linkage_summary')

      # Start with the base file name
      full_filename <- file.path(output_dir, paste0(base_filename, ".csv"))
      counter <- 1

      # While the file exists, append a number and keep checking
      while (file.exists(full_filename)) {
        full_filename <- file.path(output_dir, paste0(base_filename, " (", counter, ")", ".csv"))
        counter <- counter + 1
      }

      # Save the .CSV file
      full_filename <- stri_replace_all_regex(full_filename, "\\\\", "/")
      fwrite(algo_summary, file = full_filename, append = TRUE)

      # Print a success message
      print(paste0("Algorithm summary has been exported to: ", full_filename))
    }
    #----

    ### Step 7: Save intermediate information
    #----
    # Save the linked data
    linked_data_list[[length(linked_data_list)+1]] <- output_df

    # Save the algorithm name
    df <- dbGetQuery(linkage_metadata_db, paste0('SELECT * FROM linkage_algorithms WHERE algorithm_id = ', algorithm_id))
    linked_data_algorithm_names <- append(linked_data_algorithm_names, df$algorithm_name)

    # Save the algorithm summary
    linkage_algorithm_summary_list[[length(linkage_algorithm_summary_list)+1]] <- algo_summary

    # Save the performance measures information
    if(nrow(performance_measures_df) > 0){
      intermediate_performance_measures_df <- rbind(intermediate_performance_measures_df, performance_measures_df)
    }

    # Save the algorithm footnotes
    linkage_algorithm_footnote_list[[length(linkage_algorithm_footnote_list)+1]] <- algo_summary_footnotes
    #----
  }

  # If the user would like an intermediate report to be generated, then generate it
  if(("linkage_report_type" %in% names(extra_parameters) && extra_parameters[["linkage_report_type"]] == 2) &&
     "linkage_output_folder" %in% names(extra_parameters) && "data_linker" %in% names(extra_parameters)){
    # Get the output directory
    output_dir <- extra_parameters[["linkage_output_folder"]]
    tryCatch({
      # Get the datasets used for this algorithm
      query <- "SELECT
                    dalg.algorithm_id,
                    dleft.dataset_name AS left_dataset_name,
                    dright.dataset_name AS right_dataset_name
                FROM
                    linkage_algorithms dalg
                JOIN
                    datasets dleft ON dalg.dataset_id_left = dleft.dataset_id
                JOIN
                    datasets dright ON dalg.dataset_id_right = dright.dataset_id
                WHERE
                    dalg.algorithm_id = ?"

      # Get the datasets for this algorithm to get the left and right dataset names
      datasets <- dbGetQuery(linkage_metadata_db, query, params = list(algorithm_id))

      # Create a title for the report
      report_title <- paste0(datasets$left_dataset_name, " x ", datasets$right_dataset_name)

      # Get the username
      username <- extra_parameters[["data_linker"]]

      # Edit the output data frame by applying cutoffs to variables that may have many different values
      output_df <- apply_output_cutoffs(linkage_metadata_db, algorithm_id, output_df)

      # Get the output variables that we'll be using
      strata_vars <- colnames(output_df)
      strata_vars <- strata_vars[! strata_vars %in% c('stage')] # Drop the 'stage'/'Passes' field

      # Load the 'linkrep' library and generate a linkage quality report
      library("linkrep")
      # If we have performance measures, include them, otherwise generate a normal report
      if(nrow(intermediate_performance_measures_df) <= 0){
        intermediate_linkage_quality_report(main_data_list = linked_data_list, main_data_algorithm_names = linked_data_algorithm_names,
                                            report_title, "", datasets$left_dataset_name, paste0("the ", datasets$right_dataset_name),
                                            output_dir, username, "datalink (Record Linkage)","link_indicator", strata_vars, strata_vars, save_linkage_rate = F,
                                            algorithm_summary_data_list = linkage_algorithm_summary_list, algorithm_summary_tbl_footnotes_list = linkage_algorithm_footnote_list,
                                            R_version = as.character(getRversion()), linkrep_package_version = as.character(packageVersion("linkrep")))
      }
      else{
        performance_measures_footnotes <- c("PPV = Positive predictive value, NPV = Negative predictive value.")
        ground_truth_df <- get_ground_truth_fields(linkage_metadata_db, algorithm_id)
        ground_truth_fields <- paste(ground_truth_df$left_dataset_field, collapse = ", ")
        intermediate_linkage_quality_report(main_data_list = linked_data_list, main_data_algorithm_names = linked_data_algorithm_names,
                                            report_title, "", datasets$left_dataset_name, paste0("the ", datasets$right_dataset_name),
                                            output_dir, username, "datalink (Record Linkage)","link_indicator", strata_vars, strata_vars, save_linkage_rate = F,
                                            algorithm_summary_data_list = linkage_algorithm_summary_list, algorithm_summary_tbl_footnotes_list = linkage_algorithm_footnote_list,
                                            performance_measures_data = intermediate_performance_measures_df, performance_measures_tbl_footnotes = performance_measures_footnotes,
                                            ground_truth = ground_truth_fields,
                                            R_version = as.character(getRversion()), linkrep_package_version = as.character(packageVersion("linkrep")))
      }
      detach("package:linkrep", unload = TRUE)
    },
    error = function(e){
      detach("package:linkrep", unload = TRUE)
      print(geterrmessage())
      # If we failed to generate a linkage report, write to a csv file instead
      print("Error: Unable to generate linkage report, saving output data frame to specified output folder.")

      # Get the algorithm name
      df <- dbGetQuery(linkage_metadata_db, paste0('SELECT * FROM linkage_algorithms WHERE algorithm_id = ', algorithm_id))
      algorithm_name <- stri_replace_all_regex(df$algorithm_name, " ", "")

      # Define base file name
      base_filename <- paste0(algorithm_name, '_complete_linkage_results')

      # Start with the base file name
      full_filename <- file.path(output_dir, paste0(base_filename, ".csv"))
      counter <- 1

      # While the file exists, append a number and keep checking
      while (file.exists(full_filename)) {
        full_filename <- file.path(output_dir, paste0(base_filename, " (", counter, ")", ".csv"))
        counter <- counter + 1
      }

      # Save the .CSV file
      full_filename <- stri_replace_all_regex(full_filename, "\\\\", "/")
      fwrite(output_df, file = full_filename, append = TRUE)

      # Print a success message
      print(paste0("Linkage report data has been exported to: ", full_filename))
    })
  }

  # Disconnect from the linkage metadata database after we finish
  dbDisconnect(linkage_metadata_db)

  # If the user wanted linkage results of all ran algorithms to be returned, check that
  # the parameter was specified
  if("save_all_linkage_results" %in% names(extra_parameters)){
    # Create a result list of all the data we collected
    result_list <- list()
    result_list[["linked_data"]]            <- linked_data_list
    result_list[["linked_algorithm_ids"]]   <- algorithm_ids
    result_list[["linked_algorithm_names"]] <- linked_data_algorithm_names
    result_list[["algorithm_summaries"]]    <- linkage_algorithm_summary_list
    result_list[["algorithm_footnotes"]]    <- linkage_algorithm_footnote_list
    result_list[["performance_measures"]]   <- intermediate_performance_measures_df

    # Return the result list
    return(result_list)
  }
  else{
    # Return NULL if the user doesn't want to save all the linkage results
    return(NULL)
  }
}
