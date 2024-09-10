# UI ----
linkage_ui <- page_navbar(
  # Tags
  #----
  tags$head(
    tags$style(
      HTML("#shiny-notification-panel {
              top: 0;
              bottom: unset;
              left: 0;
              right: 0;
              margin-left: auto;
              margin-right: auto;
              width: 100%;
              max-width: 450px;
              opacity: 1;
            }"
      ),
      HTML(".shiny-notification-message {
              background-color:#0ec116;
              color:#000000;
              opacity: 1;
              text-align: center;
           }"
      ),
      HTML(".shiny-notification-error {
              background-color:#C90000;
              color:#000000;
              opacity: 1;
              text-align: center;
           }"
      ),
      HTML(
        ".dataTables_wrapper caption {
          font-size: 16px;
          font-weight: bold;
          color: black;
          text-align: center;
        }"
      ),
      HTML("
        input[type=number] {
              -moz-appearance:textfield;
        }
        input[type=number]::{
              -moz-appearance:textfield;
        }
        input[type=number]::-webkit-outer-spin-button,
        input[type=number]::-webkit-inner-spin-button {
              -webkit-appearance: none;
              margin: 0;
        }"
      ),
      HTML(
        ".popover {
          max-width: 50%;
        }"
      ),
      HTML(
        "body { word-wrap: break-word; }"
      ),
      HTML("
        .modal-dialog {
          width: 90vw !important;  /* Set modal width to 90% of the viewport width */
          max-width: none !important; /* Disable the default max-width */
        }
        .modal-content {
          overflow-y: auto;  /* Add scrolling to the modal content */
        }"
      ),
      HTML("
        .accordion .accordion-button {
          background-color: #d3d3d3; /* Darker color for closed state */
          color: #000000;
        }
        .accordion .accordion-button:not(.collapsed) {
          background-color: #f8f9fa; /* Lighter color for open state */
          color: #000000;
        }"
      )
    )
  ),
  #----
  title = "Data Linkage UI",
  id = "main_navbar",
  nav_panel(title = "Home", id = "home_page",
    fluidPage(
     HTML("<br><br>"),
     accordion(
        accordion_panel(title = "Welcome",
          "You are on the Home page. Once complete, there will be a better welcome message, followed by a breakdown of all the
           tabs in the application, and what each of them will allow the user to do. From here, you can select one of the
           above tabs to move to that page, or you may scroll down and see what each page provides before selecting
           a new page."
        ),
        accordion_panel(title = "Datasets"),
        accordion_panel(title = "Linkage Data"),
        accordion_panel(title = "Linkage Variables"),
        accordion_panel(title = "Acceptance Methods & Rules"),
        accordion_panel(title = "Comparison Methods & Rules"),
        accordion_panel(title = "Linkage Rules"),
     )
    )
  ),
  nav_panel(title = "Datasets", id = "datasets_page",
    fluidPage(
      "You are on the Datasets page. Here, you can add new datasets to be used in data linkage, disable & enable datasets to
      allow for version control, and as well as modify the dataset names and codes.",
      HTML("<br><br>"),
      "The user will be provided with a table consisting of all currently created datasets. Below the tables will be input boxes
      with the intention for the user to enter a dataset code, name, and version of the dataset. If a user clicks on one of the
      existing datasets, the input boxes will be populated with dataset metadata which will allow for quicker editing. Here, the
      user will also be allowed to toggle datasets to either enable or disable them."
    )
  ),
  navbarMenu("Linkage Data",
    nav_panel(title = "Linkage Methods", id = "linkage_methods_page",
      fluidPage(
        "You are on the Linkage Methods page. Here, you can create a new selectable linkage method which will automatically be
        called via the `datalink` package during the linkage process. Once the user creates their own custom class implementation
        in an .R script, they may come here. To add that new method to the database.",
        HTML("<br><br>"),
        "This page will have a data table of all the current linkage methods + the techniques which will be viewable. Below the
        data table, there will be input for an implementation name, which should match the R class the use defined, a linkage
        technique, and a version descriptor at the users discretion."
      )
    ),
    nav_panel(title = "Linkage Algorithms", id = "linkage_algorithms_page",
      fluidPage(
        "You are on the Linkage Algorithms page. Here, you can create a new linkage algorithm which can have iterations/steps added
        to them, the user will be asked asked to select two datasets to link, a left and right dataset which will be chosen from two
        tables provided to the user.",
        HTML("<br><br>"),
        "With the datasets selected, the user can submit to creating a blank algorithm which will supply the database with an insert
        query containing the selected dataset IDs, username, date modified, records linked, and being already set to enabled.",
        HTML("<br><br>"),
        "Additionally, the user should be provided with a table of all the current linkage algorithms with the option to enable
        or disable algorithms for testing and linkage purposes."
      )
    ),
    nav_panel(title = "Linkage Iterations", id = "linkage_iterations_page",
      fluidPage(
        "You are on the Linkage Iterations page. Here, you can select a left and right dataset for which you'd like to add iterations
        for, which will bring up a list of all current algorithms using those two datasets.",
        HTML("<br><br>"),
        "Afterwards, you may select an algorithm which will bring up all the current iterations under that specific algorithm. From here,
        the user can either enter an order for iteration which is an integer greater than 0, a linkage method which will call either
        a default or custom linkage class, and an acceptance rule if required.",
        HTML("<br><br>"),
        actionButton("iteration_acceptance_rule", "Choose a Rule"),
      )
    ),
    nav_panel(title = "Linkage Audits", id = "audits_page",
      "You are on the Audits page. Here, you can view all stored auditing information observed during data linkage, being able
      to sort by datasets, and date of capture. Further, the option to select and export selected auditing information is available
      to the user."
    ),
  ),
  navbarMenu("Linkage Variables",
    nav_panel(title = "Blocking Variables", id = "blocking_variables_page",
      fluidPage(
        "You are on the Blocking Variables page. Here, you will upload the two datasets you wish to link, the server end will perform
        error handling to ensure the provided datasets exist in the database. If successful, you may select an existing algorithm and
        existing iteration to add to (this can be done using a button which will store the selected algorithm ID and selected iteration
        ID).",
        actionButton("blocking_variable_algorithm_id", "Select an Algorithm"),
        actionButton("blocking_variable_iteration_id", "Select an Iteration"),
        HTML("<br><br>"),
        "Once an iteration is selected, two tables may be provided to the user which are the field names in the left and right dataset.
        And additionally, the user can select a Linkage Rule for blocking on the two datasets. The user will select a field from the left
        dataset and a field from the right dataset, an optional linkage rule, and then submit the blocking variable.",
        HTML("<br><br>"),
        "Once submitted, the user may continue to add as many blocking variables as they would like, viewing the currently added variables
        in a table on the same page."
      )
    ),
    nav_panel(title = "Matching Variables", id = "matching_variables_page",
      fluidPage(
        "You are on the Matching Variables page. Here, you will upload the two datasets you wish to link, the server end will perform
        error handling to ensure the provided datasets exist in the database. If successful, you may select an existing algorithm and
        existing iteration to add to (this can be done using a button which will store the selected algorithm ID and selected iteration
        ID).",
        actionButton("matching_variable_algorithm_id", "Select an Algorithm"),
        actionButton("matching_variable_iteration_id", "Select an Iteration"),
        HTML("<br><br>"),
        "Once an iteration is selected, two tables may be provided to the user which are the field names in the left and right dataset.
        And additionally, the user can select a Linkage Rule for matching on the two datasets, along with a Comparison Rule for string
        matching purposes. The user will select a field from the left dataset and a field from the right dataset, an optional linkage
        rule, and then submit the matching variable.",
        HTML("<br><br>"),
        "Once submitted, the user may continue to add as many matching variables as they would like, viewing the currently added variables
        in a table on the same page."
      )
    ),
    nav_panel(title = "Ground Truth Variables", id = "ground_truth_variables_page",
      fluidPage(
        "You are on the ground truth variables page. Here, you can view, add, modify, and drop the ground truth variables used
        in a specific linkage algorithm. Each algorithm has its own variables that can be added to, modified, or deleted, without
        affecting the variables of any other algorithm.",
      )
    )
  ),
  navbarMenu("Acceptance Methods & Rules",
    nav_panel(title = "Acceptance Methods", id = "acceptance_methods_page",
      "You are on the Acceptance Methods page. Here, you can enter information for creating a new/custom acceptance method that can
      be used in custom linkage implementations. The user will be required to provide a method name and description to submit or
      update."
    ),
    nav_panel(title = "Acceptance Parameters", id = "acceptance_parameters_page",
      "You are on the Acceptance Parameters page. Here, you can select an exisiting acceptance method to add or update the acceptance
      parameters of."
    ),
    nav_panel(title = "Acceptance Rules", id = "acceptance_rules_page",
      "You are on the Acceptance Rules page. Here, you can enter information for creating a new/custom acceptance rule that can
      be used in custom linkage implementations. The user will be required to provide a rule name and description, which will be
      stored in the database."
    )
  ),
  navbarMenu("Comparison Methods & Rules",
    nav_panel(title = "Comparison Methods", id = "comparison_methods_page",
      "You are on the Comparison Methods page. Here, you can enter information for creating a new/custom comparison method that can
      be used in custom linkage implementations. The user will be required to provide a method name and description to submit or
      update."
    ),
    nav_panel(title = "Comparison Parameters", id = "comparison_parameters_page",
      "You are on the Comparison Parameters page. Here, you can select an exisiting comparison method to add or update the comparison
      parameters of."
    ),
    nav_panel(title = "Comparison Rules", id = "comparison_rules_page",
      "You are on the Comparison Rules page. Here, you can enter information for creating a new/custom comparison rule that can
      be used in custom linkage implementations. The user will be required to provide a rule name and description, which will be
      stored in the database."
    )
  ),
  nav_panel(title = "Linkage Rules", id = "linkage_rules_page",
    "You are on the Linkage Rules page. Here, you can add a new linkage rule usable by blocking and matching variables. Input boxes for
    each of the main rules will be provided and the user may enter inputs for at least one of their choice for a rule to be valid. Once
    submitted the rule will be added to the database and thus available for use when selecting blocking and matching variables."
  ),
  nav_spacer(),
  nav_menu(
    title = "Links",
    align = "right",
    nav_item(tags$a("GitHub", href = "https://github.com/CHIMB/datalink"))
  )
)

