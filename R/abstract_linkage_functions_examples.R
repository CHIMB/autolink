# Define the abstract class (interface)
LinkageMethod <- R6::R6Class("LinkageMethod",
                             public = list(
                               run_iteration = function(left_dataset, right_dataset, blocking_keys, matching_vars, thresholds, linkage_technique) {
                                 stop("This is an abstract method and should be implemented by a subclass.")
                               }
                             )
)

# Example for reclin2
Reclin2Linkage <- R6::R6Class("Reclin2Linkage",
                              inherit = LinkageMethod,
                              public = list(
                                run_iteration = function(left_dataset, right_dataset, blocking_keys, matching_vars, thresholds, linkage_technique) {
                                  if (linkage_technique == "P") {
                                    print("This is the probabilistic version of a reclin2 iteration")
                                  } else if (linkage_technique == "D") {
                                    print("This is the deterministic version of a reclin2 iteration")
                                  }
                                }
                              )
)

# Example for fastLink
FastLinkLinkage <- R6::R6Class("FastLinkLinkage",
                               inherit = LinkageMethod,
                               public = list(
                                 run_iteration = function(left_dataset, right_dataset, blocking_keys, matching_vars, thresholds, linkage_technique) {
                                   if (linkage_technique == "P") {
                                     print("This is the probabilistic version of a fastlink iteration")
                                   } else if (linkage_technique == "D") {
                                     print("This is the deterministic version of a fastlink iteration")
                                   }
                                 }
                               )
)

