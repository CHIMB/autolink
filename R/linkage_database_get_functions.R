#-- HELPER FUNCTIONS FOR GETTING IMPLEMENTATION PARAMETERS --#
#' Get Iteration Blocking Keys
#'
#' The get_blocking_keys() function will take in a linkage database connection containing
#' all the metadata, along with an iteration ID for the current iteration being run.
#' A dataframe is returned which contains the left and right dataset fields + the linkage
#' rules that should be applied to those fields.
#' @param linkage_db A database connection to the linkage metadata.
#' @param iteration_id An iteration number.
#' @examples
#' sqlite_file <- file.choose() # Select the '.sqlite' linkage metadata file
#' linkage_db <- dbConnect(SQLite(), sqlite_file)
#' iteration_id <- 1
#' get_blocking_keys(linkage_db, iteration_id)
#' @export
get_blocking_keys <- function(linkage_db, iteration_id){
  # Start by getting all the rows from blocking_variables that match to a specific iteration_id
  blocking_keys_df <- dbGetQuery(linkage_db, paste0('
    SELECT
      dvf.field_name AS left_dataset_field,
      dvf2.field_name AS right_dataset_field,
      bv.linkage_rule_id
    FROM blocking_variables bv
    INNER JOIN dataset_fields dvf ON bv.left_dataset_field_id = dvf.field_id
    INNER JOIN dataset_fields dvf2 ON bv.right_dataset_field_id = dvf2.field_id
    WHERE bv.iteration_id = ', iteration_id))

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
      parameters_df <- dbGetQuery(linkage_db, paste0('SELECT * from linkage_rules where linkage_rule_id = ', linkage_rule_id))

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

#' Get Iteration Matching Keys
#'
#' The get_matching_keys() function will take in a linkage database connection containing
#' all the metadata, along with an iteration ID for the current iteration being run.
#' A dataframe is returned which contains the left and right dataset fields + the linkage
#' rules that should be applied to those fields.
#' @param linkage_db A database connection to the linkage metadata.
#' @param iteration_id An iteration number.
#' @examples
#' sqlite_file <- file.choose() # Select the '.sqlite' linkage metadata file
#' linkage_db <- dbConnect(SQLite(), sqlite_file)
#' iteration_id <- 1
#' get_matching_keys(linkage_db, iteration_id)
#' @export
get_matching_keys <- function(linkage_db, iteration_id){
  # Start by getting all the rows from blocking_variables that match to a specific iteration_id
  matching_keys_df <- dbGetQuery(linkage_db, paste0('
    SELECT
      dvf.field_name AS left_dataset_field,
      dvf2.field_name AS right_dataset_field,
      mv.linkage_rule_id,
      mv.comparison_rule_id
    FROM matching_variables mv
    INNER JOIN dataset_fields dvf ON mv.left_dataset_field_id = dvf.field_id
    INNER JOIN dataset_fields dvf2 ON mv.right_dataset_field_id = dvf2.field_id
    WHERE mv.iteration_id = ', iteration_id))

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
      parameters_df <- dbGetQuery(linkage_db, paste0('SELECT * from linkage_rules where linkage_rule_id = ', linkage_rule_id))

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
      parameters_df <- dbGetQuery(linkage_db, paste0('
        SELECT
          crp.parameter_id,
          crp.parameter,
          cmp.parameter_key
        FROM comparison_rules_parameters crp
        JOIN comparison_method_parameters cmp ON crp.parameter_id = cmp.parameter_id
        WHERE crp.comparison_rule_id = ', comparison_rule_id))

      key_value_pairs <- as.list(setNames(parameters_df$parameter, parameters_df$parameter_key))

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

#' Get Iteration Acceptance Threshold
#'
#' The get_acceptence_thresholds() function will take in a linkage database connection
#' containing all the metadata, along with an iteration ID for the current iteration being run.
#' A list of key-value pairs are returned containing all the necessary thresholds for the
#' current iteration.
#' @param linkage_db A database connection to the linkage metadata.
#' @param iteration_id An iteration number.
#' @examples
#' sqlite_file <- file.choose() # Select the '.sqlite' linkage metadata file
#' linkage_db <- dbConnect(SQLite(), sqlite_file)
#' iteration_id <- 1
#' get_acceptence_thresholds(linkage_db, iteration_id)
#' @export
get_acceptence_thresholds <- function(linkage_db, iteration_id){
  # Perform a query that joins linkage_iterations with acceptance rules parameters and method parameters to get the keys and values
  acceptance_rules_df <- dbGetQuery(linkage_db, paste0('SELECT iteration_id, parameter_key, parameter FROM linkage_iterations li
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

#' Get Iteration Linkage Technique
#'
#' The get_linkage_technique() function will take in a linkage database connection
#' containing all the metadata, along with an iteration ID for the current iteration being run.
#' A singular string is returned which is what linkage technique should be used by
#' a specific linkage implementation.
#' @param linkage_db A database connection to the linkage metadata.
#' @param iteration_id An iteration number.
#' @examples
#' sqlite_file <- file.choose() # Select the '.sqlite' linkage metadata file
#' linkage_db <- dbConnect(SQLite(), sqlite_file)
#' iteration_id <- 1
#' get_linkage_technique(linkage_db, iteration_id)
#' @export
get_linkage_technique <- function(linkage_db, iteration_id){
  # Perform a query that joins linkage_iterations with linkage methods
  linkage_technique_df <- dbGetQuery(linkage_db, paste0('SELECT technique_label FROM linkage_iterations li
                                       JOIN linkage_methods lm on lm.linkage_method_id = li.linkage_method_id
                                       WHERE iteration_id = ', iteration_id))

  # If somehow, there is no linkage method, return NA
  if(nrow(linkage_technique_df) <= 0){
    return(NA)
  }

  # Return the label
  return(linkage_technique_df$technique_label)
}

#' Get Iteration Implementation Name
#'
#' The get_implementation_name() function will take in a linkage database connection
#' containing all the metadata, along with an iteration ID for the current iteration being run.
#' A singular string is returned which is what linkage implementation should be used by
#' the current running iteration.
#' @param linkage_db A database connection to the linkage metadata.
#' @param iteration_id An iteration number.
#' @examples
#' sqlite_file <- file.choose() # Select the '.sqlite' linkage metadata file
#' linkage_db <- dbConnect(SQLite(), sqlite_file)
#' iteration_id <- 1
#' get_implementation_name(linkage_db, iteration_id)
#' @export
get_implementation_name <- function(linkage_db, iteration_id){
  # Perform a query that joins linkage_iterations with linkage methods
  implementation_name_df <- dbGetQuery(linkage_db, paste0('SELECT implementation_name FROM linkage_iterations li
                                       JOIN linkage_methods lm on lm.linkage_method_id = li.linkage_method_id
                                       WHERE iteration_id = ', iteration_id))

  # If somehow, there is no linkage method, return NA
  if(nrow(implementation_name_df) <= 0){
    return(NA)
  }

  # Return the label
  return(implementation_name_df$implementation_name)
}

#' Get Algorithm Ground Truth Keys
#'
#' The get_ground_truth_fields() function will take in a linkage database connection containing
#' all the metadata, along with an iteration ID for the current iteration being run.
#' A dataframe is returned which contains the left and right dataset fields + the linkage
#' rules that should be applied to those fields.
#' @param linkage_db A database connection to the linkage metadata.
#' @param algorithm_id An iteration number.
#' @examples
#' sqlite_file <- file.choose() # Select the '.sqlite' linkage metadata file
#' linkage_db <- dbConnect(SQLite(), sqlite_file)
#' algorithm_id <- 1
#' get_ground_truth_fields(linkage_db, algorithm_id)
#' @export
get_ground_truth_fields <- function(linkage_db, algorithm_id){
  # Start by getting all the rows from ground_truth_variables that match to a specific algorithm_id
  ground_truth_df <- dbGetQuery(linkage_db, paste0('
    SELECT
      dvf.field_name AS left_dataset_field,
      dvf2.field_name AS right_dataset_field,
      gtv.linkage_rule_id
    FROM ground_truth_variables gtv
    INNER JOIN dataset_fields dvf ON gtv.left_dataset_field_id = dvf.field_id
    INNER JOIN dataset_fields dvf2 ON gtv.right_dataset_field_id = dvf2.field_id
    WHERE gtv.algorithm_id = ', algorithm_id))

  # Prevent error in-case there are no blocking variables for this iteration
  if(nrow(ground_truth_df) <= 0){
    return(data.frame())
  }

  # For each row in the df we returned, if a linkage rule ID is not NA, then we will perform a query to
  # get a JSON object of the parameters stored in the database
  for(row_num in 1:nrow(ground_truth_df)) {
    # Get the current row
    row <- ground_truth_df[row_num,]

    # Get the parameters for each row if a linkage rule id was selected
    linkage_rule_id <- row$linkage_rule_id
    if(!is.na(linkage_rule_id)){
      # Get the linkage rule fields
      parameters_df <- dbGetQuery(linkage_db, paste0('SELECT * from linkage_rules where linkage_rule_id = ', linkage_rule_id))

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
      ground_truth_df[row_num, ] <- row
    }
  }

  # Rename the "linkage_rule_id" column to "linkage_rules"
  names(ground_truth_df)[names(ground_truth_df) == 'linkage_rule_id'] <- 'linkage_rules'

  # Return the blocking keys w/ rules
  return(ground_truth_df)
}
#------------------------------------------------------------#

#-- HELPER FUNCTIONS FOR LINKAGE RULES --#
#' Get Standardized Names
#'
#' The get_standardized_names() function will take in a standardizing names file in
#' the form of the csv which must contain the columns 'START' which indicates all possible
#' forms of a common name, and a column 'LABEL' which is the most common spelling of that
#' name which it will be standardized to. If no spelling is found, the name is replaced with
#' NA
#' @param file_path A path to the .csv file that will be read
#' @param data_field A vector of names that will be standardized.
#' @param lookupvector The vector of names we'll try to unname.
#' @examples
#' file_path <- choose.file() # Select the '.csv'
#' data_field <- c("John", "Johnnie", "Johnny", "Jon")
#' get_standardized_names(file_path, data_field)
#' @export
get_standardized_names <- function(file_path, data_field, lookupvector = common_standardized_names){
  # Read in the standardization data frame
  standardization_df <- fread(file_path, select = c("START","LABEL"))

  # Get the common standardized names
  common_standardized_names <- standardization_df$LABEL

  # Determine if any of our passed names from our data_field have a common spelling
  names(common_standardized_names) <- tolower(standardization_df$START)
  standardized_names <- unname(lookupvector[tolower(data_field)])

  # Clean up and return the names
  rm(standardization_df, common_standardized_names)
  gc()
  return(standardized_names)
}
#----------------------------------------#