# Script/Server
linkage_server <- function(input, output, session, linkage_metadata_conn, username){

  # TEST FOR SELECTING AN ACCEPTANCE RULE FOR AN ITERATION
  # THIS CAN ALSO BE FOR HOW YOU SELECT MATCHING AND BLOCKING VARIABLES
  #----
  observeEvent(input$iteration_acceptance_rule, {
    showModal(modalDialog(
      title = "Choose Acceptance Rule",
      fluidRow(
        # Left table (Acceptance Methods)
        column(width = 6,
               div(style = "width: 100%;",
                   tags$div("Select the Desired Acceptance Method:", style = "font-size: 16px; font-weight: bold; color: black; text-align: center; margin-bottom: 10px;"),
                   dataTableOutput("test")
               )
        ),
        # Right table (Acceptance Rules) - Conditional
        column(width = 6,
               conditionalPanel(
                 condition = "input.test_rows_selected > 0",
                 div(style = "width: 100%;",
                     tags$div("Select the Desired Acceptance Rule:", style = "font-size: 16px; font-weight: bold; color: black; text-align: center; margin-bottom: 10px;"),
                     dataTableOutput("test2")
                 )
               )
        )
      ),
      size = "l"  # Large modal size to fit both tables
    ))
  })

  output$test <- renderDataTable({
    query <- paste('SELECT * FROM acceptance_methods')
    df <- dbGetQuery(linkage_metadata_conn, query)
    datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE))
  })

  observeEvent(input$test_rows_selected, {
    selected_row <- input$test_rows_selected

    if (!is.null(selected_row)) {
      query <- paste('SELECT * from acceptance_methods')
      df <- dbGetQuery(linkage_metadata_conn, query)
      # Retrieve the dataset_id of the selected row
      selected_method <<- df[selected_row, "acceptance_method_id"]

      output$test2 <- renderDataTable({
        query <- paste('SELECT arp.acceptance_rule_id, parameter_id, parameter FROM acceptance_rules ar
                   JOIN acceptance_rules_parameters arp ON ar.acceptance_rule_id = arp.acceptance_rule_id
                   WHERE acceptance_method_id =', selected_method)
        df <- dbGetQuery(linkage_metadata_conn, query)
        # Aggregate parameters by acceptance_rule_id
        df <- df %>%
          group_by(acceptance_rule_id) %>%
          summarise(parameters = paste(parameter, collapse = ", ")) %>%
          ungroup()
        datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE))
      })
    }
  })
  #----

  observeEvent(input$to_methods, {
    updateNavbarPage(session, "main_navbar", selected = "Linkage Methods")
  })
}

