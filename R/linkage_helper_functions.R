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

#' Get Iteration Linkage Technique Description
#'
#' The get_linkage_technique_description() function will take in a linkage database connection
#' containing all the metadata, along with an iteration ID for the current iteration being run.
#' A singular string is returned which is what the description of the linkage technique
#' being used during this pass.
#' @param linkage_db A database connection to the linkage metadata.
#' @param iteration_id An iteration number.
#' @examples
#' sqlite_file <- file.choose() # Select the '.sqlite' linkage metadata file
#' linkage_db <- dbConnect(SQLite(), sqlite_file)
#' iteration_id <- 1
#' get_linkage_technique_description(linkage_db, iteration_id)
#' @export
get_linkage_technique_description <- function(linkage_db, iteration_id){
  # Perform a query that joins linkage_iterations with linkage methods
  linkage_technique_desc_df <- dbGetQuery(linkage_db, paste0('SELECT implementation_desc FROM linkage_iterations li
                                          JOIN linkage_methods lm on lm.linkage_method_id = li.linkage_method_id
                                          WHERE iteration_id = ', iteration_id))

  # If somehow, there is no linkage method, return NA
  if(nrow(linkage_technique_desc_df) <= 0){
    return(NA)
  }

  # Return the label
  return(linkage_technique_desc_df$implementation_desc)
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

#' Get Iteration Implementation Name
#'
#' The get_implementation_name() function will take in a linkage database connection
#' containing all the metadata, along with an iteration ID for the current iteration being run.
#' A singular string is returned which is the user defined name of the the pass which
#' is currently being run.
#' @param linkage_db A database connection to the linkage metadata.
#' @param iteration_id An iteration number.
#' @examples
#' sqlite_file <- file.choose() # Select the '.sqlite' linkage metadata file
#' linkage_db <- dbConnect(SQLite(), sqlite_file)
#' iteration_id <- 1
#' get_iteration_name(linkage_db, iteration_id)
#' @export
get_iteration_name <- function(linkage_db, iteration_id){
  # Perform a query that joins linkage_iterations with linkage methods
  iteration_name_df <- dbGetQuery(linkage_db, paste0('SELECT iteration_name FROM linkage_iterations
                                                        WHERE iteration_id = ', iteration_id))

  # If somehow, there is no iteration name, return NA
  if(nrow(iteration_name_df) <= 0){
    return(NA)
  }

  # Return the label
  return(iteration_name_df$iteration_name)
}

#' Get Iteration Implementation Name
#'
#' The get_algorithm_name() function will take in a linkage database connection
#' containing all the metadata, along with an algorithm ID for the current algorithm being run.
#' A singular string is returned which is the user defined name of the the algorithm which
#' is currently being run.
#' @param linkage_db A database connection to the linkage metadata.
#' @param algorithm_id An algorithm number.
#' @examples
#' sqlite_file <- file.choose() # Select the '.sqlite' linkage metadata file
#' linkage_db <- dbConnect(SQLite(), sqlite_file)
#' algorithm_id <- 1
#' get_algorithm_name(linkage_db, algorithm_id)
#' @export
get_algorithm_name <- function(linkage_db, algorithm_id){
  # Perform a query that joins linkage_iterations with linkage methods
  algorithm_name_df <- dbGetQuery(linkage_db, paste0('SELECT algorithm_name FROM linkage_algorithms
                                                        WHERE algorithm_id = ', algorithm_id))

  # If somehow, there is no iteration name, return NA
  if(nrow(algorithm_name_df) <= 0){
    return(NA)
  }

  # Return the label
  return(algorithm_name_df$algorithm_name)
}

#' Get Algorithm Ground Truth Keys
#'
#' The get_ground_truth_fields() function will take in a linkage database connection containing
#' all the metadata, along with an algorithm ID.
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
  # Get the left and right dataset
  datasets_df <- dbGetQuery(linkage_db, paste0('SELECT * FROM linkage_algorithms WHERE algorithm_id = ', algorithm_id))

  # Prevent error in-case there are no datasets for this algorithm ID
  if(nrow(datasets_df) <= 0){
    return(data.frame())
  }

  # Grab the dataset IDs
  left_dataset_id  <- datasets_df$dataset_id_left
  right_dataset_id <- datasets_df$dataset_id_right

  # Get all the rows from ground_truth_variables that match to a left and right dataset id
  ground_truth_df <- dbGetQuery(linkage_db, paste0('
    SELECT
      dvf.field_name AS left_dataset_field,
      dvf2.field_name AS right_dataset_field,
      gtv.comparison_rule_id
    FROM ground_truth_variables gtv
    INNER JOIN dataset_fields dvf ON gtv.left_dataset_field_id = dvf.field_id
    INNER JOIN dataset_fields dvf2 ON gtv.right_dataset_field_id = dvf2.field_id
    WHERE gtv.dataset_id_left = ', left_dataset_id, ' AND gtv.dataset_id_right = ', right_dataset_id))

  # Prevent error in-case there are no blocking variables for this iteration
  if(nrow(ground_truth_df) <= 0){
    return(data.frame())
  }

  # For each row in the df we returned, if a linkage rule ID is not NA, then we will perform a query to
  # get a JSON object of the parameters stored in the database
  for(row_num in 1:nrow(ground_truth_df)) {
    # Get the current row
    row <- ground_truth_df[row_num,]

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
      ground_truth_df[row_num, ] <- row
    }
  }

  # Rename the "comparison_rule_id" column to "comparison_rules"
  names(ground_truth_df)[names(ground_truth_df) == 'comparison_rule_id'] <- 'comparison_rules'

  # Return the blocking keys w/ rules
  return(ground_truth_df)
}

#' Get Algorithm Output Fields
#'
#' The get_linkage_output_fields() function will take in a linkage database connection containing
#' all the metadata, along with an algorithm ID.
#' A dataframe is returned which contains the dataset fields to keep.
#' @param linkage_db A database connection to the linkage metadata.
#' @param algorithm_id An iteration number.
#' @examples
#' sqlite_file <- file.choose() # Select the '.sqlite' linkage metadata file
#' linkage_db <- dbConnect(SQLite(), sqlite_file)
#' algorithm_id <- 1
#' get_linkage_output_fields(linkage_db, algorithm_id)
#' @export
get_linkage_output_fields <- function(linkage_db, algorithm_id){
  # Get output fields
  stored_fields_with_names <- dbGetQuery(linkage_db, "
    SELECT of.dataset_label, df.field_name
    FROM output_fields of
    JOIN output_field_parameters ofp ON of.output_field_id = ofp.output_field_id
    JOIN dataset_fields df ON ofp.dataset_field_id = df.field_id
    WHERE of.algorithm_id = ? AND of.field_type != 10
    ORDER BY ofp.parameter_id", params = list(algorithm_id))

  # Return the fields
  return(stored_fields_with_names)
}

#' Get Algorithm Missingness Fields
#'
#' The get_linkage_missingness_fields() function will take in a linkage database connection containing
#' all the metadata, along with an algorithm ID.
#' A dataframe is returned which contains the dataset fields to keep for gathering missing data indicators.
#' @param linkage_db A database connection to the linkage metadata.
#' @param algorithm_id An iteration number.
#' @examples
#' sqlite_file <- file.choose() # Select the '.sqlite' linkage metadata file
#' linkage_db <- dbConnect(SQLite(), sqlite_file)
#' algorithm_id <- 1
#' get_linkage_output_fields(linkage_db, algorithm_id)
#' @export
get_linkage_missingness_fields <- function(linkage_db, algorithm_id){
  # Get output fields
  stored_fields_with_names <- dbGetQuery(linkage_db, "
    SELECT of.dataset_label, df.field_name
    FROM output_fields of
    JOIN output_field_parameters ofp ON of.output_field_id = ofp.output_field_id
    JOIN dataset_fields df ON ofp.dataset_field_id = df.field_id
    WHERE of.algorithm_id = ? AND of.field_type == 10
    ORDER BY ofp.parameter_id", params = list(algorithm_id))

  # Return the fields
  return(stored_fields_with_names)
}
#----
#------------------------------------------------------------#

#-- HELPER FUNCTIONS FOR REPORT OUTPUT --#
#' Apply Output Cutoffs
#'
#' The apply_output_cutoffs() function will take in a linkage database connection containing
#' all the metadata, along with an algorithm ID and the dataframe being used for report generation.
#' A dataframe is returned which contains the dataset fields being kept (with cutoffs)
#' @param linkage_db A database connection to the linkage metadata.
#' @param algorithm_id An iteration number.
#' @param output_df The data frame being used during report generation
#' @examples
#' sqlite_file <- file.choose() # Select the '.sqlite' linkage metadata file
#' linkage_db <- dbConnect(SQLite(), sqlite_file)
#' algorithm_id <- 1
#' apply_output_cutoffs(linkage_db, algorithm_id, output_df)
#' @export
apply_output_cutoffs <- function(linkage_db, algorithm_id, output_df) {
  # Get output fields with necessary details
  stored_fields_with_names <- dbGetQuery(linkage_db, "
    SELECT of.output_field_id, parameter_id, of.algorithm_id, of.dataset_label, of.field_type, df.field_name, standardization_lookup_id
    FROM output_fields of
    JOIN output_field_parameters ofp ON of.output_field_id = ofp.output_field_id
    JOIN dataset_fields df ON ofp.dataset_field_id = df.field_id
    WHERE of.algorithm_id = ? and of.field_type != 10
    ORDER BY ofp.output_field_id ASC, ofp.parameter_id ASC", params = list(algorithm_id))


  # Loop through each of the output field ids, apply cutoffs and labels
  cols_to_drop <- c()
  for(output_field_id in unique(stored_fields_with_names$output_field_id)){
    # Get the field information
    field_info <- stored_fields_with_names[stored_fields_with_names$output_field_id == output_field_id, ]

    # Get the unique field type and label for this field_id
    field_type  <- unique(field_info$field_type)
    field_label <- unique(field_info$dataset_label)

    # GENERIC/PASS THROUGH FIELD
    if(field_type == 1){
      # Get the field name
      old_field_name <- field_info$field_name
      new_field_name <- paste0(old_field_name, "_untouched_categ")

      # Get the column, and apply the column label
      output_df[[new_field_name]] <- output_df[[old_field_name]]
      label(output_df[[new_field_name]]) <- field_label

      # Add this column as one we will be keeping
      cols_to_drop <- append(cols_to_drop, old_field_name)
    }
    # CATEGORIZED YEAR
    else if(field_type == 2){
      # Get the field name (appending an identifiable suffix to the column)
      old_field_name <- field_info$field_name
      new_field_name <- paste0(old_field_name, "_categ")

      # Apply Ranges for date cutoffs
      output_df[[new_field_name]] <- cut(output_df[[old_field_name]],
                                         breaks = c(-Inf, 1945, 1955, 1965, 1975, 1985, 1995, 2005, 2015, 2025, 2035, Inf),
                                         labels = c("<1945", "1945-1954", "1955-1964", "1965-1974", "1975-1984", "1985-1994",
                                                    "1995-2004", "2005-2014", "2015-2024", "2025-2034", "2035-2044"),
                                         right = FALSE)

      # Apply the column label
      label(output_df[[new_field_name]]) <- field_label

      # Add this column as one we will be removing
      cols_to_drop <- append(cols_to_drop, old_field_name)
    }
    # AGE (SEPARATE AGE FIELD)
    else if(field_type == 3){
      # Get the field name (appending an identifiable suffix to the column)
      old_field_name <- field_info$field_name
      new_field_name <- paste0(old_field_name, "_age_categ")

      # Apply Ranges for age cutoffs
      output_df[[new_field_name]] <- cut(output_df[[old_field_name]],
                                         breaks = c(-Inf, 18, 35, 65, 81, Inf),
                                         labels = c("<18", "18-34", "35-64", "65-80", "81+"),
                                         right = FALSE)

      # Apply the column label
      label(output_df[[new_field_name]]) <- field_label

      # Add this column as one we will be removing
      cols_to_drop <- append(cols_to_drop, old_field_name)
    }
    # SUBSTRING INITIAL (TAKE FIRST CHARACTER)
    else if(field_type == 4){
      # Get the field name (appending an identifiable suffix to the column)
      old_field_name <- field_info$field_name
      new_field_name <- paste0(old_field_name, "_initial_categ")

      # Apply the substring function to the field
      output_df[[new_field_name]] <- substr(trimws(output_df[[old_field_name]]), 1, 1)

      # Apply the column label
      label(output_df[[new_field_name]]) <- field_label

      # Add this column as one we will be removing
      cols_to_drop <- append(cols_to_drop, old_field_name)
    }
    # WORD LENGTH
    else if(field_type == 5){
      # Get the field name (appending an identifiable suffix to the column)
      old_field_name <- field_info$field_name
      new_field_name <- paste0(old_field_name, "_len_categ")

      # Apply cutoffs for the name length
      output_df[[new_field_name]] <- cut(nchar(output_df[[old_field_name]]),
                                         breaks = c(-Inf, 5, 6, 7, 8, Inf),
                                         labels = c("<5", "5", "6", "7", "8+"),
                                         right = FALSE)

      # Apply the column label
      label(output_df[[new_field_name]]) <- field_label

      # Add this column as one we will be removing
      cols_to_drop <- append(cols_to_drop, old_field_name)
    }
    # WORD COUNT
    else if(field_type == 6){
      # Get the field name (appending an identifiable suffix to the column)
      old_field_name <- field_info$field_name
      new_field_name <- paste0(old_field_name, "_num_categ")

      # Apply cutoffs for the count of names
      name_count <- lengths(strsplit(trimws(output_df[[old_field_name]]), " "))
      output_df[[new_field_name]] <- cut(name_count,
                                         breaks = c(-Inf, 2, 3, Inf),
                                         labels = c("1", "2", "3+"),
                                         right = FALSE)

      # Apply the column label
      label(output_df[[new_field_name]]) <- field_label

      # Add this column as one we will be removing
      cols_to_drop <- append(cols_to_drop, old_field_name)
    }
    # DERIVED AGE (FROM BIRTH DATE AND CAPTURE DATE)
    else if (field_type == 7){
      # Get the field name (appending an identifiable suffix to the column)
      old_field_name_bdate <- field_info$field_name[1]
      old_field_name_cdate <- field_info$field_name[2]
      new_field_name <- paste0(old_field_name_bdate, "_derived_age_categ")

      # Calculate the age by taking the difference of [1: CAPTURE DATE] & [2: DATE OF BIRTH] and then apply cutoffs
      age <- as.numeric(floor(difftime(as.Date(output_df[[old_field_name_cdate]]), as.Date(output_df[[old_field_name_bdate]]), unit="weeks") / 52.25))
      output_df[[new_field_name]] <- cut(age,
                                         breaks = c(-Inf, 18, 35, 65, 81, Inf),
                                         labels = c("<18", "18-34", "35-64", "65-80", "81+"),
                                         right = FALSE)

      # Apply the column label
      label(output_df[[new_field_name]]) <- field_label

      # Add both columns as ones we will be removing
      cols_to_drop <- append(cols_to_drop, c(old_field_name_bdate, old_field_name_cdate))
    }
    # STANDARDIZATION/LOOKUP FILE
    else if (field_type == 8){
      # Get the field name (appending an identifiable suffix to the column)
      old_field_name <- field_info$field_name
      new_field_name <- paste0(old_field_name, "_standardized_categ")
      standardize_id <- field_info$standardization_lookup_id

      # Query to get the file name
      file_name <- dbGetQuery(linkage_db, 'SELECT * FROM name_standardization_files WHERE standardization_file_id = ?',
                              params = list(standardize_id))$standardization_file_name

      # Get the file name and see if its available to be loaded
      file_path <- file.path(system.file(package = "autolink", "data"), file_name)

      # Read in the standardization data frame
      standardization_df_input <- data.frame()
      if(!is.null(file_path) && !is.na(file_path) && file.exists(file_path)){
        standardization_df_input <- readRDS(file_path)
      }
      else{
        next
      }

      # Create a function for standardizing the field
      standardize_field <- function(standardization_df, output_df, old_field_name){
        # Get the possible values that the field could be
        common_standardized_values <- standardization_df$common

        # Determine which values they map to
        names(common_standardized_values) <- tolower(standardization_df$unique)
        standardized_values <- standardization_df$common[match(unlist(output_df[[old_field_name]]), standardization_df$unique)]

        # Return the values
        return(standardized_values)
      }

      # Use the function to standardize the names
      standardized_field_values <- ifelse(!is.na(standardize_field(standardization_df_input, output_df, old_field_name)),
                                            standardize_field(standardization_df_input, output_df, old_field_name), "Other")
      output_df[[new_field_name]] <- standardized_field_values

      # Apply the column label
      label(output_df[[new_field_name]]) <- field_label

      # Add this column as one we will be removing
      cols_to_drop <- append(cols_to_drop, old_field_name)
    }
    # CANADIAN FORWARD SORTATION AREA (GEOGRAPHIC AREA STANDARDIZATION)
    else if(field_type == 9){
      # Get the field name (appending an identifiable suffix to the column)
      old_field_name <- field_info$field_name
      new_field_name <- paste0(old_field_name, "_standardized_categ")

      # Apply the substring function to the postal code field
      output_df[[new_field_name]] <- substr(trimws(output_df[[old_field_name]]), 1, 1)

      # Create a function for standardizing the field
      standardize_field <- function(output_df, field_name){
        # Create the standardization data frame of values and their areas
        standardization_df <- data.frame(
          unique = c("A", "B", "C", "E",
                     "G", "H", "J", "K",
                     "L", "M", "N", "P",
                     "R", "S", "T", "V",
                     "X", "Y", ""),
          common = c("Newfoundland and Labrador", "Nova Scotia", "Prince Edward Island", "New Brunswick",
                     "Eastern Quebec", "Metropolitan Montreal", "Western Quebec", "Eastern Ontario",
                     "Central Ontario", "Metropolitan Toronto", "Southwestern Ontario", "Northern Ontario",
                     "Manitoba", "Saskatchewan", "Alberta", "British Columbia",
                     "Northwest Territories/Nunavut", "Yukon", "Missing")
        )

        # Get the possible values that the field could be
        common_standardized_values <- standardization_df$common

        # Determine which values they map to
        names(common_standardized_values) <- tolower(standardization_df$unique)
        standardized_values <- standardization_df$common[match(unlist(output_df[[field_name]]), standardization_df$unique)]

        # Return the values
        return(standardized_values)
      }

      # Use the function to standardize the names
      standardized_field_values <- ifelse(!is.na(standardize_field(output_df, new_field_name)),
                                          standardize_field(output_df, new_field_name), "Other")
      output_df[[new_field_name]] <- standardized_field_values

      # Apply the column label
      label(output_df[[new_field_name]]) <- field_label

      # Add this column as one we will be removing
      cols_to_drop <- append(cols_to_drop, old_field_name)
    }
  }

  # After we finish looping through each output field id, drop the unnecessary columns
  output_df <- select(output_df, -unique(cols_to_drop))

  # Return the output dataframe
  return(output_df)
}
#----------------------------------------#

#-- HELPER FUNCTIONS FOR LINKAGE RULES --#
#' Get Standardized Names
#'
#' The get_standardized_names() function will take in an integer iteration ID
#' which will grab the .rds dataset file from the autolink packages 'data' folder, the
#' data should contain two columns, one of variant spellings of a name called 'unique',
#' and a column 'common' which is the most common spelling of that name which it will be
#' standardized to. If no spelling is found, the name is replaced with NA
#' @param linkage_db A connection to a linkage metadata file
#' @param iteration_id An integer ID for the current iteration.
#' @param data_field A vector of names that will be standardized.
#' @param lookupvector The vector of names we'll try to unname.
#' @examples
#' my_db <- dbConnect(SQLite(), file.choose())
#' iteration_id <- 1
#' data_field <- c("John", "Johnnie", "Johnny", "Jon")
#' get_standardized_names(my_db, 1, data_field)
#' @export
get_standardized_names <- function(linkage_db, iteration_id, data_field, lookupvector = common_standardized_names){
  # Check to see if the iteration is using a custom file, if so, try to get it
  file_name <- dbGetQuery(linkage_db, "SELECT standardization_file_name FROM linkage_iterations li
                                       JOIN name_standardization_files sf ON li.standardization_file_id = sf.standardization_file_id
                                       WHERE iteration_id = ?",
                          params = list(iteration_id))

  # Get the file_path
  file_path <- file.path(system.file(package = "autolink", "data"), file_name)

  # Read in the standardization data frame
  standardization_df <- data.frame()
  if(!is.null(file_path) && !is.na(file_path) && file.exists(file_path)){
    standardization_df <- readRDS(file_path)
  }
  else{
    # Load the internal dataset without affecting the global environment
    data("autolink_standardized_names", package = "autolink", envir = environment())
    standardization_df <- autolink_standardized_names
  }

  # Get the common standardized names
  common_standardized_names <- standardization_df$common

  # Determine if any of our passed names from our data_field have a common spelling
  names(common_standardized_names) <- tolower(standardization_df$unique)
  standardized_names <- unname(lookupvector[tolower(data_field)])

  # Clean up and return the names
  rm(standardization_df, common_standardized_names)
  gc()
  return(standardized_names)
}
#----------------------------------------#

#-- HELPER FUNCTIONS FOR READING IN DATASET FILES --#
#' Load Linkage File
#'
#' The load_linkage_file() function will take in a dataset file of a specific type, which may
#' be csv, txt, sqlite, sas7bdat, xlsx, and will attempt to load and return it.
#' @param dataset_file A path to the input file
#' @examples
#' file_path <- choose.file() # Select an input file
#' load_linkage_file(file_path)
#' @export
load_linkage_file <- function(dataset_file){
  # Extract the file extension
  file_extension <- tolower(tools::file_ext(dataset_file))

  # CSV Reading
  if(file_extension == "csv"){
    df <- fread(input = dataset_file)
    return(df)
  }
  # TXT Reading
  if(file_extension == "txt"){
    df <- fread(input = dataset_file)
    return(df)
  }
  # SAS7BDAT Reading
  if(file_extension == "sas7bdat"){
    df <- read_sas(data_file = dataset_file)
    return(df)
  }
  # EXCEL Reading
  if(file_extension == "xlsx"){
    df <- read.xlsx(xlsxFile = dataset_file, sheet = 1)
    return(df)
  }
  # DATASTAN Reading
  if(file_extension == "sqlite"){
    db_conn <- dbConnect(RSQLite::SQLite(), dataset_file)
    df <- dbGetQuery(conn = db_conn, statement = "SELECT * FROM clean_data_table")
    return(df)
  }
}
#---------------------------------------------------#

#-- HELPER FUNCTIONS FOR ESTABLISHING EXTRA PARAMETERS --#
#' Create Extra Parameters List
#'
#' The create_extra_parameters_list() function will allow users to modify any of the default
#' parameter values to allow for more specific linkage options.
#' @param linkage_output_folder A directory for which linkage output files will be written to.
#' @param include_unlinked_records A TRUE of FALSE value for whether you'd like the unlinked record pairs to appear in the output linked data.
#' @param output_linkage_iterations A TRUE or FALSE value for whether you'd like each iteration to write the linked pairs (UNEDITED) to the output directory.
#' @param output_unlinked_iteration_pairs A TRUE or FALSE value for whether you'd like each iteration to write the unlinked pairs (UNEDITED) to the output directory
#' @param linkage_report_type 1 = No Report, 2 = Intermediate Report, 3 = Final Report.
#' @param calculate_performance_measures A TRUE or FALSE value for whether you'd like to calculate and export performance measures from the algorithms being run.
#' @param data_linker A single string input for whom performed the data linkage (used for generating a Linkage Quality Report).
#' @param generate_algorithm_summary A TRUE or FALSE value for whether you'd like to export a CSV summary of the algorithm that was run.
#' @param generate_threshold_plots A TRUE or FALSE value for whether you'd like to export threshold plots for each pass.
#' @param log_scaled_plots A TRUE or FALSE value for whether you'd like the exported threshold plots to use log scaling instead of linear by default.
#' @param save_all_linkage_results A TRUE or FALSE value for whether you'd like a list of all report data returned after all algorithms have been ran.
#' @param collect_missing_data_indicators A TRUE or FALSE value for whether you'd like to have missing data indicators appear of the variables you're keeping as output.
#' @param save_audit_performance A TRUE or FALSE value for whether you'd like to save the performance of each algorithm being ran for later auditing purposes.
#' @param main_report_algorithm A numeric value which specified the algorithm ID of the only report that should be generated. (If the user would like performance values appear in report appendix)
#' @param report_threshold A numeric value which specifies the minimum of a value in the report can be before being considered a small count. If lower than the threshold, the violating field is removed.
#' @param extra_summary_parameters A TRUE or FALSE value for whether you'd like extra algorithm summary parameters (FDR & FOR) to appear in the table.
#' @param definitions A data frame, a file path to an rds file that contains a data frame or a file path to a csv file. Data must contain two columns: the list of terms in the first and their definitions in the second. Will appear in report (if generated).
#' @param abbreviations A data frame, a file path to an rds file that contains a data frame or a file path to a csv file. Data must contain two columns: the list of abbreviations in the first and their meaning in the second. Will appear in report (if generated).
#' @examples
#' extra_params <- create_extra_parameters_list(output_linkage_iterations = TRUE, linkage_report_type = 3, data_linker = "John Doe")
#' @export
create_extra_parameters_list <- function(linkage_output_folder = NULL,
                                         include_unlinked_records = FALSE,
                                         output_linkage_iterations = FALSE,
                                         output_unlinked_iteration_pairs = FALSE,
                                         linkage_report_type = NULL,
                                         calculate_performance_measures = FALSE,
                                         data_linker = NULL,
                                         generate_algorithm_summary = FALSE,
                                         generate_threshold_plots = FALSE,
                                         log_scaled_plots = FALSE,
                                         save_all_linkage_results = FALSE,
                                         collect_missing_data_indicators = FALSE,
                                         save_audit_performance = FALSE,
                                         main_report_algorithm = NULL,
                                         report_threshold = NULL,
                                         extra_summary_parameters = FALSE,
                                         definitions = NULL,
                                         abbreviations = NULL){

  ### Create a List to Store the Extra Parameters
  extra_params_list <- list()

  # Linkage Output
  #----------------------------------------------------------------------------#
  ### Linkage Output Folder
  if(!is.null(linkage_output_folder)){
    # Make sure the input is valid
    if(!is.na(linkage_output_folder) && dir.exists(linkage_output_folder)){
      extra_params_list[["linkage_output_folder"]] <- linkage_output_folder
    }
  }

  ### Include Unlinked Records in Output
  if(!isFALSE(include_unlinked_records) && !is.na(include_unlinked_records) && !is.null(include_unlinked_records) &&
     (isTRUE(include_unlinked_records) || include_unlinked_records == "TRUE")){
    extra_params_list[["include_unlinked_records"]] <- TRUE
  }

  ### Output/Extract Linked Iterations
  if(!isFALSE(output_linkage_iterations) && !is.na(output_linkage_iterations) && !is.null(output_linkage_iterations) &&
     (isTRUE(output_linkage_iterations) || output_linkage_iterations == "TRUE")){
    extra_params_list[["output_linkage_iterations"]] <- TRUE
  }

  ### Output/Extract Unlinked Iterations
  if(!isFALSE(output_unlinked_iteration_pairs) && !is.na(output_unlinked_iteration_pairs) && !is.null(output_unlinked_iteration_pairs) &&
     (isTRUE(output_unlinked_iteration_pairs) || output_unlinked_iteration_pairs == "TRUE")){
    extra_params_list[["output_unlinked_iteration_pairs"]] <- TRUE
  }

  ### Generate Linkage Quality Report
  if(!is.na(linkage_report_type) && !is.null(linkage_report_type) &&
     (is.numeric(linkage_report_type) && length(linkage_report_type) == 1 && linkage_report_type >= 1 && linkage_report_type <= 3)){
    extra_params_list[["linkage_report_type"]] <- linkage_report_type
  }

  ### Calculate performance measures
  if(!isFALSE(calculate_performance_measures) && !is.na(calculate_performance_measures) && !is.null(calculate_performance_measures) &&
     (isTRUE(calculate_performance_measures) || calculate_performance_measures == "TRUE")){
    extra_params_list[["calculate_performance_measures"]] <- TRUE
  }

  ### Data Linker Name
  if(!is.null(data_linker)){
    # Make sure the input is valid
    if(is.character(data_linker) && is.character(data_linker) && length(data_linker) == 1 && nchar(data_linker) > 0){
      extra_params_list[["data_linker"]] <- data_linker
    }
    else{
      extra_params_list[["data_linker"]] <- "Missing Name"
    }
  }
  else{
    extra_params_list[["data_linker"]] <- "Missing Name"
  }

  ### Output Algorithm Summary
  if(!isFALSE(generate_algorithm_summary) && !is.na(generate_algorithm_summary) && !is.null(generate_algorithm_summary) &&
     (isTRUE(generate_algorithm_summary) || generate_algorithm_summary == "TRUE")){
    extra_params_list[["generate_algorithm_summary"]] <- TRUE
  }

  ### Generate threshold plots
  if(!isFALSE(generate_threshold_plots) && !is.na(generate_threshold_plots) && !is.null(generate_threshold_plots) &&
     (isTRUE(generate_threshold_plots) || generate_threshold_plots == "TRUE")){
    extra_params_list[["generate_threshold_plots"]] <- TRUE
  }

  ### Log scaled plots
  if(!isFALSE(log_scaled_plots) && !is.na(log_scaled_plots) && !is.null(log_scaled_plots) &&
     (isTRUE(log_scaled_plots) || log_scaled_plots == "TRUE")){
    extra_params_list[["log_scaled_plots"]] <- TRUE
  }

  ### Save All Linkage Results
  if(!isFALSE(save_all_linkage_results) && !is.na(save_all_linkage_results) && !is.null(save_all_linkage_results) &&
     (isTRUE(save_all_linkage_results) || save_all_linkage_results == "TRUE")){
    extra_params_list[["save_all_linkage_results"]] <- TRUE
  }

  ### Save Missing Data Indicators
  if(!isFALSE(collect_missing_data_indicators) && !is.na(collect_missing_data_indicators) && !is.null(collect_missing_data_indicators) &&
     (isTRUE(collect_missing_data_indicators) || collect_missing_data_indicators == "TRUE")){
    extra_params_list[["collect_missing_data_indicators"]] <- TRUE
  }

  ### Save Auditing Performance Measures
  if(!isFALSE(save_audit_performance) && !is.na(save_audit_performance) && !is.null(save_audit_performance) &&
     (isTRUE(save_audit_performance) || save_audit_performance == "TRUE")){
    extra_params_list[["save_audit_performance"]] <- TRUE
  }

  ### Extra Summary Parameters
  if(!isFALSE(extra_summary_parameters) && !is.na(extra_summary_parameters) && !is.null(extra_summary_parameters) &&
     (isTRUE(extra_summary_parameters) || extra_summary_parameters == "TRUE")){
    extra_params_list[["extra_summary_parameters"]] <- TRUE
  }

  #-- Main Report Algorithm Options --#
  ### Generate Linkage Quality Report
  if(!is.na(main_report_algorithm) && !is.null(main_report_algorithm) &&
     (is.numeric(main_report_algorithm) && length(main_report_algorithm) == 1 && main_report_algorithm >= 1)){
    extra_params_list[["main_report_algorithm"]] <- main_report_algorithm
  }

  ### Report Threshold
  if(!is.na(report_threshold) && !is.null(report_threshold) &&
     (is.numeric(report_threshold) && length(report_threshold) == 1 && report_threshold >= 1)){
    extra_params_list[["report_threshold"]] <- report_threshold
  }

  ### Definitions
  if(!is.na(definitions) && !is.null(definitions) && length(definitions) == 1){
    extra_params_list[["definitions"]] <- definitions
  }

  ### Abbreviations
  if(!is.na(abbreviations) && !is.null(abbreviations) && length(abbreviations) == 1){
    extra_params_list[["abbreviations"]] <- abbreviations
  }

  #----------------------------------------------------------------------------#

  ### Finally, return the list
  return(extra_params_list)
}
#--------------------------------------------------------#
