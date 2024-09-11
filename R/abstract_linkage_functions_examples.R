# Define the abstract class (interface)
LinkageMethod <- R6::R6Class("LinkageMethod",
                             public = list(
                               run_iteration = function(left_dataset, right_dataset, linkage_metadata_db, iteration_id, extra_parameters) {
                                 stop("This is an abstract method and should be implemented by a subclass.")
                               }
                             )
)

# Default package linkage class.
Reclin2Linkage <- R6::R6Class("Reclin2Linkage",
                              inherit = LinkageMethod,
  public = list(
    run_iteration = function(left_dataset, right_dataset, linkage_metadata_db, iteration_id, extra_parameters) {
      # Track start time so that we may make note of how long each pass takes
      start_time = Sys.time()

      # Get the linkage technique to determine whether this is a deterministic or probabilistic pass
      linkage_technique <- get_linkage_technique(linkage_metadata_db, iteration_id)
      if (linkage_technique == "P") {
        # We are running a probabilistic pass of this linkage algorithm using Reclin2

        # Capture the number of records going into this pass.  This will serve as the denominator for the pass-wise linkage rate
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
              if("standardize_names_file_path" %in% names(extra_parameters)){
                # Get the file path (DEFINED/PASSED BY THE USER WHICH MUST BE A .csv)
                file_path <- extra_parameters$standardize_names_file_path

                # Get the field(s) we'll be standardizing
                dataset_field <- row$left_dataset_field

                # Get the standardized name for both datasets by calling the helper function
                standardized_names_left <- ifelse(!is.na(get_standardized_names(left_dataset[[dataset_field]])),
                                                  get_token_name(left_dataset[[dataset_field]]), left_dataset[[dataset_field]])
                standardized_names_right <- ifelse(!is.na(get_standardized_names(right_dataset[[dataset_field]])),
                                                   get_token_name(right_dataset[[dataset_field]]), right_dataset[[dataset_field]])

                # Place the standardized names back into the dataset
                left_dataset[[dataset_field]] <- standardized_names_left
                right_dataset[[dataset_field]] <- standardized_names_right

                # Store this field name as one of our blocking fields
                blocking_keys <- append(blocking_keys, dataset_field)
              }
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
          }
        }





        #----------------------------------------------------------------------#

        # Now that we have all the blocking and matching keys, we'll get
        # started on the pairs, beginning with blocking keys

        # First create an empty data frame which will contains our pairs
        blocking_pairs <- data.frame()

        # Next, we'll go through out list of blocking key pairs, and bind them all together
        for(blocking_keys in blocking_keys_pairs){
          # Use the reclin2 pair_blocking function
          curr_blocking_pair <- reclin2::pair_blocking(left_dataset, right_dataset, on = blocking_keys)

          # With the pair generated, we'll use rbind to combine all the combinations
          rbind(blocking_pairs, curr_blocking_pair)
        }

        # Now, we'll move onto the matching keys, using the compare_pairs() function from reclin2



      } else if (linkage_technique == "D") {
        print("This is the deterministic version of a reclin2 iteration")
      }

      # Track the end time time and get the difference
      end_time = Sys.time()
      difftime(end_time, start_time, units="secs")
    }
  )
)

run_main_linkage <- function(left_dataset, right_dataset, linkage_metadata_db, algorithm_id, extra_parameters){
  # Step 1: Get the iteration IDs using the selected algorithm ID
  iterations_query <- dbSendQuery(linkage_metadata_db, 'SELECT * FROM linkage_iterations WHERE algorithm_id = $id ORDER BY iteration_num asc;')
  dbBind(iterations_query, list(id=algorithm_id))
  iterations_df <- dbFetch(iterations_query)
  dbClearResult(iterations_query)

  # Error check, make sure an algorithm with this ID exists
  if(nrow(iterations_df) <= 0){
    stop("Error: No iterations found under the provided algorithm, verify that iterations exist and try running again.")
  }

  # Step 2: For each iteration ID loop through and perform data linkage
  for(row_num in 1:nrow(iterations_df)){
    # Get the current row
    row <- iterations_df[row_num,]

    # Get the current iteration_id
    curr_iteration_id <- row$iteration_id

    # BEFORE EVERYTHING #

    # Get the implementation class name to decide which linkage implementation to call
    implementation_name <- get_implementation_name(linkage_db = linkage_metadata_db, iteration_id = curr_iteration_id)

    # Retrieve the class definition from the implementation name string
    class_obj <- get(implementation_name)

    # Instantiate the class object
    linkage_implementation <- class_obj$new()

    # Call the run_iteration method implemented by the desired class
    result <- linkage_implementation$run_iteration(left_dataset, right_dataset, linkage_metadata_db, curr_iteration_id, extra_parameters)

    # Step 2.5: Do whatever we may need with the result, before going onto the next iteration


  }

  # Step 3: Save performance measures, linkage rates, auditing information and whatever
  #         we may need to the database and export data for linkage reports if asked

}