#' Start Linkage Metadata UI
#'
#' Upon call, and passing a valid linkage metadata file, the application will run using the supplied metadata file
#' as the file that can be modified. This involves viewing entries, adding new entires, modifying existing entires
#' or deleting them.
#' @examples
#' my_metadata_file <- file.choose() # Select .sqlite file
#' my_username <- "John Doe"
#' startLinkageMetadataUI(my_metadata_file, my_username)
#' @export
startLinkageMetadataUI <- function(metadata_file_path, username){
  # Error handling to ensure passed an actual .sqlite file
  #----#
  if(is.null(metadata_file_path) || file_ext(metadata_file_path) != "sqlite"){
    stop("ERROR: Input file provided was not an SQLite file.")
  }
  #----#

  # Error handling to ensure a username was successfully provided
  #----#
  if(is.null(username) || !is.character(username) || length(username) <= 0){
    stop("ERROR: Username must be a single string")
  }
  #----#

  # Connect to the SQLite file
  linkage_metadata_conn <- dbConnect(RSQLite::SQLite(), metadata_file_path)

  # Verify that the metadata contains the required tables so that we don't try calling missing tables
  #----
  # These are the tables that the provided SQLite file should at LEAST have
  required_tables <- c(
    "datasets", "performance_measures_audit", "acceptance_methods", "acceptance_method_parameters",
    "acceptance_rules", "acceptance_rules_parameters", "linkage_rules", "comparison_methods",
    "comparison_method_parameters", "comparison_rules", "comparison_rules_parameters", "linkage_methods",
    "linkage_algorithms", "linkage_iterations", "ground_truth_variables", "blocking_variables",
    "matching_variables"
  )

  # Get the existing tables by calling dbListTables()
  existing_tables <- dbListTables(linkage_metadata_conn)

  # Get the missing tables by using setdiff to see what tables appear in the REQUIRED tables
  # vs. the existing tables
  missing_tables <- setdiff(required_tables, existing_tables)

  # Check that the length of missing tables is 0 which means it AT LEAST contains the expected tables
  if(length(missing_tables) != 0){
    # Disconnect from the metadata file
    dbDisconnect(linkage_metadata_conn)

    # Split the missing table values
    split_missing_tables <- paste(missing_tables, collapse = ", ")

    stop(paste("ERROR: Invalid SQLite file. Missing the following tables:", split_missing_tables))
  }

  # Clean up by removing some of the variables we used
  rm(required_tables, existing_tables, missing_tables)
  #----

  # Set a busy timeout here to help when more than one user is writing or reading
  dbExecute(linkage_metadata_conn, "PRAGMA busy_timeout = 10000;")

  # Ensure that our foreign keys are enabled to prevent adding invalid records
  dbExecute(linkage_metadata_conn, "PRAGMA foreign_keys = ON;")

  # Start the Shiny Application
  shinyApp(ui = linkage_ui,
           server = function(input, output, session){
             linkage_server(input, output, session, linkage_metadata_conn, username)
           },
           onStart = function(){
             cat("Data Linkage App - OPENED")
             onStop(function(){
               cat("Data Linkage App - CLOSED")
             })
           })
}