run_main_linkage_v2 <- function(left_dataset, right_dataset, linkage_metadata_db, algorithm_id){
  #-- HELPER FUNCTIONS FOR GETTING IMPLEMENTATION PARAMETERS --#
  # Get the blocking keys for this iteration, returning a data frame consisting of
  # right and left data set field names, and linkage rules
  get_blocking_keys <- function(db, iteration_id){
    # Start by getting all the rows from blocking_variables that match to a specific iteration_id
    blocking_keys_df <- dbGetQuery(db, paste0('SELECT left_dataset_field, right_dataset_field, linkage_rule_id FROM blocking_variables
                                where iteration_id = ', iteration_id))

    # Prevent error in-case there are no blocking variables for this iteration
    if(nrow(blocking_keys_df) <= 0){
      return(data.frame())
    }

    # For each row in the df we returned, if a linkage rule ID is not NA, then we will perform a query to
    # get a JSON object of the parameters stored in the database
    for(row_num in 1:nrow(blocking_keys_df)) {
      # Get the current row
      row <- blocking_keys_df[row_num,]

      # Get the parameters for each row if a linkage rule id was selected
      linkage_rule_id <- row$linkage_rule_id
      if(!is.na(linkage_rule_id)){
        # Get the linkage rule fields
        parameters_df <- dbGetQuery(db, paste0('SELECT * from linkage_rules where linkage_rule_id = ', linkage_rule_id))

        # Initialize an empty list to store key-value pairs
        key_value_pairs <- list()

        # Iterate over the columns in parameters_df
        for (col_name in names(parameters_df)[-1]) {
          # Get the value for the current column
          value <- parameters_df[[col_name]][1]

          # Only include non-NA values
          if (!is.na(value)) {
            # Add the key-value pair to the list
            key_value_pairs[[col_name]] <- value
          }
        }

        # Convert the list of key-value pairs to a JSON string
        linkage_rule_json <- jsonlite::toJSON(key_value_pairs, auto_unbox = TRUE)

        # Store the linkage rules over the initial linkage rule ID, and continue through the loop
        row$linkage_rule_id <- linkage_rule_json
        blocking_keys_df[row_num, ] <- row
      }
    }

    # Rename the "linkage_rule_id" column to "linkage_rules"
    names(blocking_keys_df)[names(blocking_keys_df) == 'linkage_rule_id'] <- 'linkage_rules'

    # Return the blocking keys w/ rules
    return(blocking_keys_df)
  }

  # Get the matching keys for this iteration, returning a data frame consisting of
  # right and left data set field names, linkage rules, and comparison rules
  get_matching_keys <- function(db, iteration_id){
    # Start by getting all the rows from blocking_variables that match to a specific iteration_id
    matching_keys_df <- dbGetQuery(db, paste0('SELECT left_dataset_field, right_dataset_field, linkage_rule_id, comparison_rule_id FROM matching_variables
                                where iteration_id = ', iteration_id))

    # Prevent error in-case there are no matching variables for this iteration
    if(nrow(matching_keys_df) <= 0){
      return(data.frame())
    }

    # For each row in the df we returned, if a linkage rule ID is not NA, then we will perform a query to
    # get a JSON object of the parameters stored in the database
    for(row_num in 1:nrow(matching_keys_df)) {
      # Get the current row
      row <- matching_keys_df[row_num,]

      # Get the parameters for each row if a linkage rule id was selected
      linkage_rule_id <- row$linkage_rule_id
      if(!is.na(linkage_rule_id)){
        # Get the linkage rule fields
        parameters_df <- dbGetQuery(db, paste0('SELECT * from linkage_rules where linkage_rule_id = ', linkage_rule_id))

        # Initialize an empty list to store key-value pairs
        key_value_pairs <- list()

        # Iterate over the columns in parameters_df
        for (col_name in names(parameters_df)[-1]) {
          # Get the value for the current column
          value <- parameters_df[[col_name]][1]

          # Only include non-NA values
          if (!is.na(value)) {
            # Add the key-value pair to the list
            key_value_pairs[[col_name]] <- value
          }
        }

        # Convert the list of key-value pairs to a JSON string
        linkage_rule_json <- jsonlite::toJSON(key_value_pairs, auto_unbox = TRUE)

        # Store the linkage rules over the initial linkage rule ID, and continue through the loop
        row$linkage_rule_id <- linkage_rule_json
        matching_keys_df[row_num, ] <- row
      }

      # Get the parameters for each row if a comparison rule id was selected
      comparison_rule_id <- row$comparison_rule_id
      if(!is.na(comparison_rule_id)){
        # Get the linkage rule fields
        parameters_df <- dbGetQuery(my_db, paste0('SELECT iteration_id, right_dataset_field, left_dataset_field, parameter_key, parameter FROM matching_variables mv
                                    JOIN comparison_rules_parameters crp on crp.comparison_rule_id = mv.comparison_rule_id
                                    JOIN comparison_method_parameters cmp on cmp.parameter_id = crp.parameter_id
                                    WHERE iteration_id = ', iteration_id))

        # Initialize an empty list to store key-value pairs
        key_value_pairs <- list()

        # For each row in our returned parameters query, if the fields match up with
        # the row we're currently on, then its one of the key-value pairs.
        for (parameter_row in 1:nrow(parameters_df)) {
          left_field <- parameters_df$left_dataset_field[parameter_row]
          right_field <- parameters_df$right_dataset_field[parameter_row]

          # Check if the fields match the ones in the row
          if (left_field == row$left_dataset_field && right_field == row$right_dataset_field) {
            key <- parameters_df$parameter_key[parameter_row]
            value <- parameters_df$parameter[parameter_row]

            # Add the key-value pair to the linkage_rules list
            key_value_pairs[[key]] <- value
          }
        }

        # Convert the list of key-value pairs to a JSON string
        comparison_rule_json <- jsonlite::toJSON(key_value_pairs, auto_unbox = TRUE)

        # Store the linkage rules over the initial linkage rule ID, and continue through the loop
        row$comparison_rule_id <- comparison_rule_json
        matching_keys_df[row_num, ] <- row
      }
    }

    # Rename the "linkage_rule_id" column to "linkage_rules"
    names(matching_keys_df)[names(matching_keys_df) == 'linkage_rule_id'] <- 'linkage_rules'

    # Rename the "comparison_rule_id" column to "comparison_rules"
    names(matching_keys_df)[names(matching_keys_df) == 'comparison_rule_id'] <- 'comparison_rules'

    # Return the matching keys w/ rules
    return(matching_keys_df)
  }

  # Get the acceptance thresholds used for this iteration, returning a list of
  # key-value pairs
  get_acceptence_thresholds <- function(db, iteration_id){
    # Perform a query that joins linkage_iterations with acceptance rules parameters and method parameters to get the keys and values
    acceptance_rules_df <- dbGetQuery(my_db, paste0('SELECT iteration_id, parameter_key, parameter FROM linkage_iterations li
                                      JOIN acceptance_rules_parameters arp on arp.acceptance_rule_id = li.acceptance_rule_id
                                      JOIN acceptance_method_parameters amp on amp.parameter_id = arp.parameter_id
                                      WHERE iteration_id = ', iteration_id))

    # Prevent error in-case there are no thresholds for this iteration
    if(nrow(acceptance_rules_df) <= 0){
      return(list())
    }

    # Initialize an empty list to store key-value pairs
    key_value_pairs <- list()

    # For each row in the data frame we queried, if a add each key-value pair to a list
    for(row_num in 1:nrow(acceptance_rules_df)) {
      # Get the current row
      row <- acceptance_rules_df[row_num,]

      # Get the value of the current row (parameter)
      value <- row$parameter

      # Get the key of the current row (parameter_key)
      key <- row$parameter_key

      # Add the pair to our list
      key_value_pairs[[key]] <- value
    }

    # Return the list of key value pairs
    return(key_value_pairs)
  }

  # Returns the linkage technique for the implementation that is to be run
  get_linkage_technique <- function(db, iteration_id){
    # Perform a query that joins linkage_iterations with linkage methods
    linkage_technique_df <- dbGetQuery(my_db, paste0('SELECT technique_label FROM linkage_iterations li
                                       JOIN linkage_methods lm on lm.linkage_method_id = li.linkage_method_id
                                       WHERE iteration_id = ', iteration_id))

    # If somehow, there is no linkage method, return NA
    if(nrow(linkage_technique_df) <= 0){
      return(NA)
    }

    # Return the label
    return(linkage_technique_df$technique_label)
  }

  # Returns the name of the implementation class that will be used for linkage
  get_implementation_name <- function(db, iteration_id){
    # Perform a query that joins linkage_iterations with linkage methods
    implementation_name_df <- dbGetQuery(my_db, paste0('SELECT implementation_name FROM linkage_iterations li
                                       JOIN linkage_methods lm on lm.linkage_method_id = li.linkage_method_id
                                       WHERE iteration_id = ', iteration_id))

    # If somehow, there is no linkage method, return NA
    if(nrow(implementation_name_df) <= 0){
      return(NA)
    }

    # Return the label
    return(implementation_name_df$implementation_name)
  }
  #------------------------------------------------------------#

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
    implementation_name <- get_implementation_name(db = linkage_metadata_db, iteration_id = curr_iteration_id)

    #-------------------#

    # IF PROB CALL THIS, OTHERWISE, DO SOMETHING ELSE, CALL DIFFERENT CLASS!!!

    # Get the blocking keys using the iteration ID
    blocking_keys <- get_blocking_keys(db = linkage_metadata_db, iteration_id = curr_iteration_id)

    # Get the matching keys using the iteration ID
    matching_keys <- get_matching_keys(db = linkage_metadata_db, iteration_id = curr_iteration_id)

    # Get the acceptance thresholds using the iteration ID
    acceptance_thresholds <- get_acceptence_thresholds(db = linkage_metadata_db, iteration_id = curr_iteration_id)

    # Get the linkage technique using the iteration ID
    linkage_technique <- get_linkage_technique(db = linkage_metadata_db, iteration_id = curr_iteration_id)

    # Get the implementation class name to decide which linkage implementation to call
    implementation_name <- get_implementation_name(db = linkage_metadata_db, iteration_id = curr_iteration_id)

    # Error check here to verify that the implementation exists
    if (!exists(implementation_name)) {
      stop(paste("Class", implementation_name, "does not exist. If a custom implementation is being used,",
                 "verify that it has been sourced into the global environment for usage."))
    }

    # Retrieve the class definition from the implementation name string
    class_obj <- get(implementation_name)

    # Instantiate the class object
    linkage_implementation <- class_obj$new()

    # Call the run_iteration method implemented by the desired class
    result <- linkage_implementation$run_iteration(left_dataset, right_dataset, blocking_keys, matching_keys, acceptance_thresholds, linkage_technique)

    # Step 2.5: Do whatever we may need with the result, before going onto the next iteration


  }

  # Step 3: Save performance measures, linkage rates, auditing information and whatever
  #         we may need to the database and export data for linkage reports if asked

}
