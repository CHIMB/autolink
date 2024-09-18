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
    ),
    tags$head(tags$style('h6 {color:red;}')),
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
      h5(strong("Select An Existing Dataset to Update or Add a New Dataset Below:")),
      h6(p(strong("NOTE: "), "For datasets that use the same dataset code/prefix, only one be enabled at a time.")),
      dataTableOutput("currently_added_datasets"),

      # If the user has selected a row, then we can either UPDATE or TOGGLE a dataset
      conditionalPanel(
        condition = "input.currently_added_datasets_rows_selected > 0",
        fluidRow(
          column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
            actionButton("toggle_dataset", "Toggle Selected Dataset", class = "btn-success"),

            # Add a question mark icon button with a popover
            #actionButton("toggle_dataset_help", class = "btn btn-info", shiny::icon("question")) |>
            # Add the popover manually
            h1(tooltip(bs_icon("question-circle"),
                          paste("Toggle whether a dataset is available to be used in data linkage.",
                                "If a dataset is Enabled, you may select/view/add/modify linkage algorithms",
                                "and passes using that dataset, and may also use the dataset to perform data linkage.",
                                "If Disabled, the dataset, algorithms, and passes will be ignored, and it",
                                "may not be used for data linkage."),
                          placement = "right",
                          options = list(container = "body"))),
          ))
        ),
        HTML("<br><br>"),
        h5(strong("Update the Dataset Fields Here:")),
        fluidRow(
          column(width = 4, div(style = "display: flex; align-items: center;",
                                textAreaInput("update_dataset_code", label = "Dataset Code/File Prefix:", value = "",
                                              width = validateCssUnit(500), resize = "none"),
                                # Add a question mark icon button with a popover
                                #actionButton("update_dataset_code_help", class = "btn btn-info", shiny::icon("question")) |>

                                  # Add the popover manually
                                  h1(tooltip(bs_icon("question-circle"),
                                          paste("The dataset code is the prefix of the source dataset that you will be using",
                                                "during the data linkage process. The prefix you enter here should match the",
                                                "prefix of the file you are using using EXACTLY."),
                                          placement = "right",
                                          options = list(container = "body")))
          )),
          column(width = 4, div(style = "display: flex; align-items: center;",
                                textAreaInput("update_dataset_name", label = "Dataset Name:", value = "",
                                              width = validateCssUnit(500), resize = "none"),
                                # Add a question mark icon button with a popover
                                #actionButton("update_dataset_code_help", class = "btn btn-info", shiny::icon("question")) |>

                                  # Add the popover manually
                                  h1(tooltip(bs_icon("question-circle"),
                                          paste("The dataset name should be an identifiable name for the dataset that you can",
                                                "reasonably identify. The ideal name is the full expanded name of the dataset",
                                                "that you plan on storing."),
                                          placement = "right",
                                          options = list(container = "body")))
          )),
          column(width = 4, div(style = "display: flex; align-items: center;",
                                numericInput("update_dataset_vers", label = "Dataset Version:",
                                             value = NULL, width = validateCssUnit(500)),
                                # Add a question mark icon button with a popover
                                #actionButton("update_dataset_code_help", class = "btn btn-info", shiny::icon("question")) |>

                                  # Add the popover manually
                                  h1(tooltip(bs_icon("question-circle"),
                                          paste("The dataset version number can help differentiate dataset names additionally",
                                                "while also allowing for storing different versions of the same dataset."),
                                          placement = "right",
                                          options = list(container = "body")))
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
        h5(strong("Add the Dataset Fields Here:")),
        fluidRow(
          column(width = 3, div(style = "display: flex; align-items: center;",
            textAreaInput("add_dataset_code", label = "Dataset Code/File Prefix:", value = "",
                          width = validateCssUnit(500), resize = "none"),
            # Add a question mark icon button with a popover
            #actionButton("add_dataset_code_help", class = "btn btn-info", shiny::icon("question")) |>

            # Add the popover manually
            h1(tooltip(bs_icon("question-circle"),
                    paste("The dataset code is the prefix of the source dataset that you will be using",
                          "during the data linkage process. The prefix you enter here should match the",
                          "prefix of the file you are using using EXACTLY."),
                    placement = "right",
                    options = list(container = "body")))
          )),
          column(width = 3, div(style = "display: flex; align-items: center;",
            textAreaInput("add_dataset_name", label = "Dataset Name:", value = "",
                          width = validateCssUnit(500), resize = "none"),
            # Add a question mark icon button with a popover
            #actionButton("add_dataset_code_help", class = "btn btn-info", shiny::icon("question")) |>

            # Add the popover manually
            h1(tooltip(bs_icon("question-circle"),
                    paste("The dataset name should be an identifiable name for the dataset that you can",
                          "reasonably identify. The ideal name is the full expanded name of the dataset",
                          "that you plan on storing."),
                    placement = "right",
                    options = list(container = "body")))
          )),
          column(width = 3, div(style = "display: flex; align-items: center;",
            numericInput("add_dataset_version", label = "Dataset Version:",
                        value = NULL, width = validateCssUnit(500)),
            # Add a question mark icon button with a popover
            #actionButton("add_dataset_code_help", class = "btn btn-info", shiny::icon("question")) |>

            # Add the popover manually
            h1(tooltip(bs_icon("question-circle"),
                    paste("The dataset version number can help differentiate dataset names additionally",
                          "while also allowing for storing different versions of the same dataset."),
                    placement = "right",
                    options = list(container = "body")))
          )),
          column(width = 3, div(style = "display: flex; align-items: center;",
            fluidRow(
              column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                # Label for the uploaded file name
                div(style = "margin-right: 10px;", "Uploaded File:"),
              )),
              column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                # Boxed text output for showing the uploaded file name
                div(style = "flex-grow: 1; border: 1px solid #ccc; padding: 5px; background-color: #f9f9f9;",
                    textOutput("uploaded_file_name")
                ),
                # Upload button
                actionButton("add_dataset_file", label = "", shiny::icon("file-arrow-up")), #or use 'upload'
                # Add a question mark icon button with a popover
                #actionButton("add_dataset_code_help", class = "btn btn-info", shiny::icon("question")) |>

                # Add the popover manually
                h1(tooltip(bs_icon("question-circle"),
                        paste("The dataset you plan on using to perform data linkage should be uploaded here.",
                             "The column names will be grabbed from the first row in the source dataset for",
                             "future use when creating linkage algorithms and passes."),
                        placement = "right",
                        options = list(container = "body")))
              ))
            )
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

  #-- LINKAGE METHODS --#
  #----
  nav_panel(title = "Linkage Methods", value = "linkage_methods_page",
    fluidPage(
      # Generate the table
      h5(strong("View the Currently Usable Linkage Methods or Add a New Linkage Method Below:")),
      h6(p(strong("NOTE: "), "Only one combination of implementation name and technique label can exist at a time.")),
      dataTableOutput("currently_added_linkage_methods"),

      # Line break
      HTML("<br>"),

      # Add linkage method fields here
      h5(strong("Add New Linkage Method Here:")),
      fluidRow(
        column(width = 4, div(style = "display: flex; align-items: center;",
          textAreaInput("add_implementation_name", label = "Implementation/Class Name:", value = "",
                        width = validateCssUnit(500), resize = "none"),

          # Add the popover manually
          h1(tooltip(bs_icon("question-circle"),
                     paste("The linkage implementation/class name should match the custom R script built",
                           "by yourself to be used for linkage EXACTLY. During linkage, the program will",
                           "try to source and call your custom class by searching for this exact name."),
                     placement = "right",
                     options = list(container = "body")))
        )),
        column(width = 4, div(style = "display: flex; align-items: center;",
          textAreaInput("add_technique_label", label = "Technique Label:", value = "",
                        width = validateCssUnit(500), resize = "none"),

          # Add the popover manually
          h1(tooltip(bs_icon("question-circle"),
                     paste("Within a linkage implementation, there are various techniques that can be used",
                           "(Deterministic, Probabilistic) and the program will pass to your class which",
                           "technique should be used."),
                     placement = "right",
                     options = list(container = "body")))
        )),
        column(width = 4, div(style = "display: flex; align-items: center;",
          numericInput("add_implementation_vers", label = "Implementation Version:",
                       value = NULL, width = validateCssUnit(500)),

          # Add the popover manually
          h1(tooltip(bs_icon("question-circle"),
                     paste("The implementation version can help differentiate implementations from",
                           "other implementations with similar names and techniques."),
                     placement = "right",
                     options = list(container = "body")))
        )),
      ),
      HTML("<br>"),
      fluidRow(
        column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
          actionButton("add_linkage_method", "Add Linkage Method", class = "btn-success"),
        ))
      )
    )
  ),
  #----
  #---------------------#

  #-- LINKAGE ALGORITHMS --#
  #----
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
  #----
  #------------------------#

  #-- LINKAGE AUDITS --#
  #----
  nav_panel(title = "Linkage Audits", value = "audits_page",
            "You are on the Audits page. Here, you can view all stored auditing information observed during data linkage, being able
      to sort by datasets, and date of capture. Further, the option to select and export selected auditing information is available
      to the user."
  ),
  #----
  #--------------------#

  #-- LINKAGE ITERATIONS --#
  #----
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
  #----
  #------------------------#

  #-- BLOCKING VARIABLES PAGE --#
  #----
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
  #----
  #-----------------------------#

  #-- MATCHING VARIABLES PAGE --#
  #----
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
  #----
  #-----------------------------#

  #-- GROUND TRUTH VARIABLES PAGE --#
  #----
  nav_panel(title = "Ground Truth Variables", value = "ground_truth_variables_page",
            fluidPage(
              "You are on the ground truth variables page. Here, you can view, add, modify, and drop the ground truth variables used
        in a specific linkage algorithm. Each algorithm has its own variables that can be added to, modified, or deleted, without
        affecting the variables of any other algorithm.",
            )
  ),
  #----
  #---------------------------------#

  #-- ACCEPTANCE METHODS --#
  #----
  nav_panel(title = "Acceptance Methods", value = "acceptance_methods_page",
    fluidPage(
      # Generate the table
      h5(strong("Add a New Acceptance Method Below, or Select an Existing Method To Update or Add a Rule To:")),
      h6(p(strong("NOTE: "), "No acceptance methods can share the same the same name, and no parameters can share the same name within methods.")),
      dataTableOutput("currently_added_acceptance_methods_and_parameters"),

      # Line break
      HTML("<br>"),

      # If no row is selected, the user can enter a new method and parameters
      conditionalPanel(
        condition = "input.currently_added_acceptance_methods_and_parameters_rows_selected <= 0",

        h5(strong("Add a New Acceptance Method and Parameters Here:")),
        layout_column_wrap(
          width = 1/2,
          height = 300,
          # CARD FOR ACCEPTANCE METHOD INFO
          card(full_screen = TRUE, card_header("Acceptance Method General Information",
               tooltip(bs_icon("question-circle"),
                       paste("Within this card, you can enter general information about the acceptance",
                             "method that you want to add, which includes the name of the method and a",
                             "short description of what the expected values are."),
                       placement = "right",
                       options = list(container = "body"))),
            fluidPage(
              fluidRow(
                column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                  textAreaInput("add_acceptance_method_name", label = "Acceptance Method Name:", value = "",
                                width = validateCssUnit(500), resize = "none"),

                  # Add the popover manually
                  h1(tooltip(bs_icon("question-circle"),
                             paste("The acceptance method name should be descriptive and easy to identify for",
                                   "later linkage iteration and acceptance rule creation."),
                             placement = "right",
                             options = list(container = "body")))
                )),
                column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                  textAreaInput("add_acceptance_method_desc", label = "Acceptance Method Description:", value = "",
                                width = validateCssUnit(500), resize = "none"),

                  # Add the popover manually
                  h1(tooltip(bs_icon("question-circle"),
                             paste("The acceptance method description should be short and concise, and should",
                                   "detail the expected inputs for the parameters and how the acceptance method",
                                   "would work."),
                             placement = "right",
                             options = list(container = "body")))
                ))
              )
            )
          ),

          # CARD FOR ACCEPTANCE PARAMETER INFO
          card(full_screen = TRUE, card_header("Acceptance Method Parameter Information",
               tooltip(bs_icon("question-circle"),
                       paste("Within this card, you can add parameters that belong to the acceptance method",
                             "you are wanting to add, each parameter consists of a key which is how it would",
                             "called from R, and a short description of the parameter. You may add as many",
                             "parameters as you would like for the method being constructed."),
                       placement = "right",
                       options = list(container = "body"))),
            fluidPage(
              # Generate the table
              h5(strong("Parameters to be Added:")),
              h6(p(strong("NOTE: "), "No parameters can share the same name.")),
              dataTableOutput("acceptance_parameters_to_add"),

              # IF NO ROW IS SELECTED, STORE A PARAMETER THAT IS TO BE ADDED
              conditionalPanel(
                condition = "input.acceptance_parameters_to_add_rows_selected <= 0",
                fluidRow(
                  column(width = 6, div(style = "display: flex; justify-content: right; align-items: center;",
                    textAreaInput("add_acceptance_parameter_key", label = "Acceptance Parameter Key:", value = "",
                                  width = validateCssUnit(500), resize = "none"),

                    # Add the popover manually
                    h1(tooltip(bs_icon("question-circle"),
                               paste("The acceptance parameter key should be separated by underscores, and is how",
                                     "you would expect to retrieve the parameter value from this key value pair label."),
                               placement = "right",
                               options = list(container = "body")))
                  )),
                  column(width = 6, div(style = "display: flex; justify-content: left; align-items: center;",
                    textAreaInput("add_acceptance_parameter_desc", label = "Acceptance Parameter Description:", value = "",
                                  width = validateCssUnit(500), resize = "none"),

                    # Add the popover manually
                    h1(tooltip(bs_icon("question-circle"),
                               paste("The acceptance parameter description should be brief and should explain how each",
                                     "key is used during data linkage and what values it should expect."),
                               placement = "right",
                               options = list(container = "body")))
                  ))
                ),
                fluidRow(
                  column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                    actionButton("prepare_acceptance_method_parameters_to_add", "Add Acceptance Parameter", class = "btn-warning"),
                  ))
                )
              ),
              # IF A ROW IS SELECTED, ALLOW IT TO BE UPDATED OR DROPPED
              conditionalPanel(
                condition = "input.acceptance_parameters_to_add_rows_selected > 0",
                fluidRow(
                  column(width = 6, div(style = "display: flex; justify-content: right; align-items: center;",
                    textAreaInput("update_acceptance_parameter_key", label = "Update Parameter Key:", value = "",
                                  width = validateCssUnit(500), resize = "none"),

                    # Add the popover manually
                    h1(tooltip(bs_icon("question-circle"),
                               paste("The acceptance parameter key should be separated by underscores, and is how",
                                     "you would expect to retrieve the parameter value from this key value pair label."),
                               placement = "right",
                               options = list(container = "body")))
                  )),
                  column(width = 6, div(style = "display: flex; justify-content: left; align-items: center;",
                    textAreaInput("update_acceptance_parameter_desc", label = "Update Parameter Description:", value = "",
                                  width = validateCssUnit(500), resize = "none"),

                    # Add the popover manually
                    h1(tooltip(bs_icon("question-circle"),
                               paste("The acceptance parameter description should be brief and should explain how each",
                                     "key is used during data linkage and what values it should expect."),
                               placement = "right",
                               options = list(container = "body")))
                  ))
                ),
                fluidRow(
                  column(width = 6, div(style = "display: flex; justify-content: right; align-items: right;",
                                         actionButton("update_prepared_acceptance_method_parameters_to_add", "Update Acceptance Parameter", class = "btn-warning"),
                  )),
                  column(width = 6, div(style = "display: flex; justify-content: left; align-items: left;",
                                        actionButton("drop_prepared_acceptance_method_parameters_to_add", "Drop Acceptance Parameter", class = "btn-danger"),
                  ))
                )
              )
            )
          )
        ),
        HTML("<br>"),
        # After the user finishes adding everything they need, they can add new method and
        # parameters
        fluidRow(
          column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                                 actionButton("add_acceptance_method_and_parameters", "Add Acceptance Method & Parameters", class = "btn-success"),
          ))
        )
      ),
      # If a row is selected, you may update the acceptance method name, descriptions + parameter names and description.
      # You are, however, unable to delete parameter keys or acceptance methods after they've been created.
      # You may also click a button which brings you to a page for adding a new rule
      conditionalPanel(
        condition = "input.currently_added_acceptance_methods_and_parameters_rows_selected > 0",
        h5(strong("Create a New Acceptance Rule for the Selected Acceptance Method Here:")),
        fluidRow(
          column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                                 actionButton("acceptance_methods_to_acceptance_rules", "View and Add Acceptance Rules", class = "btn-info"),
          ))
        ),
        HTML("<br>"),
        h5(strong("Update the Selected Acceptance Method and Parameters Here:")),
        layout_column_wrap(
          width = 1/2,
          height = 300,
          # CARD FOR ACCEPTANCE METHOD INFO
          card(full_screen = TRUE, card_header("Acceptance Method General Information",
                                               tooltip(bs_icon("question-circle"),
                                                       paste("Within this card, you can enter general information about the acceptance",
                                                             "method that you want to add, which includes the name of the method and a",
                                                             "short description of what the expected values are."),
                                                       placement = "right",
                                                       options = list(container = "body"))),
               fluidPage(
                 fluidRow(
                   column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                                          textAreaInput("update_acceptance_method_name", label = "Acceptance Method Name:", value = "",
                                                        width = validateCssUnit(500), resize = "none"),

                                          # Add the popover manually
                                          h1(tooltip(bs_icon("question-circle"),
                                                     paste("The acceptance method name should be descriptive and easy to identify for",
                                                           "later linkage iteration and acceptance rule creation."),
                                                     placement = "right",
                                                     options = list(container = "body")))
                   )),
                   column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                                          textAreaInput("update_acceptance_method_desc", label = "Acceptance Method Description:", value = "",
                                                        width = validateCssUnit(500), resize = "none"),

                                          # Add the popover manually
                                          h1(tooltip(bs_icon("question-circle"),
                                                     paste("The acceptance method description should be short and concise, and should",
                                                           "detail the expected inputs for the parameters and how the acceptance method",
                                                           "would work."),
                                                     placement = "right",
                                                     options = list(container = "body")))
                   ))
                 )
               )
          ),

          # CARD FOR ACCEPTANCE PARAMETER INFO
          card(full_screen = TRUE, card_header("Acceptance Method Parameter Information",
                                               tooltip(bs_icon("question-circle"),
                                                       paste("Within this card, you can add parameters that belong to the acceptance method",
                                                             "you are wanting to add, each parameter consists of a key which is how it would",
                                                             "called from R, and a short description of the parameter. You may add as many",
                                                             "parameters as you would like for the method being constructed."),
                                                       placement = "right",
                                                       options = list(container = "body"))),
               fluidPage(
                 # Generate the table
                 h5(strong("Parameters to be Updated (Select a Row to Update the Key and Description):")),
                 h6(p(strong("NOTE: "), "No parameters can share the same name.")),
                 dataTableOutput("acceptance_parameters_to_update"),

                 # IF A ROW IS SELECTED, ALLOW IT TO BE UPDATED
                 conditionalPanel(
                   condition = "input.acceptance_parameters_to_update_rows_selected > 0",
                   fluidRow(
                     column(width = 6, div(style = "display: flex; justify-content: right; align-items: center;",
                                           textAreaInput("acceptance_parameter_key_update", label = "Update Parameter Key:", value = "",
                                                         width = validateCssUnit(500), resize = "none"),

                                           # Add the popover manually
                                           h1(tooltip(bs_icon("question-circle"),
                                                      paste("The acceptance parameter key should be separated by underscores, and is how",
                                                            "you would expect to retrieve the parameter value from this key value pair label."),
                                                      placement = "right",
                                                      options = list(container = "body")))
                     )),
                     column(width = 6, div(style = "display: flex; justify-content: left; align-items: center;",
                                           textAreaInput("acceptance_parameter_desc_update", label = "Update Parameter Description:", value = "",
                                                         width = validateCssUnit(500), resize = "none"),

                                           # Add the popover manually
                                           h1(tooltip(bs_icon("question-circle"),
                                                      paste("The acceptance parameter description should be brief and should explain how each",
                                                            "key is used during data linkage and what values it should expect."),
                                                      placement = "right",
                                                      options = list(container = "body")))
                     ))
                   ),
                   fluidRow(
                     column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                                           actionButton("update_prepared_acceptance_method_parameters_to_update", "Update Acceptance Parameter", class = "btn-warning"),
                     )),
                   )
                 )
               )
          )
        ),
        HTML("<br>"),
        # After the user finishes adding everything they need, they can update the acceptance method & parameters
        fluidRow(
          column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                                 actionButton("update_acceptance_method_and_parameters", "Update Acceptance Method & Parameters", class = "btn-success"),
          ))
        )
      )
    )
  ),
  #----
  #------------------------#

  #-- ACCEPTANCE RULES --#
  #----
  nav_panel(title = "Acceptance Rules", value = "acceptance_rules_page",
    fluidPage(
      # Put the back button on this page in the top left corner
      fluidRow(
        column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                               actionButton("acceptance_rules_back", "Back", class = "btn-info"),
        ))
      ),

      # Line break to give the back button some breathing room
      HTML("<br><br>"),

      # Generate the table
      h5(strong("View From the Table of Existing Rules & Create a New Rule Below:")),
      dataTableOutput("currently_added_acceptance_rules"),

      # Small line break
      HTML("<br><br>"),
      div(style = "display: flex; justify-content: center; align-items: center;",
        # CARD FOR ACCEPTANCE RULES
        card(max_height = 300, full_screen = TRUE, card_header("Acceptance Rules Parameter Values",
             tooltip(bs_icon("question-circle"),
                     paste("Within this card, you can enter your desired values for the acceptance",
                           "rule that you would like to use for future linkage iterations. All inputs",
                           "must be filled and should follow the descriptions listed by each parameter",
                           "to ensure that the linkage process is successful using your values."),
                     placement = "right",
                     options = list(container = "body"))),
          fluidPage(
            fluidRow(
              column(width = 12, uiOutput("acceptance_rules_inputs"))
            )
          )
        ),
      ),
      fluidRow(
        column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
          actionButton("add_acceptance_rules", "Submit Acceptance Rule Values", class = "btn-success"),
        ))
      ),
    )
  ),
  #----
  #----------------------#

  #-- COMPARISON METHODS PAGE --#
  #----
  nav_panel(title = "Comparison Methods", value = "comparison_methods_page",
            "You are on the Comparison Methods page. Here, you can enter information for creating a new/custom comparison method that can
      be used in custom linkage implementations. The user will be required to provide a method name and description to submit or
      update."
  ),
  #----
  #-----------------------------#

  #-- COMPARISON RULES PAGE --#
  #----
  nav_panel(title = "Comparison Rules", value = "comparison_rules_page",
            "You are on the Comparison Rules page. Here, you can enter information for creating a new/custom comparison rule that can
      be used in custom linkage implementations. The user will be required to provide a rule name and description, which will be
      stored in the database."
  ),
  #----
  #---------------------------#

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
  nav_hide('main_navbar', 'acceptance_rules_page')
  nav_hide('main_navbar', 'comparison_rules_page')

  # If the user goes off of an inner tab, hide it
  observeEvent(input$main_navbar, {
    # Get the tabs that are not necessary for the user
    tabs_to_hide <- c("linkage_rule_page", "acceptance_rules_page", "comparison_rules_page")
    selected_panel <- input$main_navbar

    # Hide the page if its not the one you're currently on
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

    # Create a vector for the column names
    column_names <- c()

    # Try to extract them
    tryCatch({
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
    },
    error = function(e){
      column_names <- c()
    })

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
  observe({
    uploaded_file <- file_path$path

    # Uploaded dataset file
    if(is.null(uploaded_file)){
      output$uploaded_file_name <- renderText({
        "No File Uploaded"
      })
    }
    else{
      output$uploaded_file_name <- renderText({
        basename(uploaded_file)
      })
    }
  })

  # Adds a new dataset to the database
  observeEvent(input$add_dataset, {
    # Get the values that we're inserting into a new record
    #----#
    dataset_code <- input$add_dataset_code
    dataset_name <- input$add_dataset_name
    dataset_vers <- input$add_dataset_version
    dataset_file <- file_path$path
    #----#

    # Error Handling
    #----#
    # Make sure the inputs are good
    if(dataset_code == "" || dataset_name == "" || is.na(dataset_vers) || is.null(dataset_file)){
      showNotification("Failed to Add Dataset - Some Inputs are Missing", type = "error", closeButton = FALSE)
      return()
    }

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

    # Try grabbing the column names
    dataset_cols <- read_dataset_columns(dataset_file)

    # If column reading failed (dataset_cols remains empty), return
    if(length(dataset_cols) == 0) {
      showNotification("Failed to Add Dataset - Invalid Input File", type = "error", closeButton = FALSE)
      return()
    }
    #----#

    tryCatch({
      dbBegin(linkage_metadata_conn)

      # Create a new entry query for entering into the database
      #----#
      dataset_vers <- paste0("v", dataset_vers)
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
    file_path$path <- NULL
    output$uploaded_file_name <- renderText({
      "No File Uploaded"
    })
    #----#

    # Update Data Tables and UI Renders
    #----#
    output$currently_added_datasets <- renderDataTable({
      get_datasets()
    })
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

    # Convert the version string to a number
    version <- sub('.', '', version)
    version_num <- as.numeric(version)

    # Now update the input fields
    updateTextAreaInput(session, "update_dataset_code",    value = dataset_code)
    updateTextAreaInput(session, "update_dataset_name",    value = dataset_name)
    updateNumericInput(session,  "update_dataset_vers",    value = version_num)
  })

  # Updates an existing record in the 'datasets' table
  observeEvent(input$update_dataset, {
    # Get the values that we're updating an existing record of
    #----#
    dataset_code <- input$update_dataset_code
    dataset_name <- input$update_dataset_name
    dataset_vers <- input$update_dataset_vers
    selected_row <- input$currently_added_datasets_rows_selected

    df <- dbGetQuery(linkage_metadata_conn, paste('SELECT * from datasets
                                                ORDER BY dataset_id ASC'))

    selected_dataset_id <- df[selected_row, "dataset_id"]
    #----#

    # Error handling to ensure we dont break database rules when we perform the update
    #----#
    # Verify that the updated dataset code is not already in use
    get_query <- dbSendQuery(linkage_metadata_conn, 'SELECT * FROM datasets WHERE dataset_id != ? AND dataset_code = ? AND enabled_for_linkage = 1;')
    dbBind(get_query, list(selected_dataset_id, dataset_code))
    output_df <- dbFetch(get_query)
    num_of_databases <- nrow(output_df)
    dbClearResult(get_query)
    if(num_of_databases != 0){
      showNotification("Failed to Add Dataset - Dataset Code Already in Use", type = "error", closeButton = FALSE)
      return()
    }

    # Make sure the inputs are good
    if(dataset_code == "" || dataset_name == "" || is.na(dataset_vers)){
      showNotification("Failed to Add Dataset - Some Inputs are Missing", type = "error", closeButton = FALSE)
      return()
    }
    #----#

    # Create a query for updating the dataset
    #----#
    dataset_vers <- paste0("v", dataset_vers)
    update_query <- paste("UPDATE datasets
                          SET dataset_code = ?, dataset_name = ?, version = ?
                          WHERE dataset_id = ?")
    update <- dbSendStatement(linkage_metadata_conn, update_query)
    dbBind(update, list(dataset_code, dataset_name, dataset_vers, selected_dataset_id))
    dbClearResult(update)
    #----#

    # Update the user input fields to be blank
    #----#
    updateTextAreaInput(session, "update_dataset_code",    value = "")
    updateTextAreaInput(session, "update_dataset_name",    value = "")
    updateNumericInput(session,  "update_dataset_vers",    value = NULL)
    #----#

    # Re-render data tables and reset UI
    #----#
    output$currently_added_datasets <- renderDataTable({
      get_datasets()
    })
    #----#

    # Send a success notification
    #----#
    showNotification("Dataset Successfully Updated", type = "message", closeButton = FALSE)
    #----#
  })

  #----
  #--------------------------#

  #-- LINKAGE METHODS PAGE EVENTS --#
  #----
  # Query and output for getting the users linkage methods
  get_linkage_methods <- function(){
    # Query to get all linkage method information from the 'linkage_methods' table
    query <- paste('SELECT * FROM linkage_methods
                ORDER BY linkage_method_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    # With our data frame, we'll rename some of the columns to look better
    names(df)[names(df) == 'implementation_name'] <- 'Implementation Name'
    names(df)[names(df) == 'technique_label'] <- 'Technique Label'
    names(df)[names(df) == 'version'] <- 'Version'

    # Drop the linkage_method_id value
    df <- subset(df, select = -c(linkage_method_id))

    # Reorder the columns so they're easier to read
    df <- df[, c('Implementation Name', 'Technique Label', 'Version')]

    # Put it into a data table now
    dt <- datatable(df, selection = 'none', rownames = FALSE, options = list(lengthChange = FALSE, dom = 't'))
  }

  # Renders the Data table of currently added linkage methods
  output$currently_added_linkage_methods <- renderDataTable({
    get_linkage_methods()
  })

  # Adds a new record to the linkage methods table
  observeEvent(input$add_linkage_method, {
    # Get the values that we're inserting into a new record
    #----#
    implementation_name <- input$add_implementation_name
    technique_label     <- input$add_technique_label
    implementation_vers <- input$add_implementation_vers
    #----#

    # Error check to verify that an exact match doesn't exist
    #----#
    # Verify inputs are good
    if(implementation_name == "" || technique_label == "" || is.null(implementation_vers)){
      showNotification("Failed to Add Linkage Method - Some Inputs are Missing", type = "error", closeButton = FALSE)
      return()
    }

    implementation_vers <- paste0("v", implementation_vers)
    get_query <- dbSendQuery(linkage_metadata_conn, 'SELECT * FROM linkage_methods
                                                  WHERE implementation_name = ? AND technique_label = ? AND version = ?;')
    dbBind(get_query, list(implementation_name, technique_label, implementation_vers))
    output_df <- dbFetch(get_query)
    num_of_databases <- nrow(output_df)
    dbClearResult(get_query)
    if(num_of_databases != 0){
      showNotification("Failed to Add Linkage Method - Linkage Method Already Exists", type = "error", closeButton = FALSE)
      return()
    }
    #----#

    # Create a new entry query for entering into the database
    #----#
    new_entry_query <- paste("INSERT INTO linkage_methods (implementation_name, technique_label, version)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
    dbBind(new_entry, list(implementation_name, technique_label, implementation_vers))
    dbClearResult(new_entry)
    #----#

    # Update user input fields to make them blank!
    #----#
    updateTextAreaInput(session, "add_implementation_name",    value = "")
    updateTextAreaInput(session, "add_technique_label",        value = "")
    updateNumericInput(session,  "add_implementation_vers",    value = NULL)
    #----#

    # Update Data Tables and UI Renders
    #----#
    output$currently_added_linkage_methods <- renderDataTable({
      get_linkage_methods()
    })
    #----#

    # Show success notification
    #----#
    showNotification("Linkage Method Successfully Added", type = "message", closeButton = FALSE)
    #----#
  })
  #----
  #---------------------------------#

  #-- ACCEPTANCE METHODS & PARAMETERS PAGE EVENTS --#
  #----
  # Query and output for getting the acceptance methods & parameters
  get_acceptance_methods_and_parameters <- function(){
    # Query to get all acceptance method information from the 'acceptance_methods'
    # and 'acceptance_method_parameters' table
    query <- paste('SELECT am.acceptance_method_id, method_name, am.description, parameter_key FROM acceptance_methods am
                      JOIN acceptance_method_parameters amp on amp.acceptance_method_id = am.acceptance_method_id
                      ORDER BY am.acceptance_method_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    # Aggregate parameters by acceptance_method_id
    df <- df %>%
      group_by(acceptance_method_id, method_name, description) %>%
      summarise(parameters = paste(parameter_key, collapse = ", ")) %>%
      ungroup()

    # With our data frame, we'll rename some of the columns to look better
    names(df)[names(df) == 'method_name'] <- 'Acceptance Method Name'
    names(df)[names(df) == 'description'] <- 'Acceptance Method Description'
    names(df)[names(df) == 'parameters'] <- 'Acceptance Method Parameters'

    # Drop the acceptance_method_id
    df <- subset(df, select = -c(acceptance_method_id))

    # Put it into a data table now
    dt <- datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE, dom = 't'))
  }

  # Renders the data table of currently added acceptance methods & parameters
  output$currently_added_acceptance_methods_and_parameters <- renderDataTable({
    get_acceptance_methods_and_parameters()
  })

  # Brings the user to the acceptance rules page FROM the Acceptance Methods & Parameters page
  observeEvent(input$acceptance_methods_to_acceptance_rules, {
    # Get the selected row
    selected_row <- input$currently_added_acceptance_methods_and_parameters_rows_selected
    # Get the acceptance method id from the selected row
    df <- dbGetQuery(linkage_metadata_conn, paste('SELECT * from acceptance_methods
                                             ORDER BY acceptance_method_id ASC'))
    acceptance_method_id <- df[selected_row, "acceptance_method_id"]

    # Update the global variable for the acceptance method id and the return page
    acceptance_method_id_add_rule <<- acceptance_method_id
    acceptance_rules_return_page  <<- "acceptance_methods_page"

    # Update the table of acceptance rules on that page
    output$currently_added_acceptance_rules <- renderDataTable({
      get_acceptance_rules()
    })

    # Update the UI inputs for the acceptance rules on that page
    output$acceptance_rules_inputs <- renderUI({
      get_acceptance_rules_inputs()
    })

    # Show the acceptance rules pages
    nav_show('main_navbar', 'acceptance_rules_page')
    updateNavbarPage(session, "main_navbar", selected = "acceptance_rules_page")
  })

  #-- NEW ACCEPTANCE METHOD & PARAMETERS --#
  # Create global variables for the parameter_key, and the descriptions of each
  parameter_keys_to_add <- c()
  parameter_desc_to_add <- c()

  # Function for creating the table of parameters to be added
  get_parameters_to_add <- function(){
    # Create a data frame from all the parameter keys
    df <- data.frame(
      keys = if(length(parameter_keys_to_add) == 0) numeric() else parameter_keys_to_add,
      desc = if(length(parameter_desc_to_add) == 0) character() else parameter_desc_to_add
    )

    # With our data frame, we'll rename some of the columns to look better
    names(df)[names(df) == 'keys'] <- 'Acceptance Parameter Key'
    names(df)[names(df) == 'desc'] <- 'Acceptance Parameter Description'

    # Put it into a data table now
    dt <- datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE, dom = 't'))
  }

  # Renders the data table of acceptance parameters that are to be added
  output$acceptance_parameters_to_add <- renderDataTable({
    get_parameters_to_add()
  })

  # Adds a parameter key and description to the list of prepped keys and descriptions
  observeEvent(input$prepare_acceptance_method_parameters_to_add, {
    # Get the values that we're inserting into a new record
    #----#
    parameter_key  <- input$add_acceptance_parameter_key
    parameter_desc <- input$add_acceptance_parameter_desc
    #----#

    # Error Handling
    #----#
    # Make sure the same dataset code is already being used
    if(parameter_key %in% parameter_keys_to_add){
      showNotification("Failed to Add Parameter Key - Parameter Key Already Prepared", type = "error", closeButton = FALSE)
      return()
    }

    # Make sure the inputs are good
    if(parameter_key == "" || parameter_desc == ""){
      showNotification("Failed to Add Parameter Key - Some Inputs are Missing", type = "error", closeButton = FALSE)
      return()
    }
    #----#

    # Append the data to our global variables
    #----#
    parameter_keys_to_add <<- append(parameter_keys_to_add, parameter_key)
    parameter_desc_to_add <<- append(parameter_desc_to_add, parameter_desc)
    #----#

    # Update user input fields to make them blank!
    #----#
    updateTextAreaInput(session, "add_acceptance_parameter_key",  value = "")
    updateTextAreaInput(session, "add_acceptance_parameter_desc", value = "")
    #----#

    # Update Data Tables and UI Renders
    #----#
    output$acceptance_parameters_to_add <- renderDataTable({
      get_parameters_to_add()
    })
    #----#

    # Show success notification
    #----#
    showNotification("Parameter Key Successfully Prepared", type = "message", closeButton = FALSE)
    #----#
  })

  # Observes what row the user selects to update and will pre-populate the parameter key updating fields
  observe({
    row_selected <- input$acceptance_parameters_to_add_rows_selected

    # Get the the parameter key and desc from the prepared values
    parameter_key  <- parameter_keys_to_add[row_selected]
    parameter_desc <- parameter_desc_to_add[row_selected]

    # Now update the input fields
    updateTextAreaInput(session, "update_acceptance_parameter_key",  value = parameter_key)
    updateTextAreaInput(session, "update_acceptance_parameter_desc", value = parameter_desc)
  })

  # Updates an existing record in our prepared parameters
  observeEvent(input$update_prepared_acceptance_method_parameters_to_add, {
    # Get the values that we're inserting into a new record + the selected row
    #----#
    row_selected <- input$acceptance_parameters_to_add_rows_selected
    parameter_key  <- input$update_acceptance_parameter_key
    parameter_desc <- input$update_acceptance_parameter_desc
    #----#

    # Error Handling
    #----#
    # Make sure the same parameter key is not being used
    if(parameter_key %in% parameter_keys_to_add && parameter_keys_to_add[row_selected] != parameter_key){
      showNotification("Failed to Update Parameter Key - Parameter Key Already Prepared", type = "error", closeButton = FALSE)
      return()
    }

    # Make sure the inputs are good
    if(parameter_key == "" || parameter_desc == ""){
      showNotification("Failed to Update Parameter Key - Some Inputs are Missing", type = "error", closeButton = FALSE)
      return()
    }
    #----#

    # Append the data to our global variables
    #----#
    parameter_keys_to_add[row_selected] <<- parameter_key
    parameter_desc_to_add[row_selected] <<- parameter_desc
    #----#

    # Update user input fields to make them blank!
    #----#
    updateTextAreaInput(session, "update_acceptance_parameter_key",  value = "")
    updateTextAreaInput(session, "update_acceptance_parameter_desc", value = "")
    #----#

    # Update Data Tables and UI Renders
    #----#
    output$acceptance_parameters_to_add <- renderDataTable({
      get_parameters_to_add()
    })
    #----#

    # Show success notification
    #----#
    showNotification("Prepared Parameter Key Successfully Updated", type = "message", closeButton = FALSE)
    #----#
  })

  # Drops an existing record from our prepared parameters
  observeEvent(input$drop_prepared_acceptance_method_parameters_to_add, {
    # Get the row to drop
    #----#
    row_selected <- input$acceptance_parameters_to_add_rows_selected
    #----#

    # Append the data to our global variables
    #----#
    parameter_keys_to_add <<- parameter_keys_to_add[-c(row_selected)]
    parameter_desc_to_add <<- parameter_desc_to_add[-c(row_selected)]
    #----#

    # Update user input fields to make them blank!
    #----#
    updateTextAreaInput(session, "update_acceptance_parameter_key",  value = "")
    updateTextAreaInput(session, "update_acceptance_parameter_desc", value = "")
    #----#

    # Update Data Tables and UI Renders
    #----#
    output$acceptance_parameters_to_add <- renderDataTable({
      get_parameters_to_add()
    })
    #----#

    # Show success notification
    #----#
    showNotification("Prepared Parameter Key Successfully Dropped", type = "message", closeButton = FALSE)
    #----#
  })

  # Creates a new acceptance method w/parameters using the general information & prepared parameters
  observeEvent(input$add_acceptance_method_and_parameters, {
    acceptance_method_name <- input$add_acceptance_method_name
    acceptance_method_desc <- input$add_acceptance_method_desc

    # Error checks
    #----#
    # Make Sure the acceptance method inputs are all valid
    if(acceptance_method_name == "" || acceptance_method_desc == ""){
      showNotification("Failed to Add Acceptance Method - Some Acceptance Method Inputs are Missing", type = "error", closeButton = FALSE)
      return()
    }

    # Make sure there exist acceptance parameters that are being added with this acceptance methods
    if(length(parameter_keys_to_add) == 0 || length(parameter_desc_to_add) == 0){
      showNotification("Failed to Add Acceptance Method - Missing Parameters to Add With Acceptance Method", type = "error", closeButton = FALSE)
      return()
    }

    # Make sure no other acceptance method shares the same name
    get_query <- dbSendQuery(linkage_metadata_conn, 'SELECT * FROM acceptance_methods
                                                  WHERE method_name = ?;')
    dbBind(get_query, list(acceptance_method_name))
    output_df <- dbFetch(get_query)
    num_of_databases <- nrow(output_df)
    dbClearResult(get_query)
    if(num_of_databases != 0){
      showNotification("Failed to Add Acceptance Method - Acceptance Method Already Exists", type = "error", closeButton = FALSE)
      return()
    }
    #----#

    # Create a new entry query for entering into the database
    #----#
    tryCatch({
      # Begin a transaction for the acceptance methods & parameters insertions
      dbBegin(linkage_metadata_conn)

      # Insert the acceptance method
      new_entry_query <- paste("INSERT INTO acceptance_methods (method_name, description)",
                               "VALUES(?, ?);")
      new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
      dbBind(new_entry, list(acceptance_method_name, acceptance_method_desc))
      dbClearResult(new_entry)

      # Get the most recently inserted acceptance_method_id value
      acceptance_method_id <- dbGetQuery(linkage_metadata_conn, "SELECT last_insert_rowid() AS acceptance_method_id;")$acceptance_method_id

      # Insert each parameter key and description into the database
      for (index in 1:length(parameter_keys_to_add)) {
        # Get the parameter key and description
        parameter_key <- parameter_keys_to_add[index]
        description <- parameter_desc_to_add[index]

        # Insert the parameters
        new_entry_query <- paste("INSERT INTO acceptance_method_parameters (acceptance_method_id, parameter_key, description)",
                                 "VALUES(?, ?, ?);")
        new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
        dbBind(new_entry, list(acceptance_method_id, parameter_key, description))
        dbClearResult(new_entry)
      }

      # Commit the transaction after all insertions are successful
      dbCommit(linkage_metadata_conn)
    },
    error = function(e){
      # If we throw an error because of timeout, or bad insert, then rollback and return
      dbRollback(linkage_metadata_conn)
      showNotification("Failed to Add Acceptance Method & Parameters - An Error Occurred While Inserting", type = "error", closeButton = FALSE)
      return()
    })
    #----#

    # Reset the prepared parameters and keys
    #----#
    parameter_keys_to_add <<- c()
    parameter_desc_to_add <<- c()
    #----#

    # Update user input fields to make them blank!
    #----#
    updateTextAreaInput(session, "add_acceptance_method_name",    value = "")
    updateTextAreaInput(session, "add_acceptance_method_desc",    value = "")
    updateTextAreaInput(session, "add_acceptance_parameter_key",  value = "")
    updateTextAreaInput(session, "add_acceptance_parameter_desc", value = "")
    #----#

    # Update Data Tables and UI Renders
    #----#
    output$acceptance_parameters_to_add <- renderDataTable({
      get_parameters_to_add()
    })
    output$currently_added_acceptance_methods_and_parameters <- renderDataTable({
      get_acceptance_methods_and_parameters()
    })
    #----#

    # Show success notification
    #----#
    showNotification("Acceptance Method & Parameters Successfully Created", type = "message", closeButton = FALSE)
    #----#
  })
  #----------------------------------------#

  #-- UPDATE ACCEPTANCE METHOD & PARAMETERS --#
  # Create global variables for the parameter_key, and the descriptions of each
  parameter_keys_to_update <- c()
  parameter_desc_to_update <- c()

  # Function for creating the table of parameters to be updated
  get_parameters_to_update <- function(){
    # Create a data frame from all the parameter keys
    df <- data.frame(
      keys = if(length(parameter_keys_to_update) == 0) numeric() else parameter_keys_to_update,
      desc = if(length(parameter_desc_to_update) == 0) character() else parameter_desc_to_update
    )

    # With our data frame, we'll rename some of the columns to look better
    names(df)[names(df) == 'keys'] <- 'Acceptance Parameter Key'
    names(df)[names(df) == 'desc'] <- 'Acceptance Parameter Description'

    # Put it into a data table now
    dt <- datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE, dom = 't'))
  }

  # Renders the data table of acceptance parameters that are to be updated
  output$acceptance_parameters_to_update <- renderDataTable({
    get_parameters_to_update()
  })

  # Observes what acceptance method the user will update and will pre-populate the parameter key updating fields + general information
  observe({
    # Get the selected row
    row_selected <- input$currently_added_acceptance_methods_and_parameters_rows_selected

    # If no row is selected, or a null row is selected, return
    if(is.null(row_selected)) return()

    # Query to get the general information
    df <- dbGetQuery(linkage_metadata_conn, paste('SELECT * from acceptance_methods
                                             ORDER BY acceptance_method_id ASC'))

    acceptance_method_id   <- df[row_selected, "acceptance_method_id"]
    acceptance_method_name <- df[row_selected, "method_name"]
    acceptance_method_desc <- df[row_selected, "description"]

    # Query to get the parameter keys
    df <- dbGetQuery(linkage_metadata_conn, paste('SELECT * from acceptance_method_parameters
                                                WHERE acceptance_method_id =', acceptance_method_id,
                                                'ORDER BY parameter_id ASC'))
    parameter_keys <- df$parameter_key
    parameter_desc <- df$description

    # Get the the parameter key and desc from the prepared values
    parameter_keys_to_update <<- parameter_keys
    parameter_desc_to_update <<- parameter_desc

    # Now update the input fields
    updateTextAreaInput(session, "update_acceptance_method_name", value = acceptance_method_name)
    updateTextAreaInput(session, "update_acceptance_method_desc", value = acceptance_method_desc)

    # Render the table for prepared parameters
    output$acceptance_parameters_to_update <- renderDataTable({
      get_parameters_to_update()
    })
  })

  # Observes what acceptance parameter key the user selects and pre-populates the input fields
  observe({
    row_selected <- input$acceptance_parameters_to_update_rows_selected

    # Get the the parameter key and desc from the prepared values
    parameter_key  <- parameter_keys_to_update[row_selected]
    parameter_desc <- parameter_desc_to_update[row_selected]

    # Now update the input fields
    updateTextAreaInput(session, "acceptance_parameter_key_update",  value = parameter_key)
    updateTextAreaInput(session, "acceptance_parameter_desc_update", value = parameter_desc)
  })

  # Updates an existing record in our prepared parameters to update
  observeEvent(input$update_prepared_acceptance_method_parameters_to_update, {
    # Get the values that we're inserting into a new record + the selected row
    #----#
    row_selected <- input$acceptance_parameters_to_update_rows_selected
    parameter_key  <- input$acceptance_parameter_key_update
    parameter_desc <- input$acceptance_parameter_desc_update
    #----#

    # Error Handling
    #----#
    # Make sure the same parameter key is not being used
    if(parameter_key %in% parameter_keys_to_update && parameter_keys_to_update[row_selected] != parameter_key){
      showNotification("Failed to Update Parameter Key - Parameter Key Already Prepared", type = "error", closeButton = FALSE)
      return()
    }

    # Make sure the inputs are good
    if(parameter_key == "" || parameter_desc == ""){
      showNotification("Failed to Update Parameter Key - Some Inputs are Missing", type = "error", closeButton = FALSE)
      return()
    }
    #----#

    # Append the data to our global variables
    #----#
    parameter_keys_to_update[row_selected] <<- parameter_key
    parameter_desc_to_update[row_selected] <<- parameter_desc
    #----#

    # Update user input fields to make them blank!
    #----#
    updateTextAreaInput(session, "acceptance_parameter_key_update",  value = "")
    updateTextAreaInput(session, "acceptance_parameter_desc_update", value = "")
    #----#

    # Update Data Tables and UI Renders
    #----#
    output$acceptance_parameters_to_update <- renderDataTable({
      get_parameters_to_update()
    })
    #----#

    # Show success notification
    #----#
    showNotification("Prepared Parameter Key Successfully Updated", type = "message", closeButton = FALSE)
    #----#
  })

  # Updates the acceptance method and parameters of the selected row
  observeEvent(input$update_acceptance_method_and_parameters, {
    # Get the user provided method name, description, and selected row to update
    acceptance_method_name <- input$update_acceptance_method_name
    acceptance_method_desc <- input$update_acceptance_method_desc
    selected_row <- input$currently_added_acceptance_methods_and_parameters_rows_selected

    # Get the acceptance method id from the selected row
    df <- dbGetQuery(linkage_metadata_conn, paste('SELECT * from acceptance_methods
                                             ORDER BY acceptance_method_id ASC'))

    acceptance_method_id <- df[selected_row, "acceptance_method_id"]

    # Get the parameter IDs using the selected acceptance method id
    df <- dbGetQuery(linkage_metadata_conn, paste('SELECT * from acceptance_method_parameters
                                                WHERE acceptance_method_id =', acceptance_method_id,
                                                  'ORDER BY parameter_id ASC'))
    parameter_ids <- df$parameter_id

    # Error checks
    #----#
    # Make Sure the acceptance method inputs are all valid
    if(acceptance_method_name == "" || acceptance_method_desc == ""){
      showNotification("Failed to Update Acceptance Method - Some Acceptance Method Inputs are Missing", type = "error", closeButton = FALSE)
      return()
    }

    # Make sure there exist acceptance parameters that are being added with this acceptance methods
    if(length(parameter_keys_to_update) == 0 || length(parameter_desc_to_update) == 0){
      showNotification("Failed to Update Acceptance Method - Missing Parameters to Update With Acceptance Method", type = "error", closeButton = FALSE)
      return()
    }

    # Make sure no other acceptance method shares the same name
    get_query <- dbSendQuery(linkage_metadata_conn, 'SELECT * FROM acceptance_methods
                                                  WHERE method_name = ? AND acceptance_method_id != ?;')
    dbBind(get_query, list(acceptance_method_name, acceptance_method_id))
    output_df <- dbFetch(get_query)
    num_of_databases <- nrow(output_df)
    dbClearResult(get_query)
    if(num_of_databases != 0){
      showNotification("Failed to Update Acceptance Method - Acceptance Method Already Exists", type = "error", closeButton = FALSE)
      return()
    }
    #----#

    # Create a new entry query for entering into the database
    #----#
    tryCatch({
      # Begin a transaction for the acceptance methods & parameters insertions
      dbBegin(linkage_metadata_conn)

      # Query for updating the acceptance method
      update_query <- paste("UPDATE acceptance_methods
                          SET method_name = ?, description = ?
                          WHERE acceptance_method_id = ?")
      update <- dbSendStatement(linkage_metadata_conn, update_query)
      dbBind(update, list(acceptance_method_name, acceptance_method_desc, acceptance_method_id))
      dbClearResult(update)

      # Insert each parameter key and description into the database
      for (index in 1:length(parameter_ids)) {
        # Get the parameter key, description, and ID for updating
        parameter_key <- parameter_keys_to_update[index]
        description   <- parameter_desc_to_update[index]
        parameter_id  <- parameter_ids[index]

        # Update the parameters
        update_query <- paste("UPDATE acceptance_method_parameters
                          SET parameter_key = ?, description = ?
                          WHERE parameter_id = ?")
        update <- dbSendStatement(linkage_metadata_conn, update_query)
        dbBind(update, list(parameter_key, description, parameter_id))
        dbClearResult(update)
      }

      # Commit the transaction after all insertions are successful
      dbCommit(linkage_metadata_conn)
    },
    error = function(e){
      # If we throw an error because of timeout, or bad insert, then rollback and return
      dbRollback(linkage_metadata_conn)
      showNotification("Failed to Update Acceptance Method & Parameters - An Error Occurred While Inserting", type = "error", closeButton = FALSE)
      return()
    })
    #----#

    # Reset the prepared parameters and keys
    #----#
    parameter_keys_to_update <<- c()
    parameter_desc_to_update <<- c()
    #----#

    # Update Data Tables and UI Renders
    #----#
    output$currently_added_acceptance_methods_and_parameters <- renderDataTable({
      get_acceptance_methods_and_parameters()
    })
    #----#

    # Show success notification
    #----#
    showNotification("Acceptance Method & Parameters Successfully Updated", type = "message", closeButton = FALSE)
    #----#
  })
  #-------------------------------------------#


  #----
  #-------------------------------------------------#

  #-- ACCEPTANCE RULES PAGE EVENTS --#
  #----
  # Create a global variable for which acceptance method we're wanting to add a rule for, and
  # as well as the PAGE we came from
  acceptance_method_id_add_rule <- 1
  acceptance_rules_return_page  <- "acceptance_methods_page"

  # Back button will bring you back to whichever page you came from
  observeEvent(input$acceptance_rules_back, {
    # Show return to the page you came from
    updateNavbarPage(session, "main_navbar", selected = acceptance_rules_return_page)
  })

  # Function for creating the table of parameters to be added
  get_acceptance_rules <- function(){
    acceptance_method_id <- acceptance_method_id_add_rule

    # Query to get all acceptance method information from the 'acceptance_method_parameters' table
    query <- paste('SELECT arp.acceptance_rule_id, parameter_id, parameter FROM acceptance_rules ar
                   JOIN acceptance_rules_parameters arp ON ar.acceptance_rule_id = arp.acceptance_rule_id
                   WHERE acceptance_method_id =', acceptance_method_id)
    df <- dbGetQuery(linkage_metadata_conn, query)

    # Aggregate parameters by acceptance_rule_id
    df <- df %>%
      group_by(acceptance_rule_id) %>%
      summarise(parameters = paste(parameter, collapse = ", ")) %>%
      ungroup()

    # With our data frame, we'll rename some of the columns to look better (we can always drop the ID if we want)
    names(df)[names(df) == 'acceptance_rule_id'] <- 'Acceptance Rule No.'
    names(df)[names(df) == 'parameters'] <- 'Parameter Values'

    # Put it into a data table now
    dt <- datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE, dom = 't'))
  }

  # Renders the data table of acceptance parameters that are to be added
  output$currently_added_acceptance_rules <- renderDataTable({
    get_acceptance_rules()
  })

  # Performs the query and UI construction for the acceptance rule inputs
  get_acceptance_rules_inputs <- function(){
    # Get the parameter IDs, keys, and descriptions of the inputs we need
    query <- paste('SELECT * from acceptance_method_parameters
                   WHERE acceptance_method_id =', acceptance_method_id_add_rule)
    df <- dbGetQuery(linkage_metadata_conn, query)

    # Get the number of inputs we'll need
    num_inputs <- nrow(df)

    # Construct the list of inputs
    acceptance_rule_input_list <- lapply(1:(num_inputs), function(index){
      # Using the current index, grab all the parameter information and provide a
      # numeric input for the user to enter their data.
      # Generate the table
      parameter_key  <- df[index, "parameter_key"]
      parameter_desc <- df[index, "description"]

      fluidPage(
        fluidRow(
          column(width = 12, div(style = "display: flex; justify-content: left; align-items: center;",
            numericInput(paste0("acceptance_rules_input_", index), label = h5(strong(parameter_key)),
                         value = NULL, width = validateCssUnit(500)),

            # Add the popover manually
            h1(tooltip(bs_icon("question-circle"),
                       parameter_desc,
                       placement = "right",
                       options = list(container = "body")))
          )),
        )
      )
    })
  }

  # Renders the UI inputs for the selected acceptance method
  output$acceptance_rules_inputs <- renderUI({
    get_acceptance_rules_inputs()
  })
  #----
  #----------------------------------#

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
#' as the file that can be modified. This involves viewing entries, adding new entries, modifying existing entries
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
