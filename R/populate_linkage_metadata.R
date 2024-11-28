#' Create New Metadata
#'
#' The create_new_metadata() function will run all the insert and create queries to build
#' the tables and provide some initial metadata values. The function takes two parameters,
#' one for the file name that the user will want it to be called, and one for where the
#' file will be output.
#' @param file_name The file name for what the new .sqlite metadata file will be called.
#' @param output_folder A path to the output folder, where the new metadata file will be output.
#' @param datastan_file A path to an existing `datastan` SQLite file which is an optional parameter which will import the existing datasets to avoid needing to recreate them.
#' @examples
#' create_new_metadata("my_new_metadata", "path/to/folder")
#' @export
create_new_metadata <- function(file_name, output_folder, datastan_file = NULL){
  # Error handling to ensure the file name and output folder is all valid
  #----
  if(is.null(file_name) || is.null(output_folder) || is.na(file_name) || is.na(output_folder)){
    stop("ERROR: Invalid file name or output folder.")
  }
  #----

  # Create the metadata connection
  my_db <- dbConnect(RSQLite::SQLite(), paste0(output_folder, "/", file_name, ".sqlite"))
  dbExecute(my_db, "PRAGMA foreign_keys = ON;")


  # Run the CREATE TABLE queries so that the metadata file has all that it needs
  # for the metadata UI and data linkage.
  #----

  ### DATASETS
  dbExecute(my_db, "
    CREATE TABLE datasets (
      dataset_id INTEGER PRIMARY KEY,
      dataset_code VARCHAR(255),
      dataset_name VARCHAR(255),
      dataset_location TEXT,
      version VARCHAR(255),
      is_fwf INTEGER,
      enabled_for_linkage INTEGER
    );
  ")

  dbExecute(my_db, "
    CREATE TABLE dataset_fields (
      dataset_id INTEGER REFERENCES datasets(dataset_id),
      field_id INTEGER PRIMARY KEY,
      field_name VARCHAR(255),
      field_type VARCHAR(255),
      field_width INTEGER
    );
  ")

  ### NAME STANDARDIZATION FILES/DATASETS
  dbExecute(my_db, "
    CREATE TABLE name_standardization_files (
      standardization_file_id INTEGER PRIMARY KEY,
      standardization_file_label VARCHAR(255),
      standardization_file_name VARCHAR(255)
    );
  ")
  # If Barret and Jess don't like this idea, just replace the file name with the actual file path and grab it from there instead

  ### ACCEPTANCE METHODS
  dbExecute(my_db, "
    CREATE TABLE acceptance_methods (
      acceptance_method_id INTEGER PRIMARY KEY,
      method_name VARCHAR(255),
      description VARCHAR(255)
    );
  ")

  dbExecute(my_db, "
    CREATE TABLE acceptance_method_parameters (
      acceptance_method_id INTEGER REFERENCES acceptance_methods(acceptance_method_id),
      parameter_id INTEGER PRIMARY KEY,
      parameter_key VARCHAR(255),
      description VARCHAR(255)
    );
  ")

  #-- V2 --#
  # dbExecute(my_db, "
  #   CREATE TABLE acceptance_rules (
  #     acceptance_rule_id INTEGER,
  #     acceptance_method_id INTEGER REFERENCES acceptance_methods(acceptance_method_id),
  #     parameters TEXT
  #   );
  # ")
  #--------#

  #-- V1 --#
  dbExecute(my_db, "
    CREATE TABLE acceptance_rules (
      acceptance_rule_id INTEGER PRIMARY KEY,
      acceptance_method_id INTEGER
    );
  ")

  dbExecute(my_db, "
    CREATE TABLE acceptance_rules_parameters (
      acceptance_rule_id INTEGER REFERENCES acceptance_rules(acceptance_rule_id),
      parameter_id INTEGER REFERENCES acceptance_method_parameters(parameter_id),
      parameter REAL,
      PRIMARY KEY (acceptance_rule_id, parameter_id)
    );
  ")
  #--------#

  ### LINKAGE RULES
  dbExecute(my_db, "
    CREATE TABLE linkage_rules (
      linkage_rule_id INTEGER PRIMARY KEY,
      alternate_field_value_left INTEGER,
      integer_value_variance INTEGER,
      substring_length INTEGER,
      standardize_names INTEGER,
      alternate_field_value_right INTEGER
    );
  ")

  ### STRING COMPARISON METHODS
  dbExecute(my_db, "
    CREATE TABLE comparison_methods (
      comparison_method_id INTEGER PRIMARY KEY,
      method_name VARCHAR(255),
      description VARCHAR(255)
    );
  ")

  dbExecute(my_db, "
    CREATE TABLE comparison_method_parameters (
      comparison_method_id INTEGER REFERENCES comparison_methods(comparison_method_id),
      parameter_id INTEGER PRIMARY KEY,
      parameter_key VARCHAR(255),
      description VARCHAR(255)
    );
  ")

  #-- V2 --#
  # dbExecute(my_db, "
  #   CREATE TABLE comparison_rules (
  #     comparison_rule_id INTEGER PRIMARY KEY,
  #     comparison_method_id INTEGER REFERENCES comparison_methods(comparison_method_id),
  #     parameters TEXT  -- Store as JSON string
  #   );
  # ")
  #--------#


  #-- V1 --#
  dbExecute(my_db, "
    CREATE TABLE comparison_rules (
      comparison_rule_id INTEGER PRIMARY KEY,
      comparison_method_id INTEGER
    );
  ")

  dbExecute(my_db, "
    CREATE TABLE comparison_rules_parameters (
      comparison_rule_id INTEGER REFERENCES comparison_rules(comparison_rule_id),
      parameter_id INTEGER,
      parameter REAL,
      PRIMARY KEY (comparison_rule_id, parameter_id)
    );
  ")
  #--------#

  ### LINKAGE METHODS, ALGORITHMS, ALGORITHM PASS THROUGH VARIABLES, AND ITERATIONS
  dbExecute(my_db, "
    CREATE TABLE linkage_methods (
      linkage_method_id INTEGER PRIMARY KEY,
      technique_label VARCHAR(255),
      implementation_name VARCHAR(255),
      implementation_desc VARCHAR(255),
      version VARCHAR(255)
    );
  ")

  dbExecute(my_db, "
    CREATE TABLE linkage_algorithms (
      algorithm_id INTEGER PRIMARY KEY,
      dataset_id_left INTEGER REFERENCES datasets(dataset_id),
      dataset_id_right INTEGER REFERENCES datasets(dataset_id),
      algorithm_name VARCHAR(255),
      modified_date TEXT,
      modified_by VARCHAR(255),
      enabled INTEGER,
      enabled_for_testing INTEGER,
      published INTEGER,
      archived INTEGER
    );
  ")

  ### V1
  # dbExecute(my_db, "
  #   CREATE TABLE linkage_algorithms_output_fields (
  #     algorithm_id INTEGER REFERENCES linkage_algorithms(algorithm_id),
  #     parameter_id INTEGER PRIMARY KEY,
  #     dataset_field_id REFERENCES dataset_fields(field_id),
  #     dataset_label VARCHAR(255),
  #     field_type INTEGER
  #   );
  # ")

  ### V2
  dbExecute(my_db, "
    CREATE TABLE output_fields (
      algorithm_id INTEGER REFERENCES linkage_algorithms(algorithm_id),
      output_field_id INTEGER PRIMARY KEY,
      dataset_label VARCHAR(255),
      field_type INTEGER,
      standardization_lookup_id REFERENCES name_standardization_files(standardization_file_id)
    );
  ")

  dbExecute(my_db, "
    CREATE TABLE output_field_parameters (
      output_field_id INTEGER REFERENCES output_fields(output_field_id),
      parameter_id INTEGER,
      dataset_field_id REFERENCES dataset_fields(field_id),
      PRIMARY KEY (output_field_id, parameter_id)
    );
  ")

  dbExecute(my_db, "
    CREATE TABLE linkage_iterations (
      algorithm_id INTEGER REFERENCES linkage_algorithms(algorithm_id),
      iteration_id INTEGER PRIMARY KEY,
      iteration_name VARCHAR(255),
      iteration_num INTEGER,
      linkage_method_id INTEGER REFERENCES linkage_methods(linkage_method_id),
      acceptance_rule_id INTEGER REFERENCES acceptance_rules(acceptance_rule_id),
      standardization_file_id INTEGER REFERENCES name_standardization_files(standardization_file_id),
      modified_date TEXT,
      modified_by VARCHAR (255),
      enabled INTEGER
    );
  ")

  ### AUDITING
  #-- V1 --#
  # dbExecute(my_db, "
  #   CREATE TABLE performance_measures_audit (
  #     audit_id INTEGER PRIMARY KEY,
  #     left_dataset_id INTEGER REFERENCES datasets(dataset_id),
  #     right_dataset_id INTEGER REFERENCES datasets(dataset_id),
  #     audit_date TEXT,
  #     performance_measures_json TEXT
  #   );
  # ")
  #--------#

  # V2
  dbExecute(my_db, "
    CREATE TABLE performance_measures_audit (
      audit_id INTEGER PRIMARY KEY,
      algorithm_id INTEGER REFERENCES linkage_algorithms(algorithm_id),
      audit_by VARCHAR(255),
      audit_date TEXT,
      audit_time TEXT,
      performance_measures_json TEXT
    );
  ")

  ### GROUND TRUTH VARIABLES
  #-- V1 --#
  # dbExecute(my_db, "
  #   CREATE TABLE ground_truth_variables (
  #     algorithm_id INTEGER REFERENCES linkage_algorithms(algorithm_id),
  #     parameter_id INTEGER PRIMARY KEY,
  #     left_dataset_field_id REFERENCES dataset_fields(field_id),
  #     right_dataset_field_id REFERENCES dataset_fields(field_id),
  #     linkage_rule_id INTEGER REFERENCES linkage_rules(linkage_rule_id)
  #   );
  # ")
  #-- V2 --#
  dbExecute(my_db, "
    CREATE TABLE ground_truth_variables (
      dataset_id_left INTEGER REFERENCES datasets(dataset_id),
      dataset_id_right INTEGER REFERENCES datasets(dataset_id),
      parameter_id INTEGER PRIMARY KEY,
      left_dataset_field_id REFERENCES dataset_fields(field_id),
      right_dataset_field_id REFERENCES dataset_fields(field_id),
      comparison_rule_id INTEGER REFERENCES comparison_rules(comparison_rule_id)
    );
  ")


  ### BLOCKING AND MATCHING VARIABLES
  dbExecute(my_db, "
    CREATE TABLE blocking_variables (
      iteration_id INTEGER REFERENCES linkage_iterations(iteration_id),
      right_dataset_field_id REFERENCES dataset_fields(field_id),
      left_dataset_field_id REFERENCES dataset_fields(field_id),
      linkage_rule_id INTEGER REFERENCES linkage_rules(linkage_rule_id),
      PRIMARY KEY (iteration_id, right_dataset_field_id, left_dataset_field_id, linkage_rule_id)
    );
  ")

  dbExecute(my_db, "
    CREATE TABLE matching_variables (
      iteration_id INTEGER REFERENCES linkage_iterations(iteration_id),
      right_dataset_field_id REFERENCES dataset_fields(field_id),
      left_dataset_field_id REFERENCES dataset_fields(field_id),
      linkage_rule_id INTEGER REFERENCES linkage_rules(linkage_rule_id),
      comparison_rule_id INTEGER REFERENCES comparison_rules(comparison_rule_id),
      PRIMARY KEY (iteration_id, right_dataset_field_id, left_dataset_field_id, linkage_rule_id, comparison_rule_id)
    );
  ")
  #----

  # Run insert queries to pre-populate the metadata with some starting linkage, acceptance, and
  # string comparison rules so that linkage may begin a bit quicker.
  #----

  ### LINKAGE METHODS INSERT STATEMENTS
  #~~~~
  linkage_methods_insert <- function(){
    new_entry_query <- paste('INSERT INTO linkage_methods (linkage_method_id, technique_label, implementation_name, implementation_desc, version)',
                             'VALUES(1, "D", "Reclin2Linkage", "Deterministic linkage pass using the Reclin2 package.", "v1");')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO linkage_methods (linkage_method_id, technique_label, implementation_name, implementation_desc, version)',
                             'VALUES(2, "P", "Reclin2Linkage", "Probabilistic linkage pass using the Reclin2 package.", "v1");')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO linkage_methods (linkage_method_id, technique_label, implementation_name, implementation_desc, version)',
                             'VALUES(3, "M", "Reclin2Linkage", "Machine learning linkage pass using the Reclin2 package.", "v1");')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)
  }
  linkage_methods_insert()
  #~~~~

  ### ACCEPTANCE METHOD INSERT STATEMENTS
  #~~~~
  acceptance_methods_insert <- function(){
    new_entry_query <- paste('INSERT INTO acceptance_methods (acceptance_method_id, method_name, description)',
                            'VALUES(1, "Posterior Threshold", "A minimum threshold between 0 and 1 for which a record pair must exceed to be considered a successful link.");')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_methods (acceptance_method_id, method_name, description)',
                             'VALUES(2, "Weighted Range", "A lower (X) and upper (Y) weight where anything less than (X) is considered unlinked, anything greater than (Y) is considered linked, anything between (X) and (Y) requires manual review.");')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_methods (acceptance_method_id, method_name, description)',
                             'VALUES(3, "Match Weight", "An unbounded match weight between positive and negative infinity for which a record pair must exceed to be considered a successful link.");')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_methods (acceptance_method_id, method_name, description)',
                             'VALUES(4, "Machine Learning Probability", "A probabilistic value between 0 and 1 for which the machine learning model will consider a pair a match.");')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)
  }
  acceptance_methods_insert()
  #~~~~

  ### ACCEPTANCE METHOD PARAMETERS INSERT STATEMENTS
  #~~~~
  acceptance_methods_parameters_insert <- function(){
    new_entry_query <- paste('INSERT INTO acceptance_method_parameters (acceptance_method_id, parameter_id, parameter_key, description)',
                             'VALUES(1, 1, "posterior_threshold", "The minimum value for which a record pair will be considered successful link.");')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_method_parameters (acceptance_method_id, parameter_id, parameter_key, description)',
                             'VALUES(2, 2, "lower_weight", "The lower bound weight for determining if a record pair should be rejected, or manually reviewed.");')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_method_parameters (acceptance_method_id, parameter_id, parameter_key, description)',
                             'VALUES(2, 3, "upper_weight", "The upper bound weight for determining if a record pair should be linked, or manually reviewed.");')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_method_parameters (acceptance_method_id, parameter_id, parameter_key, description)',
                             'VALUES(3, 4, "match_weight", "The unbounded weight for determining if a record pair is a successful link.");')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_method_parameters (acceptance_method_id, parameter_id, parameter_key, description)',
                             'VALUES(4, 5, "ml_probability", "The model probability for determining if a record pair is a successful link.");')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)
  }
  acceptance_methods_parameters_insert()
  #~~~~

  ### ACCEPTANCE RULES INSERT STATEMENTS
  #~~~~
  acceptance_rules_insert_v1 <- function(){
    new_entry_query <- paste('INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id)',
                             'VALUES(1, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id)',
                             'VALUES(2, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id)',
                             'VALUES(3, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id)',
                             'VALUES(4, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id)',
                             'VALUES(5, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id)',
                             'VALUES(6, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id)',
                             'VALUES(7, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id)',
                             'VALUES(8, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id)',
                             'VALUES(9, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id)',
                             'VALUES(10, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id)',
                             'VALUES(11, 2);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id)',
                             'VALUES(12, 2);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id)',
                             'VALUES(13, 2);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id)',
                             'VALUES(14, 2);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id)',
                             'VALUES(15, 2);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

  }
  acceptance_rules_insert_v2 <- function(){
    new_entry_query <- paste("INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.6)
    ))
    dbBind(new_entry, list(1, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.65)
    ))
    dbBind(new_entry, list(2, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.7)
    ))
    dbBind(new_entry, list(3, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.75)
    ))
    dbBind(new_entry, list(4, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.8)
    ))
    dbBind(new_entry, list(5, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.85)
    ))
    dbBind(new_entry, list(6, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.9)
    ))
    dbBind(new_entry, list(7, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.95)
    ))
    dbBind(new_entry, list(8, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.97)
    ))
    dbBind(new_entry, list(9, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.99)
    ))
    dbBind(new_entry, list(10, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 2, value = 8),
      list(parameter_key_id = 3, value = 12)
    ))
    dbBind(new_entry, list(11, 2, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 2, value = 13.7),
      list(parameter_key_id = 3, value = 16.4)
    ))
    dbBind(new_entry, list(12, 2, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 2, value = 20),
      list(parameter_key_id = 3, value = 21)
    ))
    dbBind(new_entry, list(13, 2, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 2, value = 9.4),
      list(parameter_key_id = 3, value = 13.6)
    ))
    dbBind(new_entry, list(14, 2, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO acceptance_rules (acceptance_rule_id, acceptance_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 2, value = 15.8),
      list(parameter_key_id = 3, value = 17.4)
    ))
    dbBind(new_entry, list(15, 2, parameters))
    dbClearResult(new_entry)
  }
  acceptance_rules_insert_v1()
  #acceptance_rules_insert_v2()
  #~~~~

  ### ACCEPTANCE RULES PARAMETERS INSERT STATEMENTS
  #~~~~
  acceptance_rules_parameters_insert <- function(){
    new_entry_query <- paste('INSERT INTO acceptance_rules_parameters (acceptance_rule_id, parameter_id, parameter)',
                             'VALUES(1, 1, 0.6);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules_parameters (acceptance_rule_id, parameter_id, parameter)',
                             'VALUES(2, 1, 0.65);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules_parameters (acceptance_rule_id, parameter_id, parameter)',
                             'VALUES(3, 1, 0.7);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules_parameters (acceptance_rule_id, parameter_id, parameter)',
                             'VALUES(4, 1, 0.75);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules_parameters (acceptance_rule_id, parameter_id, parameter)',
                             'VALUES(5, 1, 0.80);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules_parameters (acceptance_rule_id, parameter_id, parameter)',
                             'VALUES(6, 1, 0.85);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules_parameters (acceptance_rule_id, parameter_id, parameter)',
                             'VALUES(7, 1, 0.9);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules_parameters (acceptance_rule_id, parameter_id, parameter)',
                             'VALUES(8, 1, 0.95);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules_parameters (acceptance_rule_id, parameter_id, parameter)',
                             'VALUES(9, 1, 0.97);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules_parameters (acceptance_rule_id, parameter_id, parameter)',
                             'VALUES(10, 1, 0.99);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules_parameters (acceptance_rule_id, parameter_id, parameter)',
                             'VALUES(11, 2, 8);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules_parameters (acceptance_rule_id, parameter_id, parameter)',
                             'VALUES(11, 3, 12);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules_parameters (acceptance_rule_id, parameter_id, parameter)',
                             'VALUES(12, 2, 13.7);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules_parameters (acceptance_rule_id, parameter_id, parameter)',
                             'VALUES(12, 3, 16.4);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules_parameters (acceptance_rule_id, parameter_id, parameter)',
                             'VALUES(13, 2, 20);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules_parameters (acceptance_rule_id, parameter_id, parameter)',
                             'VALUES(13, 3, 21);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules_parameters (acceptance_rule_id, parameter_id, parameter)',
                             'VALUES(14, 2, 9.4);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules_parameters (acceptance_rule_id, parameter_id, parameter)',
                             'VALUES(14, 3, 13.6);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules_parameters (acceptance_rule_id, parameter_id, parameter)',
                             'VALUES(15, 2, 15.8);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO acceptance_rules_parameters (acceptance_rule_id, parameter_id, parameter)',
                             'VALUES(15, 3, 17.4);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)
  }
  acceptance_rules_parameters_insert()
  #~~~~

  ### LINKAGE RULES INSERT STATEMENTS
  #~~~~
  linkage_rules_insert <- function(){
    #-- INTEGER VARIANCE --#
    new_entry_query <- paste('INSERT INTO linkage_rules (linkage_rule_id, alternate_field_value, integer_value_variance, substring_length, standardize_names)',
                             'VALUES(1, NULL, 1, NULL, NULL);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO linkage_rules (linkage_rule_id, alternate_field_value, integer_value_variance, substring_length, standardize_names)',
                             'VALUES(2, NULL, 2, NULL, NULL);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO linkage_rules (linkage_rule_id, alternate_field_value, integer_value_variance, substring_length, standardize_names)',
                             'VALUES(3, NULL, 3, NULL, NULL);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO linkage_rules (linkage_rule_id, alternate_field_value, integer_value_variance, substring_length, standardize_names)',
                             'VALUES(4, NULL, 4, NULL, NULL);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO linkage_rules (linkage_rule_id, alternate_field_value, integer_value_variance, substring_length, standardize_names)',
                             'VALUES(5, NULL, 5, NULL, NULL);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)
    #----------------------#

    #-- INITIALS OF PRIMARY AND ALT NAMES --#
    new_entry_query <- paste('INSERT INTO linkage_rules (linkage_rule_id, alternate_field_value, integer_value_variance, substring_length, standardize_names)',
                             'VALUES(6, NULL, NULL, 1, NULL);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO linkage_rules (linkage_rule_id, alternate_field_value, integer_value_variance, substring_length, standardize_names)',
                             'VALUES(7, 2, NULL, 1, NULL);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO linkage_rules (linkage_rule_id, alternate_field_value, integer_value_variance, substring_length, standardize_names)',
                             'VALUES(8, 3, NULL, 1, NULL);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO linkage_rules (linkage_rule_id, alternate_field_value, integer_value_variance, substring_length, standardize_names)',
                             'VALUES(9, 4, NULL, 1, NULL);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO linkage_rules (linkage_rule_id, alternate_field_value, integer_value_variance, substring_length, standardize_names)',
                             'VALUES(10, 5, NULL, 1, NULL);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)
    #---------------------------------------#

    #-- ALTERNATE FIELDS --#
    new_entry_query <- paste('INSERT INTO linkage_rules (linkage_rule_id, alternate_field_value, integer_value_variance, substring_length, standardize_names)',
                             'VALUES(11, 2, NULL, NULL, NULL);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO linkage_rules (linkage_rule_id, alternate_field_value, integer_value_variance, substring_length, standardize_names)',
                             'VALUES(12, 3, NULL, NULL, NULL);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO linkage_rules (linkage_rule_id, alternate_field_value, integer_value_variance, substring_length, standardize_names)',
                             'VALUES(13, 4, NULL, NULL, NULL);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO linkage_rules (linkage_rule_id, alternate_field_value, integer_value_variance, substring_length, standardize_names)',
                             'VALUES(14, 5, NULL, NULL, NULL);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)
    #----------------------#

    #-- SUBSTRINGED FIELDS --#
    new_entry_query <- paste('INSERT INTO linkage_rules (linkage_rule_id, alternate_field_value, integer_value_variance, substring_length, standardize_names)',
                             'VALUES(15, NULL, NULL, 3, NULL);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO linkage_rules (linkage_rule_id, alternate_field_value, integer_value_variance, substring_length, standardize_names)',
                             'VALUES(16, NULL, NULL, 4, NULL);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO linkage_rules (linkage_rule_id, alternate_field_value, integer_value_variance, substring_length, standardize_names)',
                             'VALUES(17, NULL, NULL, 5, NULL);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO linkage_rules (linkage_rule_id, alternate_field_value, integer_value_variance, substring_length, standardize_names)',
                             'VALUES(18, 2, NULL, 3, NULL);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO linkage_rules (linkage_rule_id, alternate_field_value, integer_value_variance, substring_length, standardize_names)',
                             'VALUES(19, 2, NULL, 4, NULL);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO linkage_rules (linkage_rule_id, alternate_field_value, integer_value_variance, substring_length, standardize_names)',
                             'VALUES(20, 2, NULL, 5, NULL);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)
    #------------------------#

    #-- standardize_namesIZED NAMES --#
    new_entry_query <- paste('INSERT INTO linkage_rules (linkage_rule_id, alternate_field_value, integer_value_variance, substring_length, standardize_names)',
                             'VALUES(21, NULL, NULL, NULL, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO linkage_rules (linkage_rule_id, alternate_field_value, integer_value_variance, substring_length, standardize_names)',
                             'VALUES(22, 2, NULL, NULL, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO linkage_rules (linkage_rule_id, alternate_field_value, integer_value_variance, substring_length, standardize_names)',
                             'VALUES(23, 3, NULL, NULL, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO linkage_rules (linkage_rule_id, alternate_field_value, integer_value_variance, substring_length, standardize_names)',
                             'VALUES(24, 4, NULL, NULL, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)
    #---------------------#
  }
  linkage_rules_insert()
  #~~~~

  ### STRING COMPARISON METHODS INSERT STATEMENTS
  #~~~~
  comparison_methods_insert <- function(){
    new_entry_query <- paste('INSERT INTO comparison_methods (comparison_method_id, method_name, description)',
                             'VALUES(1, "Reclin-Jarowinkler", "Jaro-Winkler similarity from the Reclin2 package");')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_methods (comparison_method_id, method_name, description)',
                             'VALUES(2, "Stringdist-OSA", "Optimal String Alignment distance");')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_methods (comparison_method_id, method_name, description)',
                             'VALUES(3, "Levenshtein", "Levenshtein character distance");')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_methods (comparison_method_id, method_name, description)',
                             'VALUES(4, "Soundex", "String Soundex from Phonics");')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_methods (comparison_method_id, method_name, description)',
                             'VALUES(5, "Numeric Error Tolerance", "Error Tolerance for Numerical & Percentage Values");')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_methods (comparison_method_id, method_name, description)',
                             'VALUES(6, "Damerau–Levenshtein", "Damerau-Levenshtein character distance");')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_methods (comparison_method_id, method_name, description)',
                             'VALUES(7, "Date Error Tolerance", "Error Tolerance For Date Fields");')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)
  }
  comparison_methods_insert()
  #~~~~

  ### STRING COMPARISON METHOD PARAMETERS INSERT STATEMENTS
  #~~~~
  comparison_methods_parameters_insert <- function(){
    new_entry_query <- paste('INSERT INTO comparison_method_parameters (comparison_method_id, parameter_id, parameter_key, description)',
                             'VALUES(1, 1, "jw_score", "The floating point minimum value for which a jarowinkler comparison will be accepted (0 < X < 1).");')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_method_parameters (comparison_method_id, parameter_id, parameter_key, description)',
                             'VALUES(2, 2, "osa_string_cost", "The integer maximum number of replacements in a string before being rejected (X >= 1).");')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_method_parameters (comparison_method_id, parameter_id, parameter_key, description)',
                             'VALUES(3, 3, "levenshtein_string_cost", "The maximum number of characters that a comparison can differ before being rejected (X >= 1).");')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_method_parameters (comparison_method_id, parameter_id, parameter_key, description)',
                             'VALUES(4, 4, "to_soundex", "Convert a name to soundex formatting and compare.");')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_method_parameters (comparison_method_id, parameter_id, parameter_key, description)',
                             'VALUES(5, 5, "numeric_tolerance", "Compare two numerical fields and see whether they are within a certain tolerance range.");')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_method_parameters (comparison_method_id, parameter_id, parameter_key, description)',
                             'VALUES(6, 6, "damerau_levenshtein_string_cost", "The maximum number of characters that a comparison can differ before being rejected (X >= 1). While also allowing for swapping adjacent letters.");')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_method_parameters (comparison_method_id, parameter_id, parameter_key, description)',
                             'VALUES(7, 7, "date_tolerance", "The maximum number of days that date fields can vary from each-other.");')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)
  }
  comparison_methods_parameters_insert()
  #~~~~

  ### STRING COMPARISON RULES INSERT STATEMENTS
  #~~~~
  comparison_rules_insert_v1 <- function(){
    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(1, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(2, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(3, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(4, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(5, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(6, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(7, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(8, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(9, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(10, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(11, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(12, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(13, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(14, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(15, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(16, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(17, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(18, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(19, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(20, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(21, 2);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(22, 2);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(23, 2);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(24, 2);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(25, 2);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(26, 3);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(27, 3);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(28, 3);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(29, 3);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(30, 3);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id)',
                             'VALUES(31, 4);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)
  }
  comparison_rules_insert_v2 <- function(){
    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.05)
    ))
    dbBind(new_entry, list(1, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.1)
    ))
    dbBind(new_entry, list(2, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.15)
    ))
    dbBind(new_entry, list(3, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.20)
    ))
    dbBind(new_entry, list(4, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.25)
    ))
    dbBind(new_entry, list(5, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.30)
    ))
    dbBind(new_entry, list(6, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.35)
    ))
    dbBind(new_entry, list(7, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.40)
    ))
    dbBind(new_entry, list(8, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.45)
    ))
    dbBind(new_entry, list(9, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.50)
    ))
    dbBind(new_entry, list(10, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.55)
    ))
    dbBind(new_entry, list(11, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.60)
    ))
    dbBind(new_entry, list(12, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.65)
    ))
    dbBind(new_entry, list(13, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.70)
    ))
    dbBind(new_entry, list(14, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.75)
    ))
    dbBind(new_entry, list(15, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.80)
    ))
    dbBind(new_entry, list(16, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.85)
    ))
    dbBind(new_entry, list(17, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.90)
    ))
    dbBind(new_entry, list(18, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.95)
    ))
    dbBind(new_entry, list(19, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 1, value = 0.99)
    ))
    dbBind(new_entry, list(20, 1, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 2, value = 1)
    ))
    dbBind(new_entry, list(21, 2, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 2, value = 2)
    ))
    dbBind(new_entry, list(22, 2, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 2, value = 3)
    ))
    dbBind(new_entry, list(23, 2, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 2, value = 4)
    ))
    dbBind(new_entry, list(24, 2, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 2, value = 5)
    ))
    dbBind(new_entry, list(25, 2, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 3, value = 1)
    ))
    dbBind(new_entry, list(26, 3, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 3, value = 2)
    ))
    dbBind(new_entry, list(27, 3, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 3, value = 3)
    ))
    dbBind(new_entry, list(28, 3, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 3, value = 4)
    ))
    dbBind(new_entry, list(29, 3, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 3, value = 5)
    ))
    dbBind(new_entry, list(30, 3, parameters))
    dbClearResult(new_entry)

    new_entry_query <- paste("INSERT INTO comparison_rules (comparison_rule_id, comparison_method_id, parameters)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(my_db, new_entry_query)
    parameters <- toJSON(list(
      list(parameter_key_id = 4, value = 1)
    ))
    dbBind(new_entry, list(31, 4, parameters))
    dbClearResult(new_entry)

  }
  comparison_rules_insert_v1()
  #comparison_rules_insert_v2()
  #~~~~

  ### STRING COMPARISON RULES PARAMETERS INSERT STATEMENTS
  comparison_rules_parameters_insert <- function(){
    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(1, 1, 0.05);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(2, 1, 0.1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(3, 1, 0.15);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(4, 1, 0.2);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(5, 1, 0.25);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(6, 1, 0.3);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(7, 1, 0.35);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(8, 1, 0.4);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(9, 1, 0.45);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(10, 1, 0.5);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(11, 1, 0.55);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(12, 1, 0.6);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(13, 1, 0.65);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(14, 1, 0.7);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(15, 1, 0.75);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(16, 1, 0.8);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(17, 1, 0.85);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(18, 1, 0.9);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(19, 1, 0.95);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(20, 1, 0.99);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(21, 2, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(22, 2, 2);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(23, 2, 3);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(24, 2, 4);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(25, 2, 5);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(26, 3, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(27, 3, 2);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(28, 3, 3);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(29, 3, 4);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(30, 3, 5);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)

    new_entry_query <- paste('INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter)',
                             'VALUES(31, 4, 1);')
    new_entry <- dbSendStatement(my_db, new_entry_query)
    dbClearResult(new_entry)
  }
  comparison_rules_parameters_insert()
  #----

  # Finally disconnect
  dbDisconnect(my_db)
}
