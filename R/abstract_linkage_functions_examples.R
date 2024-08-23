# R3 VERSION

# Define the generic function
link_data <- function(data, ...) {
  UseMethod("link_data")
}

# Define a simple built-in method
link_data.simple <- function(data, ...) {
  print("Simple linkage performed.")
  return(data)
}

# Define the main linkage function
main_linkage_function <- function(data, linkage_method, ...) {
  # Check if the method exists
  if (!exists(linkage_method, mode = "function")) {
    stop(paste("Linkage method", linkage_method, "does not exist"))
  }

  # Retrieve and call the specified method
  linkage_function <- get(linkage_method)
  result <- linkage_function(data, ...)

  return(result)
}

#------------------------------------------------------------------------------#

# R6 VERSION

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
                                  if (linkage_technique == "prob") {
                                    print("This is the probabilistic version of a reclin2 iteration")
                                  } else if (linkage_technique == "det") {
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
                                   if (linkage_technique == "prob") {
                                     print("This is the probabilistic version of a fastlink iteration")
                                   } else if (linkage_technique == "det") {
                                     print("This is the deterministic version of a fastlink iteration")
                                   }
                                 }
                               )
)

run_main_linkage <- function(class_name, left_dataset, right_dataset, blocking_keys, matching_vars, thresholds, linkage_technique) {
  # Retrieve the class definition from the class name string
  if (!exists(class_name)) {
    stop(paste("Class", class_name, "does not exist."))
  }

  # Retrieve the class definition from the class name string
  class_obj <- get(class_name)

  # Instantiate the class object
  linkage_obj <- class_obj$new()

  # Call the run_iteration method
  result <- linkage_obj$run_iteration(left_dataset, right_dataset, blocking_keys, matching_vars, thresholds, linkage_technique)

  return(result)
}

# result <- run_main_linkage("FastLinkLinkage", left_dataset, right_dataset, blocking_keys, matching_vars, thresholds, "det")
