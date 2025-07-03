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
      # Get the linkage technique to determine whether this is a deterministic, probabilistic, or machine learning pass
      linkage_technique <- get_linkage_technique(linkage_metadata_db, iteration_id)
      if (linkage_technique == "P") {
        # Capture the number of records going into this pass. This will serve as the denominator for the pass-wise linkage rate
        linkage_rate_denominator <- nrow(left_dataset)

        # Get the blocking keys
        blocking_keys_df <- get_blocking_keys(linkage_metadata_db, iteration_id)

        # Get the matching keys
        matching_keys_df <- get_matching_keys(linkage_metadata_db, iteration_id)

        ### BLOCKING CRITERIA
        # Step 1: Rename fields in the right dataset to temporary names
        for (row_num in 1:nrow(blocking_keys_df)) {
          row <- blocking_keys_df[row_num,]
          right_dataset_field_name <- row$right_dataset_field
          temp_field_name <- paste0("temp_", right_dataset_field_name)

          # Rename the right dataset field to the temporary name
          names(right_dataset)[names(right_dataset) == right_dataset_field_name] <- temp_field_name
        }

        # Step 2: Now rename the temporary fields to the left dataset field names
        for (row_num in 1:nrow(blocking_keys_df)) {
          row <- blocking_keys_df[row_num,]
          left_dataset_field_name <- row$left_dataset_field
          temp_field_name <- paste0("temp_", row$right_dataset_field)

          # Rename the temporary field to the desired left dataset field name
          names(right_dataset)[names(right_dataset) == temp_field_name] <- paste0(left_dataset_field_name, "_renamed")
          names(left_dataset)[names(left_dataset) == left_dataset_field_name] <- paste0(left_dataset_field_name, "_renamed")
        }

        ### MATCHING CRITERIA
        # Step 1: Rename fields in the right dataset to temporary names
        for (row_num in 1:nrow(matching_keys_df)) {
          row <- matching_keys_df[row_num,]
          right_dataset_field_name <- row$right_dataset_field
          temp_field_name <- paste0("temp_", right_dataset_field_name)

          # Rename the right dataset field to the temporary name
          names(right_dataset)[names(right_dataset) == right_dataset_field_name] <- temp_field_name
        }

        # Step 2: Now rename the temporary fields to the left dataset field names
        for (row_num in 1:nrow(matching_keys_df)) {
          row <- matching_keys_df[row_num,]
          left_dataset_field_name <- row$left_dataset_field
          temp_field_name <- paste0("temp_", row$right_dataset_field)

          # Rename the temporary field to the desired left dataset field name
          names(right_dataset)[names(right_dataset) == temp_field_name] <- paste0(left_dataset_field_name, "_renamed")
          names(left_dataset)[names(left_dataset) == left_dataset_field_name] <- paste0(left_dataset_field_name, "_renamed")
        }

        # Rename the data frames to have "_renamed" applied to them
        blocking_keys_df$left_dataset_field <- paste0(blocking_keys_df$left_dataset_field, "_renamed")
        matching_keys_df$left_dataset_field <- paste0(matching_keys_df$left_dataset_field, "_renamed")
        blocking_keys_df$right_dataset_field <- paste0(blocking_keys_df$right_dataset_field, "_renamed")
        matching_keys_df$right_dataset_field <- paste0(matching_keys_df$right_dataset_field, "_renamed")

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
            if("alternate_field_value_left" %in% names(linkage_rules) || "alternate_field_value_right" %in% names(linkage_rules)){
              # Get the field we are blocking on
              dataset_field <- row$left_dataset_field

              # If a left alt value was provided, then split it and get the value
              if("alternate_field_value_left" %in% names(linkage_rules)){
                # Get the number of splits we expect to do
                num_of_splits <- linkage_rules$alternate_field_value_left

                # Create some vectors for storing the split name fields (left and right)
                name_split_left <- vector("list", num_of_splits + 1)
                name_split_left[[1]] <- left_dataset[[dataset_field]]

                # Loop until we reach the split field we want
                for(split_num in 1:num_of_splits){
                  # Clean up by trimming white space
                  name_split_left[[split_num]] <- trimws(name_split_left[[split_num]], "both")

                  # Split the name in half and store the results
                  split <- str_split_fixed(name_split_left[[split_num]], ' ', n = 2)
                  name_split_left[[split_num]] <- split[,1]
                  name_split_left[[split_num+1]] <- split[,2]
                }

                # After we finish splitting, return the LAST value since we split
                alternate_field_left <- name_split_left[[num_of_splits]]

                # Clean up after ourselves
                rm(name_split_left)
                gc()
              }
              else{
                alternate_field_left <- left_dataset[[dataset_field]]
              }

              # If a right alt value was provided, then split it and get the value
              if("alternate_field_value_right" %in% names(linkage_rules)){
                # Get the number of splits we expect to do
                num_of_splits <- linkage_rules$alternate_field_value_right

                # Create some vectors for storing the split name fields (left and right)
                name_split_right <- vector("list", num_of_splits + 1)
                name_split_right[[1]] <- right_dataset[[dataset_field]]

                # Loop until we reach the split field we want
                for(split_num in 1:num_of_splits){
                  # Clean up by trimming white space
                  name_split_right[[split_num]] <- trimws(name_split_right[[split_num]], "both")

                  # Split the name in half and store the results
                  split <- str_split_fixed(name_split_right[[split_num]], ' ', n = 2)
                  name_split_right[[split_num]] <- split[,1]
                  name_split_right[[split_num+1]] <- split[,2]
                }

                # After we finish splitting, return the LAST value since we split
                alternate_field_right <- name_split_right[[num_of_splits]]

                # Clean up after ourselves
                rm(name_split_right)
                gc()
              }
              else{
                alternate_field_right <- right_dataset[[dataset_field]]
              }

              # Put the alternate values back into the datasets
              left_dataset[[paste0(dataset_field, "_alt_block")]] <- alternate_field_left
              right_dataset[[paste0(dataset_field, "_alt_block")]] <- alternate_field_right

              # Add to our list of blocking keys
              blocking_keys <- append(blocking_keys, paste0(dataset_field, "_alt_block"))

              # Rename the row of blocking keys to the "_alt_block" version incase other linkage rules are being used
              blocking_keys_df$left_dataset_field[row_num]  <- paste0(dataset_field, "_alt_block")
              blocking_keys_df$right_dataset_field[row_num] <- paste0(dataset_field, "_alt_block")
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

        # If we are planning on using the "alternative field" linkage rule for matching fields,
        # then we need to error handle it
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
            if("alternate_field_value_left" %in% names(linkage_rules) || "alternate_field_value_right" %in% names(linkage_rules)){
              # Get the field we are blocking on
              dataset_field <- row$left_dataset_field

              # If a left alt value was provided, then split it and get the value
              if("alternate_field_value_left" %in% names(linkage_rules)){
                # Get the number of splits we expect to do
                num_of_splits <- linkage_rules$alternate_field_value_left

                # Create some vectors for storing the split name fields (left and right)
                name_split_left <- vector("list", num_of_splits + 1)
                name_split_left[[1]] <- left_dataset[[dataset_field]]

                # Loop until we reach the split field we want
                for(split_num in 1:num_of_splits){
                  # Clean up by trimming white space
                  name_split_left[[split_num]] <- trimws(name_split_left[[split_num]], "both")

                  # Split the name in half and store the results
                  split <- str_split_fixed(name_split_left[[split_num]], ' ', n = 2)
                  name_split_left[[split_num]] <- split[,1]
                  name_split_left[[split_num+1]] <- split[,2]
                }

                # After we finish splitting, return the LAST value since we split
                alternate_field_left <- name_split_left[[num_of_splits]]

                # Clean up after ourselves
                rm(name_split_left)
                gc()
              }
              else{
                alternate_field_left <- left_dataset[[dataset_field]]
              }

              # If a right alt value was provided, then split it and get the value
              if("alternate_field_value_right" %in% names(linkage_rules)){
                # Get the number of splits we expect to do
                num_of_splits <- linkage_rules$alternate_field_value_right

                # Create some vectors for storing the split name fields (left and right)
                name_split_right <- vector("list", num_of_splits + 1)
                name_split_right[[1]] <- right_dataset[[dataset_field]]

                # Loop until we reach the split field we want
                for(split_num in 1:num_of_splits){
                  # Clean up by trimming white space
                  name_split_right[[split_num]] <- trimws(name_split_right[[split_num]], "both")

                  # Split the name in half and store the results
                  split <- str_split_fixed(name_split_right[[split_num]], ' ', n = 2)
                  name_split_right[[split_num]] <- split[,1]
                  name_split_right[[split_num+1]] <- split[,2]
                }

                # After we finish splitting, return the LAST value since we split
                alternate_field_right <- name_split_right[[num_of_splits]]

                # Clean up after ourselves
                rm(name_split_right)
                gc()
              }
              else{
                alternate_field_right <- right_dataset[[dataset_field]]
              }

              # Put the alternate values back into the datasets
              left_dataset[[paste0(dataset_field, "_alt_match")]] <- alternate_field_left
              right_dataset[[paste0(dataset_field, "_alt_match")]] <- alternate_field_right
            }
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
            if("alternate_field_value_left" %in% names(linkage_rules) || "alternate_field_value_right" %in% names(linkage_rules)){
              # Get the field we are blocking on
              dataset_field <- row$left_dataset_field

              # If a left alt value was provided, then split it and get the value
              if("alternate_field_value_left" %in% names(linkage_rules)){
                # Get the number of splits we expect to do
                num_of_splits <- linkage_rules$alternate_field_value_left

                # Create some vectors for storing the split name fields (left and right)
                name_split_left <- vector("list", num_of_splits + 1)
                name_split_left[[1]] <- left_dataset[[dataset_field]]

                # Loop until we reach the split field we want
                for(split_num in 1:num_of_splits){
                  # Clean up by trimming white space
                  name_split_left[[split_num]] <- trimws(name_split_left[[split_num]], "both")

                  # Split the name in half and store the results
                  split <- str_split_fixed(name_split_left[[split_num]], ' ', n = 2)
                  name_split_left[[split_num]] <- split[,1]
                  name_split_left[[split_num+1]] <- split[,2]
                }

                # After we finish splitting, return the LAST value since we split
                alternate_field_left <- name_split_left[[num_of_splits]]

                # Clean up after ourselves
                rm(name_split_left)
                gc()
              }
              else{
                alternate_field_left <- left_dataset[[dataset_field]]
              }

              # If a right alt value was provided, then split it and get the value
              if("alternate_field_value_right" %in% names(linkage_rules)){
                # Get the number of splits we expect to do
                num_of_splits <- linkage_rules$alternate_field_value_right

                # Create some vectors for storing the split name fields (left and right)
                name_split_right <- vector("list", num_of_splits + 1)
                name_split_right[[1]] <- right_dataset[[dataset_field]]

                # Loop until we reach the split field we want
                for(split_num in 1:num_of_splits){
                  # Clean up by trimming white space
                  name_split_right[[split_num]] <- trimws(name_split_right[[split_num]], "both")

                  # Split the name in half and store the results
                  split <- str_split_fixed(name_split_right[[split_num]], ' ', n = 2)
                  name_split_right[[split_num]] <- split[,1]
                  name_split_right[[split_num+1]] <- split[,2]
                }

                # After we finish splitting, return the LAST value since we split
                alternate_field_right <- name_split_right[[num_of_splits]]

                # Clean up after ourselves
                rm(name_split_right)
                gc()
              }
              else{
                alternate_field_right <- right_dataset[[dataset_field]]
              }

              # Put the alternate values back into the datasets
              left_dataset[[paste0(dataset_field, "_alt_match")]] <- alternate_field_left
              right_dataset[[paste0(dataset_field, "_alt_match")]] <- alternate_field_right

              # Add to our list of blocking keys
              matching_keys <- append(matching_keys, paste0(dataset_field, "_alt_match"))

              # Rename the row of blocking keys to the "_alt_match" version incase other linkage rules are being used
              matching_keys_df$left_dataset_field[row_num]  <- paste0(dataset_field, "_alt_match")
              matching_keys_df$right_dataset_field[row_num] <- paste0(dataset_field, "_alt_match")
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

          # Make sure the comparison rules aren't NA
          if(!is.na(comparison_rules_json)){
            comparison_rules <- jsonlite::fromJSON(comparison_rules_json)

            # Get the field we'll apply the comparison rules to
            dataset_field <- row$left_dataset_field

            # Quick error handling check, if we used the ALTERNATIVE FIELD VALUE linkage rule, use that new field instead!
            if(paste0(dataset_field, "_alt_match") %in% matching_keys){
              dataset_field <- paste0(dataset_field, "_alt_match")
            }

            # Based on the comparison rule, map it to the appropriate function
            if("jw_score" %in% names(comparison_rules)){
              # "jw_score" uses the Reclin2 cmp_jarowinkler function, so get the value
              threshold <- comparison_rules[["jw_score"]]

              # Keep track of this comparison rule
              comparison_rules_list[[dataset_field]] <- reclin2::cmp_jarowinkler(threshold)
            }
            else if ("numeric_tolerance" %in% names(comparison_rules)){
              # custom "numeric error tolerance" function
              numeric_error_tolerance <- function(tolerance){
                function(x , y){
                  if(!missing(x) && !missing(y)){
                    within_tolerance <- ifelse(is.na(x) | is.na(y),
                                               FALSE,
                                               abs(x - y) <= tolerance)
                    return(within_tolerance)
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
            else if ("date_tolerance" %in% names(comparison_rules)){
              # Custom "date error tolerance" function
              date_error_tolerance <- function(tolerance){
                function(x , y){
                  if(!missing(x) && !missing(y)){
                    # Convert values to dates
                    x = as.Date(x, format = "%m/%d/%Y")
                    y = as.Date(y, format = "%m/%d/%Y")

                    # Determine if the date is within error tolerance
                    within_tolerance <- ifelse(is.na(x) | is.na(y),
                                               FALSE,
                                               abs(x - y) <= tolerance)
                    return(within_tolerance)
                  }
                  else{
                    return(FALSE)
                  }
                }
              }

              # Get the tolerance value
              tolerance <- comparison_rules[["date_tolerance"]]

              # Keep track of this comparison rule
              comparison_rules_list[[dataset_field]] <- date_error_tolerance(tolerance)
            }
            else if ("levenshtein_string_cost" %in% names(comparison_rules)){
              # Custom "levenshtein distance" function
              levenshtein_string_dist <- function(dist){
                function(x, y){
                  if(!missing(x) && !missing(y)){
                    within_tolerance <- ifelse(is.na(x) | is.na(y),
                                               FALSE,
                                               stringdist::stringdist(x, y, method = "lv") <= dist)
                    return(within_tolerance)
                  }
                  else{
                    return(FALSE)
                  }
                }
              }

              # Get the levenshtein distance value
              dist <- comparison_rules[["levenshtein_string_cost"]]

              # Keep track of this comparison rule
              comparison_rules_list[[dataset_field]] <- levenshtein_string_dist(dist)
            }
            else if ("damerau_levenshtein_string_cost" %in% names(comparison_rules)){
              # Custom "damerau levenshtein distance" function
              damerau_levenshtein_string_dist <- function(dist){
                function(x, y){
                  if(!missing(x) && !missing(y)){
                    within_tolerance <- ifelse(is.na(x) | is.na(y),
                                               FALSE,
                                               stringdist::stringdist(x, y, method = "dl") <= dist)
                    return(within_tolerance)
                  }
                  else{
                    return(FALSE)
                  }
                }
              }

              # Get the levenshtein distance value
              dist <- comparison_rules[["damerau_levenshtein_string_cost"]]

              # Keep track of this comparison rule
              comparison_rules_list[[dataset_field]] <- damerau_levenshtein_string_dist(dist)
            }
            else if ("to_soundex" %in% names(comparison_rules)){
              # Custom "soundex match" function
              soundex_dist <- function(){
                function(x, y){
                  if(!missing(x) && !missing(y)){
                    within_tolerance <- ifelse(is.na(x) | is.na(y),
                                               FALSE,
                                               stringdist::stringdist(x, y, method = "soundex") == 0)
                    return(within_tolerance)
                  }
                  else{
                    return(FALSE)
                  }
                }
              }

              # Keep track of this comparison rule
              comparison_rules_list[[dataset_field]] <- soundex_dist()
            }
            else if ("reference_val_index" %in% names(comparison_rules) && "relative_diff_tolerance" %in% names(comparison_rules)){
              # custom "relative difference tolerance" function
              relative_difference_tolerance <- function(tolerance, index){
                function(x , y){
                  if(!missing(x) && !missing(y)){
                    if(index == 1){
                      within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                 FALSE,
                                                 (abs(x - y)/x) <= tolerance)
                      return(within_tolerance)
                    }
                    else if (index == 2){
                      within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                 FALSE,
                                                 (abs(x - y)/y) <= tolerance)
                      return(within_tolerance)
                    }
                    else return(FALSE)
                  }
                  else{
                    return(FALSE)
                  }
                }
              }

              # Get the tolerance value
              tolerance <- comparison_rules[["relative_diff_tolerance"]]
              ref_index <- comparison_rules[["reference_val_index"]]

              # Keep track of this comparison rule
              comparison_rules_list[[dataset_field]] <- relative_difference_tolerance(tolerance, ref_index)
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
        # Get the acceptance threshold for this iteration
        acceptance_threshold <- get_acceptence_thresholds(linkage_metadata_db, iteration_id)

        # Select pairs using the user defined acceptance thresholds
        if("posterior_threshold" %in% names(acceptance_threshold)){
          posterior_threshold <- acceptance_threshold[["posterior_threshold"]]
          # Filter out rows with NA in 'mpost'
          linkage_pairs <- linkage_pairs[!is.na(linkage_pairs$mpost), ]
          select_greedy(linkage_pairs, variable = "selected", score = "mpost", threshold = posterior_threshold, include_ties = TRUE, inplace = TRUE)
          #select_threshold(linkage_pairs, variable = "selected", score = "mpost", threshold = posterior_threshold, include_ties = TRUE, inplace = TRUE) #IF WE WANT DUPES
        }
        else if ("match_weight" %in% names(acceptance_threshold)){
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
          comparison_rules_list_gt <- list()
          if(nrow(ground_truth_df) > 0){
            # First, check if the blocking or matching keys is using the ground truth
            for(index in 1:nrow(ground_truth_df)){
              # Check if the column is one of our blocking or matching keys, if not, then keep it as is, if so, rename it
              if(paste0(ground_truth_df$left_dataset_field[index], "_renamed") %in% matching_keys_df$left_dataset_field){
                ground_truth_df$left_dataset_field[index] <- paste0(ground_truth_df$left_dataset_field[index], "_renamed")
                ground_truth_df$right_dataset_field[index] <- paste0(ground_truth_df$left_dataset_field[index])
              }
              else if(paste0(ground_truth_df$left_dataset_field[index], "_renamed") %in% blocking_keys_df$left_dataset_field){
                ground_truth_df$left_dataset_field[index] <- paste0(ground_truth_df$left_dataset_field[index], "_renamed")
                ground_truth_df$right_dataset_field[index] <- paste0(ground_truth_df$left_dataset_field[index])
              }
              else if(paste0(ground_truth_df$left_dataset_field[index], "_renamed_alt_match") %in% matching_keys_df$left_dataset_field){
                ground_truth_df$left_dataset_field[index] <- paste0(ground_truth_df$left_dataset_field[index], "_renamed")
                ground_truth_df$right_dataset_field[index] <- paste0(ground_truth_df$left_dataset_field[index])
              }
              else if(paste0(ground_truth_df$left_dataset_field[index], "_renamed_alt_block") %in% blocking_keys_df$left_dataset_field){
                ground_truth_df$left_dataset_field[index] <- paste0(ground_truth_df$left_dataset_field[index], "_renamed")
                ground_truth_df$right_dataset_field[index] <- paste0(ground_truth_df$left_dataset_field[index])
              }
            }

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

              # Get the comparison rules for the current row
              comparison_rules_json <- row$comparison_rules

              # Make sure the comparison rules aren't NA
              if(!is.na(comparison_rules_json)){
                comparison_rules <- jsonlite::fromJSON(comparison_rules_json)

                # Get the field we'll apply the comparison rules to
                dataset_field <- row$left_dataset_field

                # Based on the comparison rule, map it to the appropriate function
                if("jw_score" %in% names(comparison_rules)){
                  # "jw_score" uses the Reclin2 cmp_jarowinkler function, so get the value
                  threshold <- comparison_rules[["jw_score"]]

                  # Keep track of this comparison rule
                  comparison_rules_list_gt[[dataset_field]] <- reclin2::cmp_jarowinkler(threshold)
                }
                else if ("numeric_tolerance" %in% names(comparison_rules)){
                  # custom "numeric error tolerance" function
                  numeric_error_tolerance <- function(tolerance){
                    function(x , y){
                      if(!missing(x) && !missing(y)){
                        within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                   FALSE,
                                                   abs(x - y) <= tolerance)
                        return(within_tolerance)
                      }
                      else{
                        return(FALSE)
                      }
                    }
                  }

                  # Get the tolerance value
                  tolerance <- comparison_rules[["numeric_tolerance"]]

                  # Keep track of this comparison rule
                  comparison_rules_list_gt[[dataset_field]] <- numeric_error_tolerance(tolerance)
                }
                else if ("date_tolerance" %in% names(comparison_rules)){
                  # Custom "date error tolerance" function
                  date_error_tolerance <- function(tolerance){
                    function(x , y){
                      if(!missing(x) && !missing(y)){
                        # Convert values to dates
                        x = as.Date(x, format = "%m/%d/%Y")
                        y = as.Date(y, format = "%m/%d/%Y")

                        # Determine if the date is within error tolerance
                        within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                   FALSE,
                                                   abs(x - y) <= tolerance)
                        return(within_tolerance)
                      }
                      else{
                        return(FALSE)
                      }
                    }
                  }

                  # Get the tolerance value
                  tolerance <- comparison_rules[["date_tolerance"]]

                  # Keep track of this comparison rule
                  comparison_rules_list_gt[[dataset_field]] <- date_error_tolerance(tolerance)
                }
                else if ("levenshtein_string_cost" %in% names(comparison_rules)){
                  # Custom "levenshtein distance" function
                  levenshtein_string_dist <- function(dist){
                    function(x, y){
                      if(!missing(x) && !missing(y)){
                        within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                   FALSE,
                                                   stringdist::stringdist(x, y, method = "lv") <= dist)
                        return(within_tolerance)
                      }
                      else{
                        return(FALSE)
                      }
                    }
                  }

                  # Get the levenshtein distance value
                  dist <- comparison_rules[["levenshtein_string_cost"]]

                  # Keep track of this comparison rule
                  comparison_rules_list_gt[[dataset_field]] <- levenshtein_string_dist(dist)
                }
                else if ("damerau_levenshtein_string_cost" %in% names(comparison_rules)){
                  # Custom "damerau levenshtein distance" function
                  damerau_levenshtein_string_dist <- function(dist){
                    function(x, y){
                      if(!missing(x) && !missing(y)){
                        within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                   FALSE,
                                                   stringdist::stringdist(x, y, method = "dl") <= dist)
                        return(within_tolerance)
                      }
                      else{
                        return(FALSE)
                      }
                    }
                  }

                  # Get the levenshtein distance value
                  dist <- comparison_rules[["damerau_levenshtein_string_cost"]]

                  # Keep track of this comparison rule
                  comparison_rules_list_gt[[dataset_field]] <- damerau_levenshtein_string_dist(dist)
                }
                else if ("to_soundex" %in% names(comparison_rules)){
                  # Custom "soundex match" function
                  soundex_dist <- function(){
                    function(x, y){
                      if(!missing(x) && !missing(y)){
                        within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                   FALSE,
                                                   stringdist::stringdist(x, y, method = "soundex") == 0)
                        return(within_tolerance)
                      }
                      else{
                        return(FALSE)
                      }
                    }
                  }

                  # Keep track of this comparison rule
                  comparison_rules_list_gt[[dataset_field]] <- soundex_dist()
                }
                else if ("reference_val_index" %in% names(comparison_rules) && "relative_diff_tolerance" %in% names(comparison_rules)){
                  # custom "relative difference tolerance" function
                  relative_difference_tolerance <- function(tolerance, index){
                    function(x , y){
                      if(!missing(x) && !missing(y)){
                        if(index == 1){
                          within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                     FALSE,
                                                     (abs(x - y)/x) <= tolerance)
                          return(within_tolerance)
                        }
                        else if (index == 2){
                          within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                     FALSE,
                                                     (abs(x - y)/y) <= tolerance)
                          return(within_tolerance)
                        }
                        else return(FALSE)
                      }
                      else{
                        return(FALSE)
                      }
                    }
                  }

                  # Get the tolerance value
                  tolerance <- comparison_rules[["relative_diff_tolerance"]]
                  ref_index <- comparison_rules[["reference_val_index"]]

                  # Keep track of this comparison rule
                  comparison_rules_list_gt[[dataset_field]] <- relative_difference_tolerance(tolerance, ref_index)
                }
              }
            }

            # Get the left fields
            left_ground_truth_fields <- ground_truth_df$left_dataset_field

            # Get the right fields
            right_ground_truth_fields <- ground_truth_df$right_dataset_field
            #right_ground_truth_fields <- ground_truth_df$left_dataset_field # They're being renamed to match anyways so why not modify this?

            # For each of the ground truth fields, check if that ground truth is true, combine all truth values afterwards
            for(i in seq_along(left_ground_truth_fields)){
              # Get the field name
              field_name_left <- left_ground_truth_fields[i]
              field_name_right <- right_ground_truth_fields[i]

              # Check if comparator function exists
              comparator_function <- comparison_rules_list_gt[[field_name_left]]

              # If NULL, there is no comparator function, otherwise, use it
              if(!is.null(comparator_function)){
                linkage_pairs <- compare_vars(linkage_pairs, variable = paste0("truth_", i), on_x = field_name_left, on_y = field_name_right,
                                              comparator = comparator_function)
              }
              else{
                linkage_pairs <- compare_vars(linkage_pairs, variable = paste0("truth_", i), on_x = field_name_left, on_y = field_name_right)
              }
            }

            ## Create a final 'truth' column based on all the truth values (truth_1, truth_2, ...), then drop the temp truth columns
            # Get the list of temporary truth columns
            truth_columns <- paste0("truth_", seq_along(left_ground_truth_fields))
            suppressWarnings(linkage_pairs[, truth := Reduce(`&`, .SD), .SDcols = truth_columns])
            linkage_pairs[, (truth_columns) := NULL]

            # Filter out pairs with missing ground truth
            linkage_pairs_non_missing <- linkage_pairs[!is.na(linkage_pairs$truth),] # Works for now, more testing should be done

            # Add a "Match Type" column to identify what we color the plot as
            linkage_pairs_non_missing$match_type <- ifelse(linkage_pairs_non_missing$truth == TRUE, "Yes", "No")

            # Create the histogram, coloring based on match type
            candidate_weights_plot_gt <- ggplot(linkage_pairs_non_missing, aes(x = weight, fill = match_type)) +
              geom_histogram(binwidth = 0.05, position = "stack", alpha = 0.8) +
              scale_fill_manual(values = c("No" = "red", "Yes" = "blue"), name = "Agreement on Ground Truth") +
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

            # Get the ground truth fields
            ground_truth_df <- get_ground_truth_fields(linkage_metadata_db, algorithm_id)
            ground_truth_fields <- ""
            ground_truth_fields_vector <- c()
            if(nrow(ground_truth_df) > 0){
              for(j in 1:nrow(ground_truth_df)){
                # First, get the dataset field name
                field_name <- ground_truth_df$left_dataset_field[j]

                # Convert the field name to either upper, lower, or title case
                field_name <- convert_name_case(field_name)

                # Append the field name to the list of ground truth fields
                ground_truth_fields_vector <- append(ground_truth_fields_vector, field_name)
              }
            }

            # Collapse the ground truth fields into a single string
            ground_truth_fields <- paste(ground_truth_fields_vector, collapse = ", ")

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
        comparison_rules_list_gt <- list()
        has_ground_truth <- FALSE
        if(nrow(ground_truth_df) > 0){
          has_ground_truth <- TRUE

          # First, check if the blocking or matching keys is using the ground truth
          for(index in 1:nrow(ground_truth_df)){
            # Check if the column is one of our blocking or matching keys, if not, then keep it as is, if so, rename it
            if(paste0(ground_truth_df$left_dataset_field[index], "_renamed") %in% matching_keys_df$left_dataset_field){
              ground_truth_df$left_dataset_field[index] <- paste0(ground_truth_df$left_dataset_field[index], "_renamed")
              ground_truth_df$right_dataset_field[index] <- paste0(ground_truth_df$left_dataset_field[index])
            }
            else if(paste0(ground_truth_df$left_dataset_field[index], "_renamed") %in% blocking_keys_df$left_dataset_field){
              ground_truth_df$left_dataset_field[index] <- paste0(ground_truth_df$left_dataset_field[index], "_renamed")
              ground_truth_df$right_dataset_field[index] <- paste0(ground_truth_df$left_dataset_field[index])
            }
            else if(paste0(ground_truth_df$left_dataset_field[index], "_renamed_alt_match") %in% matching_keys_df$left_dataset_field){
              ground_truth_df$left_dataset_field[index] <- paste0(ground_truth_df$left_dataset_field[index], "_renamed")
              ground_truth_df$right_dataset_field[index] <- paste0(ground_truth_df$left_dataset_field[index])
            }
            else if(paste0(ground_truth_df$left_dataset_field[index], "_renamed_alt_block") %in% blocking_keys_df$left_dataset_field){
              ground_truth_df$left_dataset_field[index] <- paste0(ground_truth_df$left_dataset_field[index], "_renamed")
              ground_truth_df$right_dataset_field[index] <- paste0(ground_truth_df$left_dataset_field[index])
            }
          }

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

            # Get the comparison rules for the current row
            comparison_rules_json <- row$comparison_rules

            # Make sure the comparison rules aren't NA
            if(!is.na(comparison_rules_json)){
              comparison_rules <- jsonlite::fromJSON(comparison_rules_json)

              # Get the field we'll apply the comparison rules to
              dataset_field <- row$left_dataset_field

              # Based on the comparison rule, map it to the appropriate function
              if("jw_score" %in% names(comparison_rules)){
                # "jw_score" uses the Reclin2 cmp_jarowinkler function, so get the value
                threshold <- comparison_rules[["jw_score"]]

                # Keep track of this comparison rule
                comparison_rules_list_gt[[dataset_field]] <- reclin2::cmp_jarowinkler(threshold)
              }
              else if ("numeric_tolerance" %in% names(comparison_rules)){
                # custom "numeric error tolerance" function
                numeric_error_tolerance <- function(tolerance){
                  function(x , y){
                    if(!missing(x) && !missing(y)){
                      within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                 FALSE,
                                                 abs(x - y) <= tolerance)
                      return(within_tolerance)
                    }
                    else{
                      return(FALSE)
                    }
                  }
                }

                # Get the tolerance value
                tolerance <- comparison_rules[["numeric_tolerance"]]

                # Keep track of this comparison rule
                comparison_rules_list_gt[[dataset_field]] <- numeric_error_tolerance(tolerance)
              }
              else if ("date_tolerance" %in% names(comparison_rules)){
                # Custom "date error tolerance" function
                date_error_tolerance <- function(tolerance){
                  function(x , y){
                    if(!missing(x) && !missing(y)){
                      # Convert values to dates
                      x = as.Date(x, format = "%m/%d/%Y")
                      y = as.Date(y, format = "%m/%d/%Y")

                      # Determine if the date is within error tolerance
                      within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                 FALSE,
                                                 abs(x - y) <= tolerance)
                      return(within_tolerance)
                    }
                    else{
                      return(FALSE)
                    }
                  }
                }

                # Get the tolerance value
                tolerance <- comparison_rules[["date_tolerance"]]

                # Keep track of this comparison rule
                comparison_rules_list_gt[[dataset_field]] <- date_error_tolerance(tolerance)
              }
              else if ("levenshtein_string_cost" %in% names(comparison_rules)){
                # Custom "levenshtein distance" function
                levenshtein_string_dist <- function(dist){
                  function(x, y){
                    if(!missing(x) && !missing(y)){
                      within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                 FALSE,
                                                 stringdist::stringdist(x, y, method = "lv") <= dist)
                      return(within_tolerance)
                    }
                    else{
                      return(FALSE)
                    }
                  }
                }

                # Get the levenshtein distance value
                dist <- comparison_rules[["levenshtein_string_cost"]]

                # Keep track of this comparison rule
                comparison_rules_list_gt[[dataset_field]] <- levenshtein_string_dist(dist)
              }
              else if ("damerau_levenshtein_string_cost" %in% names(comparison_rules)){
                # Custom "damerau levenshtein distance" function
                damerau_levenshtein_string_dist <- function(dist){
                  function(x, y){
                    if(!missing(x) && !missing(y)){
                      within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                 FALSE,
                                                 stringdist::stringdist(x, y, method = "dl") <= dist)
                      return(within_tolerance)
                    }
                    else{
                      return(FALSE)
                    }
                  }
                }

                # Get the levenshtein distance value
                dist <- comparison_rules[["damerau_levenshtein_string_cost"]]

                # Keep track of this comparison rule
                comparison_rules_list_gt[[dataset_field]] <- damerau_levenshtein_string_dist(dist)
              }
              else if ("to_soundex" %in% names(comparison_rules)){
                # Custom "soundex match" function
                soundex_dist <- function(){
                  function(x, y){
                    if(!missing(x) && !missing(y)){
                      within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                 FALSE,
                                                 stringdist::stringdist(x, y, method = "soundex") == 0)
                      return(within_tolerance)
                    }
                    else{
                      return(FALSE)
                    }
                  }
                }

                # Keep track of this comparison rule
                comparison_rules_list_gt[[dataset_field]] <- soundex_dist()
              }
              else if ("reference_val_index" %in% names(comparison_rules) && "relative_diff_tolerance" %in% names(comparison_rules)){
                # custom "relative difference tolerance" function
                relative_difference_tolerance <- function(tolerance, index){
                  function(x , y){
                    if(!missing(x) && !missing(y)){
                      if(index == 1){
                        within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                   FALSE,
                                                   (abs(x - y)/x) <= tolerance)
                        return(within_tolerance)
                      }
                      else if (index == 2){
                        within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                   FALSE,
                                                   (abs(x - y)/y) <= tolerance)
                        return(within_tolerance)
                      }
                      else return(FALSE)
                    }
                    else{
                      return(FALSE)
                    }
                  }
                }

                # Get the tolerance value
                tolerance <- comparison_rules[["relative_diff_tolerance"]]
                ref_index <- comparison_rules[["reference_val_index"]]

                # Keep track of this comparison rule
                comparison_rules_list_gt[[dataset_field]] <- relative_difference_tolerance(tolerance, ref_index)
              }
            }
          }

          # Get the left fields
          left_ground_truth_fields <- ground_truth_df$left_dataset_field

          # Get the right fields
          right_ground_truth_fields <- ground_truth_df$right_dataset_field
          #right_ground_truth_fields <- ground_truth_df$left_dataset_field # They're being renamed to match anyways so why not modify this?

          # For each of the ground truth fields, check if that ground truth is true, combine all truth values afterwards
          for(i in seq_along(left_ground_truth_fields)){
            # Get the field name
            field_name_left <- left_ground_truth_fields[i]
            field_name_right <- right_ground_truth_fields[i]

            # Check if comparator function exists
            comparator_function <- comparison_rules_list_gt[[field_name_left]]

            # If NULL, there is no comparator function, otherwise, use it
            if(!is.null(comparator_function)){
              linkage_pairs <- compare_vars(linkage_pairs, variable = paste0("truth_", i), on_x = field_name_left, on_y = field_name_right,
                                            comparator = comparator_function)
            }
            else{
              linkage_pairs <- compare_vars(linkage_pairs, variable = paste0("truth_", i), on_x = field_name_left, on_y = field_name_right)
            }
          }

          ## Create a final 'truth' column based on all the truth values (truth_1, truth_2, ...), then drop the temp truth columns
          # Get the list of temporary truth columns
          truth_columns <- paste0("truth_", seq_along(left_ground_truth_fields))
          suppressWarnings(linkage_pairs[, truth := Reduce(`&`, .SD), .SDcols = truth_columns])
          linkage_pairs[, (truth_columns) := NULL]

          ## Compare variables to get the truth
          #if(length(comparison_rules_list_gt) > 0){
          #  linkage_pairs <- compare_vars(linkage_pairs, variable = "truth", on_x = left_ground_truth_fields, on_y = right_ground_truth_fields,
          #                                comparator = comparison_rules_list_gt)
          #}
          #else{
          #  linkage_pairs <- compare_vars(linkage_pairs, variable = "truth", on_x = left_ground_truth_fields, on_y = right_ground_truth_fields)
          #}
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

          # Get the column and row names
          specificity_table_col_names <- colnames(specificity_table)
          specificity_table_row_names <- row.names(specificity_table)

          # Extract TP, TN, FP, FN
          TP <- ifelse(("TRUE" %in% specificity_table_row_names && "TRUE" %in% specificity_table_col_names),
                       specificity_table["TRUE", "TRUE"], 0) # True Positives
          TN <- ifelse(("FALSE" %in% specificity_table_row_names && "FALSE" %in% specificity_table_col_names),
                       specificity_table["FALSE", "FALSE"], 0) # True Negatives
          FP <- ifelse(("FALSE" %in% specificity_table_row_names && "TRUE" %in% specificity_table_col_names),
                       specificity_table["FALSE", "TRUE"], 0) # False Positives
          FN <- ifelse(("TRUE" %in% specificity_table_row_names && "FALSE" %in% specificity_table_col_names),
                       specificity_table["TRUE", "FALSE"], 0) # False Negatives

          # Create a named vector
          results_vector <- c(TP = TP, TN = TN, FP = FP, FN = FN)

          # Store the results vector
          return_list[["performance_measure_variables"]] <- results_vector
        }

        ### Keep only the linked indices
        linked_dataset <- linked_dataset[!duplicated(linked_dataset$.x)]

        ### Return the unmodified linked dataset
        return_list[["linked_dataset"]] <- linked_dataset

        ### Create the data frame of the fields to be returned
        output_fields <- get_linkage_output_fields(linkage_metadata_db, algorithm_id)
        for(index in 1:nrow(output_fields)){
          # Check if the column is one of our blocking or matching keys, if not, then keep it as is, if so, rename it
          if(paste0(output_fields$field_name[index], "_renamed") %in% matching_keys_df$left_dataset_field){
            output_fields$field_name[index] <- paste0(output_fields$field_name[index], "_renamed")
          }
          else if(paste0(output_fields$field_name[index], "_renamed") %in% blocking_keys_df$left_dataset_field){
            output_fields$field_name[index] <- paste0(output_fields$field_name[index], "_renamed")
          }
          else if(paste0(output_fields$field_name[index], "_renamed_alt_match") %in% matching_keys_df$left_dataset_field){
            output_fields$field_name[index] <- paste0(output_fields$field_name[index], "_renamed")
          }
          else if(paste0(output_fields$field_name[index], "_renamed_alt_block") %in% blocking_keys_df$left_dataset_field){
            output_fields$field_name[index] <- paste0(output_fields$field_name[index], "_renamed")
          }
        }

        # Create a vector of field names with '.x' suffix to retain
        fields_to_keep <- ifelse(output_fields$field_name %in% colnames(linked_dataset), paste0(output_fields$field_name), paste0(output_fields$field_name, ".x"))

        # Append the stage to keep
        fields_to_keep <- append(fields_to_keep, "stage")
        if("capture_month_time_trend_field" %in% colnames(linked_dataset) && "capture_year_time_trend_field" %in% colnames(linked_dataset)){
          fields_to_keep <- append(fields_to_keep, c("capture_month_time_trend_field", "capture_year_time_trend_field"))
        }

        # Select only those columns from linked_dataset that match the fields_to_keep
        filtered_data <- linked_dataset %>% select(all_of(fields_to_keep))

        # Rename the fields with suffix '.x' to have it removed.
        filtered_data <- filtered_data %>% rename_with(~ gsub("\\.x$", "", .), ends_with(".x"))

        # Rename the fields with suffix '_renamed' to have it removed.
        filtered_data <- filtered_data %>% rename_with(~ gsub("\\_renamed$", "", .), ends_with("_renamed"))

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
          if("log_scaled_plots" %in% names(extra_parameters) && extra_parameters[["log_scaled_plots"]] == T){
            decision_boundary <- ggplot(linkage_pairs, aes(x = mpost, fill = selected_label)) +
              geom_histogram(binwidth = 0.05, position = "identity", alpha = 0.8) +
              scale_fill_manual(values = c("Miss" = "red", "Match" = "blue"), name = "Selection Status") +
              labs(x = "Posterior Score", y = "Frequency") +
              geom_vline(aes(xintercept = acceptance_threshold, linetype = "Acceptance Threshold"),
                         color = "black", size = 0.6) +
              scale_linetype_manual(values = c("Acceptance Threshold" = "dashed"), name = "") +
              guides(linetype = guide_legend(override.aes = list(size = 0.5))) +
              scale_y_log10(oob = scales::squish_infinite) + # This line stops the 0 values from appearing at the bottom
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
          }
          else{
            decision_boundary <- ggplot(linkage_pairs, aes(x = mpost, fill = selected_label)) +
              geom_histogram(binwidth = 0.05, position = "stack", alpha = 0.8) +
              scale_fill_manual(values = c("Miss" = "red", "Match" = "blue"), name = "Selection Status") +
              labs(x = "Posterior Score", y = "Frequency") +
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
          }

          algorithm_name <- get_algorithm_name(linkage_metadata_db, algorithm_id)
          ground_truth_fields <- paste(get_ground_truth_fields(linkage_metadata_db, algorithm_id)$left_dataset_field, collapse = ", ")
          linkage_pairs_count <- nrow(linkage_pairs)
          caption <- paste0('Posterior distribution for candidate record pairs (N=', linkage_pairs_count, ') that were classified using an acceptance threshold of ', acceptance_threshold, ' in ', iteration_name, ' of the linkage algorithm.')
          plot_list[["decision_boundary_plot"]] <- decision_boundary
          plot_caps_list <- append(plot_caps_list, caption)

          # Create the second plot of the subset of candidate pair records (IF GROUND TRUTH IS PROVIDED)
          if(has_ground_truth){
            # Filter out pairs with missing ground truth
            linkage_pairs_non_missing <- linkage_pairs[!is.na(linkage_pairs$truth),] # Works for now, more testing should be done

            # Add a "Match Type" column to identify what we color the plot as
            linkage_pairs_non_missing$match_type <- ifelse(linkage_pairs_non_missing$truth == TRUE, "Yes", "No")

            # Create the histogram, coloring based on match type
            if("log_scaled_plots" %in% names(extra_parameters) && extra_parameters[["log_scaled_plots"]] == T){
              candidate_weights_plot_gt <- ggplot(linkage_pairs_non_missing, aes(x = mpost, fill = match_type)) +
                geom_histogram(binwidth = 0.05, position = "identity", alpha = 0.8) +
                scale_fill_manual(values = c("No" = "red", "Yes" = "blue"), name = "Agreement on Ground Truth") +
                labs(x = "Posterior Score", y = "Frequency") +
                geom_vline(aes(xintercept = acceptance_threshold, linetype = "Acceptance Threshold"),
                           color = "black", size = 0.6) +
                scale_linetype_manual(values = c("Acceptance Threshold" = "dashed"), name = "") +
                guides(linetype = guide_legend(override.aes = list(size = 0.5))) +  # Adjust line size in legend
                scale_y_log10(oob = scales::squish_infinite) + # This line stops the 0 values from appearing at the bottom
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
            }
            else{
              candidate_weights_plot_gt <- ggplot(linkage_pairs_non_missing, aes(x = mpost, fill = match_type)) +
                geom_histogram(binwidth = 0.05, position = "stack", alpha = 0.8) +
                scale_fill_manual(values = c("No" = "red", "Yes" = "blue"), name = "Agreement on Ground Truth") +
                labs(x = "Posterior Score", y = "Frequency") +
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
            }

            algorithm_name <- get_algorithm_name(linkage_metadata_db, algorithm_id)
            iteration_name <- get_iteration_name(linkage_metadata_db, iteration_id)

            # Get the ground truth fields
            ground_truth_df <- get_ground_truth_fields(linkage_metadata_db, algorithm_id)
            ground_truth_fields <- ""
            ground_truth_fields_vector <- c()
            if(nrow(ground_truth_df) > 0){
              for(j in 1:nrow(ground_truth_df)){
                # First, get the dataset field name
                field_name <- ground_truth_df$left_dataset_field[j]

                # Convert the field name to either upper, lower, or title case
                field_name <- convert_name_case(field_name)

                # Append the field name to the list of ground truth fields
                ground_truth_fields_vector <- append(ground_truth_fields_vector, field_name)
              }
            }

            # Collapse the ground truth fields into a single string
            ground_truth_fields <- paste(ground_truth_fields_vector, collapse = ", ")

            # Get the count of non missing ground truth fields for the candidate pairs
            ground_truth_non_missing_count <- nrow(linkage_pairs_non_missing)
            linkage_pairs_count            <- nrow(linkage_pairs)
            ground_truth_non_missing_pct   <- round((ground_truth_non_missing_count/linkage_pairs_count) * 100, 1)

            caption <- paste0('Posterior distribution for candidate record pairs with non-missing ground truth information (', ground_truth_fields, ', ',
                              'N=', ground_truth_non_missing_count, ', ', ground_truth_non_missing_pct, '%) that were classified using an acceptance threshold of ', acceptance_threshold, ' in ', iteration_name, ' of the linkage algorithm.')

            plot_list[["decision_boundary_plot_ground_truth"]] <- candidate_weights_plot_gt
            plot_caps_list <- append(plot_caps_list, caption)
          }

          ### Return the plot list
          return_list[["threshold_plots"]] <- plot_list

          ### Returned the plot captions
          return_list[["plot_captions"]] <- plot_caps_list
        }
        else if ("match_weight" %in% names(acceptance_threshold)){
          acceptance_threshold <- acceptance_threshold[["match_weight"]]
          # Create a histogram of the weights with the decision boundary
          if("log_scaled_plots" %in% names(extra_parameters) && extra_parameters[["log_scaled_plots"]] == T){
            decision_boundary <- ggplot(linkage_pairs, aes(x = weight, fill = selected_label)) +
              geom_histogram(binwidth = 0.05, position = "identity", alpha = 0.8) +
              scale_fill_manual(values = c("Miss" = "red", "Match" = "blue"), name = "Selection Status") +
              labs(x = "Match Weight", y = "Frequency") +
              geom_vline(aes(xintercept = acceptance_threshold, linetype = "Acceptance Threshold"),
                         color = "black", size = 0.6) +
              scale_linetype_manual(values = c("Acceptance Threshold" = "dashed"), name = "") +
              guides(linetype = guide_legend(override.aes = list(size = 0.5))) +
              scale_y_log10(oob = scales::squish_infinite) + # This line stops the 0 values from appearing at the bottom
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
          }
          else{
            decision_boundary <- ggplot(linkage_pairs, aes(x = weight, fill = selected_label)) +
              geom_histogram(binwidth = 0.05, position = "stack", alpha = 0.8) +
              scale_fill_manual(values = c("Miss" = "red", "Match" = "blue"), name = "Selection Status") +
              labs(x = "Match Weight", y = "Frequency") +
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
          }

          algorithm_name <- get_algorithm_name(linkage_metadata_db, algorithm_id)
          ground_truth_fields <- paste(get_ground_truth_fields(linkage_metadata_db, algorithm_id)$left_dataset_field, collapse = ", ")
          linkage_pairs_count <- nrow(linkage_pairs)
          caption <- paste0('Match weight distribution for candidate record pairs (N=', linkage_pairs_count, ') that were classified using an acceptance threshold of ', acceptance_threshold, ' in ', iteration_name, ' of the linkage algorithm.')
          plot_list[["decision_boundary_plot"]] <- decision_boundary
          plot_caps_list <- append(plot_caps_list, caption)

          # Create the second plot of the subset of candidate pair records (IF GROUND TRUTH IS PROVIDED)
          if(has_ground_truth){
            # Filter out pairs with missing ground truth
            linkage_pairs_non_missing <- linkage_pairs[!is.na(linkage_pairs$truth),]

            # Add a "Match Type" column to identify what we color the plot as
            linkage_pairs_non_missing$match_type <- ifelse(linkage_pairs_non_missing$truth == TRUE, "Yes", "No")

            # Create the histogram, coloring based on match type
            if("log_scaled_plots" %in% names(extra_parameters) && extra_parameters[["log_scaled_plots"]] == T){
              candidate_weights_plot_gt <- ggplot(linkage_pairs_non_missing, aes(x = weight, fill = match_type)) +
                geom_histogram(binwidth = 0.05, position = "identity", alpha = 0.8) +
                scale_fill_manual(values = c("No" = "red", "Yes" = "blue"), name = "Agreement on Ground Truth") +
                labs(x = "Match Weight", y = "Frequency") +
                geom_vline(aes(xintercept = acceptance_threshold, linetype = "Acceptance Threshold"),
                           color = "black", size = 0.6) +
                scale_linetype_manual(values = c("Acceptance Threshold" = "dashed"), name = "") +
                guides(linetype = guide_legend(override.aes = list(size = 0.5))) +  # Adjust line size in legend
                scale_y_log10(oob = scales::squish_infinite) + # This line stops the 0 values from appearing at the bottom
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
            }
            else{
              candidate_weights_plot_gt <- ggplot(linkage_pairs_non_missing, aes(x = weight, fill = match_type)) +
                geom_histogram(binwidth = 0.05, position = "stack", alpha = 0.8) +
                scale_fill_manual(values = c("No" = "red", "Yes" = "blue"), name = "Agreement on Ground Truth") +
                labs(x = "Match Weight", y = "Frequency") +
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
            }

            algorithm_name <- get_algorithm_name(linkage_metadata_db, algorithm_id)
            iteration_name <- get_iteration_name(linkage_metadata_db, iteration_id)

            # Get the ground truth fields
            ground_truth_df <- get_ground_truth_fields(linkage_metadata_db, algorithm_id)
            ground_truth_fields <- ""
            ground_truth_fields_vector <- c()
            if(nrow(ground_truth_df) > 0){
              for(j in 1:nrow(ground_truth_df)){
                # First, get the dataset field name
                field_name <- ground_truth_df$left_dataset_field[j]

                # Convert the field name to either upper, lower, or title case
                field_name <- convert_name_case(field_name)

                # Append the field name to the list of ground truth fields
                ground_truth_fields_vector <- append(ground_truth_fields_vector, field_name)
              }
            }

            # Collapse the ground truth fields into a single string
            ground_truth_fields <- paste(ground_truth_fields_vector, collapse = ", ")

            # Get the count of non missing ground truth fields for the candidate pairs
            ground_truth_non_missing_count <- nrow(linkage_pairs_non_missing)
            linkage_pairs_count            <- nrow(linkage_pairs)
            ground_truth_non_missing_pct   <- round((ground_truth_non_missing_count/linkage_pairs_count) * 100, 1)

            caption <- paste0('Match weight distribution for candidate record pairs with non-missing ground truth information (', ground_truth_fields, ', ',
                              'N=', ground_truth_non_missing_count, ', ', ground_truth_non_missing_pct, '%) that were classified using an acceptance threshold of ', acceptance_threshold, ' in ', iteration_name, ' of the linkage algorithm.')

            plot_list[["decision_boundary_plot_ground_truth"]] <- candidate_weights_plot_gt
            plot_caps_list <- append(plot_caps_list, caption)
          }

          ### Return the plot list
          return_list[["threshold_plots"]] <- plot_list

          ### Returned the plot captions
          return_list[["plot_captions"]] <- plot_caps_list
        }

        # Clean up
        rm(linkage_pairs, linked_dataset, filtered_data)
        gc()

        ### Return our list of return values
        return(return_list)
        #--------------------------#
      }
      else if (linkage_technique == "D") {
        # Capture the number of records going into this pass. This will serve as the denominator for the pass-wise linkage rate
        linkage_rate_denominator <- nrow(left_dataset)

        # Get the blocking keys
        blocking_keys_df <- get_blocking_keys(linkage_metadata_db, iteration_id)

        # Get the matching keys
        matching_keys_df <- get_matching_keys(linkage_metadata_db, iteration_id)

        ### BLOCKING CRITERIA
        # Step 1: Rename fields in the right dataset to temporary names
        for (row_num in 1:nrow(blocking_keys_df)) {
          row <- blocking_keys_df[row_num,]
          right_dataset_field_name <- row$right_dataset_field
          temp_field_name <- paste0("temp_", right_dataset_field_name)

          # Rename the right dataset field to the temporary name
          names(right_dataset)[names(right_dataset) == right_dataset_field_name] <- temp_field_name
        }

        # Step 2: Now rename the temporary fields to the left dataset field names
        for (row_num in 1:nrow(blocking_keys_df)) {
          row <- blocking_keys_df[row_num,]
          left_dataset_field_name <- row$left_dataset_field
          temp_field_name <- paste0("temp_", row$right_dataset_field)

          # Rename the temporary field to the desired left dataset field name
          names(right_dataset)[names(right_dataset) == temp_field_name] <- paste0(left_dataset_field_name, "_renamed")
          names(left_dataset)[names(left_dataset) == left_dataset_field_name] <- paste0(left_dataset_field_name, "_renamed")
        }

        ### MATCHING CRITERIA
        # Step 1: Rename fields in the right dataset to temporary names
        for (row_num in 1:nrow(matching_keys_df)) {
          row <- matching_keys_df[row_num,]
          right_dataset_field_name <- row$right_dataset_field
          temp_field_name <- paste0("temp_", right_dataset_field_name)

          # Rename the right dataset field to the temporary name
          names(right_dataset)[names(right_dataset) == right_dataset_field_name] <- temp_field_name
        }

        # Step 2: Now rename the temporary fields to the left dataset field names
        for (row_num in 1:nrow(matching_keys_df)) {
          row <- matching_keys_df[row_num,]
          left_dataset_field_name <- row$left_dataset_field
          temp_field_name <- paste0("temp_", row$right_dataset_field)

          # Rename the temporary field to the desired left dataset field name
          names(right_dataset)[names(right_dataset) == temp_field_name] <- paste0(left_dataset_field_name, "_renamed")
          names(left_dataset)[names(left_dataset) == left_dataset_field_name] <- paste0(left_dataset_field_name, "_renamed")
        }

        # Rename the data frames to have "_renamed" applied to them
        blocking_keys_df$left_dataset_field <- paste0(blocking_keys_df$left_dataset_field, "_renamed")
        matching_keys_df$left_dataset_field <- paste0(matching_keys_df$left_dataset_field, "_renamed")
        blocking_keys_df$right_dataset_field <- paste0(blocking_keys_df$right_dataset_field, "_renamed")
        matching_keys_df$right_dataset_field <- paste0(matching_keys_df$right_dataset_field, "_renamed")

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
            if("alternate_field_value_left" %in% names(linkage_rules) || "alternate_field_value_right" %in% names(linkage_rules)){
              # Get the field we are blocking on
              dataset_field <- row$left_dataset_field

              # If a left alt value was provided, then split it and get the value
              if("alternate_field_value_left" %in% names(linkage_rules)){
                # Get the number of splits we expect to do
                num_of_splits <- linkage_rules$alternate_field_value_left

                # Create some vectors for storing the split name fields (left and right)
                name_split_left <- vector("list", num_of_splits + 1)
                name_split_left[[1]] <- left_dataset[[dataset_field]]

                # Loop until we reach the split field we want
                for(split_num in 1:num_of_splits){
                  # Clean up by trimming white space
                  name_split_left[[split_num]] <- trimws(name_split_left[[split_num]], "both")

                  # Split the name in half and store the results
                  split <- str_split_fixed(name_split_left[[split_num]], ' ', n = 2)
                  name_split_left[[split_num]] <- split[,1]
                  name_split_left[[split_num+1]] <- split[,2]
                }

                # After we finish splitting, return the LAST value since we split
                alternate_field_left <- name_split_left[[num_of_splits]]

                # Clean up after ourselves
                rm(name_split_left)
                gc()
              }
              else{
                alternate_field_left <- left_dataset[[dataset_field]]
              }

              # If a right alt value was provided, then split it and get the value
              if("alternate_field_value_right" %in% names(linkage_rules)){
                # Get the number of splits we expect to do
                num_of_splits <- linkage_rules$alternate_field_value_right

                # Create some vectors for storing the split name fields (left and right)
                name_split_right <- vector("list", num_of_splits + 1)
                name_split_right[[1]] <- right_dataset[[dataset_field]]

                # Loop until we reach the split field we want
                for(split_num in 1:num_of_splits){
                  # Clean up by trimming white space
                  name_split_right[[split_num]] <- trimws(name_split_right[[split_num]], "both")

                  # Split the name in half and store the results
                  split <- str_split_fixed(name_split_right[[split_num]], ' ', n = 2)
                  name_split_right[[split_num]] <- split[,1]
                  name_split_right[[split_num+1]] <- split[,2]
                }

                # After we finish splitting, return the LAST value since we split
                alternate_field_right <- name_split_right[[num_of_splits]]

                # Clean up after ourselves
                rm(name_split_right)
                gc()
              }
              else{
                alternate_field_right <- right_dataset[[dataset_field]]
              }

              # Put the alternate values back into the datasets
              left_dataset[[paste0(dataset_field, "_alt_block")]] <- alternate_field_left
              right_dataset[[paste0(dataset_field, "_alt_block")]] <- alternate_field_right

              # Add to our list of blocking keys
              blocking_keys <- append(blocking_keys, paste0(dataset_field, "_alt_block"))

              # Rename the row of blocking keys to the "_alt_block" version incase other linkage rules are being used
              blocking_keys_df$left_dataset_field[row_num]  <- paste0(dataset_field, "_alt_block")
              blocking_keys_df$right_dataset_field[row_num] <- paste0(dataset_field, "_alt_block")
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

        # If we are planning on using the "alternative field" linkage rule for matching fields,
        # then we need to error handle it
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
            if("alternate_field_value_left" %in% names(linkage_rules) || "alternate_field_value_right" %in% names(linkage_rules)){
              # Get the field we are blocking on
              dataset_field <- row$left_dataset_field

              # If a left alt value was provided, then split it and get the value
              if("alternate_field_value_left" %in% names(linkage_rules)){
                # Get the number of splits we expect to do
                num_of_splits <- linkage_rules$alternate_field_value_left

                # Create some vectors for storing the split name fields (left and right)
                name_split_left <- vector("list", num_of_splits + 1)
                name_split_left[[1]] <- left_dataset[[dataset_field]]

                # Loop until we reach the split field we want
                for(split_num in 1:num_of_splits){
                  # Clean up by trimming white space
                  name_split_left[[split_num]] <- trimws(name_split_left[[split_num]], "both")

                  # Split the name in half and store the results
                  split <- str_split_fixed(name_split_left[[split_num]], ' ', n = 2)
                  name_split_left[[split_num]] <- split[,1]
                  name_split_left[[split_num+1]] <- split[,2]
                }

                # After we finish splitting, return the LAST value since we split
                alternate_field_left <- name_split_left[[num_of_splits]]

                # Clean up after ourselves
                rm(name_split_left)
                gc()
              }
              else{
                alternate_field_left <- left_dataset[[dataset_field]]
              }

              # If a right alt value was provided, then split it and get the value
              if("alternate_field_value_right" %in% names(linkage_rules)){
                # Get the number of splits we expect to do
                num_of_splits <- linkage_rules$alternate_field_value_right

                # Create some vectors for storing the split name fields (left and right)
                name_split_right <- vector("list", num_of_splits + 1)
                name_split_right[[1]] <- right_dataset[[dataset_field]]

                # Loop until we reach the split field we want
                for(split_num in 1:num_of_splits){
                  # Clean up by trimming white space
                  name_split_right[[split_num]] <- trimws(name_split_right[[split_num]], "both")

                  # Split the name in half and store the results
                  split <- str_split_fixed(name_split_right[[split_num]], ' ', n = 2)
                  name_split_right[[split_num]] <- split[,1]
                  name_split_right[[split_num+1]] <- split[,2]
                }

                # After we finish splitting, return the LAST value since we split
                alternate_field_right <- name_split_right[[num_of_splits]]

                # Clean up after ourselves
                rm(name_split_right)
                gc()
              }
              else{
                alternate_field_right <- right_dataset[[dataset_field]]
              }

              # Put the alternate values back into the datasets
              left_dataset[[paste0(dataset_field, "_alt_match")]] <- alternate_field_left
              right_dataset[[paste0(dataset_field, "_alt_match")]] <- alternate_field_right
            }
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
            if("alternate_field_value_left" %in% names(linkage_rules) || "alternate_field_value_right" %in% names(linkage_rules)){
              # Get the field we are blocking on
              dataset_field <- row$left_dataset_field

              # If a left alt value was provided, then split it and get the value
              if("alternate_field_value_left" %in% names(linkage_rules)){
                # Get the number of splits we expect to do
                num_of_splits <- linkage_rules$alternate_field_value_left

                # Create some vectors for storing the split name fields (left and right)
                name_split_left <- vector("list", num_of_splits + 1)
                name_split_left[[1]] <- left_dataset[[dataset_field]]

                # Loop until we reach the split field we want
                for(split_num in 1:num_of_splits){
                  # Clean up by trimming white space
                  name_split_left[[split_num]] <- trimws(name_split_left[[split_num]], "both")

                  # Split the name in half and store the results
                  split <- str_split_fixed(name_split_left[[split_num]], ' ', n = 2)
                  name_split_left[[split_num]] <- split[,1]
                  name_split_left[[split_num+1]] <- split[,2]
                }

                # After we finish splitting, return the LAST value since we split
                alternate_field_left <- name_split_left[[num_of_splits]]

                # Clean up after ourselves
                rm(name_split_left)
                gc()
              }
              else{
                alternate_field_left <- left_dataset[[dataset_field]]
              }

              # If a right alt value was provided, then split it and get the value
              if("alternate_field_value_right" %in% names(linkage_rules)){
                # Get the number of splits we expect to do
                num_of_splits <- linkage_rules$alternate_field_value_right

                # Create some vectors for storing the split name fields (left and right)
                name_split_right <- vector("list", num_of_splits + 1)
                name_split_right[[1]] <- right_dataset[[dataset_field]]

                # Loop until we reach the split field we want
                for(split_num in 1:num_of_splits){
                  # Clean up by trimming white space
                  name_split_right[[split_num]] <- trimws(name_split_right[[split_num]], "both")

                  # Split the name in half and store the results
                  split <- str_split_fixed(name_split_right[[split_num]], ' ', n = 2)
                  name_split_right[[split_num]] <- split[,1]
                  name_split_right[[split_num+1]] <- split[,2]
                }

                # After we finish splitting, return the LAST value since we split
                alternate_field_right <- name_split_right[[num_of_splits]]

                # Clean up after ourselves
                rm(name_split_right)
                gc()
              }
              else{
                alternate_field_right <- right_dataset[[dataset_field]]
              }

              # Put the alternate values back into the datasets
              left_dataset[[paste0(dataset_field, "_alt_match")]] <- alternate_field_left
              right_dataset[[paste0(dataset_field, "_alt_match")]] <- alternate_field_right

              # Add to our list of blocking keys
              matching_keys <- append(matching_keys, paste0(dataset_field, "_alt_match"))

              # Rename the row of blocking keys to the "_alt_match" version incase other linkage rules are being used
              matching_keys_df$left_dataset_field[row_num]  <- paste0(dataset_field, "_alt_match")
              matching_keys_df$right_dataset_field[row_num] <- paste0(dataset_field, "_alt_match")
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

            # Quick error handling check, if we used the ALTERNATIVE FIELD VALUE linkage rule, use that new field instead!
            if(paste0(dataset_field, "_alt_match") %in% matching_keys){
              dataset_field <- paste0(dataset_field, "_alt_match")
            }

            # Based on the comparison rule, map it to the appropriate function
            if("jw_score" %in% names(comparison_rules)){
              # "jw_score" uses the Reclin2 cmp_jarowinkler function, so get the value
              threshold <- comparison_rules[["jw_score"]]

              # Keep track of this comparison rule
              comparison_rules_list[[dataset_field]] <- reclin2::cmp_jarowinkler(threshold)
            }
            else if ("numeric_tolerance" %in% names(comparison_rules)){
              # custom "numeric error tolerance" function
              numeric_error_tolerance <- function(tolerance){
                function(x , y){
                  if(!missing(x) && !missing(y)){
                    within_tolerance <- ifelse(is.na(x) | is.na(y),
                                               FALSE,
                                               abs(x - y) <= tolerance)
                    return(within_tolerance)
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
            else if ("date_tolerance" %in% names(comparison_rules)){
              # Custom "date error tolerance" function
              date_error_tolerance <- function(tolerance){
                function(x , y){
                  if(!missing(x) && !missing(y)){
                    # Convert values to dates
                    x = as.Date(x, format = "%m/%d/%Y")
                    y = as.Date(y, format = "%m/%d/%Y")

                    # Determine if the date is within error tolerance
                    within_tolerance <- ifelse(is.na(x) | is.na(y),
                                               FALSE,
                                               abs(x - y) <= tolerance)
                    return(within_tolerance)
                  }
                  else{
                    return(FALSE)
                  }
                }
              }

              # Get the tolerance value
              tolerance <- comparison_rules[["date_tolerance"]]

              # Keep track of this comparison rule
              comparison_rules_list[[dataset_field]] <- date_error_tolerance(tolerance)
            }
            else if ("levenshtein_string_cost" %in% names(comparison_rules)){
              # Custom "levenshtein distance" function
              levenshtein_string_dist <- function(dist){
                function(x, y){
                  if(!missing(x) && !missing(y)){
                    within_tolerance <- ifelse(is.na(x) | is.na(y),
                                               FALSE,
                                               stringdist::stringdist(x, y, method = "lv") <= dist)
                    return(within_tolerance)
                  }
                  else{
                    return(FALSE)
                  }
                }
              }

              # Get the levenshtein distance value
              dist <- comparison_rules[["levenshtein_string_cost"]]

              # Keep track of this comparison rule
              comparison_rules_list[[dataset_field]] <- levenshtein_string_dist(dist)
            }
            else if ("damerau_levenshtein_string_cost" %in% names(comparison_rules)){
              # Custom "damerau levenshtein distance" function
              damerau_levenshtein_string_dist <- function(dist){
                function(x, y){
                  if(!missing(x) && !missing(y)){
                    within_tolerance <- ifelse(is.na(x) | is.na(y),
                                               FALSE,
                                               stringdist::stringdist(x, y, method = "dl") <= dist)
                    return(within_tolerance)
                  }
                  else{
                    return(FALSE)
                  }
                }
              }

              # Get the levenshtein distance value
              dist <- comparison_rules[["damerau_levenshtein_string_cost"]]

              # Keep track of this comparison rule
              comparison_rules_list[[dataset_field]] <- damerau_levenshtein_string_dist(dist)
            }
            else if ("to_soundex" %in% names(comparison_rules)){
              # Custom "soundex matching" function
              soundex_dist <- function(){
                function(x, y){
                  if(!missing(x) && !missing(y)){
                    within_tolerance <- ifelse(is.na(x) | is.na(y),
                                               FALSE,
                                               stringdist::stringdist(x, y, method = "soundex") == 0)
                    return(within_tolerance)
                  }
                  else{
                    return(FALSE)
                  }
                }
              }

              # Keep track of this comparison rule
              comparison_rules_list[[dataset_field]] <- soundex_dist()
            }
            else if ("reference_val_index" %in% names(comparison_rules) && "relative_diff_tolerance" %in% names(comparison_rules)){
              # custom "relative difference tolerance" function
              relative_difference_tolerance <- function(tolerance, index){
                function(x , y){
                  if(!missing(x) && !missing(y)){
                    if(index == 1){
                      within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                 FALSE,
                                                 (abs(x - y)/x) <= tolerance)
                      return(within_tolerance)
                    }
                    else if (index == 2){
                      within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                 FALSE,
                                                 (abs(x - y)/y) <= tolerance)
                      return(within_tolerance)
                    }
                    else return(FALSE)
                  }
                  else{
                    return(FALSE)
                  }
                }
              }

              # Get the tolerance value
              tolerance <- comparison_rules[["relative_diff_tolerance"]]
              ref_index <- comparison_rules[["reference_val_index"]]

              # Keep track of this comparison rule
              comparison_rules_list[[dataset_field]] <- relative_difference_tolerance(tolerance, ref_index)
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

        # Now, if a ground truth is provided get the ground truth variables to calculate specificity later on
        ground_truth_df <- get_ground_truth_fields(linkage_metadata_db, algorithm_id)
        comparison_rules_list_gt <- list()
        has_ground_truth <- FALSE
        if(nrow(ground_truth_df) > 0){
          has_ground_truth <- TRUE

          # First, check if the blocking or matching keys is using the ground truth
          for(index in 1:nrow(ground_truth_df)){
            # Check if the column is one of our blocking or matching keys, if not, then keep it as is, if so, rename it
            if(paste0(ground_truth_df$left_dataset_field[index], "_renamed") %in% matching_keys_df$left_dataset_field){
              ground_truth_df$left_dataset_field[index] <- paste0(ground_truth_df$left_dataset_field[index], "_renamed")
              ground_truth_df$right_dataset_field[index] <- paste0(ground_truth_df$left_dataset_field[index])
            }
            else if(paste0(ground_truth_df$left_dataset_field[index], "_renamed") %in% blocking_keys_df$left_dataset_field){
              ground_truth_df$left_dataset_field[index] <- paste0(ground_truth_df$left_dataset_field[index], "_renamed")
              ground_truth_df$right_dataset_field[index] <- paste0(ground_truth_df$left_dataset_field[index])
            }
            else if(paste0(ground_truth_df$left_dataset_field[index], "_renamed_alt_match") %in% matching_keys_df$left_dataset_field){
              ground_truth_df$left_dataset_field[index] <- paste0(ground_truth_df$left_dataset_field[index], "_renamed")
              ground_truth_df$right_dataset_field[index] <- paste0(ground_truth_df$left_dataset_field[index])
            }
            else if(paste0(ground_truth_df$left_dataset_field[index], "_renamed_alt_block") %in% blocking_keys_df$left_dataset_field){
              ground_truth_df$left_dataset_field[index] <- paste0(ground_truth_df$left_dataset_field[index], "_renamed")
              ground_truth_df$right_dataset_field[index] <- paste0(ground_truth_df$left_dataset_field[index])
            }
          }

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

            # Get the comparison rules for the current row
            comparison_rules_json <- row$comparison_rules

            # Make sure the comparison rules aren't NA
            if(!is.na(comparison_rules_json)){
              comparison_rules <- jsonlite::fromJSON(comparison_rules_json)

              # Get the field we'll apply the comparison rules to
              dataset_field <- row$left_dataset_field

              # Based on the comparison rule, map it to the appropriate function
              if("jw_score" %in% names(comparison_rules)){
                # "jw_score" uses the Reclin2 cmp_jarowinkler function, so get the value
                threshold <- comparison_rules[["jw_score"]]

                # Keep track of this comparison rule
                comparison_rules_list_gt[[dataset_field]] <- reclin2::cmp_jarowinkler(threshold)
              }
              else if ("numeric_tolerance" %in% names(comparison_rules)){
                # custom "numeric error tolerance" function
                numeric_error_tolerance <- function(tolerance){
                  function(x , y){
                    if(!missing(x) && !missing(y)){
                      within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                 FALSE,
                                                 abs(x - y) <= tolerance)
                      return(within_tolerance)
                    }
                    else{
                      return(FALSE)
                    }
                  }
                }

                # Get the tolerance value
                tolerance <- comparison_rules[["numeric_tolerance"]]

                # Keep track of this comparison rule
                comparison_rules_list_gt[[dataset_field]] <- numeric_error_tolerance(tolerance)
              }
              else if ("date_tolerance" %in% names(comparison_rules)){
                # Custom "date error tolerance" function
                date_error_tolerance <- function(tolerance){
                  function(x , y){
                    if(!missing(x) && !missing(y)){
                      # Convert values to dates
                      x = as.Date(x, format = "%m/%d/%Y")
                      y = as.Date(y, format = "%m/%d/%Y")

                      # Determine if the date is within error tolerance
                      within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                 FALSE,
                                                 abs(x - y) <= tolerance)
                      return(within_tolerance)
                    }
                    else{
                      return(FALSE)
                    }
                  }
                }

                # Get the tolerance value
                tolerance <- comparison_rules[["date_tolerance"]]

                # Keep track of this comparison rule
                comparison_rules_list_gt[[dataset_field]] <- date_error_tolerance(tolerance)
              }
              else if ("levenshtein_string_cost" %in% names(comparison_rules)){
                # Custom "levenshtein distance" function
                levenshtein_string_dist <- function(dist){
                  function(x, y){
                    if(!missing(x) && !missing(y)){
                      within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                 FALSE,
                                                 stringdist::stringdist(x, y, method = "lv") <= dist)
                      return(within_tolerance)
                    }
                    else{
                      return(FALSE)
                    }
                  }
                }

                # Get the levenshtein distance value
                dist <- comparison_rules[["levenshtein_string_cost"]]

                # Keep track of this comparison rule
                comparison_rules_list_gt[[dataset_field]] <- levenshtein_string_dist(dist)
              }
              else if ("damerau_levenshtein_string_cost" %in% names(comparison_rules)){
                # Custom "damerau levenshtein distance" function
                damerau_levenshtein_string_dist <- function(dist){
                  function(x, y){
                    if(!missing(x) && !missing(y)){
                      within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                 FALSE,
                                                 stringdist::stringdist(x, y, method = "dl") <= dist)
                      return(within_tolerance)
                    }
                    else{
                      return(FALSE)
                    }
                  }
                }

                # Get the levenshtein distance value
                dist <- comparison_rules[["damerau_levenshtein_string_cost"]]

                # Keep track of this comparison rule
                comparison_rules_list_gt[[dataset_field]] <- damerau_levenshtein_string_dist(dist)
              }
              else if ("to_soundex" %in% names(comparison_rules)){
                # Custom "soundex match" function
                soundex_dist <- function(){
                  function(x, y){
                    if(!missing(x) && !missing(y)){
                      within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                 FALSE,
                                                 stringdist::stringdist(x, y, method = "soundex") == 0)
                      return(within_tolerance)
                    }
                    else{
                      return(FALSE)
                    }
                  }
                }

                # Keep track of this comparison rule
                comparison_rules_list_gt[[dataset_field]] <- soundex_dist()
              }
              else if ("reference_val_index" %in% names(comparison_rules) && "relative_diff_tolerance" %in% names(comparison_rules)){
                # custom "relative difference tolerance" function
                relative_difference_tolerance <- function(tolerance, index){
                  function(x , y){
                    if(!missing(x) && !missing(y)){
                      if(index == 1){
                        within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                   FALSE,
                                                   (abs(x - y)/x) <= tolerance)
                        return(within_tolerance)
                      }
                      else if (index == 2){
                        within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                   FALSE,
                                                   (abs(x - y)/y) <= tolerance)
                        return(within_tolerance)
                      }
                      else return(FALSE)
                    }
                    else{
                      return(FALSE)
                    }
                  }
                }

                # Get the tolerance value
                tolerance <- comparison_rules[["relative_diff_tolerance"]]
                ref_index <- comparison_rules[["reference_val_index"]]

                # Keep track of this comparison rule
                comparison_rules_list_gt[[dataset_field]] <- relative_difference_tolerance(tolerance, ref_index)
              }
            }
          }

          # Get the left fields
          left_ground_truth_fields <- ground_truth_df$left_dataset_field

          # Get the right fields
          right_ground_truth_fields <- ground_truth_df$right_dataset_field
          #right_ground_truth_fields <- ground_truth_df$left_dataset_field # They're being renamed to match anyways so why not modify this?

          # For each of the ground truth fields, check if that ground truth is true, combine all truth values afterwards
          for(i in seq_along(left_ground_truth_fields)){
            # Get the field name
            field_name_left <- left_ground_truth_fields[i]
            field_name_right <- right_ground_truth_fields[i]

            # Check if comparator function exists
            comparator_function <- comparison_rules_list_gt[[field_name_left]]

            # If NULL, there is no comparator function, otherwise, use it
            if(!is.null(comparator_function)){
              linkage_pairs <- compare_vars(linkage_pairs, variable = paste0("truth_", i), on_x = field_name_left, on_y = field_name_right,
                                            comparator = comparator_function)
            }
            else{
              linkage_pairs <- compare_vars(linkage_pairs, variable = paste0("truth_", i), on_x = field_name_left, on_y = field_name_right)
            }
          }

          ## Create a final 'truth' column based on all the truth values (truth_1, truth_2, ...), then drop the temp truth columns
          # Get the list of temporary truth columns
          truth_columns <- paste0("truth_", seq_along(left_ground_truth_fields))
          suppressWarnings(linkage_pairs[, truth := Reduce(`&`, .SD), .SDcols = truth_columns])
          linkage_pairs[, (truth_columns) := NULL]

          ## Compare variables to get the truth
          #if(length(comparison_rules_list_gt) > 0){
          #  linkage_pairs <- compare_vars(linkage_pairs, variable = "truth", on_x = left_ground_truth_fields, on_y = right_ground_truth_fields,
          #                                comparator = comparison_rules_list_gt[1])
          #}
          #else{
          #  linkage_pairs <- compare_vars(linkage_pairs, variable = "truth", on_x = left_ground_truth_fields, on_y = right_ground_truth_fields)
          #}
        }
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

        ### Keep non duplicate rows
        linked_dataset <- linked_dataset[!duplicated(linked_dataset$.x)]

        ### Return specificity variables if ground truth was provided
        if(has_ground_truth){
          # Create the specificity table
          specificity_table <- table(linkage_pairs$truth, linkage_pairs$selected)

          # Get the column and row names
          specificity_table_col_names <- colnames(specificity_table)
          specificity_table_row_names <- row.names(specificity_table)

          # Extract TP, TN, FP, FN
          TP <- ifelse(("TRUE" %in% specificity_table_row_names && "TRUE" %in% specificity_table_col_names),
                       specificity_table["TRUE", "TRUE"], 0) # True Positives
          TN <- ifelse(("FALSE" %in% specificity_table_row_names && "FALSE" %in% specificity_table_col_names),
                       specificity_table["FALSE", "FALSE"], 0) # True Negatives
          FP <- ifelse(("FALSE" %in% specificity_table_row_names && "TRUE" %in% specificity_table_col_names),
                       specificity_table["FALSE", "TRUE"], 0) # False Positives
          FN <- ifelse(("TRUE" %in% specificity_table_row_names && "FALSE" %in% specificity_table_col_names),
                       specificity_table["TRUE", "FALSE"], 0) # False Negatives

          # Create a named vector
          results_vector <- c(TP = TP, TN = TN, FP = FP, FN = FN)

          # Store the results vector
          return_list[["performance_measure_variables"]] <- results_vector
        }

        ### Return the unmodified linked dataset
        return_list[["linked_dataset"]] <- linked_dataset

        ### Create the data frame of the fields to be returned
        output_fields <- get_linkage_output_fields(linkage_metadata_db, algorithm_id)
        for(index in 1:nrow(output_fields)){
          # Check if the column is one of our blocking or matching keys, if not, then keep it as is, if so, rename it
          if(paste0(output_fields$field_name[index], "_renamed") %in% matching_keys_df$left_dataset_field){
            output_fields$field_name[index] <- paste0(output_fields$field_name[index], "_renamed")
          }
          else if(paste0(output_fields$field_name[index], "_renamed") %in% blocking_keys_df$left_dataset_field){
            output_fields$field_name[index] <- paste0(output_fields$field_name[index], "_renamed")
          }
          else if(paste0(output_fields$field_name[index], "_renamed_alt_match") %in% matching_keys_df$left_dataset_field){
            output_fields$field_name[index] <- paste0(output_fields$field_name[index], "_renamed")
          }
          else if(paste0(output_fields$field_name[index], "_renamed_alt_block") %in% blocking_keys_df$left_dataset_field){
            output_fields$field_name[index] <- paste0(output_fields$field_name[index], "_renamed")
          }
        }

        # Create a vector of field names with '.x' suffix to retain
        fields_to_keep <- ifelse(output_fields$field_name %in% colnames(linked_dataset), paste0(output_fields$field_name), paste0(output_fields$field_name, ".x"))

        # Create a vector of fields names with '.x' that will be renamed
        fields_to_rename <- fields_to_keep

        # Append the stage to keep
        fields_to_keep <- append(fields_to_keep, "stage")
        if("capture_month_time_trend_field" %in% colnames(linked_dataset) && "capture_year_time_trend_field" %in% colnames(linked_dataset)){
          fields_to_keep <- append(fields_to_keep, c("capture_month_time_trend_field", "capture_year_time_trend_field"))
        }

        # Select only those columns from linked_dataset that match the fields_to_keep
        filtered_data <- linked_dataset %>% select(all_of(fields_to_keep))

        # Rename the fields with suffix '.x' to have it removed.
        filtered_data <- filtered_data %>% rename_with(~ gsub("\\.x$", "", .), ends_with(".x"))

        # Rename the fields with suffix '_renamed' to have it removed.
        filtered_data <- filtered_data %>% rename_with(~ gsub("\\_renamed$", "", .), ends_with("_renamed"))

        # Store the filtered data for return
        return_list[["output_linkage_df"]] <- filtered_data

        # Store the unlinked pairs for return
        return_list[['unlinked_dataset_pairs']] <- linkage_pairs

        # Clean up
        rm(linkage_pairs, linked_dataset, filtered_data)
        gc()

        ### Return our list of return values
        return(return_list)
        #--------------------------#
      }
      else if (linkage_technique == "M") {
        # Get the blocking keys
        blocking_keys_df <- get_blocking_keys(linkage_metadata_db, iteration_id)

        # Get the matching keys
        matching_keys_df <- get_matching_keys(linkage_metadata_db, iteration_id)

        ### BLOCKING CRITERIA
        # Step 1: Rename fields in the right dataset to temporary names
        for (row_num in 1:nrow(blocking_keys_df)) {
          row <- blocking_keys_df[row_num,]
          right_dataset_field_name <- row$right_dataset_field
          temp_field_name <- paste0("temp_", right_dataset_field_name)

          # Rename the right dataset field to the temporary name
          names(right_dataset)[names(right_dataset) == right_dataset_field_name] <- temp_field_name
        }

        # Step 2: Now rename the temporary fields to the left dataset field names
        for (row_num in 1:nrow(blocking_keys_df)) {
          row <- blocking_keys_df[row_num,]
          left_dataset_field_name <- row$left_dataset_field
          temp_field_name <- paste0("temp_", row$right_dataset_field)

          # Rename the temporary field to the desired left dataset field name
          names(right_dataset)[names(right_dataset) == temp_field_name] <- paste0(left_dataset_field_name, "_renamed")
          names(left_dataset)[names(left_dataset) == left_dataset_field_name] <- paste0(left_dataset_field_name, "_renamed")
        }

        ### MATCHING CRITERIA
        # Step 1: Rename fields in the right dataset to temporary names
        for (row_num in 1:nrow(matching_keys_df)) {
          row <- matching_keys_df[row_num,]
          right_dataset_field_name <- row$right_dataset_field
          temp_field_name <- paste0("temp_", right_dataset_field_name)

          # Rename the right dataset field to the temporary name
          names(right_dataset)[names(right_dataset) == right_dataset_field_name] <- temp_field_name
        }

        # Step 2: Now rename the temporary fields to the left dataset field names
        for (row_num in 1:nrow(matching_keys_df)) {
          row <- matching_keys_df[row_num,]
          left_dataset_field_name <- row$left_dataset_field
          temp_field_name <- paste0("temp_", row$right_dataset_field)

          # Rename the temporary field to the desired left dataset field name
          names(right_dataset)[names(right_dataset) == temp_field_name] <- paste0(left_dataset_field_name, "_renamed")
          names(left_dataset)[names(left_dataset) == left_dataset_field_name] <- paste0(left_dataset_field_name, "_renamed")
        }

        # Rename the data frames to have "_renamed" applied to them
        blocking_keys_df$left_dataset_field <- paste0(blocking_keys_df$left_dataset_field, "_renamed")
        matching_keys_df$left_dataset_field <- paste0(matching_keys_df$left_dataset_field, "_renamed")
        blocking_keys_df$right_dataset_field <- paste0(blocking_keys_df$right_dataset_field, "_renamed")
        matching_keys_df$right_dataset_field <- paste0(matching_keys_df$right_dataset_field, "_renamed")

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
            if("alternate_field_value_left" %in% names(linkage_rules) || "alternate_field_value_right" %in% names(linkage_rules)){
              # Get the field we are blocking on
              dataset_field <- row$left_dataset_field

              # If a left alt value was provided, then split it and get the value
              if("alternate_field_value_left" %in% names(linkage_rules)){
                # Get the number of splits we expect to do
                num_of_splits <- linkage_rules$alternate_field_value_left

                # Create some vectors for storing the split name fields (left and right)
                name_split_left <- vector("list", num_of_splits + 1)
                name_split_left[[1]] <- left_dataset[[dataset_field]]

                # Loop until we reach the split field we want
                for(split_num in 1:num_of_splits){
                  # Clean up by trimming white space
                  name_split_left[[split_num]] <- trimws(name_split_left[[split_num]], "both")

                  # Split the name in half and store the results
                  split <- str_split_fixed(name_split_left[[split_num]], ' ', n = 2)
                  name_split_left[[split_num]] <- split[,1]
                  name_split_left[[split_num+1]] <- split[,2]
                }

                # After we finish splitting, return the LAST value since we split
                alternate_field_left <- name_split_left[[num_of_splits]]

                # Clean up after ourselves
                rm(name_split_left)
                gc()
              }
              else{
                alternate_field_left <- left_dataset[[dataset_field]]
              }

              # If a right alt value was provided, then split it and get the value
              if("alternate_field_value_right" %in% names(linkage_rules)){
                # Get the number of splits we expect to do
                num_of_splits <- linkage_rules$alternate_field_value_right

                # Create some vectors for storing the split name fields (left and right)
                name_split_right <- vector("list", num_of_splits + 1)
                name_split_right[[1]] <- right_dataset[[dataset_field]]

                # Loop until we reach the split field we want
                for(split_num in 1:num_of_splits){
                  # Clean up by trimming white space
                  name_split_right[[split_num]] <- trimws(name_split_right[[split_num]], "both")

                  # Split the name in half and store the results
                  split <- str_split_fixed(name_split_right[[split_num]], ' ', n = 2)
                  name_split_right[[split_num]] <- split[,1]
                  name_split_right[[split_num+1]] <- split[,2]
                }

                # After we finish splitting, return the LAST value since we split
                alternate_field_right  <- name_split_right[[num_of_splits]]

                # Clean up after ourselves
                rm(name_split_right)
                gc()
              }
              else{
                alternate_field_right <- right_dataset[[dataset_field]]
              }

              # Put the alternate values back into the datasets
              left_dataset[[paste0(dataset_field, "_alt_block")]] <- alternate_field_left
              right_dataset[[paste0(dataset_field, "_alt_block")]] <- alternate_field_right

              # Clean up after ourselves
              rm(name_split_left)
              rm(name_split_right)
              gc()

              # Add to our list of blocking keys
              blocking_keys <- append(blocking_keys, paste0(dataset_field, "_alt_block"))

              # Rename the row of blocking keys to the "_alt_block" version incase other linkage rules are being used
              blocking_keys_df$left_dataset_field[row_num]  <- paste0(dataset_field, "_alt_block")
              blocking_keys_df$right_dataset_field[row_num] <- paste0(dataset_field, "_alt_block")
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

        # If we are planning on using the "alternative field" linkage rule for matching fields,
        # then we need to error handle it
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
            if("alternate_field_value_left" %in% names(linkage_rules) || "alternate_field_value_right" %in% names(linkage_rules)){
              # Get the field we are blocking on
              dataset_field <- row$left_dataset_field

              # If a left alt value was provided, then split it and get the value
              if("alternate_field_value_left" %in% names(linkage_rules)){
                # Get the number of splits we expect to do
                num_of_splits <- linkage_rules$alternate_field_value_left

                # Create some vectors for storing the split name fields (left and right)
                name_split_left <- vector("list", num_of_splits + 1)
                name_split_left[[1]] <- left_dataset[[dataset_field]]

                # Loop until we reach the split field we want
                for(split_num in 1:num_of_splits){
                  # Clean up by trimming white space
                  name_split_left[[split_num]] <- trimws(name_split_left[[split_num]], "both")

                  # Split the name in half and store the results
                  split <- str_split_fixed(name_split_left[[split_num]], ' ', n = 2)
                  name_split_left[[split_num]] <- split[,1]
                  name_split_left[[split_num+1]] <- split[,2]
                }

                # After we finish splitting, return the LAST value since we split
                alternate_field_left <- name_split_left[[num_of_splits]]

                # Clean up after ourselves
                rm(name_split_left)
                gc()
              }
              else{
                alternate_field_left <- left_dataset[[dataset_field]]
              }

              # If a right alt value was provided, then split it and get the value
              if("alternate_field_value_right" %in% names(linkage_rules)){
                # Get the number of splits we expect to do
                num_of_splits <- linkage_rules$alternate_field_value_right

                # Create some vectors for storing the split name fields (left and right)
                name_split_right <- vector("list", num_of_splits + 1)
                name_split_right[[1]] <- right_dataset[[dataset_field]]

                # Loop until we reach the split field we want
                for(split_num in 1:num_of_splits){
                  # Clean up by trimming white space
                  name_split_right[[split_num]] <- trimws(name_split_right[[split_num]], "both")

                  # Split the name in half and store the results
                  split <- str_split_fixed(name_split_right[[split_num]], ' ', n = 2)
                  name_split_right[[split_num]] <- split[,1]
                  name_split_right[[split_num+1]] <- split[,2]
                }

                # After we finish splitting, return the LAST value since we split
                alternate_field_right <- name_split_right[[num_of_splits]]

                # Clean up after ourselves
                rm(name_split_right)
                gc()
              }
              else{
                alternate_field_right <- right_dataset[[dataset_field]]
              }

              # Put the alternate values back into the datasets
              left_dataset[[paste0(dataset_field, "_alt_match")]] <- alternate_field_left
              right_dataset[[paste0(dataset_field, "_alt_match")]] <- alternate_field_right
            }
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
            if("alternate_field_value_left" %in% names(linkage_rules) || "alternate_field_value_right" %in% names(linkage_rules)){
              # Get the field we are blocking on
              dataset_field <- row$left_dataset_field

              # If a left alt value was provided, then split it and get the value
              if("alternate_field_value_left" %in% names(linkage_rules)){
                # Get the number of splits we expect to do
                num_of_splits <- linkage_rules$alternate_field_value_left

                # Create some vectors for storing the split name fields (left and right)
                name_split_left <- vector("list", num_of_splits + 1)
                name_split_left[[1]] <- left_dataset[[dataset_field]]

                # Loop until we reach the split field we want
                for(split_num in 1:num_of_splits){
                  # Clean up by trimming white space
                  name_split_left[[split_num]] <- trimws(name_split_left[[split_num]], "both")

                  # Split the name in half and store the results
                  split <- str_split_fixed(name_split_left[[split_num]], ' ', n = 2)
                  name_split_left[[split_num]] <- split[,1]
                  name_split_left[[split_num+1]] <- split[,2]
                }

                # After we finish splitting, return the LAST value since we split
                alternate_field_left <- name_split_left[[num_of_splits]]

                # Clean up after ourselves
                rm(name_split_left)
                gc()
              }
              else{
                alternate_field_left <- left_dataset[[dataset_field]]
              }

              # If a right alt value was provided, then split it and get the value
              if("alternate_field_value_right" %in% names(linkage_rules)){
                # Get the number of splits we expect to do
                num_of_splits <- linkage_rules$alternate_field_value_right

                # Create some vectors for storing the split name fields (left and right)
                name_split_right <- vector("list", num_of_splits + 1)
                name_split_right[[1]] <- right_dataset[[dataset_field]]

                # Loop until we reach the split field we want
                for(split_num in 1:num_of_splits){
                  # Clean up by trimming white space
                  name_split_right[[split_num]] <- trimws(name_split_right[[split_num]], "both")

                  # Split the name in half and store the results
                  split <- str_split_fixed(name_split_right[[split_num]], ' ', n = 2)
                  name_split_right[[split_num]] <- split[,1]
                  name_split_right[[split_num+1]] <- split[,2]
                }

                # After we finish splitting, return the LAST value since we split
                alternate_field_right  <- name_split_right[[num_of_splits]]

                # Clean up after ourselves
                rm(name_split_right)
                gc()
              }
              else{
                alternate_field_right <- right_dataset[[dataset_field]]
              }

              # Put the alternate values back into the datasets
              left_dataset[[paste0(dataset_field, "_alt_match")]] <- alternate_field_left
              right_dataset[[paste0(dataset_field, "_alt_match")]] <- alternate_field_right

              # Add to our list of blocking keys
              matching_keys <- append(matching_keys, paste0(dataset_field, "_alt_match"))

              # Rename the row of blocking keys to the "_alt_match" version incase other linkage rules are being used
              matching_keys_df$left_dataset_field[row_num]  <- paste0(dataset_field, "_alt_match")
              matching_keys_df$right_dataset_field[row_num] <- paste0(dataset_field, "_alt_match")
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

            # Quick error handling check, if we used the ALTERNATIVE FIELD VALUE linkage rule, use that new field instead!
            if(paste0(dataset_field, "_alt_match") %in% matching_keys){
              dataset_field <- paste0(dataset_field, "_alt_match")
            }

            # Based on the comparison rule, map it to the appropriate function
            if("jw_score" %in% names(comparison_rules)){
              # "jw_score" uses the Reclin2 cmp_jarowinkler function, so get the value
              threshold <- comparison_rules[["jw_score"]]

              # Keep track of this comparison rule
              comparison_rules_list[[dataset_field]] <- reclin2::cmp_jarowinkler(threshold)
            }
            else if ("numeric_tolerance" %in% names(comparison_rules)){
              # custom "numeric error tolerance" function
              numeric_error_tolerance <- function(tolerance){
                function(x , y){
                  if(!missing(x) && !missing(y)){
                    within_tolerance <- ifelse(is.na(x) | is.na(y),
                                               FALSE,
                                               abs(x - y) <= tolerance)
                    return(within_tolerance)
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
            else if ("date_tolerance" %in% names(comparison_rules)){
              # Custom "date error tolerance" function
              date_error_tolerance <- function(tolerance){
                function(x , y){
                  if(!missing(x) && !missing(y)){
                    # Convert values to dates
                    x = as.Date(x, format = "%m/%d/%Y")
                    y = as.Date(y, format = "%m/%d/%Y")

                    # Determine if the date is within error tolerance
                    within_tolerance <- ifelse(is.na(x) | is.na(y),
                                               FALSE,
                                               abs(x - y) <= tolerance)
                    return(within_tolerance)
                  }
                  else{
                    return(FALSE)
                  }
                }
              }

              # Get the tolerance value
              tolerance <- comparison_rules[["date_tolerance"]]

              # Keep track of this comparison rule
              comparison_rules_list[[dataset_field]] <- date_error_tolerance(tolerance)
            }
            else if ("levenshtein_string_cost" %in% names(comparison_rules)){
              # Custom "levenshtein distance" function
              levenshtein_string_dist <- function(dist){
                function(x, y){
                  if(!missing(x) && !missing(y)){
                    within_tolerance <- ifelse(is.na(x) | is.na(y),
                                               FALSE,
                                               stringdist::stringdist(x, y, method = "lv") <= dist)
                    return(within_tolerance)
                  }
                  else{
                    return(FALSE)
                  }
                }
              }

              # Get the levenshtein distance value
              dist <- comparison_rules[["levenshtein_string_cost"]]

              # Keep track of this comparison rule
              comparison_rules_list[[dataset_field]] <- levenshtein_string_dist(dist)
            }
            else if ("damerau_levenshtein_string_cost" %in% names(comparison_rules)){
              # Custom "damerau levenshtein distance" function
              damerau_levenshtein_string_dist <- function(dist){
                function(x, y){
                  if(!missing(x) && !missing(y)){
                    within_tolerance <- ifelse(is.na(x) | is.na(y),
                                               FALSE,
                                               stringdist::stringdist(x, y, method = "dl") <= dist)
                    return(within_tolerance)
                  }
                  else{
                    return(FALSE)
                  }
                }
              }

              # Get the levenshtein distance value
              dist <- comparison_rules[["damerau_levenshtein_string_cost"]]

              # Keep track of this comparison rule
              comparison_rules_list[[dataset_field]] <- damerau_levenshtein_string_dist(dist)
            }
            else if ("to_soundex" %in% names(comparison_rules)){
              # Custom "soundex matching" function
              soundex_dist <- function(){
                function(x, y){
                  if(!missing(x) && !missing(y)){
                    within_tolerance <- ifelse(is.na(x) | is.na(y),
                                               FALSE,
                                               stringdist::stringdist(x, y, method = "soundex") == 0)
                    return(within_tolerance)
                  }
                  else{
                    return(FALSE)
                  }
                }
              }

              # Keep track of this comparison rule
              comparison_rules_list[[dataset_field]] <- soundex_dist()
            }
            else if ("reference_val_index" %in% names(comparison_rules) && "relative_diff_tolerance" %in% names(comparison_rules)){
              # custom "relative difference tolerance" function
              relative_difference_tolerance <- function(tolerance, index){
                function(x , y){
                  if(!missing(x) && !missing(y)){
                    if(index == 1){
                      within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                 FALSE,
                                                 (abs(x - y)/x) <= tolerance)
                      return(within_tolerance)
                    }
                    else if (index == 2){
                      within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                 FALSE,
                                                 (abs(x - y)/y) <= tolerance)
                      return(within_tolerance)
                    }
                    else return(FALSE)
                  }
                  else{
                    return(FALSE)
                  }
                }
              }

              # Get the tolerance value
              tolerance <- comparison_rules[["relative_diff_tolerance"]]
              ref_index <- comparison_rules[["reference_val_index"]]

              # Keep track of this comparison rule
              comparison_rules_list[[dataset_field]] <- relative_difference_tolerance(tolerance, ref_index)
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

        # Now, if a ground truth is provided get the ground truth variables to calculate specificity later on
        ground_truth_df <- get_ground_truth_fields(linkage_metadata_db, algorithm_id)
        has_ground_truth <- FALSE
        comparison_rules_list_gt <- list()
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

            # Get the comparison rules for the current row
            comparison_rules_json <- row$comparison_rules

            # Make sure the comparison rules aren't NA
            if(!is.na(comparison_rules_json)){
              comparison_rules <- jsonlite::fromJSON(comparison_rules_json)

              # Get the field we'll apply the comparison rules to
              dataset_field <- row$left_dataset_field

              # Based on the comparison rule, map it to the appropriate function
              if("jw_score" %in% names(comparison_rules)){
                # "jw_score" uses the Reclin2 cmp_jarowinkler function, so get the value
                threshold <- comparison_rules[["jw_score"]]

                # Keep track of this comparison rule
                comparison_rules_list_gt[[dataset_field]] <- reclin2::cmp_jarowinkler(threshold)
              }
              else if ("numeric_tolerance" %in% names(comparison_rules)){
                # custom "numeric error tolerance" function
                numeric_error_tolerance <- function(tolerance){
                  function(x , y){
                    if(!missing(x) && !missing(y)){
                      within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                 FALSE,
                                                 abs(x - y) <= tolerance)
                      return(within_tolerance)
                    }
                    else{
                      return(FALSE)
                    }
                  }
                }

                # Get the tolerance value
                tolerance <- comparison_rules[["numeric_tolerance"]]

                # Keep track of this comparison rule
                comparison_rules_list_gt[[dataset_field]] <- numeric_error_tolerance(tolerance)
              }
              else if ("date_tolerance" %in% names(comparison_rules)){
                # Custom "date error tolerance" function
                date_error_tolerance <- function(tolerance){
                  function(x , y){
                    if(!missing(x) && !missing(y)){
                      # Convert values to dates
                      x = as.Date(x, format = "%m/%d/%Y")
                      y = as.Date(y, format = "%m/%d/%Y")

                      # Determine if the date is within error tolerance
                      within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                 FALSE,
                                                 abs(x - y) <= tolerance)
                      return(within_tolerance)
                    }
                    else{
                      return(FALSE)
                    }
                  }
                }

                # Get the tolerance value
                tolerance <- comparison_rules[["date_tolerance"]]

                # Keep track of this comparison rule
                comparison_rules_list_gt[[dataset_field]] <- date_error_tolerance(tolerance)
              }
              else if ("levenshtein_string_cost" %in% names(comparison_rules)){
                # Custom "levenshtein distance" function
                levenshtein_string_dist <- function(dist){
                  function(x, y){
                    if(!missing(x) && !missing(y)){
                      within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                 FALSE,
                                                 stringdist::stringdist(x, y, method = "lv") <= dist)
                      return(within_tolerance)
                    }
                    else{
                      return(FALSE)
                    }
                  }
                }

                # Get the levenshtein distance value
                dist <- comparison_rules[["levenshtein_string_cost"]]

                # Keep track of this comparison rule
                comparison_rules_list_gt[[dataset_field]] <- levenshtein_string_dist(dist)
              }
              else if ("damerau_levenshtein_string_cost" %in% names(comparison_rules)){
                # Custom "damerau levenshtein distance" function
                damerau_levenshtein_string_dist <- function(dist){
                  function(x, y){
                    if(!missing(x) && !missing(y)){
                      within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                 FALSE,
                                                 stringdist::stringdist(x, y, method = "dl") <= dist)
                      return(within_tolerance)
                    }
                    else{
                      return(FALSE)
                    }
                  }
                }

                # Get the levenshtein distance value
                dist <- comparison_rules[["damerau_levenshtein_string_cost"]]

                # Keep track of this comparison rule
                comparison_rules_list_gt[[dataset_field]] <- damerau_levenshtein_string_dist(dist)
              }
              else if ("to_soundex" %in% names(comparison_rules)){
                # Custom "soundex match" function
                soundex_dist <- function(){
                  function(x, y){
                    if(!missing(x) && !missing(y)){
                      within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                 FALSE,
                                                 stringdist::stringdist(x, y, method = "soundex") == 0)
                      return(within_tolerance)
                    }
                    else{
                      return(FALSE)
                    }
                  }
                }

                # Keep track of this comparison rule
                comparison_rules_list_gt[[dataset_field]] <- soundex_dist()
              }
              else if ("reference_val_index" %in% names(comparison_rules) && "relative_diff_tolerance" %in% names(comparison_rules)){
                # custom "relative difference tolerance" function
                relative_difference_tolerance <- function(tolerance, index){
                  function(x , y){
                    if(!missing(x) && !missing(y)){
                      if(index == 1){
                        within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                   FALSE,
                                                   (abs(x - y)/x) <= tolerance)
                        return(within_tolerance)
                      }
                      else if (index == 2){
                        within_tolerance <- ifelse(is.na(x) | is.na(y),
                                                   FALSE,
                                                   (abs(x - y)/y) <= tolerance)
                        return(within_tolerance)
                      }
                      else return(FALSE)
                    }
                    else{
                      return(FALSE)
                    }
                  }
                }

                # Get the tolerance value
                tolerance <- comparison_rules[["relative_diff_tolerance"]]
                ref_index <- comparison_rules[["reference_val_index"]]

                # Keep track of this comparison rule
                comparison_rules_list_gt[[dataset_field]] <- relative_difference_tolerance(tolerance, ref_index)
              }
            }
          }

          # Get the left fields
          left_ground_truth_fields <- ground_truth_df$left_dataset_field

          # Get the right fields
          right_ground_truth_fields <- ground_truth_df$right_dataset_field

          # For each of the ground truth fields, check if that ground truth is true, combine all truth values afterwards
          for(i in seq_along(left_ground_truth_fields)){
            # Get the field name
            field_name <- left_ground_truth_fields[i]

            # Check if comparator function exists
            comparator_function <- comparison_rules_list_gt[[field_name]]

            # If NULL, there is no comparator function, otherwise, use it
            if(!is.null(comparator_function)){
              linkage_pairs <- compare_vars(linkage_pairs, variable = paste0("truth_", i), on_x = field_name, on_y = field_name,
                                            comparator = comparator_function)
            }
            else{
              linkage_pairs <- compare_vars(linkage_pairs, variable = paste0("truth_", i), on_x = field_name, on_y = field_name)
            }
          }

          ## Create a final 'truth' column based on all the truth values (truth_1, truth_2, ...), then drop the temp truth columns
          # Get the list of temporary truth columns
          truth_columns <- paste0("truth_", seq_along(left_ground_truth_fields))
          linkage_pairs[, truth := Reduce(`&`, .SD), .SDcols = truth_columns]
          linkage_pairs[, (truth_columns) := NULL]

          ## Compare variables to get the truth
          #if(length(comparison_rules_list_gt) > 0){
          #  linkage_pairs <- compare_vars(linkage_pairs, variable = "truth", on_x = left_ground_truth_fields, on_y = right_ground_truth_fields,
          #                                comparator = comparison_rules_list_gt)
          #}
          #else{
          #  linkage_pairs <- compare_vars(linkage_pairs, variable = "truth", on_x = left_ground_truth_fields, on_y = right_ground_truth_fields)
          #}
        }
        #---------------------------#

        #-- STEP 3: CREATE THE MACHINE LEARNING MODEL --#
        # Before constructing our machine learning model, we'll need to make a formula
        if(has_ground_truth){
          linkage_formula <- as.formula(paste("truth ~", paste(matching_keys, collapse = " + ")))
        }
        else{
          linkage_formula <- as.formula(paste("~", paste(matching_keys, collapse = " + ")))
        }

        # Afterwards, construct the model using glm()
        ml_model <- glm(linkage_formula, data = linkage_pairs, family = binomial())
        #-----------------------------------------------#

        #-- STEP 4: APPLY THE MODEL TO OUR PAIRS --#
        # Apply the model and see what probabilities we obtain
        suppressWarnings(linkage_pairs[, prob := predict(ml_model, type = "response", newdata = linkage_pairs)])

        # Get the acceptance threshold for this iteration
        acceptance_threshold <- get_acceptence_thresholds(linkage_metadata_db, iteration_id)

        # Select pairs using the user defined acceptance thresholds
        if("ml_probability" %in% names(acceptance_threshold)){
          # Get the probability
          probability <- acceptance_threshold[["ml_probability"]]

          # Apply the probability
          linkage_pairs[, selected := prob > probability]
        }
        else{
          # Create a list of plots and captions that we'll return
          plot_list <- list()
          plot_caps_list <- c()

          # Get the pass name
          iteration_name <- get_iteration_name(linkage_metadata_db, iteration_id)

          # Create the first plot of all candidate pair records
          candidate_weights_plot <- ggplot(linkage_pairs, mapping = aes(prob)) +
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
          caption <- paste0("Probability distribution of ", trimws(iteration_name), "'s unlinked pairs for ", algorithm_name, ".")
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
            candidate_weights_plot_gt <- ggplot(linkage_pairs_non_missing, aes(x = prob, fill = match_type)) +
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

            # Get the ground truth fields
            ground_truth_df <- get_ground_truth_fields(linkage_metadata_db, algorithm_id)
            ground_truth_fields <- ""
            ground_truth_fields_vector <- c()
            if(nrow(ground_truth_df) > 0){
              for(j in 1:nrow(ground_truth_df)){
                # First, get the dataset field name
                field_name <- ground_truth_df$left_dataset_field[j]

                # Convert the field name to either upper, lower, or title case
                field_name <- convert_name_case(field_name)

                # Append the field name to the list of ground truth fields
                ground_truth_fields_vector <- append(ground_truth_fields_vector, field_name)
              }
            }

            # Collapse the ground truth fields into a single string
            ground_truth_fields <- paste(ground_truth_fields_vector, collapse = ", ")

            caption <- paste0("Probability distribution of ", trimws(iteration_name), "'s unlinked pairs for ", algorithm_name, " with the coloured ",
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
        #------------------------------------------#

        #-- STEP 5: LINK THE PAIRS --#
        # Call the link() function to finally get our linked dataset
        linked_dataset <- link(linkage_pairs, selection = "selected", keep_from_pairs = c(".x", ".y", "prob"))

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

          # Get the column and row names
          specificity_table_col_names <- colnames(specificity_table)
          specificity_table_row_names <- row.names(specificity_table)

          # Extract TP, TN, FP, FN
          TP <- ifelse(("TRUE" %in% specificity_table_row_names && "TRUE" %in% specificity_table_col_names),
                       specificity_table["TRUE", "TRUE"], 0) # True Positives
          TN <- ifelse(("FALSE" %in% specificity_table_row_names && "FALSE" %in% specificity_table_col_names),
                       specificity_table["FALSE", "FALSE"], 0) # True Negatives
          FP <- ifelse(("FALSE" %in% specificity_table_row_names && "TRUE" %in% specificity_table_col_names),
                       specificity_table["FALSE", "TRUE"], 0) # False Positives
          FN <- ifelse(("TRUE" %in% specificity_table_row_names && "FALSE" %in% specificity_table_col_names),
                       specificity_table["TRUE", "FALSE"], 0) # False Negatives

          # Create a named vector
          results_vector <- c(TP = TP, TN = TN, FP = FP, FN = FN)

          # Store the results vector
          return_list[["performance_measure_variables"]] <- results_vector
        }

        ### Keep only the linked indices
        linked_dataset <- linked_dataset[!duplicated(linked_dataset$.x)]

        ### Return the unmodified linked dataset
        return_list[["linked_dataset"]] <- linked_dataset

        ### Create the data frame of the fields to be returned
        output_fields <- get_linkage_output_fields(linkage_metadata_db, algorithm_id)
        for(index in 1:nrow(output_fields)){
          # Check if the column is one of our blocking or matching keys, if not, then keep it as is, if so, rename it
          if(paste0(output_fields$field_name[index], "_renamed") %in% matching_keys_df$left_dataset_field){
            output_fields$field_name[index] <- paste0(output_fields$field_name[index], "_renamed")
          }
          else if(paste0(output_fields$field_name[index], "_renamed") %in% blocking_keys_df$left_dataset_field){
            output_fields$field_name[index] <- paste0(output_fields$field_name[index], "_renamed")
          }
          else if(paste0(output_fields$field_name[index], "_renamed_alt_match") %in% matching_keys_df$left_dataset_field){
            output_fields$field_name[index] <- paste0(output_fields$field_name[index], "_renamed")
          }
          else if(paste0(output_fields$field_name[index], "_renamed_alt_block") %in% blocking_keys_df$left_dataset_field){
            output_fields$field_name[index] <- paste0(output_fields$field_name[index], "_renamed")
          }
        }

        # Create a vector of field names with '.x' suffix to retain
        fields_to_keep <- ifelse(output_fields$field_name %in% colnames(linked_dataset), paste0(output_fields$field_name), paste0(output_fields$field_name, ".x"))

        # Append the stage to keep
        fields_to_keep <- append(fields_to_keep, "stage")
        if("capture_month_time_trend_field" %in% colnames(linked_dataset) && "capture_year_time_trend_field" %in% colnames(linked_dataset)){
          fields_to_keep <- append(fields_to_keep, c("capture_month_time_trend_field", "capture_year_time_trend_field"))
        }

        # Select only those columns from linked_dataset that match the fields_to_keep
        filtered_data <- linked_dataset %>% select(all_of(fields_to_keep))

        # Rename the fields with suffix '.x' to have it removed.
        filtered_data <- filtered_data %>% rename_with(~ gsub("\\.x$", "", .), ends_with(".x"))

        # Rename the fields with suffix '_renamed' to have it removed.
        filtered_data <- filtered_data %>% rename_with(~ gsub("\\_renamed$", "", .), ends_with("_renamed"))

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
        if("ml_probability" %in% names(acceptance_threshold)){
          acceptance_threshold <- acceptance_threshold[["ml_probability"]]
          # Create a histogram of the posterior thresholds with the decision boundary
          decision_boundary <- ggplot(linkage_pairs, aes(x = prob, fill = selected_label)) +
            geom_histogram(binwidth = 0.05, position = "stack", alpha = 0.8) +
            scale_fill_manual(values = c("Miss" = "red", "Match" = "blue"), name = "Selection Status") +
            labs(x = "Probability", y = "Frequency") +
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
          caption <- paste0("Probability distribution of ", trimws(iteration_name), "'s linked pairs for ", algorithm_name, " with the selected probability acceptance threshold",
                            " of ", acceptance_threshold, ".")
          plot_list[["decision_boundary_plot"]] <- decision_boundary
          plot_caps_list <- append(plot_caps_list, caption)

          ### Return the plot list
          return_list[["threshold_plots"]] <- plot_list

          ### Returned the plot captions
          return_list[["plot_captions"]] <- plot_caps_list
        }

        # Clean up
        rm(linkage_pairs, linked_dataset, filtered_data)
        gc()

        ### Return our list of return values
        return(return_list)
        #--------------------------#
      }
    }
  )
)

