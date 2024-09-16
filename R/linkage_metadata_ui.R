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
      ),
      HTML("
        .tooltip-inner {
          max-width: 300px;  /* Custom width */
          background-color: #f8f9fa;  /* Light background */
          color: #333;  /* Dark text */
          border: 1px solid #ddd;  /* Border styling */
          padding: 10px;  /* Adjust padding */
        }"
      )
    )
  ),
  #----
  title = "Data Linkage UI",
  id = "main_navbar",
  #-- HOME PAGE --#
  #----
  nav_panel(title = "Home", value = "home_page",
    fluidPage(
     HTML("<br><br>"),
     accordion(
        accordion_panel(title = "Welcome",
          "You are on the Home page. Once complete, there will be a better welcome message, followed by a breakdown of all the
           tabs in the application, and what each of them will allow the user to do. From here, you can select one of the
           above tabs to move to that page, or you may scroll down and see what each page provides before selecting
           a new page."
        ),
        accordion_panel(title = "Datasets - Information"),
        accordion_panel(title = "Linkage Data - Information"),
        accordion_panel(title = "Linkage Variables - Information"),
        accordion_panel(title = "Acceptance Methods & Rules - Information"),
        accordion_panel(title = "Comparison Methods & Rules - Information"),
        accordion_panel(title = "Linkage Rules - Information",
          actionButton("to_methods", "Go To Linkage Rules Page")


        ),
     )
    )
  ),
  #----
  #---------------#

  #-- DATASETS PAGE --#
  #----
  nav_panel(title = "Datasets", value = "datasets_page",
    fluidPage(
      dataTableOutput("currently_added_datasets"),

      # If the user has selected a row, then we can either UPDATE or TOGGLE a dataset
      conditionalPanel(
        condition = "input.currently_added_datasets_rows_selected > 0",
        fluidRow(
          column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
            actionButton("toggle_dataset", "Toggle Selected Dataset", class = "btn-success"),

            # Add a question mark icon button with a popover
            actionButton("toggle_dataset_help", class = "btn btn-info", shiny::icon("question")) |>
            # Add the popover manually
            tooltip(paste("Toggle whether a dataset is available to be used in data linkage.",
                          "If a dataset is Enabled, you may select/view/add/modify linkage algorithms",
                          "and passes using that dataset, and may also use the dataset to perform data linkage.",
                          "If Disabled, the dataset, algorithms, and passes will be ignored, and it",
                          "may not be used for data linkage."),
                    placement = "right",
                    options = list(container = "body")
            ),
          ))
        ),
        HTML("<br>"),
        fluidRow(
          column(width = 4, div(style = "display: flex; align-items: center;",
                                textAreaInput("update_dataset_code", label = "Dataset Code/File Prefix:", value = "",
                                              width = validateCssUnit(500), resize = "none"),
                                # Add a question mark icon button with a popover
                                actionButton("update_dataset_code_help", class = "btn btn-info", shiny::icon("question")) |>

                                  # Add the popover manually
                                  tooltip(paste("The dataset code is the prefix of the source dataset that you will be using",
                                                "during the data linkage process. The prefix you enter here should match the",
                                                "prefix of the file you are using using EXACTLY."),
                                          placement = "right",
                                          options = list(container = "body"))
          )),
          column(width = 4, div(style = "display: flex; align-items: center;",
                                textAreaInput("update_dataset_name", label = "Dataset Name:", value = "",
                                              width = validateCssUnit(500), resize = "none"),
                                # Add a question mark icon button with a popover
                                actionButton("update_dataset_code_help", class = "btn btn-info", shiny::icon("question")) |>

                                  # Add the popover manually
                                  tooltip(paste("The dataset name should be an identifiable name for the dataset that you can",
                                                "reasonably identify. The ideal name is the full expanded name of the dataset",
                                                "that you plan on storing."),
                                          placement = "right",
                                          options = list(container = "body"))
          )),
          column(width = 4, div(style = "display: flex; align-items: center;",
                                numericInput("update_dataset_version", label = "Dataset Version:",
                                             value = NULL, width = validateCssUnit(500)),
                                # Add a question mark icon button with a popover
                                actionButton("update_dataset_code_help", class = "btn btn-info", shiny::icon("question")) |>

                                  # Add the popover manually
                                  tooltip(paste("The dataset version number can help differentiate dataset names additionally",
                                                "while also allowing for storing different versions of the same dataset."),
                                          placement = "right",
                                          options = list(container = "body"))
          )),
        ),
        HTML("<br>"),
        fluidRow(
          column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                                 actionButton("update_dataset", "Update Dataset", class = "btn-success"),
          ))
        )
      ),
      # abbreviated
      # If the user has no row selected, then we can ADD a new dataset
      conditionalPanel(
        condition = "input.currently_added_datasets_rows_selected <= 0",
        HTML("<br>"),
        fluidRow(
          column(width = 3, div(style = "display: flex; align-items: center;",
            textAreaInput("add_dataset_code", label = "Dataset Code/File Prefix:", value = "",
                          width = validateCssUnit(500), resize = "none"),
            # Add a question mark icon button with a popover
            actionButton("add_dataset_code_help", class = "btn btn-info", shiny::icon("question")) |>

            # Add the popover manually
            tooltip(paste("The dataset code is the prefix of the source dataset that you will be using",
                          "during the data linkage process. The prefix you enter here should match the",
                          "prefix of the file you are using using EXACTLY."),
                    placement = "right",
                    options = list(container = "body"))
          )),
          column(width = 3, div(style = "display: flex; align-items: center;",
            textAreaInput("add_dataset_name", label = "Dataset Name:", value = "",
                          width = validateCssUnit(500), resize = "none"),
            # Add a question mark icon button with a popover
            actionButton("add_dataset_code_help", class = "btn btn-info", shiny::icon("question")) |>

            # Add the popover manually
            tooltip(paste("The dataset name should be an identifiable name for the dataset that you can",
                          "reasonably identify. The ideal name is the full expanded name of the dataset",
                          "that you plan on storing."),
                    placement = "right",
                    options = list(container = "body"))
          )),
          column(width = 3, div(style = "display: flex; align-items: center;",
            numericInput("add_dataset_version", label = "Dataset Version:",
                        value = NULL, width = validateCssUnit(500)),
            # Add a question mark icon button with a popover
            actionButton("add_dataset_code_help", class = "btn btn-info", shiny::icon("question")) |>

            # Add the popover manually
            tooltip(paste("The dataset version number can help differentiate dataset names additionally",
                          "while also allowing for storing different versions of the same dataset."),
                    placement = "right",
                    options = list(container = "body"))
          )),
          column(width = 3, div(style = "display: flex; align-items: center;",
            actionButton("add_dataset_file", label = "Source Dataset (Fields):",
                          width = validateCssUnit(500)),
            # Add a question mark icon button with a popover
            actionButton("add_dataset_code_help", class = "btn btn-info", shiny::icon("question")) |>

            # Add the popover manually
            tooltip(paste("The dataset you plan on using to perform data linkage should be uploaded here.",
                          "The column names will be grabbed from the first row in the source dataset for",
                          "future use when creating linkage algorithms and passes."),
                    placement = "right",
                    options = list(container = "body")),
            uiOutput("uploaded_file")
          ))
        ),
        HTML("<br>"),
        fluidRow(
          column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
           actionButton("add_dataset", "Add Dataset", class = "btn-success"),
          ))
        )
      )
    )
  ),
  #----
  #-------------------#

  navbarMenu("Linkage Data",
    nav_panel(title = "Linkage Methods", value = "linkage_methods_page",
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
    nav_panel(title = "Linkage Algorithms", value = "linkage_algorithms_page",
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
    nav_panel(title = "Linkage Iterations", value = "linkage_iterations_page",
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
    nav_panel(title = "Linkage Audits", value = "audits_page",
      "You are on the Audits page. Here, you can view all stored auditing information observed during data linkage, being able
      to sort by datasets, and date of capture. Further, the option to select and export selected auditing information is available
      to the user."
    ),
  ),
  navbarMenu("Linkage Variables",
    nav_panel(title = "Blocking Variables", value = "blocking_variables_page",
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
    nav_panel(title = "Matching Variables", value = "matching_variables_page",
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
    nav_panel(title = "Ground Truth Variables", value = "ground_truth_variables_page",
      fluidPage(
        "You are on the ground truth variables page. Here, you can view, add, modify, and drop the ground truth variables used
        in a specific linkage algorithm. Each algorithm has its own variables that can be added to, modified, or deleted, without
        affecting the variables of any other algorithm.",
      )
    )
  ),
  navbarMenu("Acceptance Methods & Rules",
    nav_panel(title = "Acceptance Methods", value = "acceptance_methods_page",
      "You are on the Acceptance Methods page. Here, you can enter information for creating a new/custom acceptance method that can
      be used in custom linkage implementations. The user will be required to provide a method name and description to submit or
      update."
    ),
    nav_panel(title = "Acceptance Parameters", value = "acceptance_parameters_page",
      "You are on the Acceptance Parameters page. Here, you can select an exisiting acceptance method to add or update the acceptance
      parameters of."
    ),
    nav_panel(title = "Acceptance Rules", value = "acceptance_rules_page",
      "You are on the Acceptance Rules page. Here, you can enter information for creating a new/custom acceptance rule that can
      be used in custom linkage implementations. The user will be required to provide a rule name and description, which will be
      stored in the database."
    )
  ),
  navbarMenu("Comparison Methods & Rules",
    nav_panel(title = "Comparison Methods", value = "comparison_methods_page",
      "You are on the Comparison Methods page. Here, you can enter information for creating a new/custom comparison method that can
      be used in custom linkage implementations. The user will be required to provide a method name and description to submit or
      update."
    ),
    nav_panel(title = "Comparison Parameters", value = "comparison_parameters_page",
      "You are on the Comparison Parameters page. Here, you can select an exisiting comparison method to add or update the comparison
      parameters of."
    ),
    nav_panel(title = "Comparison Rules", value = "comparison_rules_page",
      "You are on the Comparison Rules page. Here, you can enter information for creating a new/custom comparison rule that can
      be used in custom linkage implementations. The user will be required to provide a rule name and description, which will be
      stored in the database."
    )
  ),
  #-- LINKAGE RULES PAGE --#
  #----
  nav_panel(title = "Linkage Rules", value = "linkage_rule_page",
    "You are on the Linkage Rules page. Here, you can add a new linkage rule usable by blocking and matching variables. Input boxes for
    each of the main rules will be provided and the user may enter inputs for at least one of their choice for a rule to be valid. Once
    submitted the rule will be added to the database and thus available for use when selecting blocking and matching variables."
  ),
  #----
  #------------------------#
  nav_spacer(),
  nav_menu(
    title = "Links",
    align = "right",
    nav_item(tags$a("GitHub", href = "https://github.com/CHIMB/datalink"))
  )
)

# Script/Server
linkage_server <- function(input, output, session, linkage_metadata_conn, username){
  #-- HIDING PAGES EVENTS --#
  # Initially hide some tabs we don't need the users to access
  nav_hide('main_navbar', 'linkage_rule_page')

  # If the user goes off of an inner tab, hide it
  observeEvent(input$main_navbar, {
    # Get the tabs that are not necessary for the user
    tabs_to_hide <- c("linkage_rule_page")
    selected_panel <- input$main_navbar

    # Hide them
    for(tab in tabs_to_hide){
      if(selected_panel != tab){
        nav_hide('main_navbar', tab)
      }
    }
  })
  #-------------------------#

  #-- DATASETS PAGE EVENTS --#
  #----
  # Reactive value for the file path
  file_path <- reactiveValues(
    path=NULL
  )

  # Query and output for getting the users datasets
  get_datasets <- function(){
    # Query to get all dataset information from the 'datasets' table
    query <- paste('SELECT * FROM datasets ORDER BY dataset_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    # With our data frame, we'll rename some of the columns to look better
    names(df)[names(df) == 'dataset_code'] <- 'Dataset Code'
    names(df)[names(df) == 'dataset_name'] <- 'Dataset Name'
    names(df)[names(df) == 'version'] <- 'Version'
    names(df)[names(df) == 'enabled_for_linkage'] <- 'Enabled'

    # With datasets, we'll replace the enabled [0, 1] with [No, Yes]
    df$Enabled <- str_replace(df$Enabled, "0", "No")
    df$Enabled <- str_replace(df$Enabled, "1", "Yes")

    # Drop the dataset_id value
    df <- subset(df, select = -c(dataset_id))

    # Put it into a data table now
    dt <- datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE, dom = 't'))
  }

  # Function to read in a file, extract the column names, and return them
  read_dataset_columns <- function(file_path) {
    # Extract the file extension
    file_extension <- tools::file_ext(file_path)

    # Based on file extension, attempt to read only the first row (column names)
    column_names <- switch(tolower(file_extension),
       "csv" = {
         # Read only the header from a CSV file
         data.table::fread(file_path, nrows = 1) %>% colnames()
       },
       "txt" = {
         # Read only the header from a TXT file
         data.table::fread(file_path, nrows = 1) %>% colnames()
       },
       "sas7bdat" = {
         # Read only the header from a SAS7BDAT file
         haven::read_sas(file_path, n_max = 1) %>% colnames()
       },
       "xlsx" = {
         # Read only the first row from an Excel file
         readxl::read_excel(file_path, n_max = 1) %>% colnames()
       },
       "xls" = {
         # Read only the first row from an older Excel file
         readxl::read_excel(file_path, n_max = 1) %>% colnames()
       },
       "json" = {
         # For JSON, read the first object's keys (assuming it's an array of objects)
         json_data <- jsonlite::fromJSON(file_path, simplifyDataFrame = TRUE)
         if (is.data.frame(json_data)) {
           colnames(json_data)
         } else {
           stop("Unsupported JSON format - expecting an array of objects")
         }
       },
       stop("Unsupported file format")  # Error if unsupported file type
    )

    # Return the extracted column names
    return(column_names)
  }

  # Renders the Data table of currently added datasets
  output$currently_added_datasets <- renderDataTable({
    get_datasets()
  })

  # Enables or Disables the currently selected dataset
  observeEvent(input$toggle_dataset, {
    # Get the row that we're supposed to be toggling
    #----#
    selected_row <- input$currently_added_datasets_rows_selected

    df <- dbGetQuery(linkage_metadata_conn, paste('SELECT * from datasets
                                                ORDER BY dataset_id ASC'))

    selected_dataset_id <- df[selected_row, "dataset_id"]
    enabled_value       <- df[selected_row, "enabled_for_linkage"]
    dataset_code        <- df[selected_row, "dataset_code"]
    #----#

    # Create a query for updating the enabled value of the record
    #----#
    if(enabled_value == 1){
      update_query <- paste("UPDATE datasets
                          SET enabled_for_linkage = 0
                          WHERE dataset_id = ?")
      update <- dbSendStatement(linkage_metadata_conn, update_query)
      dbBind(update, list(selected_dataset_id))
      dbClearResult(update)
    }else{
      # Error handling - don't allow user to have two databases enabled with the same data set code
      #----#
      get_query <- dbSendQuery(linkage_metadata_conn, 'SELECT * FROM datasets WHERE dataset_code = ? AND enabled_for_linkage = 1;')
      dbBind(get_query, list(dataset_code))
      output_df <- dbFetch(get_query)
      enabled_databases <- nrow(output_df)
      dbClearResult(get_query)

      if(is.na(enabled_databases) || is.null(enabled_databases) || enabled_databases != 0){
        showNotification("Failed to Enable Database - Database with the same dataset code is already enabled", type = "error", closeButton = FALSE)
        return()
      }
      #----#

      update_query <- paste("UPDATE datasets
                          SET enabled_for_linkage = 1
                          WHERE dataset_id = ?")
      update <- dbSendStatement(linkage_metadata_conn, update_query)
      dbBind(update, list(selected_dataset_id))
      dbClearResult(update)
    }
    #----#

    # Re-render data tables and reset UI
    #----#
    output$currently_added_datasets <- renderDataTable({
      get_datasets()
    })
    #----#

    # Send a success notification
    #----#
    if(enabled_value == 1){
      showNotification("Dataset Successfully Disabled", type = "message", closeButton = FALSE)
    }else{
      showNotification("Dataset Successfully Enabled", type = "message", closeButton = FALSE)
    }
    #----#
  })

  # Allows user to upload a file for grabbing column names
  observeEvent(input$add_dataset_file,{
    tryCatch({
      file_path$path <- file.choose()
    },
    error = function(e){
      file_path$path <- NULL
    })
  })

  # Render the uploaded file
  # observeEvent({
  #   #uploaded_file <- file_path$path
  #   # FIX THIS
  #   # # Uploaded dataset file
  #   # if(is.null(uploaded_file)){
  #   #   output$uploaded_file <- renderUI({
  #   #     column(12, HTML("No File Chosen"), align = "center")
  #   #   })
  #   # }
  #   # else{
  #   #   output$uploaded_file <- renderUI({
  #   #     column(12, HTML(paste("<b>File Selected:</b>", basename(file_path$path))), align = "center")
  #   #   })
  #   # }
  # })

  # Adds a new dataset to the database
  observeEvent(input$add_dataset, {
    # Get the values that we're inserting into a new record
    #----#
    dataset_code <- input$add_dataset_code
    dataset_name <- input$add_dataset_name
    dataset_vers <- input$add_dataset_version
    dataset_file <- file_path$path
    print(dataset_code)
    print(dataset_name)
    print(dataset_vers)
    print(dataset_file)
    return()
    dataset_cols <- read_dataset_columns(dataset_file)
    #----#

    # Error Handling
    #----#
    # Make sure the same dataset code is already being used
    get_query <- dbSendQuery(linkage_metadata_conn, 'SELECT * FROM datasets WHERE dataset_code = ? AND enabled_for_linkage = 1;')
    dbBind(get_query, list(dataset_code))
    output_df <- dbFetch(get_query)
    num_of_databases <- nrow(output_df)
    dbClearResult(get_query)
    if(num_of_databases != 0){
      showNotification("Failed to Add Dataset - Dataset Code Already in Use", type = "error", closeButton = FALSE)
      return()
    }

    # Make sure the inputs are good
    if(dataset_code == "" || dataset_name == "" || is.na(dataset_vers) || is.null(dataset_file)){
      showNotification("Failed to Add Dataset - Dataset Code Already in Use", type = "error", closeButton = FALSE)
      return()
    }
    #----#

    tryCatch({
      dbBegin(linkage_metadata_conn)

      # Create a new entry query for entering into the database
      #----#
      new_entry_query <- paste("INSERT INTO datasets (dataset_code, dataset_name, version, enabled_for_linkage)",
                               "VALUES(?, ?, ?, 1);")
      new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
      dbBind(new_entry, list(dataset_code, dataset_name, dataset_vers))
      dbClearResult(new_entry)
      #----#

      # Add the dataset fields to the other table after we insert basic information
      #----#
      # Get the most recently inserted dataset_id value
      dataset_id <- dbGetQuery(linkage_metadata_conn, "SELECT last_insert_rowid() AS dataset_id;")$dataset_id

      # Insert each column name into the dataset_fields table
      for (col_name in dataset_cols) {
        insert_field_query <- "INSERT INTO dataset_fields (dataset_id, field_name) VALUES (?, ?);"
        insert_field_stmt <- dbSendStatement(linkage_metadata_conn, insert_field_query)
        dbBind(insert_field_stmt, list(dataset_id, col_name))
        dbClearResult(insert_field_stmt)
      }

      # Commit transaction
      dbCommit(linkage_metadata_conn)
      #----#
    },
    error = function(e){
      # If we throw an error because of timeout, or bad insert, then rollback and return
      dbRollback(linkage_metadata_conn)
      showNotification("Failed to Add Dataset - An Error Occurred While Inserting", type = "error", closeButton = FALSE)
      return()
    })

    # Update user input fields to make them blank!
    #----#
    updateTextAreaInput(session, "add_dataset_code",    value = "")
    updateTextAreaInput(session, "add_dataset_name",    value = "")
    updateNumericInput(session,  "add_dataset_vers",    value = NULL)
    output$add_dataset_file <- renderUI({
      fileInput("add_dataset_file", label = "Source Dataset (Fields):",
                width = validateCssUnit(500))
    })
    #----#

    # Update Data Tables and UI Renders
    #----#

    #----#

    # Show success notification
    #----#
    showNotification("Dataset Successfully Added", type = "message", closeButton = FALSE)
    #----#
  })

  # Observes what row the user selects to update and will pre-populate the updating fields
  observe({
    row_selected <- input$currently_added_datasets_rows_selected

    # Get the entire dataframe for datasets so that we can get the info from the
    # row the user selected.
    df <- dbGetQuery(linkage_metadata_conn, paste('SELECT * from datasets'))
    dataset_code <- df[row_selected, "dataset_code"]
    dataset_name <- df[row_selected, "dataset_name"]
    version <- df[row_selected, "version"]

    # Now update the input fields
    updateTextAreaInput(session, "update_dataset_code",    value = dataset_code)
    updateTextAreaInput(session, "update_dataset_name",    value = dataset_name)
    updateNumericInput(session,  "update_dataset_vers",    value = version)
  })

  #----
  #--------------------------#

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
    nav_show('main_navbar', 'linkage_rule_page')
    updateNavbarPage(session, "main_navbar", selected = "linkage_rule_page")
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
#' start_linkage_metadata_ui(my_metadata_file, my_username)
#' @export
start_linkage_metadata_ui <- function(metadata_file_path, username){
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
