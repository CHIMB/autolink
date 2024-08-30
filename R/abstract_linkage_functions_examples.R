# Define the abstract class (interface)
LinkageMethod <- R6::R6Class("LinkageMethod",
                             public = list(
                               run_iteration = function(left_dataset, right_dataset, linkage_metadata_db, iteration_id) {
                                 stop("This is an abstract method and should be implemented by a subclass.")
                               }
                             )
)

# Example for reclin2
Reclin2Linkage <- R6::R6Class("Reclin2Linkage",
                              inherit = LinkageMethod,
                              public = list(
                                run_iteration = function(left_dataset, right_dataset, linkage_metadata_db, iteration_id) {
                                  linkage_technique <- get_linkage_technique(linkage_metadata_db, iteration_id)
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
                                 run_iteration = function(left_dataset, right_dataset, linkage_metadata_db, iteration_id) {
                                   if (linkage_technique == "P") {
                                     print("This is the probabilistic version of a fastlink iteration")
                                   } else if (linkage_technique == "D") {
                                     print("This is the deterministic version of a fastlink iteration")
                                   }
                                 }
                               )
)

run_main_linkage_v2 <- function(left_dataset, right_dataset, linkage_metadata_db, algorithm_id){
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

    # Retrieve the class definition from the implementation name string
    class_obj <- get(implementation_name)

    # Instantiate the class object
    linkage_implementation <- class_obj$new()

    # Call the run_iteration method implemented by the desired class
    result <- linkage_implementation$run_iteration(left_dataset, right_dataset, linkage_metadata_db, curr_iteration_id)

    # Step 2.5: Do whatever we may need with the result, before going onto the next iteration


  }

  # Step 3: Save performance measures, linkage rates, auditing information and whatever
  #         we may need to the database and export data for linkage reports if asked

}