#' Run Data Linkage Function
#'
#' The run_main_linkage() function will take in a left and right dataset, using the linkage metadata file
#' to determine which linkage classes to use for each iteration of an algorithm, with extra parameters to
#' define what kinds of outputs are wanted.
#' @param left_dataset_file The left dataset file to be linked to the right dataset file.
#' @param right_dataset_file The right dataset file that will be be linked with the left dataset file.
#' @param linkage_metadata_file The .SQLITE file of metadata information used for data linkage.
#' @param algorithm_ids A vector of integers which are the algorithm IDs that will be ran.
#' @param extra_parameters A list of optional user defined parameters that affects output.
#' @param progress_callback An optional parameter which is a SHINY UI object passed to provide UI users with a progress bar of how far along completion is.
#'
#' @return A list of linkage result data if the user specified in the extra parameters, otherwise NULL is returned
#' @examples
#' left_dataset_file   <- file.choose()
#' right_dataset_file  <- file.choose()
#' linkage_sqlite_file <- file.choose()
#' algorithm_ids       <- c(1, 2, 3)
#' extra_parameters    <- create_extra_parameters_list(linkage_output_folder = choose.dir(), linkage_report_type = 2)
#' results             <- run_main_linkage(left_dataset_file, right_dataset_file, linkage_sqlite_file, algorithm_ids, extra_parameters)
#' @export
run_main_linkage <- function(left_dataset_file, right_dataset_file, linkage_metadata_file, algorithm_ids, extra_parameters, progress_callback = NULL){
  # Error handling to ensure inputs were provided
  #----#
  if(is.na(left_dataset_file) || is.na(right_dataset_file) || is.null(left_dataset_file) ||
     is.null(right_dataset_file) || !file.exists(left_dataset_file) || !file.exists(right_dataset_file)){
    #dbDisconnect(linkage_metadata_db)
    stop("Error: Invalid Datasets were provided.")
  }

  if(anyNA(algorithm_ids) || is.null(algorithm_ids) || !is.numeric(algorithm_ids)){
    #dbDisconnect(linkage_metadata_db)
    stop("Error: Invalid Algorithm ID was provided.")
  }

  if(!is.list(extra_parameters)){
    #dbDisconnect(linkage_metadata_db)
    stop("Error: Extra parameters should be provided as a list.")
  }

  if(is.na(linkage_metadata_file) || is.null(linkage_metadata_file) || !file.exists(linkage_metadata_file) || file_ext(linkage_metadata_file) != "sqlite"){
    #dbDisconnect(linkage_metadata_db)
    stop("Error: Invalid linkage metadata file provided.")
  }
  #----#

  ### Create a variable for tracking the number of steps during this linkage and what step we're currently on
  total_steps  <- length(algorithm_ids)
  current_step <- 0
  total_progress <- 0
  if("linkage_report_type" %in% names(extra_parameters)){
    # If we are generating final reports, then each algorithm gets its own
    if(extra_parameters[["linkage_report_type"]] == 3){
      total_steps <- total_steps * 2
    }

    # If we are generating an intermediate report, then all algorithms share a report
    if(extra_parameters[["linkage_report_type"]] == 2){
      total_steps <- total_steps + 1
    }
  }

  ### Step 1: Connect to the linkage metadata file
  #----
  linkage_metadata_db <- dbConnect(RSQLite::SQLite(), linkage_metadata_file)
  #----

  # Create lists and data frames for storing ALL algorithm summaries, performance measures, and table data
  #----
  linked_data_list                <- list()
  linked_data_generation_times    <- c()
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
  intermediate_missing_indicators_df <- data.frame()
  # Apply labels to the performance measures data frame
  label(intermediate_performance_measures_df$algorithm_name) <- "Algorithm Name"
  label(intermediate_performance_measures_df$positive_predictive_value) <- "PPV"
  label(intermediate_performance_measures_df$negative_predictive_value) <- "NPV"
  label(intermediate_performance_measures_df$sensitivity) <- "Sensitivity"
  label(intermediate_performance_measures_df$specificity) <- "Specificity"
  label(intermediate_performance_measures_df$f1_score) <- "F1 Score"
  label(intermediate_performance_measures_df$linkage_rate) <- "Linkage Rate"
  #----

  # Create empty variables for storing the algorithm summaries and performance of non-main report algorithms
  #----
  considered_performance_measures_df <- data.frame(
    algorithm_name = character(),
    positive_predictive_value = numeric(),
    negative_predictive_value = numeric(),
    sensitivity = numeric(),
    specificity = numeric(),
    f1_score = numeric(),
    linkage_rate = numeric()
  )
  # Apply labels to the performance measures data frame
  label(considered_performance_measures_df$algorithm_name) <- "Algorithm Name"
  label(considered_performance_measures_df$positive_predictive_value) <- "PPV"
  label(considered_performance_measures_df$negative_predictive_value) <- "NPV"
  label(considered_performance_measures_df$sensitivity) <- "Sensitivity"
  label(considered_performance_measures_df$specificity) <- "Specificity"
  label(considered_performance_measures_df$f1_score) <- "F1 Score"
  label(considered_performance_measures_df$linkage_rate) <- "Linkage Rate"

  # List of considered algorithm summaries
  considered_linkage_algorithm_summary_list  <- list()
  considered_linkage_algorithm_footnote_list <- list()
  considered_linkage_algorithm_table_names   <- c()
  #----

  # For Steps 2-8, we'll run each of our algorithms
  algorithm_num <- 0
  for(algorithm_id in algorithm_ids){
    # Generate the timestamp this was executed at
    algorithm_timestamp <- format(Sys.time(), "%Y-%m-%d %Hh-%Mm-%Ss")

    # Create a list that will track auditing information and save it (if user defined so)
    audit_measures_list <- list()

    # Garbage collect before each algorithm
    gc()

    # List of plots and captions
    algorithm_plots <- c()
    plot_captions   <- c()
    algorithm_num   <- algorithm_num + 1

    # Ground truth no-zero count and total records count
    ground_truth_non_zero <- NULL
    total_record_count <- NULL

    # Missing data indicators data frame
    missing_data_indicators <- data.frame()

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
    # Verify that output fields were provided
    output_fields <- get_linkage_output_fields(linkage_metadata_db, algorithm_id)
    if(nrow(output_fields) <= 0){
      dbDisconnect(linkage_metadata_db)
      stop("Error: No Output Fields Were Provided, Select Fields on the Linkage Algorithms Page of the GUI.")
    }

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

    # If the user would like us to collect missing data indicators, then collect them
    if("collect_missing_data_indicators" %in% names(extra_parameters) && extra_parameters[["collect_missing_data_indicators"]] == T){
      # Obtain the output variables
      output_fields_df <- get_linkage_missingness_fields(linkage_metadata_db, algorithm_id)

      # Check if the data frame has any rows
      if(nrow(output_fields_df) > 0){
        output_fields    <- unique(output_fields_df$field_name)

        # Establish the source missing data frame
        source_missing <- subset(left_dataset, select = output_fields)

        # For each of the output fields, replace missing values with 0 and existing values with 1
        for(output_field in output_fields){
          # Get the column name
          col_name <- output_field

          # Replace blank, missing, NA, etc. values for the column with 0, otherwise replace with 1
          source_missing[[col_name]] <- ifelse(is.na(source_missing[[col_name]]) | is.null(source_missing[[col_name]]) | trimws(source_missing[[col_name]]) == "",
                                               1, 0)

          # Rename the column to append "_missing"
          names(source_missing)[names(source_missing) == col_name] <- paste0(col_name, "_missing")
        }

        # Save the sourced missing data
        missing_data_indicators <- source_missing
        rm(source_missing)
        gc()

        # Finally, apply labels to the missing data indicators
        # Apply Labels to the output data frame
        # Find duplicate labels
        label_counts <- table(output_fields_df$dataset_label)
        duplicate_labels <- names(label_counts[label_counts > 1])

        for(row_num in 1:nrow(output_fields_df)){
          # Get the field to apply a label to
          dataset_field <- paste0(output_fields_df$field_name[row_num], "_missing")

          # Get the label to apply
          dataset_label <- output_fields_df$dataset_label[row_num]

          # If the label is a duplicate, append the formatted field name
          if (dataset_label %in% duplicate_labels) {
            field_name <- output_fields_df$field_name[row_num]
            formatted_field_name <- str_to_title(gsub("[[:punct:]]", " ", field_name))
            dataset_label <- paste0(dataset_label, " (", formatted_field_name, ")")
          }

          # Apply the label to the field
          label(missing_data_indicators[[dataset_field]]) <- dataset_label
        }

        # Save intermediate missing indicators
        intermediate_missing_indicators_df <- missing_data_indicators
      }
    }

    # If the user would like us to include a time trend plot in the generated report, then get and duplicate the required fields
    if("generate_time_trend_plot" %in% names(extra_parameters) && extra_parameters[["generate_time_trend_plot"]] == T){
      # Get the capture month and capture year
      time_trend_fields <- get_linkage_time_trend_fields(linkage_metadata_db, left_dataset_code)

      # Error check to make sure the month and year are actually recorded, otherwise stop
      if(is.null(time_trend_fields[[1]]) || is.null(time_trend_fields[[2]])){
        dbDisconnect(linkage_metadata_db)
        stop("Error: Make sure the Data Capture Month and Year are properly recorded before attempting to generate time trend plot.")
      }

      # Duplicate the month and year fields
      month_field <- time_trend_fields[[1]]
      year_field  <- time_trend_fields[[2]]
      left_dataset[["capture_month_time_trend_field"]] <- left_dataset[[month_field]]
      left_dataset[["capture_year_time_trend_field"]]  <- left_dataset[[year_field]]
    }

    # If there is ground truth available for this algorithm/dataset pair, obtain the total row counts of the left data set and the non-missing ground truth
    gt_fields <- get_ground_truth_fields(linkage_metadata_db, algorithm_id)
    if(nrow(gt_fields) > 0){
      # First obtain the number of rows in the left data set
      total_record_count <- nrow(left_dataset)

      # Second, using the ground truth fields, how many rows have non-missing ground truth values for ALL fields
      required_fields <- gt_fields$left_dataset_field
      ground_truth_non_zero <- sum(complete.cases(left_dataset[, ..required_fields]))
    }
    #----

    # Call the progress for starting to run the algorithm
    if (!is.null(progress_callback)) {
      progress_value <- 1/(total_steps+1)
      progress_callback(progress_value, paste0("Step [", current_step+1, "/", total_steps, "] ", "Running Algorithm ", algorithm_num, " of ", length(algorithm_ids)))
      current_step <- current_step + 1
    }

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
    if(("extra_summary_parameters" %in% names(extra_parameters) && extra_parameters[["extra_summary_parameters"]] == TRUE)){
      algo_summary <- data.frame(
        pass = character(),
        linkage_implementation = character(),
        blocking_variables = character(),
        matching_variables = character(),
        acceptance_threshold = character(),
        linkage_rate_pass = character(),
        linkage_rate_total = character(),
        FDR = character(),
        FOR = character()
      )
      algo_summary_footnotes <- c("FDR = False Discovery Rate, FOR = False Omission Rate")
    } else{
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
    }

    # Keep a vector of performance measure values
    performance_measures <- c(TP = 0, TN = 0, FP = 0, FN = 0)

    # Track start time so that we may make note of how long all passes take
    total_start_time = proc.time()

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

      # Start by getting all the rows from blocking_variables that match to a specific iteration_id
      blocking_keys_df <- dbGetQuery(linkage_metadata_db, paste0('
          SELECT
            dvf.field_name AS left_dataset_field,
            dvf2.field_name AS right_dataset_field,
            bv.linkage_rule_id
          FROM blocking_variables bv
          INNER JOIN dataset_fields dvf ON bv.left_dataset_field_id = dvf.field_id
          INNER JOIN dataset_fields dvf2 ON bv.right_dataset_field_id = dvf2.field_id
          WHERE bv.iteration_id = ', curr_iteration_id))

      # Loop through each blocking variable, renaming them, and apply linkage rules to the fields
      blocking_keys <- c()
      if(nrow(blocking_keys_df) > 0){
        for(j in 1:nrow(blocking_keys_df)){
          # First, get the dataset field name
          field_name <- blocking_keys_df$left_dataset_field[j]

          # Remove punctuation
          field_name <- str_replace_all(field_name, "[[:punct:]]", " ")

          # Split up the words of the string, and convert them to title case, except for
          # words like "of", "and", etc.
          words <- str_split(field_name, "\\s+")[[1]]
          field_name <- str_c(
            sapply(words, function(word) {
              if (tolower(word) %in% c("of", "and", "the", "in", "on", "at", "to", "with")) {
                tolower(word)
              }
              else if (tolower(word) %in% c('id', 'phin', 'guid', 'cid')){
                toupper(word)
              }
              else {
                str_to_title(word)
              }
            }),
            collapse = " "
          )
          if(tolower(field_name) == "phin"){
            field_name <- "PHIN"
            algo_summary_footnotes <- append(algo_summary_footnotes, "PHIN = Personal Health Identification Number")
            algo_summary_footnotes <- unique(algo_summary_footnotes)
          }

          # Next, get the linkage rule
          linkage_rule_id <- blocking_keys_df$linkage_rule_id[j]

          # If the linkage_rule_id is not NA, replace it with text of the rule
          if(!is.na(linkage_rule_id)){
            # Query to get the acceptance method name from the comparison_rules table
            method_query <- paste('SELECT * FROM linkage_rules
                           WHERE linkage_rule_id =', linkage_rule_id)
            method_df <- dbGetQuery(linkage_metadata_db, method_query)

            # We'll start with "Alternative Field Left"
            alt_field_val <- method_df$alternate_field_value_left
            if(!is.na(alt_field_val)){
              field_name <- paste0(field_name, " - ", scales::ordinal(as.numeric(alt_field_val)), " Field Value (Left)")
            }

            # Next we'll handle "Alternative Field Right"
            alt_field_val <- method_df$alternate_field_value_right
            if(!is.na(alt_field_val)){
              field_name <- paste0(field_name, " - ", scales::ordinal(as.numeric(alt_field_val)), " Field Value (Right)")
            }

            # Next we'll handle the "Integer Variance"
            int_variance <- method_df$integer_value_variance
            if(!is.na(int_variance)){
              field_name <- paste0(field_name, " ±", int_variance)
            }

            # Next we'll handle "Name Substring"
            name_substring <- method_df$substring_length
            if(!is.na(name_substring)){
              field_name <- paste0(field_name, " - First ", name_substring, " character(s)")
            }

            # Next we'll handle the "Standardize Names" rule
            standardize_names <- method_df$standardize_names
            if(!is.na(standardize_names)){
              field_name <- paste0("Standardized ", field_name)
            }
          }

          # Append the field name
          blocking_keys <- append(blocking_keys, field_name)
        }
      }

      # Collapse the blocking keys, separated by a comma
      blocking_fields <- paste(blocking_keys, collapse = ", ")

      # Start by getting all the rows from blocking_variables that match to a specific iteration_id
      matching_keys_df <- dbGetQuery(linkage_metadata_db, paste0('
          SELECT
            dvf.field_name AS left_dataset_field,
            dvf2.field_name AS right_dataset_field,
            mv.linkage_rule_id,
            mv.comparison_rule_id
          FROM matching_variables mv
          INNER JOIN dataset_fields dvf ON mv.left_dataset_field_id = dvf.field_id
          INNER JOIN dataset_fields dvf2 ON mv.right_dataset_field_id = dvf2.field_id
          WHERE mv.iteration_id = ', curr_iteration_id))

      # Loop through each blocking variable, renaming them, and apply linkage rules to the fields
      matching_keys <- c()
      if(nrow(matching_keys_df) > 0){
        for(j in 1:nrow(matching_keys_df)){
          # First, get the dataset field name
          field_name <- matching_keys_df$left_dataset_field[j]

          # Remove punctuation
          field_name <- str_replace_all(field_name, "[[:punct:]]", " ")

          # Split up the words of the string, and convert them to title case, except for
          # words like "of", "and", etc.
          words <- str_split(field_name, "\\s+")[[1]]
          field_name <- str_c(
            sapply(words, function(word) {
              if (tolower(word) %in% c("of", "and", "the", "in", "on", "at", "to", "with")) {
                tolower(word)
              } else {
                str_to_title(word)
              }
            }),
            collapse = " "
          )
          if(tolower(field_name) == "phin"){
            field_name <- "PHIN"
            algo_summary_footnotes <- append(algo_summary_footnotes, "PHIN=Personal Health Identification Number")
            algo_summary_footnotes <- unique(algo_summary_footnotes)
          }

          # Next, get the linkage rule
          linkage_rule_id <- matching_keys_df$linkage_rule_id[j]

          # If the linkage_rule_id is not NA, replace it with text of the rule
          if(!is.na(linkage_rule_id)){
            # Query to get the acceptance method name from the comparison_rules table
            method_query <- paste('SELECT * FROM linkage_rules
                           WHERE linkage_rule_id =', linkage_rule_id)
            method_df <- dbGetQuery(linkage_metadata_db, method_query)

            # We'll start with "Alternative Field Left"
            alt_field_val <- method_df$alternate_field_value_left
            if(!is.na(alt_field_val)){
              field_name <- paste0(field_name, " - ", scales::ordinal(as.numeric(alt_field_val)), " Field Value (Left)")
            }

            # Next we'll handle "Alternative Field Right"
            alt_field_val <- method_df$alternate_field_value_right
            if(!is.na(alt_field_val)){
              field_name <- paste0(field_name, " - ", scales::ordinal(as.numeric(alt_field_val)), " Field Value (Right)")
            }

            # Next we'll handle the "Integer Variance"
            int_variance <- method_df$integer_value_variance
            if(!is.na(int_variance)){
              field_name <- paste0(field_name, " ±", int_variance)
            }

            # Next we'll handle "Name Substring"
            name_substring <- method_df$substring_length
            if(!is.na(name_substring)){
              field_name <- paste0(field_name, " - First ", name_substring, " character(s)")
            }

            # Next we'll handle the "Standardize Names" rule
            standardize_names <- method_df$standardize_names
            if(!is.na(standardize_names)){
              field_name <- paste0("Standardized ", field_name)
            }
          }

          # Next, get the comparison rule
          comparison_rule_id <- matching_keys_df$comparison_rule_id[j]

          # If the comparison_rule_id is not NA, replace it with text of the rule
          if(!is.na(comparison_rule_id)){
            # Define the direction of comparison for each method
            comparison_directions <- list(
              "Reclin-JaroWinkler" = "≥",
              "Stringdist-OSA" = "≤",
              "RecordLinkage-Levenshtein" = "≤",
              "Soundex" = "=",
              "Numeric Error Tolerance" = "±",
              "Damerau–Levenshtein" = "≤",
              "Date Error Tolerance" = "±",
              "Relative Difference (Percentage)" = "=",
              "JW" = "≥",
              "OSA" = "≤",
              "LS" = "≤",
              "Soundex" = "=",
              "NET" = "±",
              "DLS" = "≤",
              "DET" = "±",
              "RD" = "≤"
            )

            # Query to get the acceptance method name from the comparison_rules table
            method_query <- paste('SELECT method_name, description FROM comparison_rules cr
                             JOIN comparison_methods cm on cr.comparison_method_id = cm.comparison_method_id
                             WHERE comparison_rule_id =', comparison_rule_id)
            method_name <- dbGetQuery(linkage_metadata_db, method_query)$method_name
            description <- dbGetQuery(linkage_metadata_db, method_query)$description

            # Query to get the associated parameters for the comparison_rule_id
            params_query <- paste('SELECT parameter FROM comparison_rules_parameters WHERE comparison_rule_id =', comparison_rule_id)
            params_df <- dbGetQuery(linkage_metadata_db, params_query)

            # Combine the parameters into a string
            params_str <- paste(params_df$parameter, collapse = ", ")

            # Get the direction of comparison
            direction <- comparison_directions[[method_name]]

            # Handle cases where direction is unknown (default to "=")
            if (is.null(direction)) {
              direction <- "="
            }

            # Create the final string "method_name (key1=value1, key2=value2)"
            if(method_name == 'DET'){
              field_name <- paste0(field_name, " ", direction, params_str, " days")
            }
            else{
              field_name <- paste0(field_name, " (", method_name, direction, params_str, ")")
            }

            # Save the method and description as a footnote
            algo_summary_footnotes <- append(algo_summary_footnotes, paste0(method_name, " = ", description))
            algo_summary_footnotes <- unique(algo_summary_footnotes)
          }

          # Append the field name
          matching_keys <- append(matching_keys, field_name)
        }
      }

      # Collapse the matching keys, separated by a comma
      matching_fields <- paste(matching_keys, collapse = ", ")

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

      # Create a data frame for the current passes algorithm summary
      if(("extra_summary_parameters" %in% names(extra_parameters) && extra_parameters[["extra_summary_parameters"]] == TRUE)){
        if("performance_measure_variables" %in% names(results)){
          # Get the performance measure values
          iteration_performance_measures <- results[["performance_measure_variables"]]

          # Append the performance measure variables to the overall values
          TP <- iteration_performance_measures[1]
          TN <- iteration_performance_measures[2]
          FP <- iteration_performance_measures[3]
          FN <- iteration_performance_measures[4]

          # FDR (False Discover Rate)
          FDR <- (FP/(FP + TP)) * 100
          if(is.na(FDR))
            FDR <- 0.0

          # FOR (False Omission Rate)
          FOR <- (FN/(FN + TN)) * 100
          if(is.na(FOR))
            FOR <- 0.0

          # Create a data frame for the current passes summary
          curr_algo_summary <- data.frame(
            pass = row_num,
            linkage_implementation = linkage_method,
            blocking_variables = blocking_fields,
            matching_variables = matching_fields,
            acceptance_threshold = acceptance_threshold,
            linkage_rate_pass = linkage_rate_pass,
            linkage_rate_cumulative = linkage_rate_cumulative,
            FDR = FDR,
            FOR = FOR
          )

          # Bind this to our full algorithm summary
          algo_summary <- rbind(algo_summary, curr_algo_summary)
        } else {
          # Create a data frame for the current passes summary
          curr_algo_summary <- data.frame(
            pass = row_num,
            linkage_implementation = linkage_method,
            blocking_variables = blocking_fields,
            matching_variables = matching_fields,
            acceptance_threshold = acceptance_threshold,
            linkage_rate_pass = linkage_rate_pass,
            linkage_rate_cumulative = linkage_rate_cumulative,
            FDR = NA,
            FOR = NA
          )

          # Bind this to our full algorithm summary
          algo_summary <- rbind(algo_summary, curr_algo_summary)
        }

      } else{
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
      }

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
        algorithm_name <- get_algorithm_name(linkage_metadata_db, algorithm_id)

        # Define base file name
        base_filename <- paste0(algorithm_name, ' [', curr_iteration_name, '] - Unlinked Pairs')

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
        algorithm_name <- get_algorithm_name(linkage_metadata_db, algorithm_id)

        # Define base file name
        base_filename <- paste0(algorithm_name, ' [', curr_iteration_name, '] - Linkage Results')

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
      }
      else if(!anyNA(linked_indices)){
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
          algorithm_name <- get_algorithm_name(linkage_metadata_db, algorithm_id)

          # Clean up the plot name
          cleaned_plot_name <- str_replace_all(plot_name, "[[:punct:]]", " ") # Remove punctuation
          cleaned_plot_name <- str_to_title(cleaned_plot_name)

          # Define base file name
          base_filename <- paste0(algorithm_name, ' (', curr_iteration_name, ') - ', cleaned_plot_name)

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

    # Track the end time time and get the difference
    total_end_time = proc.time()

    # Format the time difference to two decimal places
    total_formatted_time <- format(round((total_end_time - total_start_time)[3], 3), nsmall = 3)
    #----

    ### Step 5: Add unlinked data to the output data frame
    #----
    # Add a new column that specifies that these rows didn't link
    left_dataset <- cbind(left_dataset, stage="UNLINKED")

    # Get the columns to keep
    output_fields  <- get_linkage_output_fields(linkage_metadata_db, algorithm_id)
    fields_to_keep <- output_fields$field_name
    fields_to_keep <- append(fields_to_keep, "stage")
    if("capture_month_time_trend_field" %in% colnames(left_dataset) && "capture_year_time_trend_field" %in% colnames(left_dataset)){
      fields_to_keep <- append(fields_to_keep, c("capture_month_time_trend_field", "capture_year_time_trend_field"))
    }
    fields_to_keep <- unique(fields_to_keep)

    # Keep the output fields specified by the user
    left_dataset <- subset(left_dataset, select = fields_to_keep)

    # Check if the user wants to include unlinked pairs
    if(("include_unlinked_records" %in% names(extra_parameters) && extra_parameters[["include_unlinked_records"]] == T) ||
       nrow(output_df) <= 0){
      # Bind what's left of the left dataset to the output data frame
      output_df <- rbind(output_df, left_dataset)

      # Change the stage values to be the linkage indicator
      output_df <- output_df %>% mutate(link_indicator = ifelse(stage == "UNLINKED",0,1))
      label(output_df[["link_indicator"]]) <- "Link Indicator"
    }
    else{
      # Change the stage values to be the linkage indicator
      output_df <- output_df %>% mutate(link_indicator = ifelse(stage == "UNLINKED",0,1))
      label(output_df[["link_indicator"]]) <- "Link Indicator"
    }

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
    if(("extra_summary_parameters" %in% names(extra_parameters) && extra_parameters[["extra_summary_parameters"]] == TRUE)){
      label(algo_summary$pass) <- "Step"
      label(algo_summary$linkage_rate_pass) <- "Linkage Rate (%)"
      label(algo_summary$acceptance_threshold) <- "Acceptance Threshold"
      label(algo_summary$blocking_variables) <- "Blocking Scheme"
      label(algo_summary$matching_variables) <- "Matching Criteria"
      label(algo_summary$linkage_implementation) <- "Linkage Technique"
      label(algo_summary$linkage_rate_cumulative) <- "Cumulative Linkage Rate (%)"
      label(algo_summary$FDR) <- "FDR (%)"
      label(algo_summary$FOR) <- "FOR (%)"
    } else {
      label(algo_summary$pass) <- "Step"
      label(algo_summary$linkage_rate_pass) <- "Linkage Rate (%)"
      label(algo_summary$acceptance_threshold) <- "Acceptance Threshold"
      label(algo_summary$blocking_variables) <- "Blocking Scheme"
      label(algo_summary$matching_variables) <- "Matching Criteria"
      label(algo_summary$linkage_implementation) <- "Linkage Technique"
      label(algo_summary$linkage_rate_cumulative) <- "Cumulative Linkage Rate (%)"
    }
    #----

    ### Step 6: Save performance measures, linkage rates, auditing information and whatever
    ###         we may need to the database and export data for linkage reports if asked
    #----
    main_report_algorithm <- NULL
    if("main_report_algorithm" %in% names(extra_parameters) && is.numeric(extra_parameters[["main_report_algorithm"]]) &&
       extra_parameters[["main_report_algorithm"]] > 0){
      main_report_algorithm <- extra_parameters[["main_report_algorithm"]]
    }

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

      # Save the performance measure data to our audit list
      audit_measures_list[["Linkage Rate"]] <- linkage_rate
      audit_measures_list[["Time to Completion (s)"]] <- total_formatted_time
      audit_measures_list[["PPV"]] <- PPV
      audit_measures_list[["NPV"]] <- NPV
      audit_measures_list[["Sensitivity"]] <- SENS
      audit_measures_list[["Specificity"]] <- SPEC
      audit_measures_list[["F1 Score"]] <- F1_SCORE

      # Create a performance measures data frame to store all the information
      performance_measures_df <- data.frame(
        algorithm_name = algorithm_name,
        sensitivity = SENS,
        specificity = SPEC,
        positive_predictive_value = PPV,
        negative_predictive_value = NPV,
        f1_score = F1_SCORE,
        linkage_rate = linkage_rate
      )

      # Apply labels to the performance measures data frame
      label(performance_measures_df$algorithm_name) <- "Algorithm Name"
      label(performance_measures_df$positive_predictive_value) <- "PPV"
      label(performance_measures_df$negative_predictive_value) <- "NPV"
      label(performance_measures_df$sensitivity) <- "Sensitivity"
      label(performance_measures_df$specificity) <- "Specificity"
      label(performance_measures_df$f1_score) <- "F1 Score"
      label(performance_measures_df$linkage_rate) <- "Linkage Rate"

      # Get the output directory
      output_dir <- extra_parameters[["linkage_output_folder"]]

      # Get the algorithm name
      df <- dbGetQuery(linkage_metadata_db, paste0('SELECT * FROM linkage_algorithms WHERE algorithm_id = ', algorithm_id))
      algorithm_name <- stri_replace_all_regex(df$algorithm_name, " ", "")
      algorithm_name <- get_algorithm_name(linkage_metadata_db, algorithm_id)

      # Define base file name
      base_filename <- paste0(algorithm_name, ' (', algorithm_timestamp,') - Performance Measures')

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
    else{
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

      # Save the performance measure data to our audit list
      audit_measures_list[["Linkage Rate"]] <- linkage_rate
      audit_measures_list[["Time to Completion (s)"]] <- total_formatted_time
      audit_measures_list[["PPV"]] <- PPV
      audit_measures_list[["NPV"]] <- NPV
      audit_measures_list[["Sensitivity"]] <- SENS
      audit_measures_list[["Specificity"]] <- SPEC
      audit_measures_list[["F1 Score"]] <- F1_SCORE

      # Create a performance measures data frame to store all the information
      performance_measures_df <- data.frame(
        algorithm_name = algorithm_name,
        sensitivity = SENS,
        specificity = SPEC,
        positive_predictive_value = PPV,
        negative_predictive_value = NPV,
        f1_score = F1_SCORE,
        linkage_rate = linkage_rate
      )

      # Apply labels to the performance measures data frame
      label(performance_measures_df$algorithm_name) <- "Algorithm Name"
      label(performance_measures_df$positive_predictive_value) <- "PPV"
      label(performance_measures_df$negative_predictive_value) <- "NPV"
      label(performance_measures_df$sensitivity) <- "Sensitivity"
      label(performance_measures_df$specificity) <- "Specificity"
      label(performance_measures_df$f1_score) <- "F1 Score"
      label(performance_measures_df$linkage_rate) <- "Linkage Rate"
    }

    # Try to export an algorithm summary
    if(("generate_algorithm_summary" %in% names(extra_parameters) && extra_parameters[["generate_algorithm_summary"]] == TRUE) &&
       "linkage_output_folder" %in% names(extra_parameters)){
      # Get the output directory
      output_dir <- extra_parameters[["linkage_output_folder"]]

      # Get the algorithm name
      df <- dbGetQuery(linkage_metadata_db, paste0('SELECT * FROM linkage_algorithms WHERE algorithm_id = ', algorithm_id))
      algorithm_name <- stri_replace_all_regex(df$algorithm_name, " ", "")
      algorithm_name <- get_algorithm_name(linkage_metadata_db, algorithm_id)

      # Define base file name
      base_filename <- paste0(algorithm_name, ' (', algorithm_timestamp,') - Linkage Algorithm Summary')

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

    # First check if the current algorithm is the main algorithm, otherwise do not generate a report
    if(is.null(main_report_algorithm) || main_report_algorithm == algorithm_id){
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
          strata_vars <- strata_vars[! strata_vars %in% c('link_indicator')] # Drop the 'link_indicator' field
          strata_vars <- strata_vars[! strata_vars %in% c('capture_month_time_trend_field')] # Drop the 'capture_month_time_trend_field' field
          strata_vars <- strata_vars[! strata_vars %in% c('capture_year_time_trend_field')] # Drop the 'capture_year_time_trend_field' field

          # Load the 'linkrep' library and generate a linkage quality report
          library("linkrep")

          ### Verify the performance measures info is valid
          ground_truth_df <- get_ground_truth_fields(linkage_metadata_db, algorithm_id)
          ground_truth_fields <- ""
          ground_truth_fields_vector <- c()
          performance_measures_footnotes <- c("PPV = Positive predictive value, NPV = Negative predictive value.")
          if(nrow(performance_measures_df) <= 0){
            performance_measures_df <- NULL
            performance_measures_footnotes <- NULL
            ground_truth_fields <- NULL
          }
          else{
            if(nrow(ground_truth_df) > 0){
              for(j in 1:nrow(ground_truth_df)){
                # First, get the dataset field name
                field_name <- ground_truth_df$left_dataset_field[j]

                # Convert the field name to either upper, lower, or title case
                field_name <- convert_name_case(field_name)

                # Append the field name to the list of ground truth fields
                ground_truth_fields_vector <- append(ground_truth_fields_vector, field_name)
              }
            }

            # Collapse the ground truth fields into a single string
            ground_truth_fields <- paste(ground_truth_fields_vector, collapse = ", ")
          }

          ### Verify the plot information is valid
          if(length(algorithm_plots) <= 0 || length(plot_captions) <= 0){
            algorithm_plots <- NULL
            plot_captions <- NULL
          }

          ### If we considered other algorithms, add them to the report appendix
          # Create a list of our considered algorithms
          considered_algo_summary_list           <- considered_linkage_algorithm_summary_list
          considered_algo_summary_footnotes_list <- considered_linkage_algorithm_footnote_list
          considered_algo_summary_table_names    <- considered_linkage_algorithm_table_names

          # Get the considered performance measures
          considered_performance_measures <- considered_performance_measures_df

          # Finally, if we don't have any enabled algorithms, set the input values to NULL
          if(length(considered_algo_summary_list) <= 0 || length(considered_algo_summary_footnotes_list) <= 0 || length(considered_algo_summary_table_names) <= 0){
            considered_algo_summary_footnotes_list <- NULL
            considered_algo_summary_list <- NULL
            considered_algo_summary_table_names <- NULL
          }

          # Check if we have any rows in our considered performances measures
          if(nrow(considered_performance_measures) <= 0){
            considered_performance_measures <- NULL
          }

          # Add this algorithm to our list of considered algorithms if at least one was provided
          if(!is.null(considered_algo_summary_list) && length(considered_algo_summary_list) > 0){
            # Save the performance measures information
            if(!is.null(performance_measures_df) && nrow(performance_measures_df) > 0){
              considered_performance_measures <- rbind(considered_performance_measures, performance_measures_df)
            }

            # Save the algorithm summary
            considered_algo_summary_list[[length(considered_algo_summary_list)+1]] <- algo_summary

            # Save the algorithm footnotes
            considered_algo_summary_footnotes_list[[length(considered_algo_summary_footnotes_list)+1]] <- algo_summary_footnotes

            # Save the algorithm table name
            considered_algo_summary_table_names <- append(considered_algo_summary_table_names, get_algorithm_name(linkage_metadata_db, algorithm_id))
          }

          # Check to see if we have missing data indicators
          display_missing_data_ind <- T
          if(nrow(missing_data_indicators) <= 0){
            missing_data_indicators  <- NULL
            display_missing_data_ind <- F
          }

          # Call the progress callback with progress value and optional message
          if (!is.null(progress_callback)) {
            progress_value <- 1/(total_steps+1)
            progress_callback(progress_value, paste0("Step [", current_step+1, "/", total_steps, "] ", "Generating Final Report for Algorithm ", algorithm_num, " of ", length(algorithm_ids)))
            current_step <- current_step + 1
          }

          # Generate the report file name
          report_file_name <- paste0(algorithm_name, ' (', algorithm_timestamp, ')')

          # Report title and subtitle
          report_title    <- "Data Linkage Quality Report"
          report_subtitle <- paste0("Linkage of ", datasets$left_dataset_name, " with ", datasets$right_dataset_name)

          # Get the threshold
          threshold <- NULL
          if("report_threshold" %in% names(extra_parameters)){
            threshold <- extra_parameters[["report_threshold"]]
          }

          # Modify the footnotes to be one character string per table
          algo_summary_footnotes <- paste(algo_summary_footnotes, collapse = ", ")
          if(length(considered_algo_summary_footnotes_list) > 0){
            for(i in 1:length(considered_algo_summary_footnotes_list)){
              considered_algo_summary_footnotes_list[[i]] <- paste(considered_algo_summary_footnotes_list[[i]], collapse = ", ")
            }
          }

          # Get the definitions, abbreviations, and study flow diagram (if they were provided)
          definitions        <- NULL
          abbreviations      <- NULL
          study_flow_diagram <- NULL
          if("definitions" %in% names(extra_parameters)){
            definitions <- extra_parameters[["definitions"]]
          }
          if("abbreviations" %in% names(extra_parameters)){
            abbreviations <- extra_parameters[["abbreviations"]]
          }
          if("study_flow_diagram" %in% names(extra_parameters)){
            study_flow_diagram <- extra_parameters[["study_flow_diagram"]]
          }

          # Get the time trend values
          if("capture_month_time_trend_field" %in% colnames(left_dataset) && "capture_year_time_trend_field" %in% colnames(left_dataset)){
            capture_month_time_trend_field <- "capture_month_time_trend_field"
            capture_year_time_trend_field  <- "capture_year_time_trend_field"
          }
          else{
            capture_month_time_trend_field <- NULL
            capture_year_time_trend_field  <- NULL
          }

          # Generate the linkage quality report
          final_linkage_quality_report(output_df, report_title, report_subtitle, datasets$left_dataset_name,
                                       datasets$right_dataset_name, output_dir, username, "autolink (Record Linkage)",
                                       "link_indicator", strata_vars, strata_vars, save_linkage_rate = F,
                                       algorithm_summary_data = algo_summary, algorithm_summary_tbl_footnotes = algo_summary_footnotes,
                                       performance_measures_data = performance_measures_df, performance_measures_tbl_footnotes = performance_measures_footnotes,
                                       ground_truth = ground_truth_fields,
                                       threshold_plots = algorithm_plots, threshold_plot_captions = plot_captions,
                                       considered_algorithm_summary_data = considered_algo_summary_list, considered_algorithm_summary_tbl_footnotes = considered_algo_summary_footnotes_list,
                                       considered_algorithm_summary_table_names = considered_algo_summary_table_names, considered_performance_measures = considered_performance_measures,
                                       missing_data_indicators = missing_data_indicators, display_missingness_table = display_missing_data_ind,
                                       R_version = as.character(getRversion()), linkrep_package_version = as.character(packageVersion("linkrep")),
                                       report_file_name = report_file_name, threshold = threshold,
                                       definitions = definitions, abbreviations = abbreviations, flow_chart_path = study_flow_diagram,
                                       acquisition_month_var = capture_month_time_trend_field, acquisition_year_var = capture_year_time_trend_field,
                                       num_pairs_non_missing_ground_truth = ground_truth_non_zero, num_record_pairs = total_record_count)

          detach("package:linkrep", unload = TRUE)
        },
        error = function(e){
          detach("package:linkrep", unload = TRUE)
          print(geterrmessage())
          print(e)
          # If we failed to generate a linkage report, write to a csv file instead
          print("Error: Unable to generate linkage report, saving output data frame to specified output folder.")

          # Get the algorithm name
          algorithm_name <- get_algorithm_name(linkage_metadata_db, algorithm_id)

          # Define base file name
          base_filename <- paste0(algorithm_name, ' Complete Linkage Results (', algorithm_timestamp, ')')

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
        algorithm_name <- get_algorithm_name(linkage_metadata_db, algorithm_id)

        # Define base file name
        base_filename <- paste0(algorithm_name, ' Complete Linkage Results (', algorithm_timestamp, ')')

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
    }

    # If the "main_report_algorithm" is not missing, store this algorithms performance and summary
    if("main_report_algorithm" %in% names(extra_parameters) && is.numeric(extra_parameters[["main_report_algorithm"]]) &&
       extra_parameters[["main_report_algorithm"]] > 0 && extra_parameters[["main_report_algorithm"]] != algorithm_id){
      # Save the performance measures information
      if(!is.null(performance_measures_df) && nrow(performance_measures_df) > 0){
        considered_performance_measures_df <- rbind(considered_performance_measures_df, performance_measures_df)
      }

      # Save the algorithm summary
      considered_linkage_algorithm_summary_list[[length(considered_linkage_algorithm_summary_list)+1]] <- algo_summary

      # Save the algorithm footnotes
      considered_linkage_algorithm_footnote_list[[length(considered_linkage_algorithm_footnote_list)+1]] <- algo_summary_footnotes

      # Save the algorithm table name
      considered_linkage_algorithm_table_names <- append(considered_linkage_algorithm_table_names, get_algorithm_name(linkage_metadata_db, algorithm_id))
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
    if(!is.null(performance_measures_df) && nrow(performance_measures_df) > 0){
      intermediate_performance_measures_df <- rbind(intermediate_performance_measures_df, performance_measures_df)
    }

    # Save the algorithm footnotes
    linkage_algorithm_footnote_list[[length(linkage_algorithm_footnote_list)+1]] <- algo_summary_footnotes

    # Save the algorithm run timestamp
    linked_data_generation_times <- append(linked_data_generation_times, algorithm_timestamp)
    #----

    ### Step 8: Save Auditing Information
    #----
    if("save_audit_performance" %in% names(extra_parameters) && extra_parameters[["save_audit_performance"]] == T &&
       "data_linker" %in% names(extra_parameters)){
      # Convert the list of auditing performance measures to json
      audit_json <- jsonlite::toJSON(audit_measures_list)

      # Get the audit author
      audit_author <- extra_parameters[["data_linker"]]

      # Get the audit date and time
      audit_date <- strsplit(algorithm_timestamp, " ")[[1]][1]
      audit_time <- strsplit(algorithm_timestamp, " ")[[1]][2]

      # Run a insertion query to add this into our auditing database
      new_entry_query <- paste("INSERT INTO performance_measures_audit (algorithm_id, audit_by, audit_date, audit_time, performance_measures_json)",
                               "VALUES(?, ?, ?, ?, ?);")
      new_entry <- dbSendStatement(linkage_metadata_db, new_entry_query)
      dbBind(new_entry, list(algorithm_id, audit_author, audit_date, audit_time, audit_json))
      dbClearResult(new_entry)
    }
    #----
  }

  # If the user would like an intermediate report to be generated, then generate it
  if(("linkage_report_type" %in% names(extra_parameters) && extra_parameters[["linkage_report_type"]] == 2) &&
     "linkage_output_folder" %in% names(extra_parameters) && "data_linker" %in% names(extra_parameters)){
    # Get the output directory
    output_dir <- extra_parameters[["linkage_output_folder"]]
    tryCatch({
      # Load the 'linkrep' library and generate a linkage quality report
      library("linkrep")

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
      datasets <- dbGetQuery(linkage_metadata_db, query, params = list(algorithm_ids[1]))

      # Create a title for the report
      report_file_name <- paste0(datasets$left_dataset_name, " x ", datasets$right_dataset_name)

      # Get the username
      username <- extra_parameters[["data_linker"]]

      # Get the strata variables
      strata_vars <- colnames(linked_data_list[[1]])
      strata_vars <- strata_vars[! strata_vars %in% c('stage')] # Drop the 'stage'/'Passes' field
      strata_vars <- strata_vars[! strata_vars %in% c('link_indicator')] # Drop the 'link_indicator' field
      strata_vars <- strata_vars[! strata_vars %in% c('capture_month_time_trend_field')] # Drop the 'capture_month_time_trend_field' field
      strata_vars <- strata_vars[! strata_vars %in% c('capture_year_time_trend_field')] # Drop the 'capture_year_time_trend_field' field

      # Make sure the missing data indicators were provided
      missing_data_indicators  <- intermediate_missing_indicators_df
      display_missing_data_ind <- T
      if(nrow(missing_data_indicators) <= 0){
        missing_data_indicators  <- NULL
        display_missing_data_ind <- F
      }

      # Call the progress callback
      if (!is.null(progress_callback)) {
        progress_value <- 1/(total_steps+1)
        progress_callback(progress_value, paste0("Step [", current_step+1, "/", total_steps, "] ", "Generating Intermediate Report for All Algorithms"))
        current_step <- current_step + 1
      }

      # Report title and subtitle
      report_title    <- "Data Linkage Sensitivity Analysis"
      report_subtitle <- paste0("Linkage of ", datasets$left_dataset_name, " with ", datasets$right_dataset_name)

      # Get the threshold
      threshold <- NULL
      if("report_threshold" %in% names(extra_parameters)){
        threshold <- extra_parameters[["report_threshold"]]
      }

      # Modify the footnotes to be one character string per table
      if(length(linkage_algorithm_footnote_list) > 0){
        for(i in 1:length(linkage_algorithm_footnote_list)){
          linkage_algorithm_footnote_list[[i]] <- paste(linkage_algorithm_footnote_list[[i]], collapse = ", ")
        }
      }

      # Get the definitions, abbreviations, and study flow diagram (if they were provided)
      definitions        <- NULL
      abbreviations      <- NULL
      study_flow_diagram <- NULL
      if("definitions" %in% names(extra_parameters)){
        definitions <- extra_parameters[["definitions"]]
      }
      if("abbreviations" %in% names(extra_parameters)){
        abbreviations <- extra_parameters[["abbreviations"]]
      }
      if("study_flow_diagram" %in% names(extra_parameters)){
        study_flow_diagram <- extra_parameters[["study_flow_diagram"]]
      }

      # If we have performance measures, include them, otherwise generate a normal report
      if(nrow(intermediate_performance_measures_df) <= 0){
        intermediate_linkage_quality_report(main_data_list = linked_data_list, main_data_algorithm_names = linked_data_algorithm_names,
                                            report_title, report_subtitle, datasets$left_dataset_name, datasets$right_dataset_name,
                                            output_dir, username, "autolink (Record Linkage)","link_indicator", strata_vars, strata_vars, save_linkage_rate = F,
                                            algorithm_summary_data_list = linkage_algorithm_summary_list, algorithm_summary_tbl_footnotes_list = linkage_algorithm_footnote_list,
                                            R_version = as.character(getRversion()), linkrep_package_version = as.character(packageVersion("linkrep")),
                                            report_file_name = report_file_name, threshold = threshold,
                                            definitions = definitions, abbreviations = abbreviations, flow_chart_path = study_flow_diagram)
      }
      else{
        performance_measures_footnotes <- c("PPV = Positive predictive value, NPV = Negative predictive value.")

        ### Verify the performance measures info is valid
        ground_truth_df <- get_ground_truth_fields(linkage_metadata_db, algorithm_id)
        ground_truth_fields <- ""
        ground_truth_fields_vector <- c()
        if(nrow(ground_truth_df) > 0){
          for(j in 1:nrow(ground_truth_df)){
            # First, get the dataset field name
            field_name <- ground_truth_df$left_dataset_field[j]

            # Convert the field name to either upper, lower, or title case
            field_name <- convert_name_case(field_name)

            # Append the field name to the list of ground truth fields
            ground_truth_fields_vector <- append(ground_truth_fields_vector, field_name)
          }
        }

        # Collapse the ground truth fields into a single string
        ground_truth_fields <- paste(ground_truth_fields_vector, collapse = ", ")

        #ground_truth_df <- get_ground_truth_fields(linkage_metadata_db, algorithm_id)
        #ground_truth_fields <- paste(ground_truth_df$left_dataset_field, collapse = ", ")
        intermediate_linkage_quality_report(main_data_list = linked_data_list, main_data_algorithm_names = linked_data_algorithm_names,
                                            report_title, report_subtitle, datasets$left_dataset_name, datasets$right_dataset_name,
                                            output_dir, username, "autolink (Record Linkage)","link_indicator", strata_vars, strata_vars, save_linkage_rate = F,
                                            algorithm_summary_data_list = linkage_algorithm_summary_list, algorithm_summary_tbl_footnotes_list = linkage_algorithm_footnote_list,
                                            performance_measures_data = intermediate_performance_measures_df, performance_measures_tbl_footnotes = performance_measures_footnotes,
                                            ground_truth = ground_truth_fields,
                                            R_version = as.character(getRversion()), linkrep_package_version = as.character(packageVersion("linkrep")),
                                            report_file_name = report_file_name, threshold = threshold,
                                            definitions = definitions, abbreviations = abbreviations, flow_chart_path = study_flow_diagram)
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
  if("save_all_linkage_results" %in% names(extra_parameters) && extra_parameters[["save_all_linkage_results"]] == T){
    # Create a result list of all the data we collected
    result_list <- list()
    result_list[["linked_data"]]             <- linked_data_list
    result_list[["linked_algorithm_ids"]]    <- algorithm_ids
    result_list[["linked_algorithm_names"]]  <- linked_data_algorithm_names
    result_list[["algorithm_summaries"]]     <- linkage_algorithm_summary_list
    result_list[["algorithm_footnotes"]]     <- linkage_algorithm_footnote_list
    result_list[["performance_measures"]]    <- intermediate_performance_measures_df
    result_list[["missing_data_indicators"]] <- intermediate_missing_indicators_df
    result_list[["generated_timestamps"]]    <- linked_data_generation_times

    # Remove the values
    rm(linked_data_list, linked_data_algorithm_names, linkage_algorithm_summary_list,
       linkage_algorithm_footnote_list, intermediate_performance_measures_df,
       intermediate_missing_indicators_df, linked_data_generation_times)

    # Garbage collection
    gc()

    # Return the result list
    return(result_list)
  }
  else{
    # Remove the values we didnt use
    rm(linked_data_list, linked_data_algorithm_names, linkage_algorithm_summary_list,
       linkage_algorithm_footnote_list, intermediate_performance_measures_df,
       intermediate_missing_indicators_df, linked_data_generation_times)

    # Garbage collection
    gc()

    # Return NULL if the user doesn't want to save all the linkage results
    return(NULL)
  }
}
