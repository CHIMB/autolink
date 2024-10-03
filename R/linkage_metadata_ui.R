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
              opacity: 1 !important;
              text-align: center;
           }"
      ),
      HTML(".shiny-notification-error {
              background-color:#C90000;
              color:#000000;
              opacity: 1 !important;
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
          opacity: 1 !important; /* Fully solid */
          border: 1px solid #ddd;  /* Border styling */
          padding: 10px;  /* Adjust padding */
        }"
      ),
      HTML("
          .modal{
            z-index: 1150;
        }"
      ),
      HTML("
          .dataset-field-box {
            border: 1px solid #ddd; /* Border color */
            padding: 10px; /* Padding inside the box */
            background-color: #f9f9f9; /* Background color */
            border-radius: 5px; /* Rounded corners */
            margin-bottom: 10px; /* Space below each box */
          }"
      ),
    ),
    tags$style(HTML("
      .btn-circle {
        border-radius: 50%;
        width: 40px; /* Adjust as needed */
        height: 40px; /* Adjust as needed */
        padding: 0; /* Remove padding */
        font-size: 18px; /* Adjust icon size */
      }
      .btn-green {
        background-color: lightgreen;
        border: none;
        color: white;
      }
      .btn-red {
        background-color: lightcoral;
        border: none;
        color: white;
      }
      .btn-green:hover {
        background-color: green; /* Darker shade on hover */
      }
      .btn-red:hover {
        background-color: red; /* Darker shade on hover */
      }
    ")),
    tags$head(tags$style('h6 {color:blue;}')),
  ),
  #----
  title = "Data Linkage UI",
  bg = "#f05a28",
  id = 'main_navbar',
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
          fluidPage(
            actionButton(inputId = "file_test_input", "Quick Test")
          )
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
      h5(strong("Select An Existing Dataset to Update:")),
      h6(p(strong("NOTE: "), "For datasets that use the same dataset code/prefix, only one be enabled at a time.")),
      dataTableOutput("currently_added_datasets"),

      # If the user has selected a row, then we can either UPDATE or TOGGLE a dataset
      conditionalPanel(
        condition = "input.currently_added_datasets_rows_selected > 0",
        fluidRow(
          column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
            actionButton("toggle_dataset", "Toggle Selected Dataset", class = "btn-success"),

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
        h5(strong("Update the Dataset Information & View Dataset Fields Here:")),

        # Create a column layout to separate the user inputs and dataset fields
        layout_column_wrap(
          width = 1/2,
          height = 500,
          # Card for the user inputs
          card(card_header("Update Dataset Information", class = "bg-dark"),
            fluidRow(
              column(width = 12, div(style = "display: flex; align-items: center;",
                 textAreaInput("update_dataset_code", label = "Dataset Code/File Prefix:", value = "",
                               width = validateCssUnit(500), resize = "none"),

                 # Add the popover manually
                 h1(tooltip(bs_icon("question-circle"),
                            paste("The dataset code is the prefix of the source dataset that you will be using",
                                  "during the data linkage process. The prefix you enter here should match the",
                                  "prefix of the file you are using using EXACTLY."),
                            placement = "right",
                            options = list(container = "body")))
               )),
               column(width = 12, div(style = "display: flex; align-items: center;",
                 textAreaInput("update_dataset_name", label = "Dataset Name:", value = "",
                               width = validateCssUnit(500), resize = "none"),

                 # Add the popover manually
                 h1(tooltip(bs_icon("question-circle"),
                            paste("The dataset name should be an identifiable name for the dataset that you can",
                                  "reasonably identify. The ideal name is the full expanded name of the dataset",
                                  "that you plan on storing."),
                            placement = "right",
                            options = list(container = "body")))
               )),
               column(width = 12, div(style = "display: flex; align-items: center;",
                 numericInput("update_dataset_vers", label = "Dataset Version:",
                              value = NULL, width = validateCssUnit(500)),

                 # Add the popover manually
                 h1(tooltip(bs_icon("question-circle"),
                            paste("The dataset version number can help differentiate dataset names additionally",
                                    "while also allowing for storing different versions of the same dataset."),
                           placement = "right",
                           options = list(container = "body")))
              )),
            ),
          ),

          # Card for viewing the selected fields
          card(card_header("View Selected Dataset Fields", class = "bg-dark"),
            uiOutput("selected_dataset_fields")
          )
        ),

        fluidRow(
          column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                                 actionButton("update_dataset", "Update Dataset", class = "btn-success"),
          ))
        ),
        HTML("<br>")
      ),
      # abbreviated
      # If the user has no row selected, then we can ADD a new dataset
      conditionalPanel(
        condition = "input.currently_added_datasets_rows_selected <= 0",
        HTML("<br>"),
        h5(strong("Or, Add the Dataset Information & View Uploaded Fields Here:")),

        # Create a column layout for the user inputs and viewable fields
        layout_column_wrap(
          width = 1/2,
          height = 500,

          # Card for the user inputs
          card(card_header("Add Dataset Information", class = "bg-dark"),
           fluidRow(
             column(width = 12, div(style = "display: flex; align-items: center;",
               textAreaInput("add_dataset_code", label = "Dataset Code/File Prefix:", value = "",
                             width = validateCssUnit(500), resize = "none"),

               # Add the popover manually
               h1(tooltip(bs_icon("question-circle"),
                          paste("The dataset code is the prefix of the source dataset that you will be using",
                                "during the data linkage process. The prefix you enter here should match the",
                                "prefix of the file you are using using EXACTLY."),
                          placement = "right",
                          options = list(container = "body")))
             )),
             column(width = 12, div(style = "display: flex; align-items: center;",
               textAreaInput("add_dataset_name", label = "Dataset Name:", value = "",
                             width = validateCssUnit(500), resize = "none"),

               # Add the popover manually
               h1(tooltip(bs_icon("question-circle"),
                          paste("The dataset name should be an identifiable name for the dataset that you can",
                                "reasonably identify. The ideal name is the full expanded name of the dataset",
                                "that you plan on storing."),
                          placement = "right",
                          options = list(container = "body")))
             )),
             column(width = 12, div(style = "display: flex; align-items: center;",
               numericInput("add_dataset_version", label = "Dataset Version:",
                            value = NULL, width = validateCssUnit(500)),

               # Add the popover manually
               h1(tooltip(bs_icon("question-circle"),
                          paste("The dataset version number can help differentiate dataset names additionally",
                                "while also allowing for storing different versions of the same dataset."),
                          placement = "right",
                          options = list(container = "body")))
             )),
             column(width = 12, div(style = "display: flex; align-items: center;",
               fluidRow(
                column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                                        # Label for the uploaded file name
                                        div(style = "margin-right: 10px;", "Linkage File (Field Names):"),
                 )),
                 column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                  # Boxed text output for showing the uploaded file name
                  div(style = "flex-grow: 1; border: 1px solid #ccc; padding: 5px; background-color: #f9f9f9;",
                      textOutput("uploaded_file_name")
                  ),
                  # Upload button
                  actionButton("add_dataset_file", label = "", shiny::icon("upload")), #or use 'upload'

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
          ),
          # Card for viewing the uploaded fields
          card(card_header("View Uploaded Dataset Fields", class = "bg-dark"),
            uiOutput("uploaded_dataset_fields")
          )
        ),

        fluidRow(
          column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
           actionButton("add_dataset", "Add Dataset", class = "btn-success"),
          ))
        ),
        HTML("<br><br>"),
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
      h5(strong("View the Currently Usable Linkage Methods:")),
      h6(p(strong("NOTE: "), "Only one combination of implementation name and technique label can exist at a time.")),
      dataTableOutput("currently_added_linkage_methods"),

      # Line break
      HTML("<br>"),

      # Add linkage method fields here
      h5(strong("Or, Add a New Linkage Method Here:")),
      fluidRow(
        column(width = 3, div(style = "display: flex; align-items: center;",
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
        column(width = 3, div(style = "display: flex; align-items: center;",
          textAreaInput("add_technique_label", label = "Linkage Method:", value = "",
                        width = validateCssUnit(500), resize = "none"),

          # Add the popover manually
          h1(tooltip(bs_icon("question-circle"),
                     paste("Within a linkage implementation, there are various techniques that can be used",
                           "(Deterministic, Probabilistic) and the program will pass to your class which",
                           "technique should be used."),
                     placement = "right",
                     options = list(container = "body")))
        )),
        column(width = 3, div(style = "display: flex; align-items: center;",
          textAreaInput("add_implementation_desc", label = "Implementation Description:", value = "",
                        width = validateCssUnit(500), resize = "none"),

          # Add the popover manually
          h1(tooltip(bs_icon("question-circle"),
                     paste("Short description of the linkage class being created including its method and name."),
                     placement = "right",
                     options = list(container = "body")))
        )),
        column(width = 3, div(style = "display: flex; align-items: center;",
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
      # Two select inputs for choosing which datasets we want to be using
      h5(strong("Select a Left and Right Dataset To View or Add Linkage Algorithms:")),
      h6(p(strong("Note: "), paste("The left and right dataset must be distinct."))),
      fluidRow(
        column(width = 6, div(style = "display: flex; justify-content: right; align-items: right;",
          uiOutput("linkage_algorithm_left_dataset_input"),
        )),
        column(width = 6, div(style = "display: flex; justify-content: left; align-items: left;",
          uiOutput("linkage_algorithm_right_dataset_input"),
        ))
      ),

      # Line break to give the input and table some space
      HTML("<br><br>"),

      # Once the user selects their LEFT and RIGHT dataset, show them the table of linkage algorithms
      conditionalPanel(
        condition = "input.linkage_algorithm_left_dataset != '' && input.linkage_algorithm_right_dataset != ''
                    && input.linkage_algorithm_left_dataset != input.linkage_algorithm_right_dataset",

        # Generate the table
        h5(strong("Select a Row to either Enable/Disable the Algorithm, View/Modify Passes, or View/Modify Ground Truth Variables:")),
        fluidRow(
          column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
            dataTableOutput("currently_added_linkage_algorithms"),
          )),
        ),
        # If a row WAS selected
        conditionalPanel(
          condition = "input.currently_added_linkage_algorithms_rows_selected > 0",
          HTML("<br>"),
          # Create a card for the buttons
          div(style = "display: flex; justify-content: center; align-items: center;",
            card(
              width = 1,
              height = 150,
              full_screen = FALSE,
              card_header("Algorithm Specific Information"),
              card_body(
                fluidRow(
                  column(width = 3, div(style = "display: flex; justify-content: center; align-items: center;",
                      actionButton("toggle_algorithm", "Toggle Selected Algorithm", class = "btn-success"),

                      # Add the popover manually
                      h1(tooltip(bs_icon("question-circle"),
                                 paste("Toggle whether an algorithm is available to be used in data linkage.",
                                       "If an algorithm is Enabled, you may select/view/add/modify linkage passes",
                                       "and ground truth variables for that algorithm, and may also use the algorithm",
                                       "to perform data linkage. If Disabled, the algorithm, and passes will be ignored,",
                                       "and it may not be used for data linkage."),
                                 placement = "right",
                                 options = list(container = "body")
                      ))
                    )
                  ),
                  column(width = 3, div(style = "display: flex; justify-content: center; align-items: center;",
                      actionButton("linkage_algorithms_to_view_linkage_iterations", "Algorithm Passes", class = "btn-warning"),

                      # Add the popover manually
                      h1(tooltip(bs_icon("question-circle"),
                                 paste("View, add, and modify the individual passes for this algorithm."),
                                 placement = "right",
                                 options = list(container = "body")
                      ))
                    )
                  ),
                  column(width = 3, div(style = "display: flex; justify-content: center; align-items: center;",
                      actionButton("linkage_algorithms_to_ground_truth", "Ground Truth Variables", class = "btn-info"),

                      # Add the popover manually
                      h1(tooltip(bs_icon("question-circle"),
                                 paste("View, add, and modify the ground truth variables for this algorithm."),
                                 placement = "right",
                                 options = list(container = "body")
                      ))
                    )
                  ),
                  column(width = 3, div(style = "display: flex; justify-content: center; align-items: center;",
                      actionButton("linkage_algorithms_to_audits", "Saved Performance Measures", class = "btn-info"),

                      # Add the popover manually
                      h1(tooltip(bs_icon("question-circle"),
                                 paste("View and export saved performance measure audits for this algorithm."),
                                 placement = "right",
                                 options = list(container = "body")
                      ))
                    )
                  )
                )
              )
            )
          )
        ),

        # Line break to separate the table and new algorithm input
        HTML("<br><br>"),

        # Conditional panel for if a row wasn't selected
        conditionalPanel(
          condition = "input.currently_added_linkage_algorithms_rows_selected <= 0",
          h5(strong("Or, create an empty linkage algorithm here:")),
          h6(p(strong("Note 1: "), paste("Algorithm name/descriptor must be unique to the algorithm."))),
          h6(p(strong("Note 2: "), paste("One algorithm may be enabled at a time, creating a new algorithm will require you to enable it manually"))),
          fluidRow(
            column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
              textAreaInput("linkage_algorithm_descriptor", label = "Algorithm Name/Descriptor:", value = "",
                            width = validateCssUnit(500), resize = "none"),

              # Add the popover manually
              h1(tooltip(bs_icon("question-circle"),
                         paste("The algorithm name/descriptor is a way to easily identify specific algorithms",
                               "of two datasets. The name should be short, concise, and identifiable for the user."),
                         placement = "right",
                         options = list(container = "body")))
            ))
          ),
          fluidRow(
            column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
              actionButton("add_linkage_algorithm", "Add Linkage Algorithm", class = "btn-success"),
            ))
          )
        ),
        # Conditional panel for if a row was selected
        conditionalPanel(
          condition = "input.currently_added_linkage_algorithms_rows_selected > 0",
          h5(strong("Update linkage algorithm here:")),
          h6(p(strong("Note: "), paste("Algorithm name/descriptor must be unique to the algorithm."))),
          fluidRow(
            column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
              textAreaInput("linkage_algorithm_descriptor_update", label = "Algorithm Name/Descriptor:", value = "",
                            width = validateCssUnit(500), resize = "none"),

              # Add the popover manually
              h1(tooltip(bs_icon("question-circle"),
                         paste("The algorithm name/descriptor is a way to easily identify specific algorithms",
                               "of two datasets. The name should be short, concise, and identifiable for the user."),
                         placement = "right",
                         options = list(container = "body")))
            ))
          ),
          fluidRow(
            column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
              actionButton("update_linkage_algorithm", "Update Linkage Algorithm", class = "btn-success"),
            ))
          )
        )
      ),
    )
  ),
  #----
  #------------------------#

  #-- LINKAGE AUDITS --#
  #----
  nav_panel(title = "Linkage Audits", value = "audits_page",
    fluidPage(
      # Put the back button on this page in the top left corner
      fluidRow(
        column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
          actionButton("linkage_audits_back", "Back", class = "btn-info"),
        ))
      ),

      # Line break to give the back button some space
      HTML("<br>"),

      # Render the data table of currently available iterations
      h5(strong("View The List of Performance Measures, or Select A Row to Export:")),

      # Card for the data table
      div(style = "display: flex; justify-content: center; align-items: center; width: 75%; margin: 0 auto;",
        card(
          full_screen = TRUE,
          height = 500,
          page_fillable(
            dataTableOutput("algorithm_specific_audits"),
          )
        )
      ),
      #dataTableOutput("algorithm_specific_audits"),

      # If NO ROW IS SELECTED, the user can limit results by choosing a range of years
      conditionalPanel(
        condition = "input.algorithm_specific_audits_rows_selected <= 0",

        # UI date range input
        fluidRow(
          column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
              dateRangeInput("audit_date_range", label = "Limit Audit Date Range", start = "1983-01-01", end = NULL),
            )
          ),
        )
      ),

      # If A ROW IS SELECTED, the user can export the results by clicking the button
      conditionalPanel(
        condition = "input.algorithm_specific_audits_rows_selected > 0",
        # Export Audit Button
        fluidRow(
          column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
              actionButton("export_selected_audit", label = "Export Audit", class = "btn-success")
            )
          ),
        )
      )
    )
  ),
  #----
  #--------------------#

  #-- VIEW LINKAGE ITERATIONS --#
  #----
  nav_panel(title = "View Linkage Iterations", value = "view_linkage_iterations_page",
    fluidPage(
      # Put the back button on this page in the top left corner
      fluidRow(
        column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                               actionButton("view_linkage_iterations_back", "Back", class = "btn-info"),
        ))
      ),

      # Line break to give the back button some space
      HTML("<br>"),

      # Render the data table of currently available iterations
      h5(strong("Select An Existing Iteration to Update, or to Enable/Disable:")),
      h6(p(strong("NOTE: "), "Iterations cannot contain the same name.")),
      card(full_screen = TRUE, card_header("Current Iterations", class = "bg-dark"), height = 500,
        dataTableOutput("currently_added_linkage_iterations")
      ),

      # If now row is selected, the user may either create a new iteration, or add a previously used iteration
      # belonging to the same algorithm.
      conditionalPanel(
        condition = "input.currently_added_linkage_iterations_rows_selected <= 0",

        #-- Firstly, the user can create a brand new iteration to add --#

        # Line break between the table
        HTML("<br>"),

        # Create a card for the buttons
        h5(strong("Or, create a brand new linkage iteration from scratch here:")),
        div(style = "display: flex; justify-content: center; align-items: center;",
          card(
            width = 1,
            height = 125,
            full_screen = FALSE,
            card_header("Create New Linkage Iteration", class = "bg-dark"),
            card_body(
              fluidRow(
                column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                    actionButton("add_new_linkage_iteration", "Add New Iteration", class = "btn-success"),
                  )
                ),
              )
            )
          )
        ),

        #-- Or, the user can select from an existing iteration, making any small changes that they'd like --#

        # Line break between the previous card
        HTML("<br>"),

        h5(strong("Or, select a previously used iteration to use here:")),
        # CARD FOR EXISTING LINKAGE ITERATIONS
        card(full_screen = TRUE, card_header("Previously Used Linkage Iterations", class = "bg-dark"), height = 500,
          card_body(
            fluidRow(
              column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                  dataTableOutput("previously_used_iterations"),
                )
              ),
            ),
            # If a row is selected, allow them to review and add the iteration
            conditionalPanel(
              condition = "input.previously_used_iterations_rows_selected > 0",
              fluidRow(
                column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                    actionButton("add_existing_linkage_iteration", "Review And Add Iteration", class = "btn-success"),
                  )
                ),
              )
            )
          )
        )
      ),

      # If a row IS selected, they may modify it, or enable/disable the iteration
      conditionalPanel(
        condition = "input.currently_added_linkage_iterations_rows_selected > 0",

        # Create a card for the buttons
        div(style = "display: flex; justify-content: center; align-items: center;",
          card(
            width = 1,
            height = 125,
            full_screen = FALSE,
            card_header("Iteration Specific Information"),
            card_body(
              fluidRow(
                column(width = 6, div(style = "display: flex; justify-content: right; align-items: center;",
                    actionButton("toggle_linkage_iteration", "Toggle", class = "btn-success"),

                    # Add the popover manually
                    h1(tooltip(bs_icon("question-circle"),
                               paste("Toggle whether an algorithm is available to be used in data linkage.",
                                     "If an algorithm is Enabled, you may select/view/add/modify linkage passes",
                                     "and ground truth variables for that algorithm, and may also use the algorithm",
                                     "to perform data linkage. If Disabled, the algorithm, and passes will be ignored,",
                                     "and it may not be used for data linkage."),
                               placement = "right",
                               options = list(container = "body")
                    ))
                  )
                ),
                column(width = 6, div(style = "display: flex; justify-content: left; align-items: center;",
                    actionButton("modify_linkage_iteration", "Modify", class = "btn-warning"),

                    # Add the popover manually
                    h1(tooltip(bs_icon("question-circle"),
                               paste("Modify the blocking variables, matching variables, and general information",
                                     "of the selected linkage iteration."),
                               placement = "right",
                               options = list(container = "body")
                    ))
                  )
                ),
              )
            )
          )
        )
      )
    )
  ),
  #----
  #-----------------------------#

  #-- ADD LINKAGE ITERATIONS --#
  #----
  nav_panel(title = "Modify Linkage Iterations", value = "add_linkage_iterations_page",
    fluidPage(
      # Render the data table of currently available iterations
      # h5(strong("Select An Existing Iteration to Update, or to Enable/Disable:")),
      # h6(p(strong("NOTE: "), "Iterations cannot contain the same name.")),
      # dataTableOutput("current_linkage_iterations_while_adding"), # do we want to show the current iterations while they make a new one?

      # Line break between the table
      HTML("<br>"),

      # CARD FOR GENERAL INFORMATION
      h5(strong("Step 1: Enter General Information About The Linkage Iteration")),
      h6(p(strong("NOTE: "), "Iterations cannot contain the same name.")),
      card(
        width = 1,
        height = 300,
        full_screen = FALSE,
        card_header("Create New Linkage Iteration", class = "bg-dark"),
        card_body(
          fluidRow(
            column(width = 3, div(style = "display: flex; justify-content: center; align-items: center;",
                textAreaInput("add_iteration_name", label = "Iteration/Pass Name:", value = "",
                              width = validateCssUnit(500), resize = "none"),

                # Add the popover manually
                h1(tooltip(bs_icon("question-circle"),
                           paste("The iteration/pass name is a short descriptor to help identify what was linked",
                                 "on what specific iteration/pass."),
                           placement = "right",
                           options = list(container = "body")))
              )
            ),
            column(width = 3, div(style = "display: flex; justify-content: center; align-items: center;",
                numericInput("add_iteration_order", label = "Iteration Order/Priority:", value = NULL,
                              width = validateCssUnit(500)),

                # Add the popover manually
                h1(tooltip(bs_icon("question-circle"),
                           paste("The iteration order determines the order in which the iterations/passes of",
                                 "the selected algorithm are ran in."),
                           placement = "right",
                           options = list(container = "body")))
              )
            ),
            column(width = 3, div(style = "display: flex; justify-content: center; align-items: center;",
                uiOutput("add_iteration_linkage_method_input"),

                # Add the popover manually
                h1(tooltip(bs_icon("question-circle"),
                           paste("The linkage method determines which class will perform the data linkage process."),
                           placement = "right",
                           options = list(container = "body")))
              )
            ),
            column(width = 3, div(style = "display: flex; justify-content: center; align-items: center;",
                fluidRow(
                  column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                    # Label for the uploaded file name
                    div(style = "margin-right: 10px;", "Acceptance Rule:"),
                  )),
                  column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                    # Boxed text output for showing the uploaded file name
                    div(style = "flex-grow: 1; border: 1px solid #ccc; padding: 5px; background-color: #f9f9f9;",
                        textOutput("selected_iteration_acceptance_rule")
                    ),
                    # Add acceptance rule button
                    actionButton("prepare_iteration_acceptance_rule", label = "", shiny::icon("pencil"), class = "btn-circle btn-green"),
                    # Remove acceptance rule button
                    actionButton("remove_iteration_acceptance_rule", label = "", shiny::icon("eraser"), class = "btn-circle btn-red"),
                  ))
                )
              )
            )
          )
        )
      ),

      # Line break between the previous card
      HTML("<br>"),

      # CARD FOR BLOCKING VARIABLES
      h5(strong("Step 2: Select the Blocking Variables")),
      h6(p(strong("NOTE: "), "Blocking variables cannot contain duplicate pairs.")),
      # CARD FOR BLOCKING VARIABLES
      card(full_screen = TRUE, card_header("Blocking Variables", class = "bg-dark"), height = 400,
        card_body(
          fluidRow(
            column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                dataTableOutput("add_blocking_variables_table"),
              )
            ),
          ),
          # If NO ROW IS SELECTED, allow them to add blocking variables
          conditionalPanel(
            condition = "input.add_blocking_variables_table_rows_selected <= 0",
            fluidRow(
              column(width = 4, div(style = "display: flex; justify-content: right; align-items: center;",
                  uiOutput("add_left_blocking_field_input"),
                )
              ),
              column(width = 4, div(style = "display: flex; justify-content: center; align-items: center;",
                  uiOutput("add_right_blocking_field_input"),
                )
              ),
              column(width = 4, div(style = "display: flex; justify-content: left; align-items: center;",
                  fluidRow(
                    column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                      # Label for the uploaded file name
                      div(style = "margin-right: 10px;", "Linkage Rules:"),
                    )),
                    column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                      # Boxed text output for showing the uploaded file name
                      div(style = "flex-grow: 1; border: 1px solid #ccc; padding: 5px; background-color: #f9f9f9;",
                          textOutput("blocking_linkage_rules_add")
                      ),
                      # Add linkage rule button
                      actionButton("prepare_blocking_linkage_rule", label = "", shiny::icon("pencil"), class = "btn-circle btn-green"),
                      # Remove linkage rule button
                      actionButton("remove_blocking_linkage_rule", label = "", shiny::icon("eraser"), class = "btn-circle btn-red"),
                    ))
                  )
                )
              )
            ),
            fluidRow(
              column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                  actionButton("prepare_blocking_variables", "Add Blocking Variables", class = "btn-success"),
                )
              )
            )
          ),
          # If a row IS selected, allow them to update or drop blocking variables
          conditionalPanel(
            condition = "input.add_blocking_variables_table_rows_selected > 0",
            fluidRow(
              column(width = 4, div(style = "display: flex; justify-content: right; align-items: center;",
                  uiOutput("update_left_blocking_field_input"),
                )
              ),
              column(width = 4, div(style = "display: flex; justify-content: center; align-items: center;",
                  uiOutput("update_right_blocking_field_input"),
                )
              ),
              column(width = 4, div(style = "display: flex; justify-content: left; align-items: center;",
                  fluidRow(
                    column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                      # Label for the uploaded file name
                      div(style = "margin-right: 10px;", "Linkage Rules:"),
                    )),
                    column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                      # Boxed text output for showing the uploaded file name
                      div(style = "flex-grow: 1; border: 1px solid #ccc; padding: 5px; background-color: #f9f9f9;",
                          textOutput("blocking_linkage_rules_update")
                      ),
                      # Add linkage rule button
                      actionButton("prepare_blocking_linkage_rule_update", label = "", shiny::icon("pencil"), class = "btn-circle btn-green"),
                      # Remove linkage rule button
                      actionButton("remove_blocking_linkage_rule_update", label = "", shiny::icon("eraser"), class = "btn-circle btn-red"),
                    ))
                  )
                )
              )
            ),
            fluidRow(
              column(width = 6, div(style = "display: flex; justify-content: right; align-items: center;",
                  actionButton("prepare_blocking_variables_update", "Update Blocking Variables", class = "btn-warning"),
                )
              ),
              column(width = 6, div(style = "display: flex; justify-content: left; align-items: center;",
                  actionButton("drop_blocking_variables", "Drop Blocking Variables", class = "btn-danger"),
                )
              )
            )
          )
        )
      ),

      # LINE BREAK BETWEEN CARDS
      HTML("<br>"),

      # CARD FOR MATCHING VARIABLES
      h5(strong("Step 3: Select the Matching Variables")),
      h6(p(strong("NOTE: "), "Matching variables cannot contain duplicate pairs.")),
      card(full_screen = TRUE, card_header("Matching Variables", class = "bg-dark"), height = 400,
        card_body(
          fluidRow(
            column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                dataTableOutput("add_matching_variables_table"),
              )
            ),
          ),
          # If a row IS NOT selected, allow them to add matching variables
          conditionalPanel(
            condition = "input.add_matching_variables_table_rows_selected <= 0",
            fluidRow(
              column(width = 3, div(style = "display: flex; justify-content: center; align-items: center;",
                  uiOutput("add_left_matching_field_input"),
                )
              ),
              column(width = 3, div(style = "display: flex; justify-content: center; align-items: center;",
                  uiOutput("add_right_matching_field_input"),
                )
              ),
              column(width = 3, div(style = "display: flex; justify-content: center; align-items: center;",
                  fluidRow(
                    column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                      # Label for the uploaded file name
                      div(style = "margin-right: 10px;", "Linkage Rules:"),
                    )),
                    column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                      # Boxed text output for showing the uploaded file name
                      div(style = "flex-grow: 1; border: 1px solid #ccc; padding: 5px; background-color: #f9f9f9;",
                        textOutput("matching_linkage_rules_add")
                      ),
                      # Add linkage rule button
                      actionButton("prepare_matching_linkage_rule", label = "", shiny::icon("pencil"), class = "btn-circle btn-green"),
                      # Remove linkage rule button
                      actionButton("remove_matching_linkage_rule", label = "", shiny::icon("eraser"), class = "btn-circle btn-red"),
                    ))
                  )
                )
              ),
              column(width = 3, div(style = "display: flex; justify-content: center; align-items: center;",
                  fluidRow(
                    column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                      # Label for the uploaded file name
                      div(style = "margin-right: 10px;", "Comparison Rules:"),
                    )),
                    column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                      # Boxed text output for showing the uploaded file name
                      div(style = "flex-grow: 1; border: 1px solid #ccc; padding: 5px; background-color: #f9f9f9;",
                          textOutput("matching_comparison_rules_add")
                      ),
                      # Add comparison rule button
                      actionButton("prepare_matching_comparison_rule", label = "", shiny::icon("pencil"), class = "btn-circle btn-green"),
                      # Remove comparison rule button
                      actionButton("remove_matching_comparison_rule", label = "", shiny::icon("eraser"), class = "btn-circle btn-red"),
                    ))
                  )
                )
              )
            ),
            fluidRow(
              column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                  actionButton("prepare_matching_variables", "Add Matching Variables", class = "btn-success"),
                )
              )
            )
          ),
          # If a row IS selected, allow them to update or drop matching variables
          conditionalPanel(
            condition = "input.add_matching_variables_table_rows_selected > 0",
            fluidRow(
              column(width = 3, div(style = "display: flex; justify-content: center; align-items: center;",
                  uiOutput("update_left_matching_field_input"),
                )
              ),
              column(width = 3, div(style = "display: flex; justify-content: center; align-items: center;",
                  uiOutput("update_right_matching_field_input"),
                )
              ),
              column(width = 3, div(style = "display: flex; justify-content: center; align-items: center;",
                  fluidRow(
                    column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                      # Label for the uploaded file name
                      div(style = "margin-right: 10px;", "Linkage Rules:"),
                    )),
                    column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                      # Boxed text output for showing the uploaded file name
                      div(style = "flex-grow: 1; border: 1px solid #ccc; padding: 5px; background-color: #f9f9f9;",
                          textOutput("matching_linkage_rules_update")
                      ),
                      # Add linkage rule button
                      actionButton("prepare_matching_linkage_rule_update", label = "", shiny::icon("pencil"), class = "btn-circle btn-green"),
                      # Remove linkage rule button
                      actionButton("remove_matching_linkage_rule_update", label = "", shiny::icon("eraser"), class = "btn-circle btn-red"),
                    ))
                  )
                )
              ),
              column(width = 3, div(style = "display: flex; justify-content: center; align-items: center;",
                  fluidRow(
                    column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                      # Label for the uploaded file name
                      div(style = "margin-right: 10px;", "Comparison Rules:"),
                    )),
                    column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                      # Boxed text output for showing the uploaded file name
                      div(style = "flex-grow: 1; border: 1px solid #ccc; padding: 5px; background-color: #f9f9f9;",
                          textOutput("matching_comparison_rules_update")
                      ),
                      # Add comparison rule button
                      actionButton("prepare_matching_comparison_rule_update", label = "", shiny::icon("pencil"), class = "btn-circle btn-green"),
                      # Remove comparison rule button
                      actionButton("remove_matching_comparison_rule_update", label = "", shiny::icon("eraser"), class = "btn-circle btn-red"),
                    ))
                  )
                )
              )
            ),
            fluidRow(
              column(width = 6, div(style = "display: flex; justify-content: right; align-items: center;",
                  actionButton("prepare_matching_variables_update", "Update Matching Variables", class = "btn-warning"),
                )
              ),
              column(width = 6, div(style = "display: flex; justify-content: left; align-items: center;",
                  actionButton("drop_matching_variables", "Drop Matching Variables", class = "btn-danger"),
                )
              )
            )
          )
        )
      ),

      # Two buttons for returning w/out saving, and for adding the new iteration
      fluidRow(
        column(width = 6, div(style = "display: flex; justify-content: right; align-items: center;",
            actionButton("return_from_add_iterations", "Return Without Saving", class = "btn-danger"),
          )
        ),
        column(width = 6, div(style = "display: flex; justify-content: left; align-items: center;",
            actionButton("save_iteration", "Save and Modify Iteration", class = "btn-success"),
          )
        ),
      ),

      # Final line break
      HTML("<br><br>")
    )
  ),
  #----
  #----------------------------#

  #-- GROUND TRUTH VARIABLES PAGE --#
  #----
  nav_panel(title = "Ground Truth Variables", value = "ground_truth_variables_page",
    fluidPage(
      # Put the back button on this page in the top left corner
      fluidRow(
        column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
          actionButton("modify_ground_truth_back", "Back", class = "btn-info"),
        ))
      ),

      # Line break to give the back button some space
      HTML("<br>"),

      # Render the data table of this algorithms ground truth variables
      h5(strong("Select A Pair of Ground Truth Variables to Drop:")),
      h6(p(strong("NOTE: "), "No duplicate ground truth pairs are allowed.")),
      dataTableOutput("currently_added_ground_truth_variables"),

      # If now row is selected, the user can enter a new pair of ground truth variables + linkage rules
      conditionalPanel(
        condition = "input.currently_added_ground_truth_variables_rows_selected <= 0",

        # Show a card input here which will allow users to select a left field, right field, and linkage rule to add
        card(width = 1, height = 350, full_screen = FALSE, card_header("Add Ground Truth Variables"),
          fluidPage(
            fluidRow(
              column(width = 3, div(style = "display: flex; justify-content: center; align-items: center;",
                  uiOutput("ground_truth_left_field_input"),
                )
              ),
              column(width = 3, div(style = "display: flex; justify-content: center; align-items: center;",
                  uiOutput("ground_truth_right_field_input"),
                )
              ),
              column(width = 3, div(style = "display: flex; justify-content: center; align-items: center;",
                  fluidRow(
                    column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                      # Label for the uploaded file name
                      div(style = "margin-right: 10px;", "Linkage Rule:"),
                    )),
                    column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                      # Boxed text output for showing the uploaded file name
                       div(style = "flex-grow: 1; border: 1px solid #ccc; padding: 5px; background-color: #f9f9f9;",
                          textOutput("selected_ground_truth_linkage_rule")
                      ),
                      # Add linkage rule button
                      actionButton("prepare_ground_truth_linkage_rule", label = "", shiny::icon("pencil"), class = "btn-circle btn-green"),
                      # Remove linkage rule button
                      actionButton("remove_ground_truth_linkage_rule", label = "", shiny::icon("eraser"), class = "btn-circle btn-red"),
                    ))
                  )
                )
              ),
              column(width = 3, div(style = "display: flex; justify-content: center; align-items: center;",
                  actionButton("add_ground_truth", "Add Ground Truth Pair", class = "btn-success"),
                )
              )
            )
          )
        )
      ),
      # If a row is selected, the user can drop the selected pair of ground truth variables
      conditionalPanel(
        condition = "input.currently_added_ground_truth_variables_rows_selected > 0",

        # Show a card for users to drop the selected row
        card(width = 0.25, max_height = 125, full_screen = FALSE, card_header("Drop Ground Truth Variables"),
          fluidPage(
            column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                actionButton("drop_ground_truth", "Drop Ground Truth Pair", class = "btn-danger"),
              )
            )
          )
        )
      )
    )
  ),
  #----
  #---------------------------------#

  #-- ACCEPTANCE METHODS PAGE --#
  #----
  nav_panel(title = "Acceptance Methods", value = "acceptance_methods_page",
    fluidPage(
      # Put the back button on this page in the top left corner
      fluidRow(
        column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                               actionButton("acceptance_methods_back", "Back", class = "btn-info"),
        ))
      ),

      # Line break to give the back button some space
      HTML("<br>"),

      # Generate the table
      h5(strong("Select an Existing Method To Update or Add a Rule To:")),
      h6(p(strong("NOTE: "), "No acceptance methods can share the same the same name, and no parameters can share the same name within methods.")),
      dataTableOutput("currently_added_acceptance_methods_and_parameters"),

      # Line break
      HTML("<br>"),

      # If no row is selected, the user can enter a new method and parameters
      conditionalPanel(
        condition = "input.currently_added_acceptance_methods_and_parameters_rows_selected <= 0",

        h5(strong("Or, Add a New Acceptance Method and Parameters Here:")),
        layout_column_wrap(
          width = 1/2,
          height = 500,
          # CARD FOR ACCEPTANCE METHOD INFO
          card(full_screen = TRUE, card_header("Acceptance Method General Information", class = "bg-dark",
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
          card(full_screen = TRUE, card_header("Acceptance Method Parameter Information", class = "bg-dark",
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
        ),
        # Final line break
        HTML("<br><br>")
      ),
      # If a row is selected, you may update the acceptance method name, descriptions + parameter names and description.
      # You are, however, unable to delete parameter keys or acceptance methods after they've been created.
      # You may also click a button which brings you to a page for adding a new rule
      conditionalPanel(
        condition = "input.currently_added_acceptance_methods_and_parameters_rows_selected > 0",

        h5(strong("Update the Selected Acceptance Method and Parameters Here:")),
        layout_column_wrap(
          width = 1/2,
          height = 500,
          # CARD FOR ACCEPTANCE METHOD INFO
          card(full_screen = TRUE, card_header("Acceptance Method General Information", class = "bg-dark",
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
          card(full_screen = TRUE, card_header("Acceptance Method Parameter Information", class = "bg-dark",
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
        ),
        # Final line break
        HTML("<br><br>")
      )
    )
  ),
  #----
  #-----------------------------#

  #-- ACCEPTANCE RULES PAGE --#
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
        card(max_height = 300, full_screen = TRUE, card_header("Acceptance Rules Parameter Values", class = "bg-dark",
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
          actionButton("add_acceptance_rule", "Submit Acceptance Rule Values", class = "btn-success"),
        ))
      ),
      HTML("<br><br>")
    )
  ),
  #----
  #---------------------------#

  #-- COMPARISON METHODS PAGE --#
  #----
  nav_panel(title = "Comparison Methods", value = "comparison_methods_page",
    fluidPage(
      # Put the back button on this page in the top left corner
      fluidRow(
        column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                               actionButton("comparison_methods_back", "Back", class = "btn-info"),
        ))
      ),

      # Line break to give the back button some space
      HTML("<br>"),

      # Generate the table
      h5(strong("Select an Existing Method To Update or Add a Rule To:")),
      h6(p(strong("NOTE: "), "No comparison methods can share the same the same name, and no parameters can share the same name within methods.")),
      dataTableOutput("currently_added_comparison_methods_and_parameters"),

      # Line break
      HTML("<br>"),

      # If no row is selected, the user can enter a new method and parameters
      conditionalPanel(
        condition = "input.currently_added_comparison_methods_and_parameters_rows_selected <= 0",

        h5(strong("Or, Add a New Comparison Method and Parameters Here:")),
        layout_column_wrap(
          width = 1/2,
          height = 500,
          # CARD FOR ACCEPTANCE METHOD INFO
          card(full_screen = TRUE, card_header("Comparison Method General Information", class = "bg-dark",
                                   tooltip(bs_icon("question-circle"),
                                           paste("Within this card, you can enter general information about the comparison",
                                                 "method that you want to add, which includes the name of the method and a",
                                                 "short description of what the expected values are."),
                                           placement = "right",
                                           options = list(container = "body"))),
             fluidPage(
               fluidRow(
                 column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                    textAreaInput("add_comparison_method_name", label = "Comparison Method Name:", value = "",
                                  width = validateCssUnit(500), resize = "none"),

                    # Add the popover manually
                    h1(tooltip(bs_icon("question-circle"),
                               paste("The comparison method name should be descriptive and easy to identify for",
                                     "later linkage iteration and comparison rule creation."),
                               placement = "right",
                               options = list(container = "body")))
                 )),
                 column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                    textAreaInput("add_comparison_method_desc", label = "Comparison Method Description:", value = "",
                                  width = validateCssUnit(500), resize = "none"),

                    # Add the popover manually
                    h1(tooltip(bs_icon("question-circle"),
                               paste("The comparison method description should be short and concise, and should",
                                     "detail the expected inputs for the parameters and how the comparison method",
                                     "would work."),
                               placement = "right",
                               options = list(container = "body")))
                 ))
               )
             )
          ),

          # CARD FOR ACCEPTANCE PARAMETER INFO
          card(full_screen = TRUE, card_header("Comparison Method Parameter Information", class = "bg-dark",
                                   tooltip(bs_icon("question-circle"),
                                           paste("Within this card, you can add parameters that belong to the comparison method",
                                                 "you are wanting to add, each parameter consists of a key which is how it would",
                                                 "called from R, and a short description of the parameter. You may add as many",
                                                 "parameters as you would like for the method being constructed."),
                                           placement = "right",
                                           options = list(container = "body"))),
             fluidPage(
               # Generate the table
               h5(strong("Parameters to be Added:")),
               h6(p(strong("NOTE: "), "No parameters can share the same name.")),
               dataTableOutput("comparison_parameters_to_add"),

               # IF NO ROW IS SELECTED, STORE A PARAMETER THAT IS TO BE ADDED
               conditionalPanel(
                 condition = "input.comparison_parameters_to_add_rows_selected <= 0",
                 fluidRow(
                   column(width = 6, div(style = "display: flex; justify-content: right; align-items: center;",
                     textAreaInput("add_comparison_parameter_key", label = "Comparison Parameter Key:", value = "",
                                   width = validateCssUnit(500), resize = "none"),

                     # Add the popover manually
                     h1(tooltip(bs_icon("question-circle"),
                                paste("The comparison parameter key should be separated by underscores, and is how",
                                      "you would expect to retrieve the parameter value from this key value pair label."),
                                placement = "right",
                                options = list(container = "body")))
                   )),
                   column(width = 6, div(style = "display: flex; justify-content: left; align-items: center;",
                     textAreaInput("add_comparison_parameter_desc", label = "Comparison Parameter Description:", value = "",
                                   width = validateCssUnit(500), resize = "none"),

                     # Add the popover manually
                     h1(tooltip(bs_icon("question-circle"),
                                paste("The comparison parameter description should be brief and should explain how each",
                                      "key is used during data linkage and what values it should expect."),
                                placement = "right",
                                options = list(container = "body")))
                   ))
                 ),
                 fluidRow(
                   column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                     actionButton("prepare_comparison_method_parameters_to_add", "Add Comparison Parameter", class = "btn-warning"),
                   ))
                 )
               ),
               # IF A ROW IS SELECTED, ALLOW IT TO BE UPDATED OR DROPPED
               conditionalPanel(
                 condition = "input.comparison_parameters_to_add_rows_selected > 0",
                 fluidRow(
                   column(width = 6, div(style = "display: flex; justify-content: right; align-items: center;",
                     textAreaInput("update_comparison_parameter_key", label = "Update Parameter Key:", value = "",
                                   width = validateCssUnit(500), resize = "none"),

                     # Add the popover manually
                     h1(tooltip(bs_icon("question-circle"),
                                paste("The comparison parameter key should be separated by underscores, and is how",
                                      "you would expect to retrieve the parameter value from this key value pair label."),
                                placement = "right",
                                options = list(container = "body")))
                   )),
                   column(width = 6, div(style = "display: flex; justify-content: left; align-items: center;",
                     textAreaInput("update_comparison_parameter_desc", label = "Update Parameter Description:", value = "",
                                   width = validateCssUnit(500), resize = "none"),

                     # Add the popover manually
                     h1(tooltip(bs_icon("question-circle"),
                                paste("The comparison parameter description should be brief and should explain how each",
                                      "key is used during data linkage and what values it should expect."),
                                placement = "right",
                                options = list(container = "body")))
                   ))
                 ),
                 fluidRow(
                   column(width = 6, div(style = "display: flex; justify-content: right; align-items: right;",
                     actionButton("update_prepared_comparison_method_parameters_to_add", "Update Comparison Parameter", class = "btn-warning"),
                   )),
                   column(width = 6, div(style = "display: flex; justify-content: left; align-items: left;",
                     actionButton("drop_prepared_comparison_method_parameters_to_add", "Drop Comparison Parameter", class = "btn-danger"),
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
            actionButton("add_comparison_method_and_parameters", "Add Comparison Method & Parameters", class = "btn-success"),
          ))
        ),
        # Final line break
        HTML("<br><br>")
      ),
      # If a row is selected, you may update the comparison method name, descriptions + parameter names and description.
      # You are, however, unable to delete parameter keys or comparison methods after they've been created.
      # You may also click a button which brings you to a page for adding a new rule
      conditionalPanel(
        condition = "input.currently_added_comparison_methods_and_parameters_rows_selected > 0",

        h5(strong("Update the Selected Comparison Method and Parameters Here:")),
        layout_column_wrap(
          width = 1/2,
          height = 500,
          # CARD FOR ACCEPTANCE METHOD INFO
          card(full_screen = TRUE, card_header("Comparison Method General Information", class = "bg-dark",
                                   tooltip(bs_icon("question-circle"),
                                           paste("Within this card, you can enter general information about the comparison",
                                                 "method that you want to add, which includes the name of the method and a",
                                                 "short description of what the expected values are."),
                                           placement = "right",
                                           options = list(container = "body"))),
             fluidPage(
               fluidRow(
                 column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                    textAreaInput("update_comparison_method_name", label = "Comparison Method Name:", value = "",
                                  width = validateCssUnit(500), resize = "none"),

                    # Add the popover manually
                    h1(tooltip(bs_icon("question-circle"),
                               paste("The comparison method name should be descriptive and easy to identify for",
                                     "later linkage iteration and comparison rule creation."),
                               placement = "right",
                               options = list(container = "body")))
                 )),
                 column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                    textAreaInput("update_comparison_method_desc", label = "Comparison Method Description:", value = "",
                                  width = validateCssUnit(500), resize = "none"),

                    # Add the popover manually
                    h1(tooltip(bs_icon("question-circle"),
                               paste("The comparison method description should be short and concise, and should",
                                     "detail the expected inputs for the parameters and how the comparison method",
                                     "would work."),
                               placement = "right",
                               options = list(container = "body")))
                 ))
               )
             )
          ),

          # CARD FOR ACCEPTANCE PARAMETER INFO
          card(full_screen = TRUE, card_header("Comparison Method Parameter Information", class = "bg-dark",
                                   tooltip(bs_icon("question-circle"),
                                           paste("Within this card, you can add parameters that belong to the comparison method",
                                                 "you are wanting to add, each parameter consists of a key which is how it would",
                                                 "called from R, and a short description of the parameter. You may add as many",
                                                 "parameters as you would like for the method being constructed."),
                                           placement = "right",
                                           options = list(container = "body"))),
             fluidPage(
               # Generate the table
               h5(strong("Parameters to be Updated (Select a Row to Update the Key and Description):")),
               h6(p(strong("NOTE: "), "No parameters can share the same name.")),
               dataTableOutput("comparison_parameters_to_update"),

               # IF A ROW IS SELECTED, ALLOW IT TO BE UPDATED
               conditionalPanel(
                 condition = "input.comparison_parameters_to_update_rows_selected > 0",
                 fluidRow(
                   column(width = 6, div(style = "display: flex; justify-content: right; align-items: center;",
                     textAreaInput("comparison_parameter_key_update", label = "Update Parameter Key:", value = "",
                                   width = validateCssUnit(500), resize = "none"),

                     # Add the popover manually
                     h1(tooltip(bs_icon("question-circle"),
                                paste("The comparison parameter key should be separated by underscores, and is how",
                                      "you would expect to retrieve the parameter value from this key value pair label."),
                                placement = "right",
                                options = list(container = "body")))
                   )),
                   column(width = 6, div(style = "display: flex; justify-content: left; align-items: center;",
                     textAreaInput("comparison_parameter_desc_update", label = "Update Parameter Description:", value = "",
                                   width = validateCssUnit(500), resize = "none"),

                     # Add the popover manually
                     h1(tooltip(bs_icon("question-circle"),
                                paste("The comparison parameter description should be brief and should explain how each",
                                      "key is used during data linkage and what values it should expect."),
                                placement = "right",
                                options = list(container = "body")))
                   ))
                 ),
                 fluidRow(
                   column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                     actionButton("update_prepared_comparison_method_parameters_to_update", "Update Comparison Parameter", class = "btn-warning"),
                   )),
                 )
               )
             )
          )
        ),
        HTML("<br>"),
        # After the user finishes adding everything they need, they can update the comparison method & parameters
        fluidRow(
          column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                                 actionButton("update_comparison_method_and_parameters", "Update Comparison Method & Parameters", class = "btn-success"),
          ))
        ),
        # Final line break
        HTML("<br><br>")
      )
    )
  ),
  #----
  #-----------------------------#

  #-- COMPARISON RULES PAGE --#
  #----
  nav_panel(title = "Comparison Rules", value = "comparison_rules_page",
    fluidPage(
      # Put the back button on this page in the top left corner
      fluidRow(
        column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
          actionButton("comparison_rules_back", "Back", class = "btn-info"),
        ))
      ),

      # Line break to give the back button some breathing room
      HTML("<br><br>"),

      # Generate the table
      h5(strong("View From the Table of Existing Rules & Create a New Rule Below:")),
      dataTableOutput("currently_added_comparison_rules"),

      # Small line break
      HTML("<br><br>"),
      div(style = "display: flex; justify-content: center; align-items: center;",
          # CARD FOR COMPARISON RULES
          card(max_height = 300, full_screen = TRUE, card_header("Comparison Rules Parameter Values", class = "bg-dark",
               tooltip(bs_icon("question-circle"),
                       paste("Within this card, you can enter your desired values for the comparison",
                             "rule that you would like to use for future linkage iterations. All inputs",
                             "must be filled and should follow the descriptions listed by each parameter",
                             "to ensure that the linkage process is successful using your values."),
                       placement = "right",
                       options = list(container = "body"))),
           fluidPage(
             fluidRow(
               column(width = 12, uiOutput("comparison_rules_inputs"))
             )
           )
        ),
      ),
      fluidRow(
        column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
          actionButton("add_comparison_rule", "Submit Comparison Rule Values", class = "btn-success"),
        ))
      ),
      HTML("<br><br>")
    )
  ),
  #----
  #---------------------------#

  #-- LINKAGE RULES PAGE --#
  #----
  nav_panel(title = "Linkage Rules", value = "linkage_rule_page",
    fluidPage(
      # Put the back button on this page in the top left corner
      fluidRow(
        column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                               actionButton("linkage_rules_back", "Back", class = "btn-info"),
        ))
      ),

      # Line break to give the back button some breathing room
      HTML("<br><br>"),

      # Generate the table
      h5(strong("View From the Table of Existing Rules & Create a New Rule Below:")),
      h6(p(strong("Note: "), paste("A rule cannot contain both numerical AND string rules, it can contain one or the other."))),
      dataTableOutput("currently_added_linkage_rules"),

      # Small line break
      HTML("<br><br>"),

      # Fluid row for the 4 inputs (alternate field, date variance, substring length, and name standardization)
      fluidRow(
        column(width = 3, div(style = "display: flex; justify-content: center; align-items: center;",
          numericInput("add_alternate_field_number", label = "Alternative Field Value:",
                       value = NULL, width = validateCssUnit(500)),

          # Add the popover manually
          h1(tooltip(bs_icon("question-circle"),
                     paste("The alternative field number should be a positive number greater than 1, and is",
                           "used to select which alternative value to use in place of the original value when",
                           "performing blocking or matching."),
                     placement = "right",
                     options = list(container = "body")))
        )),
        column(width = 3, div(style = "display: flex; justify-content: center; align-items: center;",
          numericInput("add_integer_value_variance", label = "Integer Value Variance:",
                       value = NULL, width = validateCssUnit(500)),

          # Add the popover manually
          h1(tooltip(bs_icon("question-circle"),
                     paste("The integer value variance should be a positive number greater than 0, and is",
                           "used for date related fields. The number entered will be used to block on the",
                           "original value, as well as plus and minus the integer you added to obtain a range",
                           "of dates. Used for blocking keys primarily."),
                     placement = "right",
                     options = list(container = "body")))
        )),
        column(width = 3, div(style = "display: flex; justify-content: center; align-items: center;",
          numericInput("add_substring_length", label = "Substring Length:",
                       value = NULL, width = validateCssUnit(500)),

          # Add the popover manually
          h1(tooltip(bs_icon("question-circle"),
                     paste("The substring length should be a positive number greater than 0, and is",
                           "used to block or match on the first certain number of characters in a name."),
                     placement = "right",
                     options = list(container = "body")))
        )),
        column(width = 3, div(style = "display: flex; justify-content: center; align-items: center;",
          selectInput("add_name_standardization", label = "Standardize Names?",
                      choices = list("No" = 1,
                                     "Yes" = 2),
                      selected = 1,
                      width = validateCssUnit(500)),

          # Add the popover manually
          h1(tooltip(bs_icon("question-circle"),
                     paste("If names are to be standardized, variations of names are converted to the most",
                           "common spelling of that name. You must provide a CSV file when you begin the linkage",
                           "process containing a column of the variant spellings, titled START, and a column",
                           "of the common spelling it maps to, titled LABEL. A default CSV is provided on",
                           "GitHub."),
                     placement = "right",
                     options = list(container = "body")))
        ))
      ),

      # Submit Linkage Rule Button
      fluidRow(
        column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
          actionButton("add_linkage_rule", "Submit Linkage Rule Values", class = "btn-success"),
        ))
      ),
    )
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
  nav_hide('main_navbar', 'view_linkage_iterations_page')
  nav_hide('main_navbar', 'add_linkage_iterations_page')
  nav_hide('main_navbar', 'update_linkage_iterations_page')
  nav_hide('main_navbar', 'acceptance_methods_page')
  nav_hide('main_navbar', 'comparison_methods_page')
  nav_hide('main_navbar', 'ground_truth_variables_page')
  nav_hide('main_navbar', 'audits_page')

  # If the user goes off of an inner tab, hide it
  observeEvent(input$main_navbar, {
    # Get the tabs that are not necessary for the user
    tabs_to_hide <- c("linkage_rule_page", "acceptance_rules_page", "comparison_rules_page",
                      "view_linkage_iterations_page", "add_linkage_iterations_page", "update_linkage_iterations_page",
                      "acceptance_methods_page", "comparison_methods_page", "ground_truth_variables_page", "audits_page")
    selected_panel <- input$main_navbar

    # Hide the page if its not the one you're currently on
    for(tab in tabs_to_hide){
      if(selected_panel != tab){
        nav_hide('main_navbar', tab)
      }
    }

    # Remove the modal
    removeModal()
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
    dt <- datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE, dom = 'tp'))
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
      column_names <<- c()
    })

    # Return the extracted column names
    return(column_names)
  }

  # Renders the Data table of currently added datasets
  output$currently_added_datasets <- renderDataTable({
    get_datasets()
  })

  # Renders the selected dataset fields based on what dataset the user selected
  output$selected_dataset_fields <- renderUI({
    # Get the selected row
    selected_row <- input$currently_added_datasets_rows_selected

    # Make sure the row is not null
    if(is.null(selected_row)) return()

    # Query to get the dataset ID
    df <- dbGetQuery(linkage_metadata_conn, paste('SELECT * from datasets
                                                ORDER BY dataset_id ASC'))

    selected_dataset_id <- df[selected_row, "dataset_id"]

    # Query to get the field names
    df <- dbGetQuery(linkage_metadata_conn, paste('SELECT * from dataset_fields
                                                WHERE dataset_id =', selected_dataset_id,
                                                'ORDER BY field_id ASC'))

    field_names <- df$field_name

    # Create a tag list for the field names
    if (length(field_names) == 0) {
      return(HTML("<p>No columns found under this dataset.</p>"))
    } else {
      tagList(
        HTML("<b>The Selected Dataset Fields Are:</b>"),
        div(class = "dataset-field-box",  # Add the custom class here
          tags$ul(
            lapply(field_names, function(col) {
              tags$li(col)  # Each column as a list item
            })
          )
        )
      )
    }
  })

  # Renders the uploaded dataset fields based on the file the user provided
  output$uploaded_dataset_fields <- renderUI({
    field_names <- read_dataset_columns(file_path$path)

    if (is.null(field_names) || length(field_names) == 0) {
      return(HTML("<p>No columns found or unsupported file format.</p>"))
    } else {
      tagList(
        HTML("<b>The Uploaded Dataset Fields Are:</b>"),
        div(class = "dataset-field-box",  # Add the custom class here
          tags$ul(
            lapply(field_names, function(col) {
              tags$li(col)  # Each column as a list item
            })
          )
        )
      )
    }
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
    output$linkage_algorithm_left_dataset_input <- renderUI({
      get_left_datasets_linkage_algorithms()
    })

    # Renders the UI for the right dataset select input
    output$linkage_algorithm_right_dataset_input <- renderUI({
      get_right_datasets_linkage_algorithms()
    })

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
    if(is.null(dataset_cols) || length(dataset_cols) == 0) {
      showNotification("Failed to Add Dataset - Invalid Input File", type = "error", closeButton = FALSE)
      return()
    }
    #----#

    successful <- TRUE

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
      successful <<- FALSE
      dbRollback(linkage_metadata_conn)
      showNotification("Failed to Add Dataset - An Error Occurred While Inserting", type = "error", closeButton = FALSE)
      return()
    })

    # If we didn't successfully add the dataset, then return
    if(successful == FALSE) return()

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
    output$linkage_algorithm_left_dataset_input <- renderUI({
      get_left_datasets_linkage_algorithms()
    })
    output$linkage_algorithm_right_dataset_input <- renderUI({
      get_right_datasets_linkage_algorithms()
    })
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
    updateNumericInput(session,  "update_dataset_vers",    value = NA)
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
    names(df)[names(df) == 'technique_label'] <- 'Linkage Method'
    names(df)[names(df) == 'implementation_desc'] <- 'Implementation Description'
    names(df)[names(df) == 'version'] <- 'Version'

    # Drop the linkage_method_id value
    df <- subset(df, select = -c(linkage_method_id))

    # Reorder the columns so they're easier to read
    df <- df[, c('Implementation Name', 'Linkage Method', 'Implementation Description', 'Version')]

    # Put it into a data table now
    dt <- datatable(df, selection = 'none', rownames = FALSE, options = list(lengthChange = FALSE, dom = 'tp'))
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
    implementation_desc <- input$add_implementation_desc
    technique_label     <- input$add_technique_label
    implementation_vers <- input$add_implementation_vers
    #----#

    # Error check to verify that an exact match doesn't exist
    #----#
    # Verify inputs are good
    if(implementation_name == "" || technique_label == "" || is.na(implementation_vers)){
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
    new_entry_query <- paste("INSERT INTO linkage_methods (implementation_name, technique_label, implementation_desc, version)",
                             "VALUES(?, ?, ?);")
    new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
    dbBind(new_entry, list(implementation_name, technique_label, implementation_desc, implementation_vers))
    dbClearResult(new_entry)
    #----#

    # Update user input fields to make them blank!
    #----#
    updateTextAreaInput(session, "add_implementation_name", value = "")
    updateTextAreaInput(session, "add_implementation_desc", value = "")
    updateTextAreaInput(session, "add_technique_label",     value = "")
    updateNumericInput(session,  "add_implementation_vers", value = NA)
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

  #-- LINKAGE ALGORITHMS PAGE EVENTS --#
  #----
  # Brings the user to view the selected linkage algorithm and its iterations
  observeEvent(input$linkage_algorithms_to_view_linkage_iterations, {
    # Get the selected row
    left_dataset_id  <- input$linkage_algorithm_left_dataset
    right_dataset_id <- input$linkage_algorithm_right_dataset
    selected_row     <- input$currently_added_linkage_algorithms_rows_selected
    df <- dbGetQuery(linkage_metadata_conn, paste('SELECT * from linkage_algorithms
                                                WHERE dataset_id_left =', left_dataset_id, 'AND dataset_id_right =', right_dataset_id,
                                                  'ORDER BY algorithm_id ASC'))

    # Grab the algorithm id
    algorithm_id <- df[selected_row, "algorithm_id"]

    # Update the global variable for the acceptance method id and the return page
    view_linkage_iterations_algorithm_id     <<- algorithm_id
    view_linkage_iterations_left_dataset_id  <<- left_dataset_id
    view_linkage_iterations_right_dataset_id <<- right_dataset_id
    view_linkage_iterations_return_page      <<- "linkage_algorithms_page"

    # Update the table of iterations on that page
    output$currently_added_linkage_iterations <- renderDataTable({
      get_linkage_iterations_view()
    })
    output$previously_used_iterations <- renderDataTable({
      get_linkage_iterations_add_existing()
    })

    # Show the iterations page
    nav_show('main_navbar', 'view_linkage_iterations_page')
    updateNavbarPage(session, "main_navbar", selected = "view_linkage_iterations_page")
  })

  # Creates the select input UI for the left dataset
  get_left_datasets_linkage_algorithms <- function(){

    # Perform query using linkage_metadata_conn
    query_result <- dbGetQuery(linkage_metadata_conn, "SELECT dataset_name, dataset_id FROM datasets where enabled_for_linkage = 1")

    # Extract columns from query result
    choices <- setNames(query_result$dataset_id, query_result$dataset_name)

    # Create select input with dynamic choices
    span(selectizeInput("linkage_algorithm_left_dataset", label = "Left Dataset:",
                     choices = choices, multiple = FALSE, width = validateCssUnit(500),
                     options = list(
                       placeholder = 'Select a Left Dataset',
                       onInitialize = I('function() { this.setValue(""); }')
                     )))
  }

  # Creates the select input UI for the left dataset
  get_right_datasets_linkage_algorithms <- function(){

    # Perform query using linkage_metadata_conn
    query_result <- dbGetQuery(linkage_metadata_conn, "SELECT dataset_name, dataset_id FROM datasets where enabled_for_linkage = 1")

    # Extract columns from query result
    choices <- setNames(query_result$dataset_id, query_result$dataset_name)

    # Create select input with dynamic choices
    span(selectizeInput("linkage_algorithm_right_dataset", label = "Right Dataset:",
                     choices = choices, multiple = FALSE, width = validateCssUnit(500),
                     options = list(
                       placeholder = 'Select a Right Dataset',
                       onInitialize = I('function() { this.setValue(""); }')
                     )))
  }

  # Renders the UI for the left dataset select input
  output$linkage_algorithm_left_dataset_input <- renderUI({
    get_left_datasets_linkage_algorithms()
  })

  # Renders the UI for the right dataset select input
  output$linkage_algorithm_right_dataset_input <- renderUI({
    get_right_datasets_linkage_algorithms()
  })

  # Query and output for getting the selected linkage algorithms
  get_linkage_algorithms <- function(){
    left_dataset_id  <- input$linkage_algorithm_left_dataset
    right_dataset_id <- input$linkage_algorithm_right_dataset

    # Convert the dataset IDs to numeric
    left_dataset_id <- as.numeric(left_dataset_id)
    right_dataset_id <- as.numeric(right_dataset_id)

    # Make sure the dataset IDs aren't NA
    if(is.na(left_dataset_id) || is.na(right_dataset_id)){
      return()
    }

    # Query to get all linkage method information from the 'linkage_methods' table
    query <- paste('SELECT * FROM linkage_algorithms
                WHERE dataset_id_left =', left_dataset_id, ' AND dataset_id_right =', right_dataset_id,
                   'ORDER BY algorithm_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    # With our data frame, we'll rename some of the columns to look better
    names(df)[names(df) == 'algorithm_name'] <- 'Algorithm Name'
    names(df)[names(df) == 'modified_date'] <- 'Modified Date'
    names(df)[names(df) == 'modified_by'] <- 'Modified By'
    names(df)[names(df) == 'enabled'] <- 'Enabled'

    # With algorithms, we'll replace the enabled [0, 1] with [No, Yes]
    df$Enabled <- str_replace(df$Enabled, "0", "No")
    df$Enabled <- str_replace(df$Enabled, "1", "Yes")

    # Drop the algorithm_id, dataset_id_left, and dataset_id_right value
    df <- subset(df, select = -c(algorithm_id, dataset_id_left, dataset_id_right))

    # Put it into a data table now
    dt <- datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE))
  }

  # Render the data table for the linkage algorithms of the desired 2 datasets
  output$currently_added_linkage_algorithms <- renderDataTable({
    get_linkage_algorithms()
  })

  # Add an empty linkage algorithm to the table using the provided datasets and name
  observeEvent(input$add_linkage_algorithm, {
    left_dataset_id  <- input$linkage_algorithm_left_dataset
    right_dataset_id <- input$linkage_algorithm_right_dataset
    algorithm_name   <- trimws(input$linkage_algorithm_descriptor)
    modified_by <- username
    modified_date <- format(Sys.Date(), format = "%Y-%m-%d")

    # Error check to verify that an exact match doesn't exist
    #----#
    if(algorithm_name == ""){
      showNotification("Failed to Add Linkage Algorithm - Algorithm Name Missing", type = "error", closeButton = FALSE)
      return()
    }

    get_query <- dbSendQuery(linkage_metadata_conn, 'SELECT * FROM linkage_algorithms
                                                  WHERE dataset_id_left = ? AND dataset_id_right = ? AND algorithm_name = ? AND enabled = 1;')
    dbBind(get_query, list(left_dataset_id, right_dataset_id, algorithm_name))
    output_df <- dbFetch(get_query)
    num_of_databases <- nrow(output_df)
    dbClearResult(get_query)
    if(num_of_databases != 0){
      showNotification("Failed to Add Linkage Algorithm - Linkage Algorithm Already Exists", type = "error", closeButton = FALSE)
      return()
    }
    #----#

    # Create a new entry query for entering into the database
    #----#
    new_entry_query <- paste("INSERT INTO linkage_algorithms (dataset_id_left, dataset_id_right, algorithm_name, modified_date, modified_by, enabled)",
                             "VALUES(?, ?, ?, ?, ?, ?);")
    new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
    dbBind(new_entry, list(left_dataset_id, right_dataset_id, algorithm_name, modified_date, modified_by, 0))
    dbClearResult(new_entry)
    #----#

    # Update user input fields to make them blank!
    #----#
    updateTextAreaInput(session, "linkage_algorithm_descriptor", value = "")
    #----#

    # Update Data Tables and UI Renders
    #----#
    output$currently_added_linkage_algorithms <- renderDataTable({
      get_linkage_algorithms()
    })
    #----#

    # Show success notification
    #----#
    showNotification("Linkage Algorithm Successfully Created", type = "message", closeButton = FALSE)
    #----#
  })

  # Observes what row the user selects to update and will pre-populate the parameter key updating fields
  observe({
    # Get the user inputs
    left_dataset_id  <- input$linkage_algorithm_left_dataset
    right_dataset_id <- input$linkage_algorithm_right_dataset
    selected_row     <- input$currently_added_linkage_algorithms_rows_selected

    # If no row is selected, or a null row is selected, return
    if(is.null(selected_row)) return()

    # Query to get the algorithms we could select from
    df <- dbGetQuery(linkage_metadata_conn, paste('SELECT * from linkage_algorithms
                                                WHERE dataset_id_left =', left_dataset_id, 'AND dataset_id_right =', right_dataset_id,
                                                  'ORDER BY algorithm_id ASC'))

    algorithm_name <- df[selected_row, "algorithm_name"]

    # Now update the input fields
    updateTextAreaInput(session, "linkage_algorithm_descriptor_update",  value = algorithm_name)
  })

  # Update the selected linkage algorithm by changing the name
  observeEvent(input$update_linkage_algorithm, {
    left_dataset_id  <- input$linkage_algorithm_left_dataset
    right_dataset_id <- input$linkage_algorithm_right_dataset
    algorithm_name   <- input$linkage_algorithm_descriptor_update
    selected_row     <- input$currently_added_linkage_algorithms_rows_selected
    df <- dbGetQuery(linkage_metadata_conn, paste('SELECT * from linkage_algorithms
                                                WHERE dataset_id_left =', left_dataset_id, 'AND dataset_id_right =', right_dataset_id,
                                                  'ORDER BY algorithm_id ASC'))

    algorithm_id <- df[selected_row, "algorithm_id"]
    modified_by <- username
    modified_date <- format(Sys.Date(), format = "%Y-%m-%d")

    # Error check to verify that an exact match doesn't exist
    #----#
    if(algorithm_name == ""){
      showNotification("Failed to Update Linkage Algorithm - Missing Algorithm Name", type = "error", closeButton = FALSE)
      return()
    }

    get_query <- dbSendQuery(linkage_metadata_conn, 'SELECT * FROM linkage_algorithms
                                                  WHERE dataset_id_left = ? AND dataset_id_right = ? AND algorithm_name = ? AND algorithm_id != ?;')
    dbBind(get_query, list(left_dataset_id, right_dataset_id, algorithm_name, algorithm_id))
    output_df <- dbFetch(get_query)
    num_of_databases <- nrow(output_df)
    dbClearResult(get_query)
    if(num_of_databases != 0){
      showNotification("Failed to Update Linkage Algorithm - Linkage Algorithm Already Exists", type = "error", closeButton = FALSE)
      return()
    }
    #----#

    # Create a new entry query for updating the linkage algorithm
    #----#
    update_query <- paste("UPDATE linkage_algorithms
                          SET algorithm_name = ?, modified_by = ?, modified_date = ?
                          WHERE algorithm_id = ?")
    update <- dbSendStatement(linkage_metadata_conn, update_query)
    dbBind(update, list(algorithm_name, modified_by, modified_date, algorithm_id))
    dbClearResult(update)
    #----#

    # Update Data Tables and UI Renders
    #----#
    output$currently_added_linkage_algorithms <- renderDataTable({
      get_linkage_algorithms()
    })
    #----#

    # Show success notification
    #----#
    showNotification("Linkage Algorithm Successfully Updated", type = "message", closeButton = FALSE)
    #----#
  })

  # Toggle the selected linkage algorithm
  observeEvent(input$toggle_algorithm, {
    # Get the row that we're supposed to be toggling
    #----#
    left_dataset_id  <- input$linkage_algorithm_left_dataset
    right_dataset_id <- input$linkage_algorithm_right_dataset
    selected_row     <- input$currently_added_linkage_algorithms_rows_selected
    df <- dbGetQuery(linkage_metadata_conn, paste('SELECT * from linkage_algorithms
                                                WHERE dataset_id_left =', left_dataset_id, 'AND dataset_id_right =', right_dataset_id,
                                                  'ORDER BY algorithm_id ASC'))

    algorithm_id <- df[selected_row, "algorithm_id"]
    algorithm_name <- df[selected_row, "algorithm_name"]
    enabled_value <- df[selected_row, "enabled"]
    #----#

    # Create a query for updating the enabled value of the record
    #----#
    if(enabled_value == 1){
      update_query <- paste("UPDATE linkage_algorithms
                          SET enabled = 0
                          WHERE algorithm_id = ?")
      update <- dbSendStatement(linkage_metadata_conn, update_query)
      dbBind(update, list(algorithm_id))
      dbClearResult(update)
    }else{
      # Disable all algorithms for the selected data sets,
      update_query <- paste("UPDATE linkage_algorithms
                          SET enabled = 0
                          WHERE dataset_id_left = ? AND dataset_id_right = ?")
      update <- dbSendStatement(linkage_metadata_conn, update_query)
      dbBind(update, list(left_dataset_id, right_dataset_id))
      dbClearResult(update)

      # Error handling - don't allow user to have two algorithms enabled with the same name
      #----#
      get_query <- dbSendQuery(linkage_metadata_conn, 'SELECT * FROM linkage_algorithms WHERE algorithm_name = ? AND enabled = 1;')
      dbBind(get_query, list(algorithm_name))
      output_df <- dbFetch(get_query)
      enabled_databases <- nrow(output_df)
      dbClearResult(get_query)

      if(is.na(enabled_databases) || is.null(enabled_databases) || enabled_databases != 0){
        showNotification("Failed to Enable Algorithm - Algorithm with the same name is already enabled", type = "error", closeButton = FALSE)
        return()
      }
      #----#

      # Set the selected algorithm ID to be enabled
      update_query <- paste("UPDATE linkage_algorithms
                          SET enabled = 1
                          WHERE algorithm_id = ?")
      update <- dbSendStatement(linkage_metadata_conn, update_query)
      dbBind(update, list(algorithm_id))
      dbClearResult(update)
    }
    #----#

    # Re-render data tables and reset UI
    #----#
    output$currently_added_linkage_algorithms <- renderDataTable({
      get_linkage_algorithms()
    })
    #----#

    # Send a success notification
    #----#
    if(enabled_value == 1){
      showNotification("Algorithm Successfully Disabled", type = "message", closeButton = FALSE)
    }else{
      showNotification("Algorithm Successfully Enabled", type = "message", closeButton = FALSE)
    }
  })

  # Modify the ground truth variables of the selected algorithm
  observeEvent(input$linkage_algorithms_to_ground_truth, {
    # Get the selected row
    left_dataset_id  <- input$linkage_algorithm_left_dataset
    right_dataset_id <- input$linkage_algorithm_right_dataset
    selected_row     <- input$currently_added_linkage_algorithms_rows_selected
    df <- dbGetQuery(linkage_metadata_conn, paste('SELECT * from linkage_algorithms
                                                WHERE dataset_id_left =', left_dataset_id, 'AND dataset_id_right =', right_dataset_id,
                                                  'ORDER BY algorithm_id ASC'))

    # Grab the algorithm id
    algorithm_id <- df[selected_row, "algorithm_id"]

    # Update the global variable for the acceptance method id and the return page
    modify_ground_truth_algorithm_id     <<- algorithm_id
    modify_ground_truth_left_dataset_id  <<- left_dataset_id
    modify_ground_truth_right_dataset_id <<- right_dataset_id
    modify_ground_truth_return_page      <<- "linkage_algorithms_page"

    # Update the table of iterations on that page
    output$ground_truth_left_field_input <- renderUI({
      left_dataset_ground_truth_fields()
    })
    output$ground_truth_right_field_input <- renderUI({
      right_dataset_ground_truth_fields()
    })
    output$currently_added_ground_truth_variables <- renderDataTable({
      get_ground_truth_variables()
    })

    # Show the iterations page
    nav_show('main_navbar', 'ground_truth_variables_page')
    updateNavbarPage(session, "main_navbar", selected = "ground_truth_variables_page")
  })

  # View and export the saved performance measures of the selected algorithm
  observeEvent(input$linkage_algorithms_to_audits, {
    # Get the selected row
    left_dataset_id  <- input$linkage_algorithm_left_dataset
    right_dataset_id <- input$linkage_algorithm_right_dataset
    selected_row     <- input$currently_added_linkage_algorithms_rows_selected
    df <- dbGetQuery(linkage_metadata_conn, paste('SELECT * from linkage_algorithms
                                                WHERE dataset_id_left =', left_dataset_id, 'AND dataset_id_right =', right_dataset_id,
                                                  'ORDER BY algorithm_id ASC'))

    # Grab the algorithm id
    algorithm_id <- df[selected_row, "algorithm_id"]

    # Update the global variable for the acceptance method id and the return page
    linkage_audits_algorithm_id <<- algorithm_id
    linkage_audits_return_page  <<- "linkage_algorithms_page"

    # Update the table of performance measures and the date range element
    output$algorithm_specific_audits <- renderDataTable({
      get_audit_information()
    })
    updateDateRangeInput(session, "audit_date_range", start = "1983-01-01", end = format(Sys.Date(), format = "%Y-%m-%d"))

    # Show the iterations page
    nav_show('main_navbar', 'audits_page')
    updateNavbarPage(session, "main_navbar", selected = "audits_page")
  })
  #----
  #------------------------------------#

  #-- VIEW/EXPORT LINKAGE AUDITS PAGE EVENTS --#
  #----
  # Global variables for the linkage audits page
  linkage_audits_algorithm_id <- 1
  linkage_audits_return_page  <- "linkage_algorithms_page"

  # Back button will bring you back to whichever page you came from
  observeEvent(input$linkage_audits_back, {
    # Show return to the page you came from
    updateNavbarPage(session, "main_navbar", selected = linkage_audits_return_page)
  })

  # Function for generating the table of audit information
  get_audit_information <- function(){
    # Get the user input information (ID, date ranges)
    algorithm_id <- linkage_audits_algorithm_id
    lower_date   <- input$audit_date_range[1]
    upper_date   <- input$audit_date_range[2]

    # Format the dates
    lower_date <- as.character(as.Date(lower_date, "%Y-%m-%d"))
    upper_date <- as.character(as.Date(upper_date, "%Y-%m-%d"))

    # Create a variable for getting the query results
    audit_df <- data.frame()

    # QUERY 1 (Both date ranges were provided)
    if(!is.na(lower_date) && !is.na(upper_date)){
      # Query for obtaining the performance measures
      query <- 'SELECT * FROM performance_measures_audit WHERE audit_date >= ? AND audit_date <= ? AND algorithm_id = ? ORDER BY audit_id'

      # Execute the query and bind parameters
      df <- dbGetQuery(linkage_metadata_conn, query, params = list(lower_date, upper_date, algorithm_id))

      # Pass back the audit_df
      audit_df <- df
    }

    # QUERY 2 (Only lower date range was provided)
    if(!is.na(lower_date) && is.na(upper_date)){
      # Query for obtaining the performance measures
      query <- 'SELECT * FROM performance_measures_audit WHERE audit_date >= ? AND algorithm_id = ? ORDER BY audit_id'

      # Execute the query and bind parameters
      df <- dbGetQuery(linkage_metadata_conn, query, params = list(lower_date, algorithm_id))

      # Pass back the audit_df
      audit_df <- df
    }

    # QUERY 3 (Only upper date range was provided)
    if(is.na(lower_date) && !is.na(upper_date)){
      # Query for obtaining the performance measures
      query <- 'SELECT * FROM performance_measures_audit WHERE audit_date <= ? AND algorithm_id = ? ORDER BY audit_id'

      # Execute the query and bind parameters
      df <- dbGetQuery(linkage_metadata_conn, query, params = list(upper_date, algorithm_id))

      # Pass back the audit_df
      audit_df <- df
    }

    # QUERY 4 (No date range was provided)
    if(is.na(lower_date) && is.na(upper_date)){
      # Query for obtaining the performance measures
      query <- 'SELECT * FROM performance_measures_audit WHERE algorithm_id = ? ORDER BY audit_id'

      # Execute the query and bind parameters
      df <- dbGetQuery(linkage_metadata_conn, query, params = list(algorithm_id))

      # Pass back the audit_df
      audit_df <- df
    }

    # If there are rows for this data frame, convert JSON to a readable format
    if(nrow(audit_df) > 0){
      for(row_num in 1:nrow(audit_df)){
        # Get the stored JSON value
        json_audit <- audit_df$performance_measures_json[row_num]

        # Parse the JSON into a list
        parsed_json <- jsonlite::fromJSON(json_audit)

        # Convert the list to a comma-separated string (key: value pairs)
        json_string <- paste(names(parsed_json), parsed_json, sep = ": ", collapse = ", ")

        # Replace the original JSON with the string in the same row
        audit_df$performance_measures_json[row_num] <- json_string
      }
    }

    # Drop the audit_id
    audit_df <- subset(audit_df, select = -c(audit_id, algorithm_id))

    # With our data frame, we'll rename some of the columns to look better
    names(audit_df)[names(audit_df) == 'audit_by']                  <- 'Audited By'
    names(audit_df)[names(audit_df) == 'audit_date']                <- 'Date Audited'
    names(audit_df)[names(audit_df) == 'performance_measures_json'] <- 'Performance Measures'

    # Put it into a data table now
    dt <- datatable(audit_df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE))
    return(dt)
  }

  # Renders the table of audit information
  output$algorithm_specific_audits <- renderDataTable({
    get_audit_information()
  })

  # Observe Whenever the user selects a new data range and re-render the table
  observe({
    # If the user changes either the lower or upper date, re-render
    lower_date   <- input$audit_date_range[1]
    upper_date   <- input$audit_date_range[2]

    # Re-render the audit table
    output$algorithm_specific_audits <- renderDataTable({
      get_audit_information()
    })
  })

  # Observes when the user exports a selected audit
  observeEvent(input$export_selected_audit, {
    # Get the user input information (ID, date ranges)
    selected_row <- input$algorithm_specific_audits_rows_selected
    algorithm_id <- linkage_audits_algorithm_id
    lower_date   <- input$audit_date_range[1]
    upper_date   <- input$audit_date_range[2]

    # Format the dates
    lower_date <- as.character(as.Date(lower_date, "%Y-%m-%d"))
    upper_date <- as.character(as.Date(upper_date, "%Y-%m-%d"))

    # Keep a data frame variable to obtain the table the user selected from
    audit_df <- data.frame()

    # QUERY 1 (Both date ranges were provided)
    if(!is.na(lower_date) && !is.na(upper_date)){
      # Query for obtaining the performance measures
      query <- 'SELECT * FROM performance_measures_audit WHERE audit_date >= ? AND audit_date <= ? AND algorithm_id = ? ORDER BY audit_id'

      # Execute the query and bind parameters
      df <- dbGetQuery(linkage_metadata_conn, query, params = list(lower_date, upper_date, algorithm_id))

      # Return the queried data frame to our audit_df variable
      audit_df <- df
    }

    # QUERY 2 (Only lower date range was provided)
    if(!is.na(lower_date) && is.na(upper_date)){
      # Query for obtaining the performance measures
      query <- 'SELECT * FROM performance_measures_audit WHERE audit_date >= ? AND algorithm_id = ? ORDER BY audit_id'

      # Execute the query and bind parameters
      df <- dbGetQuery(linkage_metadata_conn, query, params = list(lower_date, algorithm_id))

      # Return the queried data frame to our audit_df variable
      audit_df <- df
    }

    # QUERY 3 (Only upper date range was provided)
    if(is.na(lower_date) && !is.na(upper_date)){
      # Query for obtaining the performance measures
      query <- 'SELECT * FROM performance_measures_audit WHERE audit_date <= ? AND algorithm_id = ? ORDER BY audit_id'

      # Execute the query and bind parameters
      df <- dbGetQuery(linkage_metadata_conn, query, params = list(upper_date, algorithm_id))

      # Return the queried data frame to our audit_df variable
      audit_df <- df
    }

    # QUERY 4 (No date range was provided)
    if(is.na(lower_date) && is.na(upper_date)){
      # Query for obtaining the performance measures
      query <- 'SELECT * FROM performance_measures_audit WHERE algorithm_id = ? ORDER BY audit_id'

      # Execute the query and bind parameters
      df <- dbGetQuery(linkage_metadata_conn, query, params = list(algorithm_id))

      # Return the queried data frame to our audit_df variable
      audit_df <- df
    }

    # Get the algorithm name
    df <- dbGetQuery(linkage_metadata_conn, paste0('SELECT * FROM linkage_algorithms WHERE algorithm_id = ', algorithm_id))
    algorithm_name <- stri_replace_all_regex(df$algorithm_name, " ", "")

    # Get the performance measure information
    audit_by                  <- audit_df$audit_by[selected_row]
    audit_date                <- audit_df$audit_date[selected_row]
    performance_measures_json <- audit_df$performance_measures_json[selected_row]

    # Create a data frame which will contain the auditing information to export
    export_df <- data.frame(matrix(ncol = 0, nrow = 1))

    # Add the date and author as columns
    export_df[["Audited By"]]   <- audit_by
    export_df[["Audited Date"]] <- audit_date

    # Convert the performance measures_json to a data frame
    performance_measures_df <- jsonlite::fromJSON(performance_measures_json, simplifyDataFrame = TRUE)

    # Bind the columns
    export_df <- cbind(export_df, performance_measures_df)

    # Get user input by requiring them to supply a directory for output
    output_dir <- choose.dir(getwd(), "Choose a Folder")

    # Two things can happen, if no directory is chosen, or NA happens, write it to the working directory, otherwise use user input
    if(!is.na(output_dir)){
      # Define base file name
      base_filename <- paste0(algorithm_name, '_performance_measures_', audit_date)

      # Start with the base file name
      full_filename <- file.path(output_dir, paste0(base_filename, ".csv"))
      counter <- 1

      # While the file exists, append a number and keep checking
      while (file.exists(full_filename)) {
        full_filename <- file.path(output_dir, paste0(base_filename, " (", counter, ")", ".csv"))
        counter <- counter + 1
      }

      # Save the csv file
      fwrite(export_df, file = full_filename, append = TRUE)
    }
    else{
      # Define base file name
      base_filename <- paste0(algorithm_name, '_performance_measures_', audit_date)

      # Start with the base file name
      full_filename <- file.path(getwd(), paste0(base_filename, ".csv"))
      counter <- 1

      # While the file exists, append a number and keep checking
      while (file.exists(full_filename)) {
        full_filename <- file.path(getwd(), paste0(base_filename, " (", counter, ")", ".csv"))
        counter <- counter + 1
      }

      # Save the csv file
      fwrite(export_df, file = full_filename, append = TRUE)
    }

    # Show success notification
    full_filename <- stri_replace_all_regex(full_filename, "\\\\", "/")
    showNotification(paste0("Performance Measures Exported to: ", full_filename), type = "message", closeButton = FALSE)
  })

  #----
  #--------------------------------------------#

  #-- MODIFY GROUND TRUTH VARIABLES PAGE EVENTS --#
  #----
  modify_ground_truth_algorithm_id     <- 1
  modify_ground_truth_left_dataset_id  <- 1
  modify_ground_truth_right_dataset_id <- 1
  modify_ground_truth_return_page      <- "linkage_algorithms_page"

  # Some global variables for the linkage rule that needs to be added
  ground_truth_linkage_rule_to_add     <- NA

  # Back button will bring you back to whichever page you came from
  observeEvent(input$modify_ground_truth_back, {
    # Show return to the page you came from
    updateNavbarPage(session, "main_navbar", selected = modify_ground_truth_return_page)
  })

  # Function for creating the table of the currently selected algorithms iterations
  get_ground_truth_variables <- function(){
    algorithm_id <- modify_ground_truth_algorithm_id

    # Query to get blocking variables with left and right dataset field names
    query <- paste('SELECT gt.*,
                       dfl.field_name AS left_field_name,
                       dfr.field_name AS right_field_name
                FROM ground_truth_variables gt
                LEFT JOIN dataset_fields dfl
                  ON gt.left_dataset_field_id = dfl.field_id
                LEFT JOIN dataset_fields dfr
                  ON gt.right_dataset_field_id = dfr.field_id
                WHERE gt.algorithm_id =', algorithm_id,
                   'ORDER BY gt.parameter_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    # Loop through each row in the dataframe to replace the linkage_rule_id with the method name and parameters
    for (i in 1:nrow(df)) {

      # Get the linkage_rule_id for the current row
      linkage_rule_id <- df$linkage_rule_id[i]
      if (nrow(df) > 0 && !is.na(linkage_rule_id)){
        # Query to get the acceptance method name from the comparison_rules table
        method_query <- paste('SELECT * FROM linkage_rules
                           WHERE linkage_rule_id =', linkage_rule_id)
        method_df <- dbGetQuery(linkage_metadata_conn, method_query)

        # We'll start with "Alternative Field"
        alt_field_val <- method_df$alternate_field_value
        if(!is.na(alt_field_val)){
          method_df$alternate_field_value <- paste0(scales::ordinal(as.numeric(alt_field_val)), " Field Value")
        }

        # Next we'll handle the "Integer Variance"
        int_variance <- method_df$integer_value_variance
        if(!is.na(int_variance)){
          method_df$integer_value_variance <- paste0("±", int_variance)
        }

        # Next we'll handle "Name Substring"
        name_substring <- method_df$substring_length
        if(!is.na(name_substring)){
          method_df$substring_length <- paste0("First ", name_substring, " character(s)")
        }

        # With standardized names, we'll replace the [0, 1] with [No, Yes]
        method_df$standardize_names <- str_replace(method_df$standardize_names, "1", "Standardize Names")

        # Rename the column names to be easier to read when printed in table format
        names(method_df)[names(method_df) == 'alternate_field_value'] <- 'Alternate Field Number'
        names(method_df)[names(method_df) == 'integer_value_variance'] <- 'Integer Value Variance'
        names(method_df)[names(method_df) == 'substring_length'] <- 'Substring Length'
        names(method_df)[names(method_df) == 'standardize_names'] <- 'Standardize Names'

        # Drop the linkage_rule_id from the table
        method_df <- subset(method_df, select = -c(linkage_rule_id))

        # Initialize an empty list to store non-NA values
        non_na_values <- list()

        # Loop through each column in the current row
        for (col_name in colnames(method_df)) {
          value <- method_df[1, col_name]

          # If the value is not NA, add it to the list
          if (!is.na(value)) {
            non_na_values <- c(non_na_values, paste0(value))
          }
        }

        # Combine the non-NA values into a single string, separated by commas
        combined_values <- paste(non_na_values, collapse = ", ")

        # Place the combined values into the data frame
        df$linkage_rule_id[i] <- combined_values
      }
    }

    # With our data frame, we'll rename some of the columns to look better
    names(df)[names(df) == 'right_field_name'] <- 'Right Dataset Field'
    names(df)[names(df) == 'left_field_name'] <- 'Left Dataset Field'
    names(df)[names(df) == 'linkage_rule_id'] <- 'Linkage Rules'

    # Drop the algorithm_id, parameter_id, and dataset field ID columns from the table
    df <- subset(df, select = -c(algorithm_id, parameter_id, right_dataset_field_id, left_dataset_field_id))

    # Reorder the columns
    df <- df[, c('Right Dataset Field', 'Left Dataset Field', 'Linkage Rules')]

    # Put it into a data table now
    dt <- datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE, dom = 'tp'))
  }

  # Renders the data table of iterations that can be modified
  output$currently_added_ground_truth_variables <- renderDataTable({
    get_ground_truth_variables()
  })

  # Creates the select input UI for available left fields
  left_dataset_ground_truth_fields <- function(){

    # Perform query using linkage_metadata_conn
    query_result <- dbGetQuery(linkage_metadata_conn, paste("SELECT * from dataset_fields WHERE dataset_id =", modify_ground_truth_left_dataset_id))

    # Extract columns from query result
    choices <- setNames(query_result$field_id, query_result$field_name)

    # Create select input with dynamic choices
    span(selectizeInput("left_ground_truth_field", label = "Left Dataset Field:",
                     choices = choices, multiple = FALSE, width = validateCssUnit(300),
                     options = list(
                       placeholder = 'Select a Left Ground Truth Field',
                       onInitialize = I('function() { this.setValue(""); }')
                     )))
  }

  # Creates the select input UI for available right fields
  right_dataset_ground_truth_fields <- function(){

    # Perform query using linkage_metadata_conn
    query_result <- dbGetQuery(linkage_metadata_conn, paste("SELECT * from dataset_fields WHERE dataset_id =", modify_ground_truth_right_dataset_id))

    # Extract columns from query result
    choices <- setNames(query_result$field_id, query_result$field_name)

    # Create select input with dynamic choices
    span(selectizeInput("right_ground_truth_field", label = "Right Dataset Field:",
                        choices = choices, multiple = FALSE, width = validateCssUnit(300),
                        options = list(
                          placeholder = 'Select a Right Ground Truth Field',
                          onInitialize = I('function() { this.setValue(""); }')
                        )))
  }

  # Renders the UI for the left ground truth field add select input
  output$ground_truth_left_field_input <- renderUI({
    left_dataset_ground_truth_fields()
  })

  # Renders the UI for the right ground truth field add select input
  output$ground_truth_right_field_input <- renderUI({
    right_dataset_ground_truth_fields()
  })

  ### LINKAGE RULE EVENTS ###
  #----#
  # Selecting a linkage rule for adding ground truth variables
  observeEvent(input$prepare_ground_truth_linkage_rule, {
    # Re-render the data table
    output$ground_truth_add_linkage_rules <- renderDataTable({
      get_linkage_rules()
    })

    showModal(modalDialog(
      title = "Choose Linkage Rule",
      easyClose = TRUE,
      footer = NULL,
      fluidRow(
        # Linkage rule table
        h5(strong("Select a Linkage Rule Below to Use for the Ground Truth Variables:")),
        column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
            dataTableOutput("ground_truth_add_linkage_rules"),
          )
        ),

        # If NO row is selected, the user may add a new linkage rule by clicking
        # a button that will take them to the linkage rule page
        conditionalPanel(
          condition = "input.ground_truth_add_linkage_rules_rows_selected <= 0",
          HTML("<br>"),
          h5(strong("Or, Create a New Rule Here:")),

          # Button for going to the linkage rules page from this modal
          fluidRow(
            column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                actionButton("ground_truth_add_linkage_rules_to_linkage_rules", "Create New Linkage Rule", class = "btn-info"),
              )
            ),
          )
        ),

        # If a row IS SELECTED, the user can then click then choose that rule
        conditionalPanel(
          condition = "input.ground_truth_add_linkage_rules_rows_selected > 0",
          HTML("<br>"),

          # Button for preparing the selected linkage rule to add
          fluidRow(
            column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                actionButton("ground_truth_add_prepare_linkage_rule", "Add Linkage Rule", class = "btn-success"),
              )
            ),
          )
        ),
      ),
      size = "l"  # Large modal size to fit both tables
    ))
  })

  # Brings the user to the linkage rules page
  observeEvent(input$ground_truth_add_linkage_rules_to_linkage_rules, {

    # Set the return page to the add linkage iterations page
    linkage_rules_return_page <<- "ground_truth_variables_page"

    # Show the linkage rule page
    nav_show("main_navbar", "linkage_rule_page")

    # Brings you to the linkage rules page
    updateNavbarPage(session, "main_navbar", selected = "linkage_rule_page")
  })

  # Selects the linkage rule the user wanted
  observeEvent(input$ground_truth_add_prepare_linkage_rule, {
    # Get the selected row
    selected_row <- input$ground_truth_add_linkage_rules_rows_selected

    # Query to get all linkage rule information from the 'linkage_rules' table
    query <- paste('SELECT * FROM linkage_rules
               ORDER BY linkage_rule_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    # Get the linkage rule
    linkage_rule_id <- df$linkage_rule_id[selected_row]

    # Set the global variable to the selected linkage rule id
    ground_truth_linkage_rule_to_add <<- linkage_rule_id

    # Render the UI output text
    if(!is.na(linkage_rule_id)){
      # Query to get the acceptance method name from the comparison_rules table
      method_query <- paste('SELECT * FROM linkage_rules
                           WHERE linkage_rule_id =', linkage_rule_id)
      method_df <- dbGetQuery(linkage_metadata_conn, method_query)

      # We'll start with "Alternative Field"
      alt_field_val <- method_df$alternate_field_value
      if(!is.na(alt_field_val)){
        method_df$alternate_field_value <- paste0(scales::ordinal(as.numeric(alt_field_val)), " Field Value")
      }

      # Next we'll handle the "Integer Variance"
      int_variance <- method_df$integer_value_variance
      if(!is.na(int_variance)){
        method_df$integer_value_variance <- paste0("±", int_variance)
      }

      # Next we'll handle "Name Substring"
      name_substring <- method_df$substring_length
      if(!is.na(name_substring)){
        method_df$substring_length <- paste0("First ", name_substring, " character(s)")
      }

      # With standardized names, we'll replace the [0, 1] with [No, Yes]
      method_df$standardize_names <- str_replace(method_df$standardize_names, "1", "Standardize Names")

      # Rename the column names to be easier to read when printed in table format
      names(method_df)[names(method_df) == 'alternate_field_value'] <- 'Alternate Field Number'
      names(method_df)[names(method_df) == 'integer_value_variance'] <- 'Integer Value Variance'
      names(method_df)[names(method_df) == 'substring_length'] <- 'Substring Length'
      names(method_df)[names(method_df) == 'standardize_names'] <- 'Standardize Names'

      # Drop the linkage_rule_id from the table
      method_df <- subset(method_df, select = -c(linkage_rule_id))

      # Initialize an empty list to store non-NA values
      non_na_values <- list()

      # Loop through each column in the current row
      for (col_name in colnames(method_df)) {
        value <- method_df[1, col_name]

        # If the value is not NA, add it to the list
        if (!is.na(value)) {
          non_na_values <- c(non_na_values, paste0(value))
        }
      }

      # Combine the non-NA values into a single string, separated by commas
      combined_values <- paste(non_na_values, collapse = ", ")

      # Render the output text
      output$selected_ground_truth_linkage_rule <- renderText({
        combined_values
      })
    }

    # Dismiss the modal
    removeModal()
  })

  # Generates the table of linkage rules
  output$ground_truth_add_linkage_rules <- renderDataTable({
    get_linkage_rules()
  })

  # Remove the linkage rule for this ground truth variable
  observeEvent(input$remove_ground_truth_linkage_rule, {
    # Set the global variable value to NA
    ground_truth_linkage_rule_to_add <<- NA

    # Render the text output to not include anything
    output$selected_ground_truth_linkage_rule <- renderText({
      " "
    })
  })
  #----#

  ### ADD/DROP EVENTS ###
  #----#
  # Adds the provided ground truth fields + linkage rule into the database
  observeEvent(input$add_ground_truth, {
    algorithm_id           <- modify_ground_truth_algorithm_id
    left_dataset_field_id  <- input$left_ground_truth_field
    right_dataset_field_id <- input$right_ground_truth_field
    linkage_rule_id        <- ground_truth_linkage_rule_to_add

    # Error handling
    #----#
    # Make sure a left and right dataset was passed
    if(left_dataset_field_id == '' || right_dataset_field_id == ''){
      showNotification("Failed to Add Ground Truth Variables - Missing Ground Truth Field Input(s)", type = "error", closeButton = FALSE)
      return()
    }

    # Make sure this ground truth variable isn't already being used
    get_query <- dbSendQuery(linkage_metadata_conn, 'SELECT * FROM ground_truth_variables
                                                  WHERE right_dataset_field_id = ? AND left_dataset_field_id = ? AND algorithm_id = ?;')
    dbBind(get_query, list(right_dataset_field_id, left_dataset_field_id, algorithm_id))
    output_df <- dbFetch(get_query)
    num_of_databases <- nrow(output_df)
    dbClearResult(get_query)
    if(num_of_databases != 0){
      showNotification("Failed to Add Ground Truth Variables - Variable Combination Already Exists", type = "error", closeButton = FALSE)
      return()
    }
    #----#

    # Create a new entry query for entering into the database
    #----#
    new_entry_query <- paste("INSERT INTO ground_truth_variables (algorithm_id, right_dataset_field_id, left_dataset_field_id, linkage_rule_id)",
                             "VALUES(?, ?, ?, ?);")
    new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
    dbBind(new_entry, list(algorithm_id, right_dataset_field_id, left_dataset_field_id, linkage_rule_id))
    dbClearResult(new_entry)
    #----#

    ## Reset Data Tables, UI Renders, and global variables
    #----#
    output$ground_truth_left_field_input <- renderUI({
      left_dataset_ground_truth_fields()
    })
    output$ground_truth_right_field_input <- renderUI({
      right_dataset_ground_truth_fields()
    })
    output$currently_added_ground_truth_variables <- renderDataTable({
      get_ground_truth_variables()
    })
    output$selected_ground_truth_linkage_rule <- renderText({
      ""
    })
    ground_truth_linkage_rule_to_add <<- NA
    #----#

    # Show success notification
    #----#
    showNotification("Ground Truth Variables Successfully Added", type = "message", closeButton = FALSE)
    #----#
  })

  # Drops the selected pair of ground truth fields
  observeEvent(input$drop_ground_truth, {
    algorithm_id <- modify_ground_truth_algorithm_id
    selected_row <- input$currently_added_ground_truth_variables_rows_selected
    df <- dbGetQuery(linkage_metadata_conn, paste('SELECT * from ground_truth_variables
                                                WHERE algorithm_id =', algorithm_id,
                                                  'ORDER BY parameter_id ASC'))
    # Get the fields to delete
    parameter_id  <- df$parameter_id[selected_row]

    # Create a new entry query for deleting the blocking variable
    #----#
    delete_query <- paste("DELETE FROM ground_truth_variables
                          WHERE parameter_id = ?")
    delete <- dbSendStatement(linkage_metadata_conn, delete_query)
    dbBind(delete, list(parameter_id))
    dbClearResult(delete)
    #----#

    # Update Data Tables and UI Renders
    #----#
    output$currently_added_ground_truth_variables <- renderDataTable({
      get_ground_truth_variables()
    })
    #----#

    # Show success notification
    #----#
    showNotification("Ground Truth Variables Successfully Deleted", type = "message", closeButton = FALSE)
    #----#
  })
  #----#

  #----
  #-----------------------------------------------#

  #-- VIEW LINKAGE ITERATIONS PAGE EVENTS --#
  #----
  # Create a global variable for which acceptance method we're wanting to add a rule for, and
  # as well as the PAGE we came from
  view_linkage_iterations_algorithm_id     <- 1
  view_linkage_iterations_left_dataset_id  <- 1
  view_linkage_iterations_right_dataset_id <- 1
  view_linkage_iterations_return_page  <- "linkage_algorithms_page"

  # Back button will bring you back to whichever page you came from
  observeEvent(input$view_linkage_iterations_back, {
    # Show return to the page you came from
    updateNavbarPage(session, "main_navbar", selected = view_linkage_iterations_return_page)
  })

  # Function for creating the table of the currently selected algorithms iterations
  get_linkage_iterations_view <- function(){
    algorithm_id <- view_linkage_iterations_algorithm_id

    # Query to get all linkage method information from the 'linkage_methods' table
    query <- paste('SELECT * FROM linkage_iterations
                WHERE algorithm_id =', algorithm_id,
                   'ORDER BY iteration_num ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    # Loop through each row in the dataframe to replace the acceptance_rule_id with the method name and parameters & the linkage method
    if(nrow(df) > 0){
      for (i in 1:nrow(df)) {
        # Get the acceptance_rule_id for the current row
        acceptance_rule_id <- df$acceptance_rule_id[i]
        if (nrow(df) > 0 && !is.na(acceptance_rule_id)) {
          # Query to get the acceptance method name from the acceptance_rules table
          method_query <- paste('SELECT method_name FROM acceptance_rules ar
                             JOIN acceptance_methods am on ar.acceptance_method_id = am.acceptance_method_id
                             WHERE acceptance_rule_id =', acceptance_rule_id)
          method_name <- dbGetQuery(linkage_metadata_conn, method_query)$method_name

          # Query to get the associated parameters for the acceptance_rule_id
          params_query <- paste('SELECT parameter FROM acceptance_rules_parameters WHERE acceptance_rule_id =', acceptance_rule_id)
          params_df <- dbGetQuery(linkage_metadata_conn, params_query)

          # Combine the parameters into a string
          params_str <- paste(params_df$parameter, collapse = ", ")

          # Create the final string "method_name (key1=value1, key2=value2)"
          method_with_params <- paste0(method_name, " (", params_str, ")")

          # Replace the acceptance_rule_id with the method and parameters string
          df$acceptance_rule_id[i] <- method_with_params
        }

        # Get the linkage_method_id for the current row
        linkage_method_id <- df$linkage_method_id[i]
        if (nrow(df) > 0 && !is.na(linkage_method_id)){
          # Query to get the linkage method
          method_query <- paste('SELECT technique_label, implementation_name FROM linkage_iterations li
                             JOIN linkage_methods lm on li.linkage_method_id = lm.linkage_method_id
                             WHERE lm.linkage_method_id =', linkage_method_id)
          method_df <- dbGetQuery(linkage_metadata_conn, method_query)

          # Create a string with the implementation name and label together
          linkage_method_and_technique <- paste0(method_df$implementation_name, " (", method_df$technique_label, ")")

          # Replace the linkage method ID with the string
          suppressWarnings(df$linkage_method_id[i] <- linkage_method_and_technique)
        }

        # Get the iteration_id for the current row
        iteration_id <- df$iteration_id[i]

        # Query to get blocking LEFT fields
        blocking_query <- paste('SELECT field_name FROM blocking_variables
                              JOIN dataset_fields on field_id = left_dataset_field_id
                              WHERE iteration_id =', iteration_id)
        blocking_fields <- dbGetQuery(linkage_metadata_conn, blocking_query)$field_name
        blocking_left_fields <- paste(blocking_fields, collapse = ", ")

        # Add blocking fields to the dataframe
        df$blocking_left_fields[i] <- blocking_left_fields

        # Query to get matching LEFT fields
        matching_query <- paste('SELECT field_name, comparison_rule_id FROM matching_variables
                              JOIN dataset_fields on field_id = left_dataset_field_id
                              WHERE iteration_id =', iteration_id)
        matching_df <- dbGetQuery(linkage_metadata_conn, matching_query)

        # Loop through each matching variable to get its comparison methods
        for(j in 1:nrow(matching_df)){
          # Get the comparison_rule_id for this row
          comparison_rule_id <- matching_df$comparison_rule_id[j]
          if(nrow(matching_df) > 0 && !is.na(comparison_rule_id)){
            # Query to get the acceptance method name from the comparison_rules table
            method_query <- paste('SELECT method_name FROM comparison_rules cr
                             JOIN comparison_methods cm on cr.comparison_method_id = cm.comparison_method_id
                             WHERE comparison_rule_id =', comparison_rule_id)
            method_name <- dbGetQuery(linkage_metadata_conn, method_query)$method_name

            # Query to get the associated parameters for the comparison_rule_id
            params_query <- paste('SELECT parameter FROM comparison_rules_parameters WHERE comparison_rule_id =', comparison_rule_id)
            params_df <- dbGetQuery(linkage_metadata_conn, params_query)

            # Combine the parameters into a string
            params_str <- paste(params_df$parameter, collapse = ", ")

            # Create the final string "method_name (key1=value1, key2=value2)"
            method_with_params <- paste0(" - ", method_name, " (", params_str, ")")

            # Replace the comparison_rule_id with the method and parameters string
            matching_df$field_name[j] <- paste0(matching_df$field_name[j], method_with_params)
          }
        }

        matching_fields <- matching_df$field_name
        matching_left_fields <- paste(matching_fields, collapse = ", ")

        # Add blocking fields to the dataframe
        df$matching_left_fields[i] <- matching_left_fields
      }
    }
    else{
      # Create an empty data frame if no iterations exist
      df <- data.frame(
        algorithm_id = numeric(),
        iteration_id = numeric(),
        iteration_name = character(),
        iteration_num = numeric(),
        modified_date = character(),
        modified_by = character(),
        enabled = numeric(),
        linkage_method_id = numeric(),
        acceptance_rule_id = numeric(),
        blocking_left_fields = character(),
        matching_left_fields = character()
      )
    }

    # With our data frame, we'll rename some of the columns to look better
    names(df)[names(df) == 'iteration_name'] <- 'Iteration Name'
    names(df)[names(df) == 'iteration_num'] <- 'Iteration Order/Priority'
    names(df)[names(df) == 'modified_date'] <- 'Modified Date'
    names(df)[names(df) == 'modified_by'] <- 'Modified By'
    names(df)[names(df) == 'enabled'] <- 'Enabled'
    names(df)[names(df) == 'linkage_method_id'] <- 'Linkage Method'
    names(df)[names(df) == 'acceptance_rule_id'] <- 'Acceptance Rules'
    names(df)[names(df) == 'blocking_left_fields'] <- 'Blocking Keys'
    names(df)[names(df) == 'matching_left_fields'] <- 'Matching Keys'

    # With algorithms, we'll replace the enabled [0, 1] with [No, Yes]
    df$Enabled <- str_replace(df$Enabled, "0", "No")
    df$Enabled <- str_replace(df$Enabled, "1", "Yes")

    # Drop the algorithm_id, dataset_id_left, and dataset_id_right value
    df <- subset(df, select = -c(algorithm_id, iteration_id))

    # Reorder the columns so that 'Blocking Keys' and 'Matching Keys' come after 'Linkage Method'
    df <- df[, c('Iteration Name', 'Iteration Order/Priority', 'Linkage Method', 'Blocking Keys', 'Matching Keys',
                 'Acceptance Rules', 'Modified Date', 'Modified By', 'Enabled')]

    # Put it into a data table now
    dt <- datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE, dom = 'tp'))
  }

  # Renders the data table of iterations that can be modified
  output$currently_added_linkage_iterations <- renderDataTable({
    get_linkage_iterations_view()
  })

  # Function for creating the table of existing iterations that we may add (NOT BELONGING TO THIS ALGORITHM)
  get_linkage_iterations_add_existing <- function(){
    # Query to get all the algorithm IDs that belong to these two datasets
    query <- paste('SELECT * FROM linkage_algorithms
                    WHERE dataset_id_left =', view_linkage_iterations_left_dataset_id, 'AND dataset_id_right =', view_linkage_iterations_right_dataset_id,
                   'ORDER BY algorithm_id ASC;')
    algorithms_df <- dbGetQuery(linkage_metadata_conn, query)

    # Go through each row in all the linkage algorithms, and bind the dataframe to one large one
    df <- data.frame()

    if(nrow(algorithms_df) > 0){
      for(i in 1:nrow(algorithms_df)){
        # Get the algorithm ID
        algorithm_id <- algorithms_df$algorithm_id[i]

        # If this isnt the current algorithm we're viewing, ignore it, otherwise, get the rows and bind them
        if(algorithm_id != view_linkage_iterations_algorithm_id){
          # Query to get all linkage iteration information from the 'linkage_iterations' table
          query <- paste('SELECT * FROM linkage_iterations
                WHERE algorithm_id =', algorithm_id,
                         'ORDER BY iteration_num ASC;')
          df_temp <- dbGetQuery(linkage_metadata_conn, query)

          # Bind the data frame
          df <- rbind(df, df_temp)
        }
      }
    }

    # Loop through each row in the dataframe to replace the acceptance_rule_id with the method name and parameters & the linkage method
    if(nrow(df) > 0){
      for (i in 1:nrow(df)) {
        # Get the acceptance_rule_id for the current row
        acceptance_rule_id <- df$acceptance_rule_id[i]
        if (nrow(df) > 0 && !is.na(acceptance_rule_id)) {
          # Query to get the acceptance method name from the acceptance_rules table
          method_query <- paste('SELECT method_name FROM acceptance_rules ar
                             JOIN acceptance_methods am on ar.acceptance_method_id = am.acceptance_method_id
                             WHERE acceptance_rule_id =', acceptance_rule_id)
          method_name <- dbGetQuery(linkage_metadata_conn, method_query)$method_name

          # Query to get the associated parameters for the acceptance_rule_id
          params_query <- paste('SELECT parameter FROM acceptance_rules_parameters WHERE acceptance_rule_id =', acceptance_rule_id)
          params_df <- dbGetQuery(linkage_metadata_conn, params_query)

          # Combine the parameters into a string
          params_str <- paste(params_df$parameter, collapse = ", ")

          # Create the final string "method_name (key1=value1, key2=value2)"
          method_with_params <- paste0(method_name, " (", params_str, ")")

          # Replace the acceptance_rule_id with the method and parameters string
          df$acceptance_rule_id[i] <- method_with_params
        }

        # Get the linkage_method_id for the current row
        linkage_method_id <- df$linkage_method_id[i]
        if (nrow(df) > 0 && !is.na(linkage_method_id)){
          # Query to get the linkage method
          method_query <- paste('SELECT technique_label, implementation_name FROM linkage_iterations li
                             JOIN linkage_methods lm on li.linkage_method_id = lm.linkage_method_id
                             WHERE lm.linkage_method_id =', linkage_method_id)
          method_df <- dbGetQuery(linkage_metadata_conn, method_query)

          # Create a string with the implementation name and label together
          linkage_method_and_technique <- paste0(method_df$implementation_name, " (", method_df$technique_label, ")")

          # Replace the linkage method ID with the string
          suppressWarnings(df$linkage_method_id[i] <- linkage_method_and_technique)
        }

        # Get the iteration_id for the current row
        iteration_id <- df$iteration_id[i]

        # Query to get blocking LEFT fields
        blocking_query <- paste('SELECT field_name FROM blocking_variables
                              JOIN dataset_fields on field_id = left_dataset_field_id
                              WHERE iteration_id =', iteration_id)
        blocking_fields <- dbGetQuery(linkage_metadata_conn, blocking_query)$field_name
        blocking_left_fields <- paste(blocking_fields, collapse = ", ")

        # Add blocking fields to the dataframe
        df$blocking_left_fields[i] <- blocking_left_fields

        # Query to get matching LEFT fields
        matching_query <- paste('SELECT field_name, comparison_rule_id FROM matching_variables
                              JOIN dataset_fields on field_id = left_dataset_field_id
                              WHERE iteration_id =', iteration_id)
        matching_df <- dbGetQuery(linkage_metadata_conn, matching_query)

        # Loop through each matching variable to get its comparison methods
        for(j in 1:nrow(matching_df)){
          # Get the comparison_rule_id for this row
          comparison_rule_id <- matching_df$comparison_rule_id[j]
          if(nrow(matching_df) > 0 && !is.na(comparison_rule_id)){
            # Query to get the acceptance method name from the comparison_rules table
            method_query <- paste('SELECT method_name FROM comparison_rules cr
                             JOIN comparison_methods cm on cr.comparison_method_id = cm.comparison_method_id
                             WHERE comparison_rule_id =', comparison_rule_id)
            method_name <- dbGetQuery(linkage_metadata_conn, method_query)$method_name

            # Query to get the associated parameters for the comparison_rule_id
            params_query <- paste('SELECT parameter FROM comparison_rules_parameters WHERE comparison_rule_id =', comparison_rule_id)
            params_df <- dbGetQuery(linkage_metadata_conn, params_query)

            # Combine the parameters into a string
            params_str <- paste(params_df$parameter, collapse = ", ")

            # Create the final string "method_name (key1=value1, key2=value2)"
            method_with_params <- paste0(" - ", method_name, " (", params_str, ")")

            # Replace the comparison_rule_id with the method and parameters string
            matching_df$field_name[j] <- paste0(matching_df$field_name[j], method_with_params)
          }
        }

        matching_fields <- matching_df$field_name
        matching_left_fields <- paste(matching_fields, collapse = ", ")

        # Add blocking fields to the dataframe
        df$matching_left_fields[i] <- matching_left_fields
      }
    }
    else{
      # Create an empty data frame if no iterations exist
      df <- data.frame(
        algorithm_id = numeric(),
        iteration_id = numeric(),
        iteration_name = character(),
        iteration_num = numeric(),
        modified_date = character(),
        modified_by = character(),
        enabled = numeric(),
        linkage_method_id = numeric(),
        acceptance_rule_id = numeric(),
        blocking_left_fields = character(),
        matching_left_fields = character()
      )
    }

    # With our data frame, we'll rename some of the columns to look better
    names(df)[names(df) == 'iteration_name'] <- 'Iteration Name'
    names(df)[names(df) == 'iteration_num'] <- 'Iteration Order/Priority'
    names(df)[names(df) == 'modified_date'] <- 'Modified Date'
    names(df)[names(df) == 'modified_by'] <- 'Modified By'
    names(df)[names(df) == 'enabled'] <- 'Enabled'
    names(df)[names(df) == 'linkage_method_id'] <- 'Linkage Method'
    names(df)[names(df) == 'acceptance_rule_id'] <- 'Acceptance Rules'
    names(df)[names(df) == 'blocking_left_fields'] <- 'Blocking Keys'
    names(df)[names(df) == 'matching_left_fields'] <- 'Matching Keys'

    # With algorithms, we'll replace the enabled [0, 1] with [No, Yes]
    df$Enabled <- str_replace(df$Enabled, "0", "No")
    df$Enabled <- str_replace(df$Enabled, "1", "Yes")

    # Drop the algorithm_id, dataset_id_left, and dataset_id_right value
    df <- subset(df, select = -c(algorithm_id, iteration_id))

    # Reorder the columns so that 'Blocking Keys' and 'Matching Keys' come after 'Linkage Method'
    df <- df[, c('Iteration Name', 'Iteration Order/Priority', 'Linkage Method', 'Blocking Keys', 'Matching Keys',
                 'Acceptance Rules', 'Modified Date', 'Modified By', 'Enabled')]

    # Put it into a data table now
    dt <- datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE, dom = 'tp'))
  }

  # Renders the data table of previously used iterations that can be added to the selected algorithm
  output$previously_used_iterations <- renderDataTable({
    get_linkage_iterations_add_existing()
  })

  # If user wants to create a new iteration from scratch, send them to the next page
  observeEvent(input$add_new_linkage_iteration, {
    # Set the global variable values to being empty, since we're starting from scratch
    left_blocking_keys_to_add        <<- c()
    right_blocking_keys_to_add       <<- c()
    blocking_linkage_rules_to_add    <<- c()

    left_matching_keys_to_add        <<- c()
    right_matching_keys_to_add       <<- c()
    matching_linkage_rules_to_add    <<- c()
    matching_comparison_rules_to_add <<- c()

    # Set the back page to here and give them the algorithm ID we're part of
    add_linkage_iterations_algorithm_id <<- view_linkage_iterations_algorithm_id
    add_linkage_iterations_return_page  <<- "view_linkage_iterations_page"
    add_linkage_iterations_left_dataset_id  <<- view_linkage_iterations_left_dataset_id
    add_linkage_iterations_right_dataset_id <<- view_linkage_iterations_right_dataset_id
    existing_iteration_id <<- 0

    # Update the table of matching and blocking keys on that page
    output$add_blocking_variables_table <- renderDataTable({
      get_blocking_keys_to_add()
    })
    output$add_matching_variables_table <- renderDataTable({
      get_matching_keys_to_add()
    })
    output$add_iteration_linkage_method_input <- renderUI({
      get_linkage_methods_to_add()
    })
    output$add_left_blocking_field_input <- renderUI({
      get_left_dataset_blocking_fields_to_add()
    })
    output$add_right_blocking_field_input <- renderUI({
      get_right_dataset_blocking_fields_to_add()
    })
    output$update_left_blocking_field_input <- renderUI({
      get_left_dataset_blocking_fields_to_update()
    })
    output$update_right_blocking_field_input <- renderUI({
      get_right_dataset_blocking_fields_to_update()
    })
    output$add_left_matching_field_input <- renderUI({
      get_left_dataset_matching_fields_to_add()
    })
    output$add_right_matching_field_input <- renderUI({
      get_right_dataset_matching_fields_to_add()
    })
    output$update_left_matching_field_input <- renderUI({
      get_left_dataset_matching_fields_to_update()
    })
    output$update_right_matching_field_input <- renderUI({
      get_right_dataset_matching_fields_to_update()
    })

    # Pre-populate the general information
    updateTextAreaInput(session, "add_iteration_name", value = "")
    updateNumericInput(session, "add_iteration_order", value = NA)
    iteration_acceptance_rule_to_add <<- NA
    output$selected_iteration_acceptance_rule <- renderText({
      " "
    })

    # Show the add linkage iteration page
    nav_show('main_navbar', 'add_linkage_iterations_page')
    updateNavbarPage(session, "main_navbar", selected = "add_linkage_iterations_page")
  })

  # If user wants to create a new iteration using a previously defined one
  observeEvent(input$add_existing_linkage_iteration, {
    # Query to get all the algorithm IDs that belong to these two datasets
    query <- paste('SELECT * FROM linkage_algorithms
                    WHERE dataset_id_left =', view_linkage_iterations_left_dataset_id, 'AND dataset_id_right =', view_linkage_iterations_right_dataset_id,
                   'ORDER BY algorithm_id ASC;')
    algorithms_df <- dbGetQuery(linkage_metadata_conn, query)

    # Go through each row in all the linkage algorithms, and bind the dataframe to one large one
    df <- data.frame()

    if(nrow(algorithms_df) > 0){
      for(i in 1:nrow(algorithms_df)){
        # Get the algorithm ID
        algorithm_id <- algorithms_df$algorithm_id[i]

        # If this isnt the current algorithm we're viewing, ignore it, otherwise, get the rows and bind them
        if(algorithm_id != view_linkage_iterations_algorithm_id){
          # Query to get all linkage iteration information from the 'linkage_iterations' table
          query <- paste('SELECT * FROM linkage_iterations
                WHERE algorithm_id =', algorithm_id,
                         'ORDER BY iteration_num ASC;')
          df_temp <- dbGetQuery(linkage_metadata_conn, query)

          # Bind the data frame
          df <- rbind(df, df_temp)
        }
      }
    }

    # With the completed data frame, get the row we selected
    selected_row <- input$previously_used_iterations_rows_selected

    # Grab the iteration id
    iteration_id <- df[selected_row, "iteration_id"]

    # Get the blocking variables for this iteration
    query <- paste('SELECT * FROM blocking_variables
                WHERE iteration_id =', iteration_id,
                   'ORDER BY iteration_id ASC;')
    df_temp <- dbGetQuery(linkage_metadata_conn, query)

    # Prepare the global variables
    left_blocking_keys_to_add        <<- df_temp$left_dataset_field_id
    right_blocking_keys_to_add       <<- df_temp$right_dataset_field_id
    blocking_linkage_rules_to_add    <<- df_temp$linkage_rule_id

    # Get the blocking variables for this iteration
    query <- paste('SELECT * FROM matching_variables
                WHERE iteration_id =', iteration_id,
                   'ORDER BY iteration_id ASC;')
    df_temp <- dbGetQuery(linkage_metadata_conn, query)

    # Prepare the global variables
    left_matching_keys_to_add        <<- df_temp$left_dataset_field_id
    right_matching_keys_to_add       <<- df_temp$right_dataset_field_id
    matching_linkage_rules_to_add    <<- df_temp$linkage_rule_id
    matching_comparison_rules_to_add <<- df_temp$comparison_rule_id

    # Set the back page to here and give them the algorithm ID we're part of
    add_linkage_iterations_algorithm_id <<- view_linkage_iterations_algorithm_id
    add_linkage_iterations_return_page  <<- "view_linkage_iterations_page"
    add_linkage_iterations_left_dataset_id  <<- view_linkage_iterations_left_dataset_id
    add_linkage_iterations_right_dataset_id <<- view_linkage_iterations_right_dataset_id
    existing_iteration_id <<- 0

    # Update the table of matching and blocking keys on that page
    output$add_blocking_variables_table <- renderDataTable({
      get_blocking_keys_to_add()
    })
    output$add_matching_variables_table <- renderDataTable({
      get_matching_keys_to_add()
    })
    # output$add_iteration_linkage_method_input <- renderUI({
    #   get_linkage_methods_to_add()
    # })
    output$add_left_blocking_field_input <- renderUI({
      get_left_dataset_blocking_fields_to_add()
    })
    output$add_right_blocking_field_input <- renderUI({
      get_right_dataset_blocking_fields_to_add()
    })
    output$update_left_blocking_field_input <- renderUI({
      get_left_dataset_blocking_fields_to_update()
    })
    output$update_right_blocking_field_input <- renderUI({
      get_right_dataset_blocking_fields_to_update()
    })
    output$add_left_matching_field_input <- renderUI({
      get_left_dataset_matching_fields_to_add()
    })
    output$add_right_matching_field_input <- renderUI({
      get_right_dataset_matching_fields_to_add()
    })
    output$update_left_matching_field_input <- renderUI({
      get_left_dataset_matching_fields_to_update()
    })
    output$update_right_matching_field_input <- renderUI({
      get_right_dataset_matching_fields_to_update()
    })

    # Get the general iteration information from the database
    query <- paste('SELECT * FROM linkage_iterations
                WHERE iteration_id =', iteration_id,
                   'ORDER BY iteration_id ASC;')
    df_temp <- dbGetQuery(linkage_metadata_conn, query)

    iteration_name     <- df_temp$iteration_name
    iteration_num      <- df_temp$iteration_num
    linkage_method_id  <- df_temp$linkage_method_id
    acceptance_rule_id <- df_temp$acceptance_rule_id

    # Pre-populate the general information from the database
    updateTextAreaInput(session, "add_iteration_name", value = iteration_name)
    updateNumericInput(session, "add_iteration_order", value = iteration_num)
    updateSelectizeInput(session, "add_iteration_linkage_method", selected = linkage_method_id)
    iteration_acceptance_rule_to_add <<- acceptance_rule_id
    if(!is.na(acceptance_rule_id)){
      # Query to get the acceptance method name from the acceptance_rules table
      method_query <- paste('SELECT method_name FROM acceptance_rules ar
                           JOIN acceptance_methods am on ar.acceptance_method_id = am.acceptance_method_id
                           WHERE acceptance_rule_id =', acceptance_rule_id)
      method_name <- dbGetQuery(linkage_metadata_conn, method_query)$method_name

      # Query to get the associated parameters for the acceptance_rule_id
      params_query <- paste('SELECT parameter FROM acceptance_rules_parameters WHERE acceptance_rule_id =', acceptance_rule_id)
      params_df <- dbGetQuery(linkage_metadata_conn, params_query)

      # Combine the parameters into a string
      params_str <- paste(params_df$parameter, collapse = ", ")

      # Create the final string "method_name (key1=value1, key2=value2)"
      method_with_params <- paste0(method_name, " (", params_str, ")")
      output$selected_iteration_acceptance_rule <- renderText({
        method_with_params
      })
    }

    # Show the add linkage iteration page
    nav_show('main_navbar', 'add_linkage_iterations_page')
    updateNavbarPage(session, "main_navbar", selected = "add_linkage_iterations_page")
  })

  # If the user wants to toggle an iteration
  observeEvent(input$toggle_linkage_iteration, {
    # Get the row that we're supposed to be toggling
    #----#
    algorithm_id <- view_linkage_iterations_algorithm_id
    selected_row     <- input$currently_added_linkage_iterations_rows_selected
    # Query to get all linkage iteration information from the 'linkage_iterations' table
    query <- paste('SELECT * FROM linkage_iterations
                WHERE algorithm_id =', algorithm_id,
                   'ORDER BY iteration_num ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    iteration_id   <- df$iteration_id[selected_row]
    iteration_name <- df$iteration_name[selected_row]
    enabled_value  <- df$enabled[selected_row]
    #----#

    # Create a query for updating the enabled value of the record
    #----#
    if(enabled_value == 1){
      update_query <- paste("UPDATE linkage_iterations
                          SET enabled = 0
                          WHERE iteration_id = ?")
      update <- dbSendStatement(linkage_metadata_conn, update_query)
      dbBind(update, list(iteration_id))
      dbClearResult(update)
    }else{
      # Error handling - don't allow user to have two iterations enabled with the same name
      #----#
      get_query <- dbSendQuery(linkage_metadata_conn, 'SELECT * FROM linkage_iterations WHERE algorithm_id = ? AND iteration_name = ? AND enabled = 1;')
      dbBind(get_query, list(algorithm_id, iteration_name))
      output_df <- dbFetch(get_query)
      enabled_databases <- nrow(output_df)
      dbClearResult(get_query)

      if(is.na(enabled_databases) || is.null(enabled_databases) || enabled_databases != 0){
        showNotification("Failed to Enable Algorithm - Algorithm with the same name is already enabled", type = "error", closeButton = FALSE)
        return()
      }
      #----#

      update_query <- paste("UPDATE linkage_iterations
                          SET enabled = 1
                          WHERE iteration_id = ?")
      update <- dbSendStatement(linkage_metadata_conn, update_query)
      dbBind(update, list(iteration_id))
      dbClearResult(update)
    }
    #----#

    # Re-render data tables and reset UI
    #----#
    output$currently_added_linkage_iterations <- renderDataTable({
      get_linkage_iterations_view()
    })
    #----#

    # Send a success notification
    #----#
    if(enabled_value == 1){
      showNotification("Iteration Successfully Disabled", type = "message", closeButton = FALSE)
    }else{
      showNotification("Iteration Successfully Enabled", type = "message", closeButton = FALSE)
    }
  })

  # If the user wants to update the iteration (and its fields)
  observeEvent(input$modify_linkage_iteration, {
    # Get the selected algorithm ID and the selected row
    algorithm_id <- view_linkage_iterations_algorithm_id
    selected_row <- input$currently_added_linkage_iterations_rows_selected

    # Query to get all linkage iteration information from the 'linkage_iterations' table
    query <- paste('SELECT * FROM linkage_iterations
                WHERE algorithm_id =', algorithm_id,
                   'ORDER BY iteration_num ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    # Grab the iteration id
    iteration_id <- df$iteration_id[selected_row]

    # Get the blocking variables for this iteration
    query <- paste('SELECT * FROM blocking_variables
                WHERE iteration_id =', iteration_id,
                   'ORDER BY iteration_id ASC;')
    df_temp <- dbGetQuery(linkage_metadata_conn, query)

    # Prepare the global variables
    left_blocking_keys_to_add        <<- df_temp$left_dataset_field_id
    right_blocking_keys_to_add       <<- df_temp$right_dataset_field_id
    blocking_linkage_rules_to_add    <<- df_temp$linkage_rule_id

    # Get the blocking variables for this iteration
    query <- paste('SELECT * FROM matching_variables
                WHERE iteration_id =', iteration_id,
                   'ORDER BY iteration_id ASC;')
    df_temp <- dbGetQuery(linkage_metadata_conn, query)

    # Prepare the global variables
    left_matching_keys_to_add        <<- df_temp$left_dataset_field_id
    right_matching_keys_to_add       <<- df_temp$right_dataset_field_id
    matching_linkage_rules_to_add    <<- df_temp$linkage_rule_id
    matching_comparison_rules_to_add <<- df_temp$comparison_rule_id

    # Set the back page to here and give them the algorithm ID we're part of
    add_linkage_iterations_algorithm_id     <<- view_linkage_iterations_algorithm_id
    add_linkage_iterations_return_page      <<- "view_linkage_iterations_page"
    add_linkage_iterations_left_dataset_id  <<- view_linkage_iterations_left_dataset_id
    add_linkage_iterations_right_dataset_id <<- view_linkage_iterations_right_dataset_id
    existing_iteration_id                   <<- iteration_id

    # Update the table of matching and blocking keys on that page
    output$add_blocking_variables_table <- renderDataTable({
      get_blocking_keys_to_add()
    })
    output$add_matching_variables_table <- renderDataTable({
      get_matching_keys_to_add()
    })
    output$add_left_blocking_field_input <- renderUI({
      get_left_dataset_blocking_fields_to_add()
    })
    output$add_right_blocking_field_input <- renderUI({
      get_right_dataset_blocking_fields_to_add()
    })
    output$update_left_blocking_field_input <- renderUI({
      get_left_dataset_blocking_fields_to_update()
    })
    output$update_right_blocking_field_input <- renderUI({
      get_right_dataset_blocking_fields_to_update()
    })
    output$add_left_matching_field_input <- renderUI({
      get_left_dataset_matching_fields_to_add()
    })
    output$add_right_matching_field_input <- renderUI({
      get_right_dataset_matching_fields_to_add()
    })
    output$update_left_matching_field_input <- renderUI({
      get_left_dataset_matching_fields_to_update()
    })
    output$update_right_matching_field_input <- renderUI({
      get_right_dataset_matching_fields_to_update()
    })

    # Get the general iteration information from the database
    query <- paste('SELECT * FROM linkage_iterations
                WHERE iteration_id =', iteration_id,
                   'ORDER BY iteration_id ASC;')
    df_temp <- dbGetQuery(linkage_metadata_conn, query)

    iteration_name     <- df_temp$iteration_name
    iteration_num      <- df_temp$iteration_num
    linkage_method_id  <- df_temp$linkage_method_id
    acceptance_rule_id <- df_temp$acceptance_rule_id

    # Pre-populate the general information from the database
    updateTextAreaInput(session, "add_iteration_name", value = iteration_name)
    updateNumericInput(session, "add_iteration_order", value = iteration_num)
    updateSelectizeInput(session, "add_iteration_linkage_method", selected = linkage_method_id)
    iteration_acceptance_rule_to_add <<- acceptance_rule_id
    if(!is.na(acceptance_rule_id)){
      # Query to get the acceptance method name from the acceptance_rules table
      method_query <- paste('SELECT method_name FROM acceptance_rules ar
                           JOIN acceptance_methods am on ar.acceptance_method_id = am.acceptance_method_id
                           WHERE acceptance_rule_id =', acceptance_rule_id)
      method_name <- dbGetQuery(linkage_metadata_conn, method_query)$method_name

      # Query to get the associated parameters for the acceptance_rule_id
      params_query <- paste('SELECT parameter FROM acceptance_rules_parameters WHERE acceptance_rule_id =', acceptance_rule_id)
      params_df <- dbGetQuery(linkage_metadata_conn, params_query)

      # Combine the parameters into a string
      params_str <- paste(params_df$parameter, collapse = ", ")

      # Create the final string "method_name (key1=value1, key2=value2)"
      method_with_params <- paste0(method_name, " (", params_str, ")")
      output$selected_iteration_acceptance_rule <- renderText({
        method_with_params
      })
    }

    # Show the add linkage iteration page
    nav_show('main_navbar', 'add_linkage_iterations_page')
    updateNavbarPage(session, "main_navbar", selected = "add_linkage_iterations_page")
  })

  #----
  #-----------------------------------------#

  #-- ADD LINKAGE ITERATION PAGE EVENTS --#
  #----
  # GLOBAL VARIABLES FOR RETURNING TO PREVIOUS PAGE
  add_linkage_iterations_return_page  <- "view_linkage_algorithms_page"

  # GLOBAL VARIABLES FOR ITERATION SPECIFIC INFORMATION
  add_linkage_iterations_algorithm_id <- 1
  add_linkage_iterations_left_dataset_id  <- 1
  add_linkage_iterations_right_dataset_id <- 1
  existing_iteration_id <- 0

  # GLOBAL VARIABLES FOR STORING THE TEMPORARY BLOCKING AND MATCHING KEYS + THEIR RULES
  left_blocking_keys_to_add        <- c()
  right_blocking_keys_to_add       <- c()
  blocking_linkage_rules_to_add    <- c()

  left_matching_keys_to_add        <- c()
  right_matching_keys_to_add       <- c()
  matching_linkage_rules_to_add    <- c()
  matching_comparison_rules_to_add <- c()

  # GLOBAL VARIABLES FOR STORING THE ACCEPTANCE RULES, PREPARED LINKAGE RULES, AND PREPARED COMPARISON RULES
  iteration_acceptance_rule_to_add   <- NA
  blocking_linkage_rule_to_add       <- NA
  blocking_linkage_rule_to_update    <- NA
  matching_linkage_rule_to_add       <- NA
  matching_linkage_rule_to_update    <- NA
  matching_comparison_rule_to_add    <- NA
  matching_comparison_rule_to_update <- NA

  #-- SELECT INPUT UI FOR ADDING AND UPDATING BLOCKING FIELDS --#
  # Creates the select input UI for available left fields
  get_left_dataset_blocking_fields_to_add <- function(){

    # Perform query using linkage_metadata_conn
    query_result <- dbGetQuery(linkage_metadata_conn, paste("SELECT * from dataset_fields WHERE dataset_id =", add_linkage_iterations_left_dataset_id))

    # Extract columns from query result
    choices <- setNames(query_result$field_id, query_result$field_name)

    # Create select input with dynamic choices
    span(selectizeInput("left_blocking_field_add", label = "Left Dataset Field:",
                     choices = choices, multiple = FALSE, width = validateCssUnit(300),
                     options = list(
                       placeholder = 'Select a Left Blocking Field',
                       onInitialize = I('function() { this.setValue(""); }')
                     )))
  }

  # Creates the select input UI for available right fields
  get_right_dataset_blocking_fields_to_add <- function(){

    # Perform query using linkage_metadata_conn
    query_result <- dbGetQuery(linkage_metadata_conn, paste("SELECT * from dataset_fields WHERE dataset_id =", add_linkage_iterations_right_dataset_id))

    # Extract columns from query result
    choices <- setNames(query_result$field_id, query_result$field_name)

    # Create select input with dynamic choices
    span(selectizeInput("right_blocking_field_add", label = "Right Dataset Field:",
                     choices = choices, multiple = FALSE, width = validateCssUnit(300),
                     options = list(
                       placeholder = 'Select a Right Blocking Field',
                       onInitialize = I('function() { this.setValue(""); }')
                     )))
  }

  # Creates the select input UI for available left fields
  get_left_dataset_blocking_fields_to_update <- function(){

    # Perform query using linkage_metadata_conn
    query_result <- dbGetQuery(linkage_metadata_conn, paste("SELECT * from dataset_fields WHERE dataset_id =", add_linkage_iterations_left_dataset_id))

    # Extract columns from query result
    choices <- setNames(query_result$field_id, query_result$field_name)

    # Create select input with dynamic choices
    span(selectizeInput("left_blocking_field_update", label = "Left Dataset Field:",
                     choices = choices, multiple = FALSE, width = validateCssUnit(300),
                     options = list(
                       placeholder = 'Select a Left Blocking Field',
                       onInitialize = I('function() { this.setValue(""); }')
                     )))
  }

  # Creates the select input UI for available right fields
  get_right_dataset_blocking_fields_to_update <- function(){

    # Perform query using linkage_metadata_conn
    query_result <- dbGetQuery(linkage_metadata_conn, paste("SELECT * from dataset_fields WHERE dataset_id =", add_linkage_iterations_right_dataset_id))

    # Extract columns from query result
    choices <- setNames(query_result$field_id, query_result$field_name)

    # Create select input with dynamic choices
    span(selectizeInput("right_blocking_field_update", label = "Right Dataset Field:",
                     choices = choices, multiple = FALSE, width = validateCssUnit(300),
                     options = list(
                       placeholder = 'Select a Right Blocking Field',
                       onInitialize = I('function() { this.setValue(""); }')
                     )))
  }

  # Renders the UI for the left blocking field add select input
  output$add_left_blocking_field_input <- renderUI({
    get_left_dataset_blocking_fields_to_add()
  })

  # Renders the UI for the right blocking field add select input
  output$add_right_blocking_field_input <- renderUI({
    get_right_dataset_blocking_fields_to_add()
  })

  # Renders the UI for the left blocking field update select input
  output$update_left_blocking_field_input <- renderUI({
    get_left_dataset_blocking_fields_to_update()
  })

  # Renders the UI for the right blocking field update select input
  output$update_right_blocking_field_input <- renderUI({
    get_right_dataset_blocking_fields_to_update()
  })
  #-------------------------------------------------------------#

  #-- SELECT INPUT UI FOR ADDING AND UPDATING MATCHING FIELDS --#
  # Creates the select input UI for available left fields
  get_left_dataset_matching_fields_to_add <- function(){

    # Perform query using linkage_metadata_conn
    query_result <- dbGetQuery(linkage_metadata_conn, paste("SELECT * from dataset_fields WHERE dataset_id =", add_linkage_iterations_left_dataset_id))

    # Extract columns from query result
    choices <- setNames(query_result$field_id, query_result$field_name)

    # Create select input with dynamic choices
    span(selectizeInput("left_matching_field_add", label = "Left Dataset Field:",
                        choices = choices, multiple = FALSE, width = validateCssUnit(300),
                        options = list(
                          placeholder = 'Select a Left Matching Field',
                          onInitialize = I('function() { this.setValue(""); }')
                        )))
  }

  # Creates the select input UI for available right fields
  get_right_dataset_matching_fields_to_add <- function(){

    # Perform query using linkage_metadata_conn
    query_result <- dbGetQuery(linkage_metadata_conn, paste("SELECT * from dataset_fields WHERE dataset_id =", add_linkage_iterations_right_dataset_id))

    # Extract columns from query result
    choices <- setNames(query_result$field_id, query_result$field_name)

    # Create select input with dynamic choices
    span(selectizeInput("right_matching_field_add", label = "Right Dataset Field:",
                     choices = choices, multiple = FALSE, width = validateCssUnit(300),
                     options = list(
                       placeholder = 'Select a Right Matching Field',
                       onInitialize = I('function() { this.setValue(""); }')
                     )))
  }

  # Creates the select input UI for available left fields
  get_left_dataset_matching_fields_to_update <- function(){

    # Perform query using linkage_metadata_conn
    query_result <- dbGetQuery(linkage_metadata_conn, paste("SELECT * from dataset_fields WHERE dataset_id =", add_linkage_iterations_left_dataset_id))

    # Extract columns from query result
    choices <- setNames(query_result$field_id, query_result$field_name)

    # Create select input with dynamic choices
    span(selectizeInput("left_matching_field_update", label = "Left Dataset Field:",
                     choices = choices, multiple = FALSE, width = validateCssUnit(300),
                     options = list(
                       placeholder = 'Select a Left Matching Field',
                       onInitialize = I('function() { this.setValue(""); }')
                     )))
  }

  # Creates the select input UI for available right fields
  get_right_dataset_matching_fields_to_update <- function(){

    # Perform query using linkage_metadata_conn
    query_result <- dbGetQuery(linkage_metadata_conn, paste("SELECT * from dataset_fields WHERE dataset_id =", add_linkage_iterations_right_dataset_id))

    # Extract columns from query result
    choices <- setNames(query_result$field_id, query_result$field_name)

    # Create select input with dynamic choices
    span(selectizeInput("right_matching_field_update", label = "Right Dataset Field:",
                     choices = choices, multiple = FALSE, width = validateCssUnit(300),
                     options = list(
                       placeholder = 'Select a Right Matching Field',
                       onInitialize = I('function() { this.setValue(""); }')
                     )))
  }

  # Renders the UI for the left blocking field add select input
  output$add_left_matching_field_input <- renderUI({
    get_left_dataset_matching_fields_to_add()
  })

  # Renders the UI for the right blocking field add select input
  output$add_right_matching_field_input <- renderUI({
    get_right_dataset_matching_fields_to_add()
  })

  # Renders the UI for the left blocking field update select input
  output$update_left_matching_field_input <- renderUI({
    get_left_dataset_matching_fields_to_update()
  })

  # Renders the UI for the right blocking field update select input
  output$update_right_matching_field_input <- renderUI({
    get_right_dataset_matching_fields_to_update()
  })
  #-------------------------------------------------------------#

  #-- REMOVE ACCEPTANCE, LINKAGE, AND COMPARISON RULE BUTTONS --#
  # Remove the acceptance rule for this iteration
  observeEvent(input$remove_iteration_acceptance_rule, {
    # Set the global variable value to NA
    iteration_acceptance_rule_to_add <<- NA

    # Render the text output to not include anything
    output$selected_iteration_acceptance_rule <- renderText({
      " "
    })
  })

  # Remove the linkage rule from blocking variable being added
  observeEvent(input$remove_blocking_linkage_rule, {
    # Set the global variable value to NA
    blocking_linkage_rule_to_add <<- NA

    # Render the text output to not include anything
    output$blocking_linkage_rules_add <- renderText({
      " "
    })
  })

  # Remove the linkage rule from blocking variable being updated
  observeEvent(input$remove_blocking_linkage_rule_update, {
    # Set the global variable value to NA
    blocking_linkage_rule_to_update <<- NA

    # Render the text output to not include anything
    output$blocking_linkage_rules_update <- renderText({
      " "
    })
  })

  # Remove the linkage rule from matching variable being added
  observeEvent(input$remove_matching_linkage_rule, {
    # Set the global variable value to NA
    matching_linkage_rule_to_add <<- NA

    # Render the text output to not include anything
    output$matching_linkage_rules_add <- renderText({
      " "
    })
  })

  # Remove the linkage rule from matching variable being updated
  observeEvent(input$remove_matching_linkage_rule_update, {
    # Set the global variable value to NA
    matching_linkage_rule_to_update <<- NA

    # Render the text output to not include anything
    output$matching_linkage_rules_update <- renderText({
      " "
    })
  })

  # Remove the comparison rule from matching variable being added
  observeEvent(input$remove_matching_comparison_rule, {
    # Set the global variable value to NA
    matching_comparison_rule_to_add <<- NA

    # Render the text output to not include anything
    output$matching_comparison_rules_add <- renderText({
      " "
    })
  })

  # Remove the comparison rule from matching variable being updated
  observeEvent(input$remove_matching_comparison_rule_update, {
    # Set the global variable value to NA
    matching_comparison_rule_to_update <<- NA

    # Render the text output to not include anything
    output$matching_comparison_rules_update <- renderText({
      " "
    })
  })
  #-------------------------------------------------------------#

  # Creates the select input UI for the left dataset
  get_linkage_methods_to_add <- function(){

    # Get all linkage methods
    query <- paste('SELECT * FROM linkage_methods
                ORDER BY linkage_method_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    # For all method IDs, combine the label and implementation name
    for(i in 1:nrow(df)){
      # Create a string with the implementation name and label together
      linkage_method_and_technique <- paste0(df$implementation_name[i], " (", df$technique_label[i], ")")

      # Replace the linkage method ID with the string
      df$implementation_name[i] <- linkage_method_and_technique
    }

    # Extract columns from query result
    choices <- setNames(df$linkage_method_id, df$implementation_name)

    # Create select input with dynamic choices
    span(selectizeInput("add_iteration_linkage_method", label = "Linkage Implementation:",
                     choices = choices, multiple = FALSE, width = validateCssUnit(300),
                     options = list(
                       placeholder = 'Select Implementation & Method',
                       onInitialize = I('function() { this.setValue(""); }')
                     )))
  }

  # Renders the UI for the linkage method select input
  output$add_iteration_linkage_method_input <- renderUI({
    get_linkage_methods_to_add()
  })

  # Function for creating the table of blocking keys to be added
  get_blocking_keys_to_add <- function(){
    # Create a data frame from all the parameter keys
    df <- data.frame(
      left_keys  = if(length(left_blocking_keys_to_add) == 0) numeric() else left_blocking_keys_to_add,
      right_keys = if(length(right_blocking_keys_to_add) == 0) numeric() else right_blocking_keys_to_add,
      rules      = if(length(blocking_linkage_rules_to_add) == 0) numeric() else blocking_linkage_rules_to_add
    )

    # If we have rows, perform queries to convert the IDs into actual text
    if(nrow(df) > 0){
      # Loop through each row in the dataframe to replace the linkage_rule_id with the method name and parameters
      for (i in 1:nrow(df)) {

        # Get the left blocking key for the current row
        left_blocking_id <- df$left_keys[i]
        if(!is.na(left_blocking_id)){
          # Query to get the left blocking field name
          query <- paste('SELECT * FROM dataset_fields
                           WHERE field_id =', left_blocking_id)
          df_temp <- dbGetQuery(linkage_metadata_conn, query)

          # Grab the field name from the data frame
          field_name <- df_temp$field_name

          # Place it into the left_keys location
          df$left_keys[i] <- field_name
        }

        # Get the left blocking key for the current row
        right_blocking_id <- df$right_keys[i]
        if(!is.na(right_blocking_id)){
          # Query to get the left blocking field name
          query <- paste('SELECT * FROM dataset_fields
                           WHERE field_id =', right_blocking_id)
          df_temp <- dbGetQuery(linkage_metadata_conn, query)

          # Grab the field name from the data frame
          field_name <- df_temp$field_name

          # Place it into the right_keys location
          df$right_keys[i] <- field_name
        }

        # Get the linkage_rule_id for the current row
        linkage_rule_id <- df$rules[i]
        if (nrow(df) > 0 && !is.na(linkage_rule_id)){
          # Query to get the acceptance method name from the comparison_rules table
          method_query <- paste('SELECT * FROM linkage_rules
                           WHERE linkage_rule_id =', linkage_rule_id)
          method_df <- dbGetQuery(linkage_metadata_conn, method_query)

          # We'll start with "Alternative Field"
          alt_field_val <- method_df$alternate_field_value
          if(!is.na(alt_field_val)){
            method_df$alternate_field_value <- paste0(scales::ordinal(as.numeric(alt_field_val)), " Field Value")
          }

          # Next we'll handle the "Integer Variance"
          int_variance <- method_df$integer_value_variance
          if(!is.na(int_variance)){
            method_df$integer_value_variance <- paste0("±", int_variance)
          }

          # Next we'll handle "Name Substring"
          name_substring <- method_df$substring_length
          if(!is.na(name_substring)){
            method_df$substring_length <- paste0("First ", name_substring, " character(s)")
          }

          # With standardized names, we'll replace the [0, 1] with [No, Yes]
          method_df$standardize_names <- str_replace(method_df$standardize_names, "1", "Standardize Names")

          # Rename the column names to be easier to read when printed in table format
          names(method_df)[names(method_df) == 'alternate_field_value'] <- 'Alternate Field Number'
          names(method_df)[names(method_df) == 'integer_value_variance'] <- 'Integer Value Variance'
          names(method_df)[names(method_df) == 'substring_length'] <- 'Substring Length'
          names(method_df)[names(method_df) == 'standardize_names'] <- 'Standardize Names'

          # Drop the linkage_rule_id from the table
          method_df <- subset(method_df, select = -c(linkage_rule_id))

          # Initialize an empty list to store non-NA values
          non_na_values <- list()

          # Loop through each column in the current row
          for (col_name in colnames(method_df)) {
            value <- method_df[1, col_name]

            # If the value is not NA, add it to the list
            if (!is.na(value)) {
              non_na_values <- c(non_na_values, paste0(value))
            }
          }

          # Combine the non-NA values into a single string, separated by commas
          combined_values <- paste(non_na_values, collapse = ", ")

          # Place the combined values into the data frame
          df$rules[i] <- combined_values
        }
      }
    }

    # With our data frame, we'll rename some of the columns to look better
    names(df)[names(df) == 'left_keys']  <- 'Blocking Left Field'
    names(df)[names(df) == 'right_keys'] <- 'Blocking Right Field'
    names(df)[names(df) == 'rules']      <- 'Linkage Rules'

    # Put it into a data table now
    dt <- datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE, dom = 'tp'))
  }

  # Renders the data table of blocking keys that are to be added
  output$add_blocking_variables_table <- renderDataTable({
    get_blocking_keys_to_add()
  })

  # Function for creating the table of matching keys to be added
  get_matching_keys_to_add <- function(){
    # Create a data frame from all the parameter keys
    df <- data.frame(
      left_keys  = if(length(left_matching_keys_to_add) == 0) numeric() else left_matching_keys_to_add,
      right_keys = if(length(right_matching_keys_to_add) == 0) numeric() else right_matching_keys_to_add,
      link_rules = if(length(matching_linkage_rules_to_add) == 0) numeric() else matching_linkage_rules_to_add,
      comp_rules = if(length(matching_comparison_rules_to_add) == 0) numeric() else matching_comparison_rules_to_add
    )

    # If we have rows, perform queries to convert the IDs into actual text
    if(nrow(df) > 0){
      # Loop through each row in the dataframe to replace the linkage_rule_id with the method name and parameters
      for (i in 1:nrow(df)) {

        # Get the left blocking key for the current row
        left_blocking_id <- df$left_keys[i]
        if(!is.na(left_blocking_id)){
          # Query to get the left blocking field name
          query <- paste('SELECT * FROM dataset_fields
                           WHERE field_id =', left_blocking_id)
          df_temp <- dbGetQuery(linkage_metadata_conn, query)

          # Grab the field name from the data frame
          field_name <- df_temp$field_name

          # Place it into the left_keys location
          df$left_keys[i] <- field_name
        }

        # Get the left blocking key for the current row
        right_blocking_id <- df$right_keys[i]
        if(!is.na(right_blocking_id)){
          # Query to get the left blocking field name
          query <- paste('SELECT * FROM dataset_fields
                           WHERE field_id =', right_blocking_id)
          df_temp <- dbGetQuery(linkage_metadata_conn, query)

          # Grab the field name from the data frame
          field_name <- df_temp$field_name

          # Place it into the right_keys location
          df$right_keys[i] <- field_name
        }

        # Get the linkage_rule_id for the current row
        linkage_rule_id <- df$link_rules[i]
        if (nrow(df) > 0 && !is.na(linkage_rule_id)){
          # Query to get the acceptance method name from the comparison_rules table
          method_query <- paste('SELECT * FROM linkage_rules
                           WHERE linkage_rule_id =', linkage_rule_id)
          method_df <- dbGetQuery(linkage_metadata_conn, method_query)

          # We'll start with "Alternative Field"
          alt_field_val <- method_df$alternate_field_value
          if(!is.na(alt_field_val)){
            method_df$alternate_field_value <- paste0(scales::ordinal(as.numeric(alt_field_val)), " Field Value")
          }

          # Next we'll handle the "Integer Variance"
          int_variance <- method_df$integer_value_variance
          if(!is.na(int_variance)){
            method_df$integer_value_variance <- paste0("±", int_variance)
          }

          # Next we'll handle "Name Substring"
          name_substring <- method_df$substring_length
          if(!is.na(name_substring)){
            method_df$substring_length <- paste0("First ", name_substring, " character(s)")
          }

          # With standardized names, we'll replace the [0, 1] with [No, Yes]
          method_df$standardize_names <- str_replace(method_df$standardize_names, "1", "Standardize Names")

          # Rename the column names to be easier to read when printed in table format
          names(method_df)[names(method_df) == 'alternate_field_value'] <- 'Alternate Field Number'
          names(method_df)[names(method_df) == 'integer_value_variance'] <- 'Integer Value Variance'
          names(method_df)[names(method_df) == 'substring_length'] <- 'Substring Length'
          names(method_df)[names(method_df) == 'standardize_names'] <- 'Standardize Names'

          # Drop the linkage_rule_id from the table
          method_df <- subset(method_df, select = -c(linkage_rule_id))

          # Initialize an empty list to store non-NA values
          non_na_values <- list()

          # Loop through each column in the current row
          for (col_name in colnames(method_df)) {
            value <- method_df[1, col_name]

            # If the value is not NA, add it to the list
            if (!is.na(value)) {
              non_na_values <- c(non_na_values, paste0(value))
            }
          }

          # Combine the non-NA values into a single string, separated by commas
          combined_values <- paste(non_na_values, collapse = ", ")

          # Place the combined values into the data frame
          df$link_rules[i] <- combined_values
        }

        # Get the comparison_rule_id for the current row
        comparison_rule_id <- df$comp_rules[i]
        if(nrow(df) > 0 && !is.na(comparison_rule_id)){
          # Query to get the acceptance method name from the comparison_rules table
          method_query <- paste('SELECT method_name FROM comparison_rules cr
                           JOIN comparison_methods cm on cr.comparison_method_id = cm.comparison_method_id
                           WHERE comparison_rule_id =', comparison_rule_id)
          method_name <- dbGetQuery(linkage_metadata_conn, method_query)$method_name

          # Query to get the associated parameters for the comparison_rule_id
          params_query <- paste('SELECT parameter FROM comparison_rules_parameters WHERE comparison_rule_id =', comparison_rule_id)
          params_df <- dbGetQuery(linkage_metadata_conn, params_query)

          # Combine the parameters into a string
          params_str <- paste(params_df$parameter, collapse = ", ")

          # Create the final string "method_name (key1=value1, key2=value2)"
          method_with_params <- paste0(method_name, " (", params_str, ")")

          # Replace the comparison_rule_id with the method and parameters string
          df$comp_rules[i] <- method_with_params
        }
      }
    }

    # With our data frame, we'll rename some of the columns to look better
    names(df)[names(df) == 'left_keys']  <- 'Matching Left Field'
    names(df)[names(df) == 'right_keys'] <- 'Matching Right Field'
    names(df)[names(df) == 'link_rules'] <- 'Linkage Rules'
    names(df)[names(df) == 'comp_rules'] <- 'Comparison Rules'

    # Put it into a data table now
    dt <- datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE, dom = 'tp'))
  }

  # Renders the data table of matching keys that are to be added
  output$add_matching_variables_table <- renderDataTable({
    get_matching_keys_to_add()
  })

  # If user returns without saving, bring them back to the view page
  observeEvent(input$return_from_add_iterations, {
    # Show return to the page you came from
    nav_show("main_navbar", add_linkage_iterations_return_page)
    updateNavbarPage(session, "main_navbar", selected = add_linkage_iterations_return_page)
  })

  #-- DYNAMIC UI GENERATION CODE --#
  modify_iteration_get_acceptance_rule_inputs <- function(acceptance_method_id, label_name){
    # Get the parameter IDs, keys, and descriptions of the inputs we need
    query <- paste('SELECT * from acceptance_method_parameters
                   WHERE acceptance_method_id =', acceptance_method_id)
    df <- dbGetQuery(linkage_metadata_conn, query)

    # Get the number of inputs we'll need
    num_inputs <- nrow(df)

    # Construct the list of inputs
    acceptance_rule_input_list <- lapply(1:(num_inputs), function(index){
      # Using the current index, grab all the parameter information and provide a
      # numeric input for the user to enter their data.
      parameter_key  <- df[index, "parameter_key"]
      parameter_desc <- df[index, "description"]

      fluidPage(
        fluidRow(
          column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
            numericInput(paste0(label_name, index), label = h5(strong(parameter_key)),
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

  modify_iteration_get_comparison_rule_inputs <- function(comparison_method_id, label_name){
    # Get the parameter IDs, keys, and descriptions of the inputs we need
    query <- paste('SELECT * from comparison_method_parameters
                   WHERE comparison_method_id =', comparison_method_id)
    df <- dbGetQuery(linkage_metadata_conn, query)

    # Get the number of inputs we'll need
    num_inputs <- nrow(df)

    # Construct the list of inputs
    comparison_rule_input_list <- lapply(1:(num_inputs), function(index){
      # Using the current index, grab all the parameter information and provide a
      # numeric input for the user to enter their data.
      parameter_key  <- df[index, "parameter_key"]
      parameter_desc <- df[index, "description"]

      fluidPage(
        fluidRow(
          column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
            numericInput(paste0(label_name, index), label = h5(strong(parameter_key)),
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
  #--------------------------------#

  #-- GENERAL INFORMATION RELATED EVENTS --#
  # Selecting an acceptance rule for the iteration
  observeEvent(input$prepare_iteration_acceptance_rule, {
    # Generates the table of acceptance methods
    output$add_acceptance_method_iteration <- renderDataTable({
      get_acceptance_methods_and_parameters()
    })

    output$iteration_acceptance_rule_add_inputs <- renderUI({

    })

    showModal(modalDialog(
      title = "Choose Acceptance Rule",
      easyClose = TRUE,
      footer = NULL,
      fluidPage(
        # Acceptance rule table
        h5("Select an Acceptance Method & Enter Rule Parameters:"),
        layout_column_wrap(
          width = 1/2,
          height = 500,

          # Card for the acceptance methods table
          card(card_header("Acceptance Methods Table", class = "bg-dark"),
            dataTableOutput("add_acceptance_method_iteration")
          ),

          # Card for the acceptance rules UI
          card(card_header("Acceptance Rule Inputs", class = "bg-dark"),
            uiOutput("iteration_acceptance_rule_add_inputs")
          )
        ),

        # OPTION 1: User may enter a new acceptance method & parameters
        conditionalPanel(
          condition = "input.add_acceptance_method_iteration_rows_selected <= 0",
          HTML("<br>"),

          # Button for moving the user to the acceptance methods page
          fluidRow(
            h5(strong("Or, create a new acceptance method below:")),
            column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                actionButton("add_linkage_iteration_to_add_acceptance_methods", "Create Acceptance Method", class = "btn-info"),
              )
            ),
          )
        ),

        # OPTION 2: User can submit which acceptance rule they'd like to use
        conditionalPanel(
          condition = "input.add_acceptance_method_iteration_rows_selected > 0",
          HTML("<br>"),

          # Button for moving the user to the acceptance rules page
          fluidRow(
            column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                actionButton("prepare_iteration_acceptance_rule_to_add", "Add Acceptance Rule", class = "btn-success"),
              )
            )
          )
        ),
      ),
      size = "l"  # Large modal size to fit both tables
    ))
  })

  # Generates the table of acceptance methods
  output$add_acceptance_method_iteration <- renderDataTable({
    get_acceptance_methods_and_parameters()
  })

  # Generates the dynamic acceptance rule inputs
  observeEvent(input$add_acceptance_method_iteration_rows_selected, {
    selected_row <- input$add_acceptance_method_iteration_rows_selected

    if (!is.null(selected_row)) {
      # Perform a query to get the acceptance methods
      query <- paste('SELECT * from acceptance_methods')
      df <- dbGetQuery(linkage_metadata_conn, query)
      # Retrieve the acceptance method id of the selected row
      selected_method <- df$acceptance_method_id[selected_row]

      output$iteration_acceptance_rule_add_inputs <- renderUI({
        modify_iteration_get_acceptance_rule_inputs(selected_method, "modify_iteration_acceptance_rule_input")
      })
    }
    else{
      output$iteration_acceptance_rule_add_inputs <- renderUI({

      })
    }
  })

  # Selects the acceptance rule the user wanted
  observeEvent(input$prepare_iteration_acceptance_rule_to_add, {
    # Get the selected row
    selected_row <- input$add_acceptance_method_iteration_rows_selected

    # Query to get all linkage rule information from the 'acceptance_methods' table
    query <- paste('SELECT * FROM acceptance_methods
               ORDER BY acceptance_method_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    # Get the linkage rule
    acceptance_method_id <- df[selected_row, "acceptance_method_id"]

    # Get the parameter IDs, keys, and descriptions of the inputs we need
    query <- paste('SELECT * from acceptance_method_parameters
                   WHERE acceptance_method_id =', acceptance_method_id)
    df <- dbGetQuery(linkage_metadata_conn, query)

    # Get the number of inputs we'll be adding
    num_inputs <- nrow(df)
    parameter_ids <- df$parameter_id

    # Error handling
    #----#
    # Error Handling to make sure all inputs are filled
    for(index in 1:(num_inputs)){
      # Get the input value for each input
      input_val <- input[[paste0("modify_iteration_acceptance_rule_input", index)]]
      # Ensure it isn't null
      if(is.na(input_val)){
        showNotification("Failed to Use Acceptance Rule - Some Input(s) Are Missing", type = "error", closeButton = FALSE)
        return()
      }
    }
    #----#

    # If the rule already exists, then use that Acceptance Rule ID
    df <- data.frame()
    for (index in 1:(num_inputs)) {
      # Get the parameter to input
      parameter <- input[[paste0("modify_iteration_acceptance_rule_input", index)]]

      # Get the parameter ID
      parameter_id <- parameter_ids[index]

      # Check if the database has this eact match
      get_query <- dbSendQuery(linkage_metadata_conn, 'SELECT * FROM acceptance_rules_parameters
                                                  WHERE parameter_id = ? AND parameter = ?;')
      dbBind(get_query, list(parameter_id, parameter))
      output_df <- dbFetch(get_query)
      dbClearResult(get_query)
      df <- rbind(df, output_df)
    }

    # Group by the acceptance_rule_id
    df_grouped <- df %>% group_by(acceptance_rule_id) %>% filter(n() == num_inputs)

    # If it contains exactly those parameters, then there will be a row in the grouped df, so grab the acceptance rule
    acceptance_rule_id <- 0
    if(nrow(df_grouped) > 0){
      acceptance_rule_id <- df_grouped$acceptance_rule_id[1]
    }
    #----#

    # If the acceptance_rule_id is 0, then it does not exist, so create a new one
    if(acceptance_rule_id == 0){
      # Add all the necessary acceptance rule information
      successful <- TRUE
      #----#
      added_acceptance_rule_id <- tryCatch({
        # Start a transaction
        dbBegin(linkage_metadata_conn)

        # Start by creating a new acceptance rule
        new_entry_query <- paste("INSERT INTO acceptance_rules (acceptance_method_id)",
                                 "VALUES(?);")
        new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
        dbBind(new_entry, list(acceptance_method_id))
        dbClearResult(new_entry)

        # Add the dataset fields to the other table after we insert basic information
        #----#
        # Get the most recently inserted acceptance_rule_id value
        new_acceptance_rule_id <- dbGetQuery(linkage_metadata_conn, "SELECT last_insert_rowid() AS acceptance_rule_id;")$acceptance_rule_id

        # Insert each parameter value into the database
        for (index in 1:(num_inputs)) {
          # Get the parameter to input
          parameter <- input[[paste0("modify_iteration_acceptance_rule_input", index)]]

          # Get the parameter ID
          parameter_id <- parameter_ids[index]

          insert_field_query <- "INSERT INTO acceptance_rules_parameters (acceptance_rule_id, parameter_id, parameter) VALUES (?, ?, ?);"
          insert_field_stmt <- dbSendStatement(linkage_metadata_conn, insert_field_query)
          dbBind(insert_field_stmt, list(new_acceptance_rule_id, parameter_id, parameter))
          dbClearResult(insert_field_stmt)
        }

        # End a transaction
        dbCommit(linkage_metadata_conn)

        # Return the new acceptance rule
        new_acceptance_rule_id
      },
      error = function(e){
        # If we throw an error because of timeout, or bad insert, then rollback and return
        successful <- FALSE
        dbRollback(linkage_metadata_conn)
        showNotification("Failed to Add Acceptance Rule - An Error Occurred While Inserting", type = "error", closeButton = FALSE)
        return(0)
      })

      # If we didn't successfully add the acceptance rule, then return
      if(!successful) return()

      acceptance_rule_id <- added_acceptance_rule_id
      #----#
    }

    # Render the output text to make the method readable
    if(!is.na(acceptance_rule_id)){
      # Query to get the acceptance method name from the acceptance_rules table
      method_query <- paste('SELECT method_name FROM acceptance_rules ar
                           JOIN acceptance_methods am on ar.acceptance_method_id = am.acceptance_method_id
                           WHERE acceptance_rule_id =', acceptance_rule_id)
      method_name <- dbGetQuery(linkage_metadata_conn, method_query)$method_name

      # Query to get the associated parameters for the acceptance_rule_id
      params_query <- paste('SELECT parameter FROM acceptance_rules_parameters WHERE acceptance_rule_id =', acceptance_rule_id)
      params_df <- dbGetQuery(linkage_metadata_conn, params_query)

      # Combine the parameters into a string
      params_str <- paste(params_df$parameter, collapse = ", ")

      # Create the final string "method_name (key1=value1, key2=value2)"
      method_with_params <- paste0(method_name, " (", params_str, ")")
      output$selected_iteration_acceptance_rule <- renderText({
        method_with_params
      })
    }

    # Set the global variable
    iteration_acceptance_rule_to_add <<- acceptance_rule_id

    # Dismiss the modal
    removeModal()
  })

  # Brings the user to the acceptance methods page
  observeEvent(input$add_linkage_iteration_to_add_acceptance_methods, {

    # Set the return page to the add linkage iterations page
    acceptance_methods_return_page <<- "add_linkage_iterations_page"

    # Show the linkage rule page
    nav_show("main_navbar", "acceptance_methods_page")

    # Brings you to the linkage rules page
    updateNavbarPage(session, "main_navbar", selected = "acceptance_methods_page")
  })
  #----------------------------------------#

  #-- BLOCKING KEY RELATED EVENTS --#
  # Appending pair of fields and linkage rule to be blocking fields + the rule
  observeEvent(input$prepare_blocking_variables, {
    # Get the values that we're inserting into a new record
    #----#
    left_blocking_field  <- input$left_blocking_field_add
    right_blocking_field <- input$right_blocking_field_add
    linkage_rule_id      <- blocking_linkage_rule_to_add
    #----#

    # Error Handling
    #----#
    # Make sure neither of the blocking fields are null
    if(left_blocking_field == '' || right_blocking_field == ''){
      showNotification("Failed to Prepare Blocking Keys - Missing Blocking Key(s)", type = "error", closeButton = FALSE)
      return()
    }

    # Make sure this pair of fields isn't already in use
    if(length(left_blocking_keys_to_add) > 0){
      for(index in 1:length(left_blocking_keys_to_add)){
        if(left_blocking_keys_to_add[index] == left_blocking_field && right_blocking_keys_to_add[index] == right_blocking_field){
          showNotification("Failed to Prepare Blocking Keys - Combination Already Prepared", type = "error", closeButton = FALSE)
          return()
        }
      }
    }
    #----#

    # Append the data to our global variables
    #----#
    left_blocking_keys_to_add <<- append(left_blocking_keys_to_add, left_blocking_field)
    right_blocking_keys_to_add <<- append(right_blocking_keys_to_add, right_blocking_field)
    blocking_linkage_rules_to_add <<- append(blocking_linkage_rules_to_add, linkage_rule_id)
    #----#

    # Reset Data Tables, UI Renders, and global variables
    #----#
    output$add_blocking_variables_table <- renderDataTable({
      get_blocking_keys_to_add()
    })
    output$add_left_blocking_field_input <- renderUI({
      get_left_dataset_blocking_fields_to_add()
    })
    output$add_right_blocking_field_input <- renderUI({
      get_right_dataset_blocking_fields_to_add()
    })
    blocking_linkage_rule_to_add <<- NA
    # Render the output text
    output$blocking_linkage_rules_add <- renderText({
      ""
    })
    #----#

    # Show success notification
    #----#
    showNotification("Blocking Keys Successfully Prepared", type = "message", closeButton = FALSE)
    #----#
  })

  # Observes what row the user selects to update and will pre-populate the parameter key updating fields
  observe({
    row_selected <- input$add_blocking_variables_table_rows_selected

    # Make sure a row is selected
    if(is.null(row_selected)) return()

    # Get the the parameter key and desc from the prepared values
    left_blocking_field  <- left_blocking_keys_to_add[row_selected]
    right_blocking_field <- right_blocking_keys_to_add[row_selected]
    linkage_rule_id      <- blocking_linkage_rules_to_add[row_selected]

    # Now update the input fields
    updateSelectizeInput(session, "left_blocking_field_update",  selected = left_blocking_field)
    updateSelectizeInput(session, "right_blocking_field_update", selected = right_blocking_field)
    if(!is.na(linkage_rule_id)){
      # Query to get the acceptance method name from the comparison_rules table
      method_query <- paste('SELECT * FROM linkage_rules
                           WHERE linkage_rule_id =', linkage_rule_id)
      method_df <- dbGetQuery(linkage_metadata_conn, method_query)

      # We'll start with "Alternative Field"
      alt_field_val <- method_df$alternate_field_value
      if(!is.na(alt_field_val)){
        method_df$alternate_field_value <- paste0(scales::ordinal(as.numeric(alt_field_val)), " Field Value")
      }

      # Next we'll handle the "Integer Variance"
      int_variance <- method_df$integer_value_variance
      if(!is.na(int_variance)){
        method_df$integer_value_variance <- paste0("±", int_variance)
      }

      # Next we'll handle "Name Substring"
      name_substring <- method_df$substring_length
      if(!is.na(name_substring)){
        method_df$substring_length <- paste0("First ", name_substring, " character(s)")
      }

      # With standardized names, we'll replace the [0, 1] with [No, Yes]
      method_df$standardize_names <- str_replace(method_df$standardize_names, "1", "Standardize Names")

      # Rename the column names to be easier to read when printed in table format
      names(method_df)[names(method_df) == 'alternate_field_value'] <- 'Alternate Field Number'
      names(method_df)[names(method_df) == 'integer_value_variance'] <- 'Integer Value Variance'
      names(method_df)[names(method_df) == 'substring_length'] <- 'Substring Length'
      names(method_df)[names(method_df) == 'standardize_names'] <- 'Standardize Names'

      # Drop the linkage_rule_id from the table
      method_df <- subset(method_df, select = -c(linkage_rule_id))

      # Initialize an empty list to store non-NA values
      non_na_values <- list()

      # Loop through each column in the current row
      for (col_name in colnames(method_df)) {
        value <- method_df[1, col_name]

        # If the value is not NA, add it to the list
        if (!is.na(value)) {
          non_na_values <- c(non_na_values, paste0(value))
        }
      }

      # Combine the non-NA values into a single string, separated by commas
      combined_values <- paste(non_na_values, collapse = ", ")

      # Render the output text
      output$blocking_linkage_rules_update <- renderText({
        combined_values
      })
    }
    else{
      # Render the output text
      output$blocking_linkage_rules_update <- renderText({
        ""
      })
    }

    # Global variable for the blocking linkage rule
    blocking_linkage_rule_to_update <<- linkage_rule_id
  })

  # Updating a prepared combination of blocking fields and linkage rule
  observeEvent(input$prepare_blocking_variables_update, {
    # Get the values that we're inserting into a new record + the selected row
    #----#
    row_selected          <- input$add_blocking_variables_table_rows_selected
    left_blocking_field   <- input$left_blocking_field_update
    right_blocking_field  <- input$right_blocking_field_update
    linkage_rule_id       <- blocking_linkage_rule_to_update
    #----#

    # Error Handling
    #----#
    # Make sure neither of the blocking fields are null
    if(left_blocking_field == '' || right_blocking_field == ''){
      showNotification("Failed to Prepare Blocking Keys - Missing Blocking Key(s)", type = "error", closeButton = FALSE)
      return()
    }

    # Make sure this pair of fields isn't already in use
    if(length(left_blocking_keys_to_add) > 0){
      for(index in 1:length(left_blocking_keys_to_add)){
        if(left_blocking_keys_to_add[index] == left_blocking_field && right_blocking_keys_to_add[index] == right_blocking_field && row_selected != index){
          showNotification("Failed to Prepare Blocking Keys - Combination Already Prepared", type = "error", closeButton = FALSE)
          return()
        }
      }
    }
    #----#

    # Append the data to our global variables
    #----#
    left_blocking_keys_to_add[row_selected]     <<- left_blocking_field
    right_blocking_keys_to_add[row_selected]    <<- right_blocking_field
    blocking_linkage_rules_to_add[row_selected] <<- linkage_rule_id
    #----#

    # Update Data Tables and UI Renders
    #----#
    output$add_blocking_variables_table <- renderDataTable({
      get_blocking_keys_to_add()
    })
    blocking_linkage_rule_to_update <<- NA
    #----#

    # Show success notification
    #----#
    showNotification("Prepared Blocking Keys Successfully Updated", type = "message", closeButton = FALSE)
    #----#
  })

  # Dropping a prepared combination of blocking fields and linkage rule
  observeEvent(input$drop_blocking_variables, {
    # Get the row to drop
    #----#
    row_selected <- input$add_blocking_variables_table_rows_selected
    #----#

    # Append the data to our global variables
    #----#
    left_blocking_keys_to_add <<- left_blocking_keys_to_add[-c(row_selected)]
    right_blocking_keys_to_add <<- right_blocking_keys_to_add[-c(row_selected)]
    blocking_linkage_rules_to_add <<- blocking_linkage_rules_to_add[-c(row_selected)]
    #----#

    # Update Data Tables and UI Renders
    #----#
    output$add_blocking_variables_table <- renderDataTable({
      get_blocking_keys_to_add()
    })
    #----#

    # Show success notification
    #----#
    showNotification("Prepared Blocking Keys Successfully Dropped", type = "message", closeButton = FALSE)
    #----#
  })

  # Selecting a linkage rule for ADDING blocking keys
  observeEvent(input$prepare_blocking_linkage_rule, {
    showModal(modalDialog(
      title = "Choose Linkage Rule",
      easyClose = TRUE,
      footer = NULL,
      fluidRow(
        # Linkage rule table
        h5(strong("Select a Linkage Rule Below to Use for the Blocking Variables:")),
        column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
            dataTableOutput("blocking_keys_add_linkage_rules"),
          )
        ),

        # If NO row is selected, the user may add a new linkage rule by clicking
        # a button that will take them to the linkage rule page
        conditionalPanel(
          condition = "input.blocking_keys_add_linkage_rules_rows_selected <= 0",
          HTML("<br>"),
          h5(strong("Or, Create a New Rule Here:")),

          # Button for going to the linkage rules page from this modal
          fluidRow(
            column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                actionButton("blocking_keys_add_linkage_rules_to_linkage_rules", "Create New Linkage Rule", class = "btn-info"),
              )
            ),
          )
        ),

        # If a row IS SELECTED, the user can then click then choose that rule
        conditionalPanel(
          condition = "input.blocking_keys_add_linkage_rules_rows_selected > 0",
          HTML("<br>"),

          # Button for preparing the selected linkage rule to add
          fluidRow(
            column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                actionButton("blocking_keys_add_prepare_linkage_rule", "Add Linkage Rule", class = "btn-success"),
              )
            ),
          )
        ),
      ),
      size = "l"  # Large modal size to fit both tables
    ))
  })

  # Brings the user to the linkage rules page
  observeEvent(input$blocking_keys_add_linkage_rules_to_linkage_rules, {

    # Set the return page to the add linkage iterations page
    linkage_rules_return_page <<- "add_linkage_iterations_page"

    # Show the linkage rule page
    nav_show("main_navbar", "linkage_rule_page")

    # Brings you to the linkage rules page
    updateNavbarPage(session, "main_navbar", selected = "linkage_rule_page")
  })

  # Selects the linkage rule the user wanted
  observeEvent(input$blocking_keys_add_prepare_linkage_rule, {
    # Get the selected row
    selected_row <- input$blocking_keys_add_linkage_rules_rows_selected

    # Query to get all linkage rule information from the 'linkage_rules' table
    query <- paste('SELECT * FROM linkage_rules
               ORDER BY linkage_rule_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    # Get the linkage rule
    linkage_rule_id <- df[selected_row, "linkage_rule_id"]

    # Set the global variable to the selected linkage rule id
    blocking_linkage_rule_to_add <<- linkage_rule_id

    # Render the UI output text
    if(!is.na(linkage_rule_id)){
      # Query to get the acceptance method name from the comparison_rules table
      method_query <- paste('SELECT * FROM linkage_rules
                           WHERE linkage_rule_id =', linkage_rule_id)
      method_df <- dbGetQuery(linkage_metadata_conn, method_query)

      # We'll start with "Alternative Field"
      alt_field_val <- method_df$alternate_field_value
      if(!is.na(alt_field_val)){
        method_df$alternate_field_value <- paste0(scales::ordinal(as.numeric(alt_field_val)), " Field Value")
      }

      # Next we'll handle the "Integer Variance"
      int_variance <- method_df$integer_value_variance
      if(!is.na(int_variance)){
        method_df$integer_value_variance <- paste0("±", int_variance)
      }

      # Next we'll handle "Name Substring"
      name_substring <- method_df$substring_length
      if(!is.na(name_substring)){
        method_df$substring_length <- paste0("First ", name_substring, " character(s)")
      }

      # With standardized names, we'll replace the [0, 1] with [No, Yes]
      method_df$standardize_names <- str_replace(method_df$standardize_names, "1", "Standardize Names")

      # Rename the column names to be easier to read when printed in table format
      names(method_df)[names(method_df) == 'alternate_field_value'] <- 'Alternate Field Number'
      names(method_df)[names(method_df) == 'integer_value_variance'] <- 'Integer Value Variance'
      names(method_df)[names(method_df) == 'substring_length'] <- 'Substring Length'
      names(method_df)[names(method_df) == 'standardize_names'] <- 'Standardize Names'

      # Drop the linkage_rule_id from the table
      method_df <- subset(method_df, select = -c(linkage_rule_id))

      # Initialize an empty list to store non-NA values
      non_na_values <- list()

      # Loop through each column in the current row
      for (col_name in colnames(method_df)) {
        value <- method_df[1, col_name]

        # If the value is not NA, add it to the list
        if (!is.na(value)) {
          non_na_values <- c(non_na_values, paste0(value))
        }
      }

      # Combine the non-NA values into a single string, separated by commas
      combined_values <- paste(non_na_values, collapse = ", ")

      # Render the output text
      output$blocking_linkage_rules_add <- renderText({
        combined_values
      })
    }

    # Dismiss the modal
    removeModal()
  })

  # Generates the table of linkage rules
  output$blocking_keys_add_linkage_rules <- renderDataTable({
    get_linkage_rules()
  })

  # Selecting a linkage rule for UPDATING blocking keys
  observeEvent(input$prepare_blocking_linkage_rule_update, {
    showModal(modalDialog(
      title = "Choose Linkage Rule",
      easyClose = TRUE,
      footer = NULL,
      fluidRow(
        # Linkage rule table
        h5(strong("Select a Linkage Rule Below to Use for the Blocking Variables:")),
        column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
            dataTableOutput("blocking_keys_update_linkage_rules"),
          )
        ),

        # If NO row is selected, the user may add a new linkage rule by clicking
        # a button that will take them to the linkage rule page
        conditionalPanel(
          condition = "input.blocking_keys_update_linkage_rules_rows_selected <= 0",
          HTML("<br>"),
          h5(strong("Or, Create a New Rule Here:")),

          # Button for going to the linkage rules page from this modal
          fluidRow(
            column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                actionButton("blocking_keys_update_linkage_rules_to_linkage_rules", "Create New Linkage Rule", class = "btn-info"),
              )
            ),
          )
        ),

        # If a row IS SELECTED, the user can then click then choose that rule
        conditionalPanel(
          condition = "input.blocking_keys_update_linkage_rules_rows_selected > 0",
          HTML("<br>"),

          # Button for preparing the selected linkage rule to add
          fluidRow(
            column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                actionButton("blocking_keys_update_prepare_linkage_rule", "Add Linkage Rule", class = "btn-success"),
              )
            ),
          )
        ),
      ),
      size = "l"  # Large modal size to fit both tables
    ))
  })

  # Brings the user to the linkage rules page
  observeEvent(input$blocking_keys_update_linkage_rules_to_linkage_rules, {

    # Set the return page to the add linkage iterations page
    linkage_rules_return_page <<- "add_linkage_iterations_page"

    # Show the linkage rule page
    nav_show("main_navbar", "linkage_rule_page")

    # Brings you to the linkage rules page
    updateNavbarPage(session, "main_navbar", selected = "linkage_rule_page")
  })

  # Selects the linkage rule the user wanted
  observeEvent(input$blocking_keys_update_prepare_linkage_rule, {
    # Get the selected row
    selected_row <- input$blocking_keys_update_linkage_rules_rows_selected

    # Query to get all linkage rule information from the 'linkage_rules' table
    query <- paste('SELECT * FROM linkage_rules
               ORDER BY linkage_rule_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    # Get the linkage rule
    linkage_rule_id <- df[selected_row, "linkage_rule_id"]

    # Set the global variable to the selected linkage rule id
    blocking_linkage_rule_to_update <<- linkage_rule_id

    # Render the UI output text
    if(!is.na(linkage_rule_id)){
      # Query to get the acceptance method name from the comparison_rules table
      method_query <- paste('SELECT * FROM linkage_rules
                           WHERE linkage_rule_id =', linkage_rule_id)
      method_df <- dbGetQuery(linkage_metadata_conn, method_query)

      # We'll start with "Alternative Field"
      alt_field_val <- method_df$alternate_field_value
      if(!is.na(alt_field_val)){
        method_df$alternate_field_value <- paste0(scales::ordinal(as.numeric(alt_field_val)), " Field Value")
      }

      # Next we'll handle the "Integer Variance"
      int_variance <- method_df$integer_value_variance
      if(!is.na(int_variance)){
        method_df$integer_value_variance <- paste0("±", int_variance)
      }

      # Next we'll handle "Name Substring"
      name_substring <- method_df$substring_length
      if(!is.na(name_substring)){
        method_df$substring_length <- paste0("First ", name_substring, " character(s)")
      }

      # With standardized names, we'll replace the [0, 1] with [No, Yes]
      method_df$standardize_names <- str_replace(method_df$standardize_names, "1", "Standardize Names")

      # Rename the column names to be easier to read when printed in table format
      names(method_df)[names(method_df) == 'alternate_field_value'] <- 'Alternate Field Number'
      names(method_df)[names(method_df) == 'integer_value_variance'] <- 'Integer Value Variance'
      names(method_df)[names(method_df) == 'substring_length'] <- 'Substring Length'
      names(method_df)[names(method_df) == 'standardize_names'] <- 'Standardize Names'

      # Drop the linkage_rule_id from the table
      method_df <- subset(method_df, select = -c(linkage_rule_id))

      # Initialize an empty list to store non-NA values
      non_na_values <- list()

      # Loop through each column in the current row
      for (col_name in colnames(method_df)) {
        value <- method_df[1, col_name]

        # If the value is not NA, add it to the list
        if (!is.na(value)) {
          non_na_values <- c(non_na_values, paste0(value))
        }
      }

      # Combine the non-NA values into a single string, separated by commas
      combined_values <- paste(non_na_values, collapse = ", ")

      # Render the output text
      output$blocking_linkage_rules_update <- renderText({
        combined_values
      })
    }

    # Dismiss the modal
    removeModal()
  })

  # Generates the table of linkage rules
  output$blocking_keys_update_linkage_rules <- renderDataTable({
    get_linkage_rules()
  })
  #---------------------------------#

  #-- MATCHING KEY RELATED EVENTS --#
  # Appending pair of fields, linkage rule, and comparison rule to be matching fields + the rules
  observeEvent(input$prepare_matching_variables, {
    # Get the values that we're inserting into a new record
    #----#
    left_matching_field  <- input$left_matching_field_add
    right_matching_field <- input$right_matching_field_add
    linkage_rule_id      <- matching_linkage_rule_to_add
    comparison_rule_id   <- matching_comparison_rule_to_add
    #----#

    # Error Handling
    #----#
    # Make sure neither of the blocking fields are null
    if(left_matching_field == '' || right_matching_field == ''){
      showNotification("Failed to Prepare Matching Keys - Missing Matching Key(s)", type = "error", closeButton = FALSE)
      return()
    }

    # Make sure this pair of fields isn't already in use
    if(length(left_matching_keys_to_add) > 0){
      for(index in 1:length(left_matching_keys_to_add)){
        if(left_matching_keys_to_add[index] == left_matching_field && right_blocking_keys_to_add[index] == right_matching_field){
          showNotification("Failed to Prepare Matching Keys - Combination Already Prepared", type = "error", closeButton = FALSE)
          return()
        }
      }
    }
    #----#

    # Append the data to our global variables
    #----#
    left_matching_keys_to_add <<- append(left_matching_keys_to_add, left_matching_field)
    right_matching_keys_to_add <<- append(right_matching_keys_to_add, right_matching_field)
    matching_linkage_rules_to_add <<- append(matching_linkage_rules_to_add, linkage_rule_id)
    matching_comparison_rules_to_add <<- append(matching_comparison_rules_to_add, comparison_rule_id)
    #----#

    # Reset Data Tables, UI Renders, and global variables
    #----#
    output$add_matching_variables_table <- renderDataTable({
      get_matching_keys_to_add()
    })
    output$add_left_matching_field_input <- renderUI({
      get_left_dataset_matching_fields_to_add()
    })
    output$add_right_matching_field_input <- renderUI({
      get_right_dataset_matching_fields_to_add()
    })
    matching_linkage_rule_to_add <<- NA
    output$matching_linkage_rules_add <- renderText({
      ""
    })
    matching_comparison_rule_to_add <<- NA
    output$matching_comparison_rules_add <- renderText({
      ""
    })
    #----#

    # Show success notification
    #----#
    showNotification("Matching Keys Successfully Prepared", type = "message", closeButton = FALSE)
    #----#
  })

  # Observes what row the user selects to update and will pre-populate the parameter key updating fields
  observe({
    row_selected <- input$add_matching_variables_table_rows_selected

    # Make sure a row is selected
    if(is.null(row_selected)) return()

    # Get the the parameter key and desc from the prepared values
    left_matching_field  <- left_matching_keys_to_add[row_selected]
    right_matching_field <- right_matching_keys_to_add[row_selected]
    linkage_rule_id      <- matching_linkage_rules_to_add[row_selected]
    comparison_rule_id   <- matching_comparison_rules_to_add[row_selected]

    # Now update the input fields
    updateSelectizeInput(session, "left_matching_field_update",  selected = left_matching_field)
    updateSelectizeInput(session, "right_matching_field_update", selected = right_matching_field)
    if(!is.na(linkage_rule_id)){
      # Query to get the acceptance method name from the comparison_rules table
      method_query <- paste('SELECT * FROM linkage_rules
                           WHERE linkage_rule_id =', linkage_rule_id)
      method_df <- dbGetQuery(linkage_metadata_conn, method_query)

      # We'll start with "Alternative Field"
      alt_field_val <- method_df$alternate_field_value
      if(!is.na(alt_field_val)){
        method_df$alternate_field_value <- paste0(scales::ordinal(as.numeric(alt_field_val)), " Field Value")
      }

      # Next we'll handle the "Integer Variance"
      int_variance <- method_df$integer_value_variance
      if(!is.na(int_variance)){
        method_df$integer_value_variance <- paste0("±", int_variance)
      }

      # Next we'll handle "Name Substring"
      name_substring <- method_df$substring_length
      if(!is.na(name_substring)){
        method_df$substring_length <- paste0("First ", name_substring, " character(s)")
      }

      # With standardized names, we'll replace the [0, 1] with [No, Yes]
      method_df$standardize_names <- str_replace(method_df$standardize_names, "1", "Standardize Names")

      # Rename the column names to be easier to read when printed in table format
      names(method_df)[names(method_df) == 'alternate_field_value'] <- 'Alternate Field Number'
      names(method_df)[names(method_df) == 'integer_value_variance'] <- 'Integer Value Variance'
      names(method_df)[names(method_df) == 'substring_length'] <- 'Substring Length'
      names(method_df)[names(method_df) == 'standardize_names'] <- 'Standardize Names'

      # Drop the linkage_rule_id from the table
      method_df <- subset(method_df, select = -c(linkage_rule_id))

      # Initialize an empty list to store non-NA values
      non_na_values <- list()

      # Loop through each column in the current row
      for (col_name in colnames(method_df)) {
        value <- method_df[1, col_name]

        # If the value is not NA, add it to the list
        if (!is.na(value)) {
          non_na_values <- c(non_na_values, paste0(value))
        }
      }

      # Combine the non-NA values into a single string, separated by commas
      combined_values <- paste(non_na_values, collapse = ", ")

      # Render the output text
      output$matching_linkage_rules_update <- renderText({
        combined_values
      })
    }
    else{
      # Render the output text
      output$matching_linkage_rules_update <- renderText({
        ""
      })
    }

    if(!is.na(comparison_rule_id)){
      # Query to get the acceptance method name from the comparison_rules table
      method_query <- paste('SELECT method_name FROM comparison_rules cr
                           JOIN comparison_methods cm on cr.comparison_method_id = cm.comparison_method_id
                           WHERE comparison_rule_id =', comparison_rule_id)
      method_name <- dbGetQuery(linkage_metadata_conn, method_query)$method_name

      # Query to get the associated parameters for the comparison_rule_id
      params_query <- paste('SELECT parameter FROM comparison_rules_parameters WHERE comparison_rule_id =', comparison_rule_id)
      params_df <- dbGetQuery(linkage_metadata_conn, params_query)

      # Combine the parameters into a string
      params_str <- paste(params_df$parameter, collapse = ", ")

      # Create the final string "method_name (key1=value1, key2=value2)"
      method_with_params <- paste0(method_name, " (", params_str, ")")

      # Render the output text
      output$matching_comparison_rules_update <- renderText({
        method_with_params
      })
    }
    else{
      # Render the output text
      output$matching_comparison_rules_update <- renderText({
        ""
      })
    }

    # Global variable for the matching linkage rule and comparison rule
    matching_linkage_rule_to_update    <<- linkage_rule_id
    matching_comparison_rule_to_update <<- comparison_rule_id
  })

  # Updating a prepared combination of matching fields and linkage rule
  observeEvent(input$prepare_matching_variables_update, {
    # Get the values that we're inserting into a new record + the selected row
    #----#
    row_selected          <- input$add_matching_variables_table_rows_selected
    left_matching_field   <- input$left_matching_field_update
    right_matching_field  <- input$right_matching_field_update
    linkage_rule_id       <- matching_linkage_rule_to_update
    comparison_rule_id    <- matching_comparison_rule_to_update
    #----#

    # Error Handling
    #----#
    # Make sure neither of the blocking fields are null
    if(left_matching_field == '' || right_matching_field == ''){
      showNotification("Failed to Prepare Matching Keys - Missing Matching Key(s)", type = "error", closeButton = FALSE)
      return()
    }

    # Make sure this pair of fields isn't already in use
    if(length(left_matching_keys_to_add) > 0){
      for(index in 1:length(left_matching_keys_to_add)){
        if(left_matching_keys_to_add[index] == left_matching_field && right_matching_keys_to_add[index] == right_matching_field && row_selected != index){
          showNotification("Failed to Prepare Matching Keys - Combination Already Prepared", type = "error", closeButton = FALSE)
          return()
        }
      }
    }
    #----#

    # Append the data to our global variables
    #----#
    left_matching_keys_to_add[row_selected]        <<- left_matching_field
    right_matching_keys_to_add[row_selected]       <<- right_matching_field
    matching_linkage_rules_to_add[row_selected]    <<- linkage_rule_id
    matching_comparison_rules_to_add[row_selected] <<- comparison_rule_id
    #----#

    # Update Data Tables and UI Renders
    #----#
    output$add_matching_variables_table <- renderDataTable({
      get_matching_keys_to_add()
    })
    matching_linkage_rule_to_update <<- NA
    matching_comparison_rule_to_update <<- NA
    #----#

    # Show success notification
    #----#
    showNotification("Prepared Matching Keys Successfully Updated", type = "message", closeButton = FALSE)
    #----#
  })

  # Dropping a prepared combination of matching fields and linkage rule
  observeEvent(input$drop_matching_variables, {
    # Get the row to drop
    #----#
    row_selected <- input$add_matching_variables_table_rows_selected
    #----#

    # Append the data to our global variables
    #----#
    left_matching_keys_to_add        <<- left_matching_keys_to_add[-c(row_selected)]
    right_matching_keys_to_add       <<- right_matching_keys_to_add[-c(row_selected)]
    matching_linkage_rules_to_add    <<- matching_linkage_rules_to_add[-c(row_selected)]
    matching_comparison_rules_to_add <<- matching_comparison_rules_to_add[-c(row_selected)]
    #----#

    # Update Data Tables and UI Renders
    #----#
    output$add_matching_variables_table <- renderDataTable({
      get_matching_keys_to_add()
    })
    #----#

    # Show success notification
    #----#
    showNotification("Prepared Matching Keys Successfully Dropped", type = "message", closeButton = FALSE)
    #----#
  })

  # Selecting a linkage rule for ADDING matching keys
  observeEvent(input$prepare_matching_linkage_rule, {
    showModal(modalDialog(
      title = "Choose Linkage Rule",
      easyClose = TRUE,
      footer = NULL,
      fluidRow(
        # Linkage rule table
        h5(strong("Select a Linkage Rule Below to Use for the Matching Variables:")),
        column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
            dataTableOutput("matching_keys_add_linkage_rules"),
          )
        ),

        # If NO row is selected, the user may add a new linkage rule by clicking
        # a button that will take them to the linkage rule page
        conditionalPanel(
          condition = "input.matching_keys_add_linkage_rules_rows_selected <= 0",
          HTML("<br>"),
          h5(strong("Or, Create a New Rule Here:")),

          # Button for going to the linkage rules page from this modal
          fluidRow(
            column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                actionButton("matching_keys_add_linkage_rules_to_linkage_rules", "Create New Linkage Rule", class = "btn-info"),
              )
            ),
          )
        ),

        # If a row IS SELECTED, the user can then click then choose that rule
        conditionalPanel(
          condition = "input.matching_keys_add_linkage_rules_rows_selected > 0",
          HTML("<br>"),

          # Button for preparing the selected linkage rule to add
          fluidRow(
            column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                actionButton("matching_keys_add_prepare_linkage_rule", "Add Linkage Rule", class = "btn-success"),
              )
            ),
          )
        ),
      ),
      size = "l"  # Large modal size to fit both tables
    ))
  })

  # Brings the user to the linkage rules page
  observeEvent(input$matching_keys_add_linkage_rules_to_linkage_rules, {

    # Set the return page to the add linkage iterations page
    linkage_rules_return_page <<- "add_linkage_iterations_page"

    # Show the linkage rule page
    nav_show("main_navbar", "linkage_rule_page")

    # Brings you to the linkage rules page
    updateNavbarPage(session, "main_navbar", selected = "linkage_rule_page")
  })

  # Selects the linkage rule the user wanted
  observeEvent(input$matching_keys_add_prepare_linkage_rule, {
    # Get the selected row
    selected_row <- input$matching_keys_add_linkage_rules_rows_selected

    # Query to get all linkage rule information from the 'linkage_rules' table
    query <- paste('SELECT * FROM linkage_rules
               ORDER BY linkage_rule_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    # Get the linkage rule
    linkage_rule_id <- df[selected_row, "linkage_rule_id"]

    # Set the global variable to the selected linkage rule id
    matching_linkage_rule_to_add <<- linkage_rule_id

    # Render the UI output text
    if(!is.na(linkage_rule_id)){
      # Query to get the acceptance method name from the comparison_rules table
      method_query <- paste('SELECT * FROM linkage_rules
                           WHERE linkage_rule_id =', linkage_rule_id)
      method_df <- dbGetQuery(linkage_metadata_conn, method_query)

      # We'll start with "Alternative Field"
      alt_field_val <- method_df$alternate_field_value
      if(!is.na(alt_field_val)){
        method_df$alternate_field_value <- paste0(scales::ordinal(as.numeric(alt_field_val)), " Field Value")
      }

      # Next we'll handle the "Integer Variance"
      int_variance <- method_df$integer_value_variance
      if(!is.na(int_variance)){
        method_df$integer_value_variance <- paste0("±", int_variance)
      }

      # Next we'll handle "Name Substring"
      name_substring <- method_df$substring_length
      if(!is.na(name_substring)){
        method_df$substring_length <- paste0("First ", name_substring, " character(s)")
      }

      # With standardized names, we'll replace the [0, 1] with [No, Yes]
      method_df$standardize_names <- str_replace(method_df$standardize_names, "1", "Standardize Names")

      # Rename the column names to be easier to read when printed in table format
      names(method_df)[names(method_df) == 'alternate_field_value'] <- 'Alternate Field Number'
      names(method_df)[names(method_df) == 'integer_value_variance'] <- 'Integer Value Variance'
      names(method_df)[names(method_df) == 'substring_length'] <- 'Substring Length'
      names(method_df)[names(method_df) == 'standardize_names'] <- 'Standardize Names'

      # Drop the linkage_rule_id from the table
      method_df <- subset(method_df, select = -c(linkage_rule_id))

      # Initialize an empty list to store non-NA values
      non_na_values <- list()

      # Loop through each column in the current row
      for (col_name in colnames(method_df)) {
        value <- method_df[1, col_name]

        # If the value is not NA, add it to the list
        if (!is.na(value)) {
          non_na_values <- c(non_na_values, paste0(value))
        }
      }

      # Combine the non-NA values into a single string, separated by commas
      combined_values <- paste(non_na_values, collapse = ", ")

      # Render the output text
      output$matching_linkage_rules_add <- renderText({
        combined_values
      })
    }

    # Dismiss the modal
    removeModal()
  })

  # Generates the table of linkage rules
  output$matching_keys_add_linkage_rules <- renderDataTable({
    get_linkage_rules()
  })

  # Selecting a linkage rule for UPDATING matching keys
  observeEvent(input$prepare_matching_linkage_rule_update, {
    showModal(modalDialog(
      title = "Choose Linkage Rule",
      easyClose = TRUE,
      footer = NULL,
      fluidRow(
        # Linkage rule table
        h5(strong("Select a Linkage Rule Below to Use for the Matching Variables:")),
        column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
            dataTableOutput("matching_keys_update_linkage_rules"),
          )
        ),

        # If NO row is selected, the user may add a new linkage rule by clicking
        # a button that will take them to the linkage rule page
        conditionalPanel(
          condition = "input.matching_keys_update_linkage_rules_rows_selected <= 0",
          HTML("<br>"),
          h5(strong("Or, Create a New Rule Here:")),

          # Button for going to the linkage rules page from this modal
          fluidRow(
            column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                actionButton("matching_keys_update_linkage_rules_to_linkage_rules", "Create New Linkage Rule", class = "btn-info"),
              )
            ),
          )
        ),

        # If a row IS SELECTED, the user can then click then choose that rule
        conditionalPanel(
          condition = "input.matching_keys_update_linkage_rules_rows_selected > 0",
          HTML("<br>"),

          # Button for preparing the selected linkage rule to add
          fluidRow(
            column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                actionButton("matching_keys_update_prepare_linkage_rule", "Add Linkage Rule", class = "btn-success"),
              )
            ),
          )
        ),
      ),
      size = "l"  # Large modal size to fit both tables
    ))
  })

  # Brings the user to the linkage rules page
  observeEvent(input$matching_keys_update_linkage_rules_to_linkage_rules, {

    # Set the return page to the add linkage iterations page
    linkage_rules_return_page <<- "add_linkage_iterations_page"

    # Show the linkage rule page
    nav_show("main_navbar", "linkage_rule_page")

    # Brings you to the linkage rules page
    updateNavbarPage(session, "main_navbar", selected = "linkage_rule_page")
  })

  # Selects the linkage rule the user wanted
  observeEvent(input$matching_keys_update_prepare_linkage_rule, {
    # Get the selected row
    selected_row <- input$matching_keys_update_linkage_rules_rows_selected

    # Query to get all linkage rule information from the 'linkage_rules' table
    query <- paste('SELECT * FROM linkage_rules
               ORDER BY linkage_rule_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    # Get the linkage rule
    linkage_rule_id <- df[selected_row, "linkage_rule_id"] # If this breaks, use "df$linkage_rule_id[selected_row]"

    # Set the global variable to the selected linkage rule id
    matching_linkage_rule_to_update <<- linkage_rule_id

    # Render the UI output text
    if(!is.na(linkage_rule_id)){
      # Query to get the acceptance method name from the comparison_rules table
      method_query <- paste('SELECT * FROM linkage_rules
                           WHERE linkage_rule_id =', linkage_rule_id)
      method_df <- dbGetQuery(linkage_metadata_conn, method_query)

      # We'll start with "Alternative Field"
      alt_field_val <- method_df$alternate_field_value
      if(!is.na(alt_field_val)){
        method_df$alternate_field_value <- paste0(scales::ordinal(as.numeric(alt_field_val)), " Field Value")
      }

      # Next we'll handle the "Integer Variance"
      int_variance <- method_df$integer_value_variance
      if(!is.na(int_variance)){
        method_df$integer_value_variance <- paste0("±", int_variance)
      }

      # Next we'll handle "Name Substring"
      name_substring <- method_df$substring_length
      if(!is.na(name_substring)){
        method_df$substring_length <- paste0("First ", name_substring, " character(s)")
      }

      # With standardized names, we'll replace the [0, 1] with [No, Yes]
      method_df$standardize_names <- str_replace(method_df$standardize_names, "1", "Standardize Names")

      # Rename the column names to be easier to read when printed in table format
      names(method_df)[names(method_df) == 'alternate_field_value'] <- 'Alternate Field Number'
      names(method_df)[names(method_df) == 'integer_value_variance'] <- 'Integer Value Variance'
      names(method_df)[names(method_df) == 'substring_length'] <- 'Substring Length'
      names(method_df)[names(method_df) == 'standardize_names'] <- 'Standardize Names'

      # Drop the linkage_rule_id from the table
      method_df <- subset(method_df, select = -c(linkage_rule_id))

      # Initialize an empty list to store non-NA values
      non_na_values <- list()

      # Loop through each column in the current row
      for (col_name in colnames(method_df)) {
        value <- method_df[1, col_name]

        # If the value is not NA, add it to the list
        if (!is.na(value)) {
          non_na_values <- c(non_na_values, paste0(value))
        }
      }

      # Combine the non-NA values into a single string, separated by commas
      combined_values <- paste(non_na_values, collapse = ", ")

      # Render the output text
      output$matching_linkage_rules_update <- renderText({
        combined_values
      })
    }

    # Dismiss the modal
    removeModal()
  })

  # Generates the table of linkage rules
  output$matching_keys_update_linkage_rules <- renderDataTable({
    get_linkage_rules()
  })

  ### ADDING COMPARISON RULE

  # Selecting an comparison rule for the iteration
  observeEvent(input$prepare_matching_comparison_rule, {
    # Generates the table of acceptance methods
    output$add_comparison_method_iteration <- renderDataTable({
      get_comparison_methods_and_parameters()
    })

    output$iteration_comparison_rule_add_inputs <- renderUI({

    })

    showModal(modalDialog(
      title = "Choose Comparison Rule",
      easyClose = TRUE,
      footer = NULL,
      fluidPage(
        # Comparison rule table
        h5("Select a Comparison Method & Enter Rule Parameters:"),
        layout_column_wrap(
          width = 1/2,
          height = 500,

          # Card for the comparison methods table
          card(card_header("Comparison Methods Table", class = "bg-dark"),
            dataTableOutput("add_comparison_method_iteration")
          ),

          # Card for the comparison rules UI
          card(card_header("Comparison Rule Inputs", class = "bg-dark"),
            uiOutput("iteration_comparison_rule_add_inputs")
          )
        ),

        # OPTION 1: User may enter a new comparison method & parameters
        conditionalPanel(
          condition = "input.add_comparison_method_iteration_rows_selected <= 0",
          HTML("<br>"),

          # Button for moving the user to the comparison methods page
          fluidRow(
            h5(strong("Or, create a new comparison method below:")),
            column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                actionButton("add_linkage_iteration_to_add_comparison_methods", "Create Comparison Method", class = "btn-info"),
              )
            ),
          )
        ),

        # OPTION 2: User can submit which comparison rule they'd like to use
        conditionalPanel(
          condition = "input.add_comparison_method_iteration_rows_selected > 0",
          HTML("<br>"),

          # Button for moving the user to the comparison rules page
          fluidRow(
            column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                actionButton("prepare_iteration_comparison_rule_to_add", "Add Comparison Rule", class = "btn-success"),
              )
            )
          )
        ),
      ),
      size = "l"  # Large modal size to fit both tables
    ))
  })

  # Generates the table of comparison methods
  output$add_comparison_method_iteration <- renderDataTable({
    get_comparison_methods_and_parameters()
  })

  # Generates the dynamic comparison rule inputs
  observeEvent(input$add_comparison_method_iteration_rows_selected, {
    selected_row <- input$add_comparison_method_iteration_rows_selected

    if (!is.null(selected_row)) {
      # Perform a query to get the comparison methods
      query <- paste('SELECT * from comparison_methods')
      df <- dbGetQuery(linkage_metadata_conn, query)
      # Retrieve the comparison method id of the selected row
      selected_method <- df$comparison_method_id[selected_row]

      output$iteration_comparison_rule_add_inputs <- renderUI({
        modify_iteration_get_comparison_rule_inputs(selected_method, "modify_iteration_comparison_rule_input")
      })
    }
    else{
      output$iteration_comparison_rule_add_inputs <- renderUI({

      })
    }
  })

  # Selects the comparison rule the user wanted
  observeEvent(input$prepare_iteration_comparison_rule_to_add, {
    # Get the selected row
    selected_row <- input$add_comparison_method_iteration_rows_selected

    # Query to get all linkage rule information from the 'comparison_methods' table
    query <- paste('SELECT * FROM comparison_methods
               ORDER BY comparison_method_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    # Get the linkage rule
    comparison_method_id <- df$comparison_method_id[selected_row]

    # Get the parameter IDs, keys, and descriptions of the inputs we need
    query <- paste('SELECT * from comparison_method_parameters
                   WHERE comparison_method_id =', comparison_method_id)
    df <- dbGetQuery(linkage_metadata_conn, query)

    # Get the number of inputs we'll be adding
    num_inputs <- nrow(df)
    parameter_ids <- df$parameter_id

    # Error handling
    #----#
    # Error Handling to make sure all inputs are filled
    for(index in 1:(num_inputs)){
      # Get the input value for each input
      input_val <- input[[paste0("modify_iteration_comparison_rule_input", index)]]
      # Ensure it isn't null
      if(is.na(input_val)){
        showNotification("Failed to Use Comparison Rule - Some Input(s) Are Missing", type = "error", closeButton = FALSE)
        return()
      }
    }
    #----#

    # If the rule already exists, then use that Comparison Rule ID
    df <- data.frame()
    for (index in 1:(num_inputs)) {
      # Get the parameter to input
      parameter <- input[[paste0("modify_iteration_comparison_rule_input", index)]]

      # Get the parameter ID
      parameter_id <- parameter_ids[index]

      # Check if the database has this eact match
      get_query <- dbSendQuery(linkage_metadata_conn, 'SELECT * FROM comparison_rules_parameters
                                                  WHERE parameter_id = ? AND parameter = ?;')
      dbBind(get_query, list(parameter_id, parameter))
      output_df <- dbFetch(get_query)
      dbClearResult(get_query)
      df <- rbind(df, output_df)
    }

    # Group by the comparison_rule_id
    df_grouped <- df %>% group_by(comparison_rule_id) %>% filter(n() == num_inputs)

    # If it contains exactly those parameters, then there will be a row in the grouped df, so grab the acceptance rule
    comparison_rule_id <- 0
    if(nrow(df_grouped) > 0){
      comparison_rule_id <- df_grouped$comparison_rule_id[1]
    }
    #----#

    # If the comparison_rule_id is 0, then it does not exist, so create a new one
    if(comparison_rule_id == 0){
      # Add all the necessary acceptance rule information
      successful <- TRUE
      #----#
      added_comparison_rule_id <- tryCatch({
        # Start a transaction
        dbBegin(linkage_metadata_conn)

        # Start by creating a new comparison rule
        new_entry_query <- paste("INSERT INTO comparison_rules (comparison_method_id)",
                                 "VALUES(?);")
        new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
        dbBind(new_entry, list(comparison_method_id))
        dbClearResult(new_entry)

        # Add the dataset fields to the other table after we insert basic information
        #----#
        # Get the most recently inserted comparison_rule_id value
        new_comparison_rule_id <- dbGetQuery(linkage_metadata_conn, "SELECT last_insert_rowid() AS comparison_rule_id;")$comparison_rule_id

        # Insert each parameter value into the database
        for (index in 1:(num_inputs)) {
          # Get the parameter to input
          parameter <- input[[paste0("modify_iteration_comparison_rule_input", index)]]

          # Get the parameter ID
          parameter_id <- parameter_ids[index]

          insert_field_query <- "INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter) VALUES (?, ?, ?);"
          insert_field_stmt <- dbSendStatement(linkage_metadata_conn, insert_field_query)
          dbBind(insert_field_stmt, list(new_comparison_rule_id, parameter_id, parameter))
          dbClearResult(insert_field_stmt)
        }

        # End a transaction
        dbCommit(linkage_metadata_conn)

        # Return the new comparison rule
        new_comparison_rule_id
      },
      error = function(e){
        # If we throw an error because of timeout, or bad insert, then rollback and return
        successful <- FALSE
        dbRollback(linkage_metadata_conn)
        showNotification("Failed to Add Comparison Rule - An Error Occurred While Inserting", type = "error", closeButton = FALSE)
        return(0)
      })

      # If we didn't successfully add the acceptance rule, then return
      if(!successful) return()

      comparison_rule_id <- added_comparison_rule_id
      #----#
    }

    # Render the output text to make the method readable
    if(!is.na(comparison_rule_id)){
      # Query to get the acceptance method name from the comparison_rules table
      method_query <- paste('SELECT method_name FROM comparison_rules cr
                           JOIN comparison_methods cm on cr.comparison_method_id = cm.comparison_method_id
                           WHERE comparison_rule_id =', comparison_rule_id)
      method_name <- dbGetQuery(linkage_metadata_conn, method_query)$method_name

      # Query to get the associated parameters for the comparison_rule_id
      params_query <- paste('SELECT parameter FROM comparison_rules_parameters WHERE comparison_rule_id =', comparison_rule_id)
      params_df <- dbGetQuery(linkage_metadata_conn, params_query)

      # Combine the parameters into a string
      params_str <- paste(params_df$parameter, collapse = ", ")

      # Create the final string "method_name (key1=value1, key2=value2)"
      method_with_params <- paste0(method_name, " (", params_str, ")")
      output$matching_comparison_rules_add <- renderText({
        method_with_params
      })
    }

    # Set the global variable
    matching_comparison_rule_to_add <<- comparison_rule_id

    # Dismiss the modal
    removeModal()
  })

  # Brings the user to the comparison methods page
  observeEvent(input$add_linkage_iteration_to_add_comparison_methods, {

    # Set the return page to the add linkage iterations page
    comparison_methods_return_page <<- "add_linkage_iterations_page"

    # Show the linkage rule page
    nav_show("main_navbar", "comparison_methods_page")

    # Brings you to the linkage rules page
    updateNavbarPage(session, "main_navbar", selected = "comparison_methods_page")
  })

  ### UPDATING COMPARISON RULE

  # Selecting an comparison rule for the iteration
  observeEvent(input$prepare_matching_comparison_rule_update, {
    # Generates the table of acceptance methods
    output$update_comparison_method_iteration <- renderDataTable({
      get_comparison_methods_and_parameters()
    })

    output$iteration_comparison_rule_add_inputs_update <- renderUI({

    })

    showModal(modalDialog(
      title = "Choose Comparison Rule",
      easyClose = TRUE,
      footer = NULL,
      fluidPage(
        # Comparison rule table
        h5("Select a Comparison Method & Enter Rule Parameters:"),
        layout_column_wrap(
          width = 1/2,
          height = 500,

          # Card for the comparison methods table
          card(card_header("Comparison Methods Table", class = "bg-dark"),
               dataTableOutput("update_comparison_method_iteration")
          ),

          # Card for the comparison rules UI
          card(card_header("Comparison Rule Inputs", class = "bg-dark"),
               uiOutput("iteration_comparison_rule_add_inputs_update")
          )
        ),

        # OPTION 1: User may enter a new comparison method & parameters
        conditionalPanel(
          condition = "input.update_comparison_method_iteration_rows_selected <= 0",
          HTML("<br>"),

          # Button for moving the user to the comparison methods page
          fluidRow(
            h5(strong("Or, create a new comparison method below:")),
            column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                actionButton("add_linkage_iteration_to_add_comparison_methods_update", "Create Comparison Method", class = "btn-info"),
              )
            ),
          )
        ),

        # OPTION 2: User can submit which comparison rule they'd like to use
        conditionalPanel(
          condition = "input.update_comparison_method_iteration_rows_selected > 0",
          HTML("<br>"),

          # Button for moving the user to the comparison rules page
          fluidRow(
            column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                actionButton("prepare_iteration_comparison_rule_to_add_update", "Add Comparison Rule", class = "btn-success"),
              )
            )
          )
        ),
      ),
      size = "l"  # Large modal size to fit both tables
    ))
  })

  # Generates the table of comparison methods
  output$update_comparison_method_iteration <- renderDataTable({
    get_comparison_methods_and_parameters()
  })

  # Generates the dynamic comparison rule inputs
  observeEvent(input$update_comparison_method_iteration_rows_selected, {
    selected_row <- input$add_comparison_method_iteration_rows_selected

    if (!is.null(selected_row)) {
      # Perform a query to get the comparison methods
      query <- paste('SELECT * from comparison_methods')
      df <- dbGetQuery(linkage_metadata_conn, query)
      # Retrieve the comparison method id of the selected row
      selected_method <- df$comparison_method_id[selected_row]

      output$iteration_comparison_rule_add_inputs_update <- renderUI({
        modify_iteration_get_comparison_rule_inputs(selected_method, "modify_iteration_comparison_rule_update_input")
      })
    }
    else{
      output$iteration_comparison_rule_add_inputs_update <- renderUI({

      })
    }
  })

  # Selects the comparison rule the user wanted
  observeEvent(input$prepare_iteration_comparison_rule_to_add_update, {
    # Get the selected row
    selected_row <- input$update_comparison_method_iteration_rows_selected

    # Query to get all linkage rule information from the 'comparison_methods' table
    query <- paste('SELECT * FROM comparison_methods
               ORDER BY comparison_method_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    # Get the linkage rule
    comparison_method_id <- df$comparison_method_id[selected_row]

    # Get the parameter IDs, keys, and descriptions of the inputs we need
    query <- paste('SELECT * from comparison_method_parameters
                   WHERE comparison_method_id =', comparison_method_id)
    df <- dbGetQuery(linkage_metadata_conn, query)

    # Get the number of inputs we'll be adding
    num_inputs <- nrow(df)
    parameter_ids <- df$parameter_id

    # Error handling
    #----#
    # Error Handling to make sure all inputs are filled
    for(index in 1:(num_inputs)){
      # Get the input value for each input
      input_val <- input[[paste0("modify_iteration_comparison_rule_update_input", index)]]
      # Ensure it isn't null
      if(is.na(input_val)){
        showNotification("Failed to Use Comparison Rule - Some Input(s) Are Missing", type = "error", closeButton = FALSE)
        return()
      }
    }
    #----#

    # If the rule already exists, then use that Comparison Rule ID
    df <- data.frame()
    for (index in 1:(num_inputs)) {
      # Get the parameter to input
      parameter <- input[[paste0("modify_iteration_comparison_rule_update_input", index)]]

      # Get the parameter ID
      parameter_id <- parameter_ids[index]

      # Check if the database has this eact match
      get_query <- dbSendQuery(linkage_metadata_conn, 'SELECT * FROM comparison_rules_parameters
                                                  WHERE parameter_id = ? AND parameter = ?;')
      dbBind(get_query, list(parameter_id, parameter))
      output_df <- dbFetch(get_query)
      dbClearResult(get_query)
      df <- rbind(df, output_df)
    }

    # Group by the comparison_rule_id
    df_grouped <- df %>% group_by(comparison_rule_id) %>% filter(n() == num_inputs)

    # If it contains exactly those parameters, then there will be a row in the grouped df, so grab the acceptance rule
    comparison_rule_id <- 0
    if(nrow(df_grouped) > 0){
      comparison_rule_id <- df_grouped$comparison_rule_id[1]
    }
    #----#

    # If the comparison_rule_id is 0, then it does not exist, so create a new one
    if(comparison_rule_id == 0){
      # Add all the necessary acceptance rule information
      successful <- TRUE
      #----#
      added_comparison_rule_id <- tryCatch({
        # Start a transaction
        dbBegin(linkage_metadata_conn)

        # Start by creating a new comparison rule
        new_entry_query <- paste("INSERT INTO comparison_rules (comparison_method_id)",
                                 "VALUES(?);")
        new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
        dbBind(new_entry, list(comparison_method_id))
        dbClearResult(new_entry)

        # Add the dataset fields to the other table after we insert basic information
        #----#
        # Get the most recently inserted comparison_rule_id value
        new_comparison_rule_id <- dbGetQuery(linkage_metadata_conn, "SELECT last_insert_rowid() AS comparison_rule_id;")$comparison_rule_id

        # Insert each parameter value into the database
        for (index in 1:(num_inputs)) {
          # Get the parameter to input
          parameter <- input[[paste0("modify_iteration_comparison_rule_update_input", index)]]

          # Get the parameter ID
          parameter_id <- parameter_ids[index]

          insert_field_query <- "INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter) VALUES (?, ?, ?);"
          insert_field_stmt <- dbSendStatement(linkage_metadata_conn, insert_field_query)
          dbBind(insert_field_stmt, list(new_comparison_rule_id, parameter_id, parameter))
          dbClearResult(insert_field_stmt)
        }

        # End a transaction
        dbCommit(linkage_metadata_conn)

        # Return the new comparison rule
        new_comparison_rule_id
      },
      error = function(e){
        # If we throw an error because of timeout, or bad insert, then rollback and return
        successful <- FALSE
        dbRollback(linkage_metadata_conn)
        showNotification("Failed to Add Comparison Rule - An Error Occurred While Inserting", type = "error", closeButton = FALSE)
        return(0)
      })

      # If we didn't successfully add the acceptance rule, then return
      if(!successful) return()

      comparison_rule_id <- added_comparison_rule_id
      #----#
    }

    # Render the output text to make the method readable
    if(!is.na(comparison_rule_id)){
      # Query to get the acceptance method name from the comparison_rules table
      method_query <- paste('SELECT method_name FROM comparison_rules cr
                           JOIN comparison_methods cm on cr.comparison_method_id = cm.comparison_method_id
                           WHERE comparison_rule_id =', comparison_rule_id)
      method_name <- dbGetQuery(linkage_metadata_conn, method_query)$method_name

      # Query to get the associated parameters for the comparison_rule_id
      params_query <- paste('SELECT parameter FROM comparison_rules_parameters WHERE comparison_rule_id =', comparison_rule_id)
      params_df <- dbGetQuery(linkage_metadata_conn, params_query)

      # Combine the parameters into a string
      params_str <- paste(params_df$parameter, collapse = ", ")

      # Create the final string "method_name (key1=value1, key2=value2)"
      method_with_params <- paste0(method_name, " (", params_str, ")")
      output$matching_comparison_rules_update <- renderText({
        method_with_params
      })
    }

    # Set the global variable
    matching_comparison_rule_to_update <<- comparison_rule_id

    # Dismiss the modal
    removeModal()
  })

  # Brings the user to the comparison methods page
  observeEvent(input$add_linkage_iteration_to_add_comparison_methods_update, {

    # Set the return page to the add linkage iterations page
    comparison_methods_return_page <<- "add_linkage_iterations_page"

    # Show the linkage rule page
    nav_show("main_navbar", "comparison_methods_page")

    # Brings you to the linkage rules page
    updateNavbarPage(session, "main_navbar", selected = "comparison_methods_page")
  })

  #---------------------------------#

  #-- SAVE/MODIFY ITERATION --#
  # If user clicks on "Save Iteration" we'll either create a new iteration ID or update an existing one
  observeEvent(input$save_iteration, {
    # Get the user input values
    algorithm_id       <- add_linkage_iterations_algorithm_id
    iteration_name     <- input$add_iteration_name
    iteration_priority <- input$add_iteration_order
    linkage_method_id  <- input$add_iteration_linkage_method
    acceptance_rule_id <- iteration_acceptance_rule_to_add
    modified_by <- username
    modified_date <- format(Sys.Date(), format = "%Y-%m-%d")
    # print(paste0("Algorithm ID: ", algorithm_id))
    # print(paste0("Iteration Name: ", iteration_name))
    # print(paste0("Iteration Priority: ", iteration_priority))
    # print(paste0("Linkage Method: ", linkage_method_id))
    # print(paste0("Acceptance Rule: ", acceptance_rule_id))

    # Create a data frame of the blocking keys
    blocking_keys_df <- data.frame(
      left_field = left_blocking_keys_to_add,
      right_field = right_blocking_keys_to_add,
      linkage_rule = blocking_linkage_rules_to_add
    )

    # Create a data frame of the matching keys
    matching_keys_df <- data.frame(
      left_field = left_matching_keys_to_add,
      right_field = right_matching_keys_to_add,
      linkage_rule = matching_linkage_rules_to_add,
      comparison_rule = matching_comparison_rules_to_add
    )

    #-- Error Handling --#
    # Make sure the generic inputs are all filled
    if(trimws(iteration_name) == ""){
      showNotification("Failed to Save Iteration Changes - Iteration Name is Missing", type = "error", closeButton = FALSE)
      return()
    }
    if(is.na(iteration_priority) || iteration_priority <= 0){
      showNotification("Failed to Save Iteration Changes - Iteration Priority Must be >= 1", type = "error", closeButton = FALSE)
      return()
    }
    if(linkage_method_id == ''){
      showNotification("Failed to Save Iteration Changes - Linkage Method Must Be Selected", type = "error", closeButton = FALSE)
      return()
    }
    #--------------------#

    # Get the existing iteration ID (if there is one) and use it to either update
    # an existing ID, or create a new iteration with an auto-increment primary key
    stored_iteration_id <- existing_iteration_id

    # Variable to determine whether we modified the iteration successfully
    successful <- TRUE

    #If ID == 0, then we aren't updating an iteration
    if(stored_iteration_id == 0){
      # Make sure the iteration name isn't being used yet
      #----#
      query <- paste('SELECT * FROM linkage_iterations
                        WHERE algorithm_id =', algorithm_id,
                     'ORDER BY iteration_num ASC;')
      df <- dbGetQuery(linkage_metadata_conn, query)

      # Get the iteration names currently being used
      iteration_names <- df$iteration_name

      # Check if the name the user passed exists in the database
      if(iteration_name %in% iteration_names){
        showNotification("Failed to Save Iteration Changes - Iteration Name Already Being Used", type = "error", closeButton = FALSE)
        return()
      }
      #----#

      tryCatch({
        # Start a transaction
        dbBegin(linkage_metadata_conn)

        # Make sure no two iterations share the same iteration number by updating any that may require it
        #----#
        query <- paste('SELECT * FROM linkage_iterations
                        WHERE algorithm_id =', algorithm_id,
                       'ORDER BY iteration_num ASC;')
        df <- dbGetQuery(linkage_metadata_conn, query)

        # For each row in the data frame, make sure no two rows have the same priority
        if(nrow(df) > 0){
          # Start by storing the 'previous' iteration priority
          previous_iteration_priority <- iteration_priority
          for(index in 1:nrow(df)){
            # If the previous iteration priority equals the priority stored in the database, add +1 to it
            if(df$iteration_num[index] == previous_iteration_priority){
              df$iteration_num[index] <- df$iteration_num[index] + 1
              previous_iteration_priority <- df$iteration_num[index]
            }
          }

          # After we update all the iteration priorities, update their values in the database
          for(index in 1:nrow(df)){
            # Update query
            update_query <- paste("UPDATE linkage_iterations
                                   SET iteration_num = ?
                                   WHERE iteration_id = ?")
            update <- dbSendStatement(linkage_metadata_conn, update_query)
            dbBind(update, list(df$iteration_num[index], df$iteration_id[index]))
            dbClearResult(update)
          }
        }

        #print("STEP 1")
        #----#

        # Create a new iteration
        #----#
        # print(class(algorithm_id))
        # print(class(iteration_name))
        # print(class(iteration_priority))
        # print(class(linkage_method_id))
        # print(class(acceptance_rule_id))
        # print(class(modified_date))
        # print(class(modified_by))

        new_entry_query <- paste("INSERT INTO linkage_iterations (algorithm_id, iteration_name, iteration_num, linkage_method_id, acceptance_rule_id, modified_date, modified_by, enabled)",
                                 "VALUES(?, ?, ?, ?, ?, ?, ?, ?);")
        new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
        dbBind(new_entry, list(algorithm_id, iteration_name, iteration_priority, linkage_method_id, acceptance_rule_id, modified_date, modified_by, 1))
        dbClearResult(new_entry)
        #----#

        #print("STEP 2")

        # Get the most recently inserted iteration_id value
        iteration_id <- dbGetQuery(linkage_metadata_conn, "SELECT last_insert_rowid() AS iteration_id;")$iteration_id

        # Add each of the blocking keys into the database
        if(nrow(blocking_keys_df) > 0){
          for(index in 1:nrow(blocking_keys_df)){
            # Get the blocking key data for the current row
            right_dataset_field_id  <- blocking_keys_df$right_field[index]
            left_dataset_field_id   <- blocking_keys_df$left_field[index]
            linkage_rule_id         <- blocking_keys_df$linkage_rule[index]

            # Insert the pair of keys + linkage rules into the database
            new_entry_query <- paste("INSERT INTO blocking_variables (iteration_id, right_dataset_field_id, left_dataset_field_id, linkage_rule_id)",
                                     "VALUES(?, ?, ?, ?);")
            new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
            dbBind(new_entry, list(iteration_id, right_dataset_field_id, left_dataset_field_id, linkage_rule_id))
            dbClearResult(new_entry)
          }
        }

        #print("STEP 3")

        # Finally, add each of the matching keys into the database
        if(nrow(matching_keys_df) > 0){
          for(index in 1:nrow(matching_keys_df)){
            # Get the blocking key data for the current row
            right_dataset_field_id  <- matching_keys_df$right_field[index]
            left_dataset_field_id   <- matching_keys_df$left_field[index]
            linkage_rule_id         <- matching_keys_df$linkage_rule[index]
            comparison_rule_id      <- matching_keys_df$comparison_rule[index]

            # Insert the pair of keys + linkage rule & comparison rule into the database
            new_entry_query <- paste("INSERT INTO matching_variables (iteration_id, right_dataset_field_id, left_dataset_field_id, linkage_rule_id, comparison_rule_id)",
                                     "VALUES(?, ?, ?, ?, ?);")
            new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
            dbBind(new_entry, list(iteration_id, right_dataset_field_id, left_dataset_field_id, linkage_rule_id, comparison_rule_id))
            dbClearResult(new_entry)
          }
        }

        #print("STEP 4")

        # Commit transaction
        dbCommit(linkage_metadata_conn)
      },
      error = function(e){
        print(geterrmessage())
        # We were unsuccessful
        successful <<- FALSE

        # If we throw an error because of timeout, or bad insert, then rollback and return
        dbRollback(linkage_metadata_conn)
        showNotification("Failed to Create Iteration - An Error Occurred While Inserting", type = "error", closeButton = FALSE)
        return()
      })
    }
    # If ID != 0, then we got an existing iteration to update
    else{
      # Make sure the iteration name isn't being used yet
      #----#
      query <- paste('SELECT * FROM linkage_iterations
                        WHERE algorithm_id =', algorithm_id, 'AND iteration_id !=', stored_iteration_id,
                     'ORDER BY iteration_num ASC;')
      df <- dbGetQuery(linkage_metadata_conn, query)

      # Get the iteration names currently being used
      iteration_names <- df$iteration_name

      # Check if the name the user passed exists in the database
      if(iteration_name %in% iteration_names){
        showNotification("Failed to Save Iteration Changes - Iteration Name Already Being Used", type = "error", closeButton = FALSE)
        return()
      }
      #----#

      tryCatch({
        # Start a transaction
        dbBegin(linkage_metadata_conn)

        # Make sure no two iterations share the same iteration number by updating any that may require it
        #----#
        query <- paste('SELECT * FROM linkage_iterations
                        WHERE algorithm_id =', algorithm_id, 'AND iteration_id !=', stored_iteration_id,
                       'ORDER BY iteration_num ASC;')
        df <- dbGetQuery(linkage_metadata_conn, query)

        # For each row in the data frame, make sure no two rows have the same priority
        if(nrow(df) > 0){
          # Start by storing the 'previous' iteration priority
          previous_iteration_priority <- iteration_priority
          for(index in 1:nrow(df)){
            # If the previous iteration priority equals the priority stored in the database, add +1 to it
            if(df$iteration_num[index] == previous_iteration_priority){
              df$iteration_num[index] <- df$iteration_num[index] + 1
              previous_iteration_priority <- df$iteration_num[index]
            }
          }

          # After we update all the iteration priorities, update their values in the database
          for(index in 1:nrow(df)){
            # Update query
            update_query <- paste("UPDATE linkage_iterations
                                   SET iteration_num = ?
                                   WHERE iteration_id = ?")
            update <- dbSendStatement(linkage_metadata_conn, update_query)
            dbBind(update, list(df$iteration_num[index], df$iteration_id[index]))
            dbClearResult(update)
          }
        }
        #----#

        # Create a new entry query for updating the linkage iteration
        #----#
        update_query <- paste("UPDATE linkage_iterations
                          SET iteration_name = ?, iteration_num = ?, linkage_method_id = ?, acceptance_rule_id = ?, modified_date = ?, modified_by = ?
                          WHERE iteration_id = ?")
        update <- dbSendStatement(linkage_metadata_conn, update_query)
        dbBind(update, list(iteration_name, iteration_priority, linkage_method_id, acceptance_rule_id, modified_date, modified_by, stored_iteration_id))
        dbClearResult(update)
        #----#

        # To update the blocking and matching keys, we'll need to delete them and add the prepared keys

        # Create a new entry query for deleting the blocking variable
        #----#
        delete_query <- paste("DELETE FROM blocking_variables
                               WHERE iteration_id = ?")
        delete <- dbSendStatement(linkage_metadata_conn, delete_query)
        dbBind(delete, list(stored_iteration_id))
        dbClearResult(delete)
        #----#

        # Create a new entry query for deleting the matching variable
        #----#
        delete_query <- paste("DELETE FROM matching_variables
                               WHERE iteration_id = ?")
        delete <- dbSendStatement(linkage_metadata_conn, delete_query)
        dbBind(delete, list(stored_iteration_id))
        dbClearResult(delete)
        #----#

        # Add each of the blocking keys into the database
        if(nrow(blocking_keys_df) > 0){
          for(index in 1:nrow(blocking_keys_df)){
            # Get the blocking key data for the current row
            right_dataset_field_id  <- blocking_keys_df$right_field[index]
            left_dataset_field_id   <- blocking_keys_df$left_field[index]
            linkage_rule_id         <- blocking_keys_df$linkage_rule[index]

            # Insert the pair of keys + linkage rules into the database
            new_entry_query <- paste("INSERT INTO blocking_variables (iteration_id, right_dataset_field_id, left_dataset_field_id, linkage_rule_id)",
                                     "VALUES(?, ?, ?, ?);")
            new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
            dbBind(new_entry, list(stored_iteration_id, right_dataset_field_id, left_dataset_field_id, linkage_rule_id))
            dbClearResult(new_entry)
          }
        }

        # Finally, add each of the matching keys into the database
        if(nrow(matching_keys_df) > 0){
          for(index in 1:nrow(matching_keys_df)){
            # Get the blocking key data for the current row
            right_dataset_field_id  <- matching_keys_df$right_field[index]
            left_dataset_field_id   <- matching_keys_df$left_field[index]
            linkage_rule_id         <- matching_keys_df$linkage_rule[index]
            comparison_rule_id      <- matching_keys_df$comparison_rule[index]

            # Insert the pair of keys + linkage rule & comparison rule into the database
            new_entry_query <- paste("INSERT INTO matching_variables (iteration_id, right_dataset_field_id, left_dataset_field_id, linkage_rule_id, comparison_rule_id)",
                                     "VALUES(?, ?, ?, ?, ?);")
            new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
            dbBind(new_entry, list(stored_iteration_id, right_dataset_field_id, left_dataset_field_id, linkage_rule_id, comparison_rule_id))
            dbClearResult(new_entry)
          }
        }

        # Commit transaction
        dbCommit(linkage_metadata_conn)
      },
      error = function(e){
        # We were unsuccessful
        successful <- FALSE

        # If we throw an error because of timeout, or bad insert, then rollback and return
        dbRollback(linkage_metadata_conn)
        showNotification("Failed to Modify Iteration - An Error Occurred While Inserting", type = "error", closeButton = FALSE)
        return()
      })
    }

    # If we were unsuccessful, return here
    if(successful == FALSE) return()

    # Show success notification
    if(stored_iteration_id == 0){
      showNotification("Linkage Iteration Successfully Created", type = "message", closeButton = FALSE)
    }
    else{
      showNotification("Linkage Iteration Successfully Updated", type = "message", closeButton = FALSE)
    }

    # GLOBAL VARIABLES FOR STORING THE TEMPORARY BLOCKING AND MATCHING KEYS + THEIR RULES
    left_blocking_keys_to_add        <<- c()
    right_blocking_keys_to_add       <<- c()
    blocking_linkage_rules_to_add    <<- c()

    left_matching_keys_to_add        <<- c()
    right_matching_keys_to_add       <<- c()
    matching_linkage_rules_to_add    <<- c()
    matching_comparison_rules_to_add <<- c()

    # GLOBAL VARIABLES FOR STORING THE ACCEPTANCE RULES, PREPARED LINKAGE RULES, AND PREPARED COMPARISON RULES
    iteration_acceptance_rule_to_add   <<- NA
    blocking_linkage_rule_to_add       <<- NA
    blocking_linkage_rule_to_update    <<- NA
    matching_linkage_rule_to_add       <<- NA
    matching_linkage_rule_to_update    <<- NA
    matching_comparison_rule_to_add    <<- NA
    matching_comparison_rule_to_update <<- NA

    # Update the table of iterations on the 'view iterations' page
    output$currently_added_linkage_iterations <- renderDataTable({
      get_linkage_iterations_view()
    })
    output$previously_used_iterations <- renderDataTable({
      get_linkage_iterations_add_existing()
    })

    # Bring the user back to the view iterations page
    nav_show("main_navbar", add_linkage_iterations_return_page)
    updateNavbarPage(session, "main_navbar", selected = add_linkage_iterations_return_page)
  })
  #---------------------------#

  #----
  #---------------------------------------#

  #-- ACCEPTANCE METHODS & PARAMETERS PAGE EVENTS --#
  #----
  acceptance_methods_return_page <- "home_page"

  # Back button will bring you back to whichever page you came from
  observeEvent(input$acceptance_methods_back, {
    # Show the page we need to return to
    nav_show("main_navbar", acceptance_methods_return_page)

    # Show return to the page you came from
    updateNavbarPage(session, "main_navbar", selected = acceptance_methods_return_page)
  })

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
    dt <- datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE, dom = 'tp'))
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
    dt <- datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE, dom = 'tp'))
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
    successful <- TRUE
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
      successful <- FALSE
      dbRollback(linkage_metadata_conn)
      showNotification("Failed to Add Acceptance Method & Parameters - An Error Occurred While Inserting", type = "error", closeButton = FALSE)
      return()
    })

    # If we didn't successfully update the acceptance method, then return
    if(!successful) return()

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
    dt <- datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE, dom = 'tp'))
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
    successful <- TRUE
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
      errmsg <- geterrmessage()
      successful <- FALSE
      dbRollback(linkage_metadata_conn)

      if(errmsg != "thrown"){
        showNotification("Failed to Update Acceptance Method & Parameters - An Error Occurred While Inserting", type = "error", closeButton = FALSE)
      }
      return()
    })

    # If we didn't successfully update the acceptance method, then return
    if(!successful) return()
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
    # Show the page we need to return to
    nav_show("main_navbar", acceptance_rules_return_page)

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
    dt <- datatable(df, selection = 'none', rownames = FALSE, options = list(lengthChange = FALSE, dom = 'tp'))
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
          column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
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

  # Attempts to add the acceptance rule using the provided input values
  observeEvent(input$add_acceptance_rule, {
    # Get the parameter IDs, keys, and descriptions of the inputs we need
    query <- paste('SELECT * from acceptance_method_parameters
                   WHERE acceptance_method_id =', acceptance_method_id_add_rule)
    df <- dbGetQuery(linkage_metadata_conn, query)

    # Get the number of inputs we'll be adding
    num_inputs <- nrow(df)
    parameter_ids <- df$parameter_id

    # Error handling
    #----#
    # Error Handling to make sure all inputs are filled
    for(index in 1:(num_inputs)){
      # Get the input value for each input
      input_val <- input[[paste0("acceptance_rules_input_", index)]]
      # Ensure it isn't null
      if(is.na(input_val)){
        showNotification("Failed to Add Acceptance Rule - Some Input(s) Are Missing", type = "error", closeButton = FALSE)
        return()
      }
    }

    # Lastly, we'll make sure this rule doesn't already exist
    df <- data.frame()
    for (index in 1:(num_inputs)) {
      # Get the parameter to input
      parameter <- input[[paste0("acceptance_rules_input_", index)]]

      # Get the parameter ID
      parameter_id <- parameter_ids[index]

      # Check if the database has this eact match
      get_query <- dbSendQuery(linkage_metadata_conn, 'SELECT * FROM acceptance_rules_parameters
                                                  WHERE parameter_id = ? AND parameter = ?;')
      dbBind(get_query, list(parameter_id, parameter))
      output_df <- dbFetch(get_query)
      dbClearResult(get_query)
      df <- rbind(df, output_df)
    }

    # Group by the acceptance_rule_id
    df_grouped <- df %>% group_by(acceptance_rule_id) %>% filter(n() == num_inputs)

    # If it contains exactly those parameters, then there will be a row in the grouped df, so return
    if(nrow(df_grouped) > 0){
      showNotification("Failed to Add Acceptance Rule - Acceptance Rule Already Exists", type = "error", closeButton = FALSE)
      return()
    }
    #----#

    # Add all the necessary acceptance rule information
    successful <- TRUE
    #----#
    tryCatch({
      # Start a transaction
      dbBegin(linkage_metadata_conn)

      # Start by creating a new acceptance rule
      new_entry_query <- paste("INSERT INTO acceptance_rules (acceptance_method_id)",
                               "VALUES(?);")
      new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
      dbBind(new_entry, list(acceptance_method_id_add_rule))
      dbClearResult(new_entry)

      # Add the dataset fields to the other table after we insert basic information
      #----#
      # Get the most recently inserted acceptance_rule_id value
      acceptance_rule_id <- dbGetQuery(linkage_metadata_conn, "SELECT last_insert_rowid() AS acceptance_rule_id;")$acceptance_rule_id

      # Insert each parameter value into the database
      for (index in 1:(num_inputs)) {
        # Get the parameter to input
        parameter <- input[[paste0("acceptance_rules_input_", index)]]

        # Get the parameter ID
        parameter_id <- parameter_ids[index]

        insert_field_query <- "INSERT INTO acceptance_rules_parameters (acceptance_rule_id, parameter_id, parameter) VALUES (?, ?, ?);"
        insert_field_stmt <- dbSendStatement(linkage_metadata_conn, insert_field_query)
        dbBind(insert_field_stmt, list(acceptance_rule_id, parameter_id, parameter))
        dbClearResult(insert_field_stmt)
      }

      # End a transaction
      dbCommit(linkage_metadata_conn)

    },
    error = function(e){
      # If we throw an error because of timeout, or bad insert, then rollback and return
      successful <- FALSE
      dbRollback(linkage_metadata_conn)
      showNotification("Failed to Add Acceptance Rule - An Error Occurred While Inserting", type = "error", closeButton = FALSE)
      return()
    })

    # If we didn't successfully add the acceptance rule, then return
    if(!successful) return()
    #----#

    # Update Data Tables and UI Renders
    #----#
    output$currently_added_acceptance_rules <- renderDataTable({
      get_acceptance_rules()
    })
    output$acceptance_rules_inputs <- renderUI({
      get_acceptance_rules_inputs()
    })
    #----#

    # Show success notification
    #----#
    showNotification("Acceptance Rule Successfully Created", type = "message", closeButton = FALSE)
    #----#

  })
  #----
  #----------------------------------#

  #-- COMPARISON METHODS & PARAMETERS PAGE EVENTS --#
  #----
  comparison_methods_return_page  <- "home_page"

  # Back button will bring you back to whichever page you came from
  observeEvent(input$comparison_methods_back, {
    # Show the page we need to return to
    nav_show("main_navbar", comparison_methods_return_page)

    # Show return to the page you came from
    updateNavbarPage(session, "main_navbar", selected = comparison_methods_return_page)
  })

  # Query and output for getting the acceptance methods & parameters
  get_comparison_methods_and_parameters <- function(){
    # Query to get all acceptance method information from the 'comparison_methods'
    # and 'comparison_method_parameters' table
    query <- paste('SELECT cm.comparison_method_id, method_name, cm.description, parameter_key FROM comparison_methods cm
                      JOIN comparison_method_parameters cmp on cmp.comparison_method_id = cm.comparison_method_id
                      ORDER BY cm.comparison_method_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    # Aggregate parameters by comparison_method_id
    df <- df %>%
      group_by(comparison_method_id, method_name, description) %>%
      summarise(parameters = paste(parameter_key, collapse = ", ")) %>%
      ungroup()

    # With our data frame, we'll rename some of the columns to look better
    names(df)[names(df) == 'method_name'] <- 'Comparison Method Name'
    names(df)[names(df) == 'description'] <- 'Comparison Method Description'
    names(df)[names(df) == 'parameters'] <- 'Comparison Method Parameters'

    # Drop the comparison_method_id
    df <- subset(df, select = -c(comparison_method_id))

    # Put it into a data table now
    dt <- datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE, dom = 'tp'))
  }

  # Renders the data table of currently added acceptance methods & parameters
  output$currently_added_comparison_methods_and_parameters <- renderDataTable({
    get_comparison_methods_and_parameters()
  })

  # Brings the user to the acceptance rules page FROM the Acceptance Methods & Parameters page
  observeEvent(input$comparison_methods_to_comparison_rules, {
    # Get the selected row
    selected_row <- input$currently_added_comparison_methods_and_parameters_rows_selected
    # Get the acceptance method id from the selected row
    df <- dbGetQuery(linkage_metadata_conn, paste('SELECT * from comparison_methods
                                             ORDER BY comparison_method_id ASC'))
    comparison_method_id <- df[selected_row, "comparison_method_id"]

    # Update the global variable for the acceptance method id and the return page
    comparison_method_id_add_rule <<- comparison_method_id
    comparison_rules_return_page  <<- "comparison_methods_page"

    # Update the table of acceptance rules on that page
    output$currently_added_comparison_rules <- renderDataTable({
      get_comparison_rules()
    })

    # Update the UI inputs for the acceptance rules on that page
    output$comparison_rules_inputs <- renderUI({
      get_comparison_rules_inputs()
    })

    # Show the acceptance rules pages
    nav_show('main_navbar', 'comparison_rules_page')
    updateNavbarPage(session, "main_navbar", selected = "comparison_rules_page")
  })

  #-- NEW ACCEPTANCE METHOD & PARAMETERS --#
  # Create global variables for the parameter_key, and the descriptions of each
  comparison_parameter_keys_to_add <- c()
  comparison_parameter_desc_to_add <- c()

  # Function for creating the table of parameters to be added
  get_comparison_parameters_to_add <- function(){
    # Create a data frame from all the parameter keys
    df <- data.frame(
      keys = if(length(comparison_parameter_keys_to_add) == 0) numeric() else comparison_parameter_keys_to_add,
      desc = if(length(comparison_parameter_desc_to_add) == 0) character() else comparison_parameter_desc_to_add
    )

    # With our data frame, we'll rename some of the columns to look better
    names(df)[names(df) == 'keys'] <- 'Comparison Parameter Key'
    names(df)[names(df) == 'desc'] <- 'Comparison Parameter Description'

    # Put it into a data table now
    dt <- datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE, dom = 'tp'))
  }

  # Renders the data table of acceptance parameters that are to be added
  output$comparison_parameters_to_add <- renderDataTable({
    get_comparison_parameters_to_add()
  })

  # Adds a parameter key and description to the list of prepped keys and descriptions
  observeEvent(input$prepare_comparison_method_parameters_to_add, {
    # Get the values that we're inserting into a new record
    #----#
    parameter_key  <- input$add_comparison_parameter_key
    parameter_desc <- input$add_comparison_parameter_desc
    #----#

    # Error Handling
    #----#
    # Make sure the same dataset code is already being used
    if(parameter_key %in% comparison_parameter_keys_to_add){
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
    comparison_parameter_keys_to_add <<- append(comparison_parameter_keys_to_add, parameter_key)
    comparison_parameter_desc_to_add <<- append(comparison_parameter_desc_to_add, parameter_desc)
    #----#

    # Update user input fields to make them blank!
    #----#
    updateTextAreaInput(session, "add_comparison_parameter_key",  value = "")
    updateTextAreaInput(session, "add_comparison_parameter_desc", value = "")
    #----#

    # Update Data Tables and UI Renders
    #----#
    output$comparison_parameters_to_add <- renderDataTable({
      get_comparison_parameters_to_add()
    })
    #----#

    # Show success notification
    #----#
    showNotification("Parameter Key Successfully Prepared", type = "message", closeButton = FALSE)
    #----#
  })

  # Observes what row the user selects to update and will pre-populate the parameter key updating fields
  observe({
    row_selected <- input$comparison_parameters_to_add_rows_selected

    # Get the the parameter key and desc from the prepared values
    parameter_key  <- comparison_parameter_keys_to_add[row_selected]
    parameter_desc <- comparison_parameter_desc_to_add[row_selected]

    # Now update the input fields
    updateTextAreaInput(session, "update_comparison_parameter_key",  value = parameter_key)
    updateTextAreaInput(session, "update_comparison_parameter_desc", value = parameter_desc)
  })

  # Updates an existing record in our prepared parameters
  observeEvent(input$update_prepared_comparison_method_parameters_to_add, {
    # Get the values that we're inserting into a new record + the selected row
    #----#
    row_selected <- input$comparison_parameters_to_add_rows_selected
    parameter_key  <- input$update_comparison_parameter_key
    parameter_desc <- input$update_comparison_parameter_desc
    #----#

    # Error Handling
    #----#
    # Make sure the same parameter key is not being used
    if(parameter_key %in% comparison_parameter_keys_to_add && comparison_parameter_keys_to_add[row_selected] != parameter_key){
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
    comparison_parameter_keys_to_add[row_selected] <<- parameter_key
    comparison_parameter_desc_to_add[row_selected] <<- parameter_desc
    #----#

    # Update user input fields to make them blank!
    #----#
    updateTextAreaInput(session, "update_comparison_parameter_key",  value = "")
    updateTextAreaInput(session, "update_comparison_parameter_desc", value = "")
    #----#

    # Update Data Tables and UI Renders
    #----#
    output$comparison_parameters_to_add <- renderDataTable({
      get_comparison_parameters_to_add()
    })
    #----#

    # Show success notification
    #----#
    showNotification("Prepared Parameter Key Successfully Updated", type = "message", closeButton = FALSE)
    #----#
  })

  # Drops an existing record from our prepared parameters
  observeEvent(input$drop_prepared_comparison_method_parameters_to_add, {
    # Get the row to drop
    #----#
    row_selected <- input$comparison_parameters_to_add_rows_selected
    #----#

    # Append the data to our global variables
    #----#
    comparison_parameter_keys_to_add <<- comparison_parameter_keys_to_add[-c(row_selected)]
    comparison_parameter_desc_to_add <<- comparison_parameter_desc_to_add[-c(row_selected)]
    #----#

    # Update user input fields to make them blank!
    #----#
    updateTextAreaInput(session, "update_comparison_parameter_key",  value = "")
    updateTextAreaInput(session, "update_comparison_parameter_desc", value = "")
    #----#

    # Update Data Tables and UI Renders
    #----#
    output$comparison_parameters_to_add <- renderDataTable({
      get_comparison_parameters_to_add()
    })
    #----#

    # Show success notification
    #----#
    showNotification("Prepared Parameter Key Successfully Dropped", type = "message", closeButton = FALSE)
    #----#
  })

  # Creates a new comparison method w/parameters using the general information & prepared parameters
  observeEvent(input$add_comparison_method_and_parameters, {
    comparison_method_name <- input$add_comparison_method_name
    comparison_method_desc <- input$add_comparison_method_desc

    # Error checks
    #----#
    # Make Sure the comparison method inputs are all valid
    if(comparison_method_name == "" || comparison_method_desc == ""){
      showNotification("Failed to Add Comparison Method - Some Comparison Method Inputs are Missing", type = "error", closeButton = FALSE)
      return()
    }

    # Make sure there exist comparison parameters that are being added with this comparison methods
    if(length(comparison_parameter_keys_to_add) == 0 || length(comparison_parameter_desc_to_add) == 0){
      showNotification("Failed to Add Comparison Method - Missing Parameters to Add With Comparison Method", type = "error", closeButton = FALSE)
      return()
    }

    # Make sure no other comparison method shares the same name
    get_query <- dbSendQuery(linkage_metadata_conn, 'SELECT * FROM comparison_methods
                                                  WHERE method_name = ?;')
    dbBind(get_query, list(comparison_method_name))
    output_df <- dbFetch(get_query)
    num_of_databases <- nrow(output_df)
    dbClearResult(get_query)
    if(num_of_databases != 0){
      showNotification("Failed to Add Comparison Method - Comparison Method Already Exists", type = "error", closeButton = FALSE)
      return()
    }
    #----#

    # Create a new entry query for entering into the database
    successful <- TRUE
    #----#
    tryCatch({
      # Begin a transaction for the comparison methods & parameters insertions
      dbBegin(linkage_metadata_conn)

      # Insert the comparison method
      new_entry_query <- paste("INSERT INTO comparison_methods (method_name, description)",
                               "VALUES(?, ?);")
      new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
      dbBind(new_entry, list(comparison_method_name, comparison_method_desc))
      dbClearResult(new_entry)

      # Get the most recently inserted comparison_method_id value
      comparison_method_id <- dbGetQuery(linkage_metadata_conn, "SELECT last_insert_rowid() AS comparison_method_id;")$comparison_method_id

      # Insert each parameter key and description into the database
      for (index in 1:length(comparison_parameter_keys_to_add)) {
        # Get the parameter key and description
        parameter_key <- comparison_parameter_keys_to_add[index]
        description <- comparison_parameter_desc_to_add[index]

        # Insert the parameters
        new_entry_query <- paste("INSERT INTO comparison_method_parameters (comparison_method_id, parameter_key, description)",
                                 "VALUES(?, ?, ?);")
        new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
        dbBind(new_entry, list(comparison_method_id, parameter_key, description))
        dbClearResult(new_entry)
      }

      # Commit the transaction after all insertions are successful
      dbCommit(linkage_metadata_conn)
    },
    error = function(e){
      # If we throw an error because of timeout, or bad insert, then rollback and return
      successful <- FALSE
      dbRollback(linkage_metadata_conn)
      showNotification("Failed to Add Comparison Method & Parameters - An Error Occurred While Inserting", type = "error", closeButton = FALSE)
      return()
    })

    # If we didn't successfully update the comparison method, then return
    if(!successful) return()

    #----#

    # Reset the prepared parameters and keys
    #----#
    comparison_parameter_keys_to_add <<- c()
    comparison_parameter_desc_to_add <<- c()
    #----#

    # Update user input fields to make them blank!
    #----#
    updateTextAreaInput(session, "add_comparison_method_name",    value = "")
    updateTextAreaInput(session, "add_comparison_method_desc",    value = "")
    updateTextAreaInput(session, "add_comparison_parameter_key",  value = "")
    updateTextAreaInput(session, "add_comparison_parameter_desc", value = "")
    #----#

    # Update Data Tables and UI Renders
    #----#
    output$comparison_parameters_to_add <- renderDataTable({
      get_comparison_parameters_to_add()
    })
    output$currently_added_comparison_methods_and_parameters <- renderDataTable({
      get_comparison_methods_and_parameters()
    })
    #----#

    # Show success notification
    #----#
    showNotification("Comparison Method & Parameters Successfully Created", type = "message", closeButton = FALSE)
    #----#
  })
  #----------------------------------------#

  #-- UPDATE ACCEPTANCE METHOD & PARAMETERS --#
  # Create global variables for the parameter_key, and the descriptions of each
  comparison_parameter_keys_to_update <- c()
  comparison_parameter_desc_to_update <- c()

  # Function for creating the table of parameters to be updated
  get_comparison_parameters_to_update <- function(){
    # Create a data frame from all the parameter keys
    df <- data.frame(
      keys = if(length(comparison_parameter_keys_to_update) == 0) numeric() else comparison_parameter_keys_to_update,
      desc = if(length(comparison_parameter_desc_to_update) == 0) character() else comparison_parameter_desc_to_update
    )

    # With our data frame, we'll rename some of the columns to look better
    names(df)[names(df) == 'keys'] <- 'Comparison Parameter Key'
    names(df)[names(df) == 'desc'] <- 'Comparison Parameter Description'

    # Put it into a data table now
    dt <- datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE, dom = 'tp'))
  }

  # Renders the data table of comparison parameters that are to be updated
  output$comparison_parameters_to_update <- renderDataTable({
    get_comparison_parameters_to_update()
  })

  # Observes what comparison method the user will update and will pre-populate the parameter key updating fields + general information
  observe({
    # Get the selected row
    row_selected <- input$currently_added_comparison_methods_and_parameters_rows_selected

    # If no row is selected, or a null row is selected, return
    if(is.null(row_selected)) return()

    # Query to get the general information
    df <- dbGetQuery(linkage_metadata_conn, paste('SELECT * from comparison_methods
                                             ORDER BY comparison_method_id ASC'))

    comparison_method_id   <- df[row_selected, "comparison_method_id"]
    comparison_method_name <- df[row_selected, "method_name"]
    comparison_method_desc <- df[row_selected, "description"]

    # Query to get the parameter keys
    df <- dbGetQuery(linkage_metadata_conn, paste('SELECT * from comparison_method_parameters
                                                WHERE comparison_method_id =', comparison_method_id,
                                                  'ORDER BY parameter_id ASC'))
    parameter_keys <- df$parameter_key
    parameter_desc <- df$description

    # Get the the parameter key and desc from the prepared values
    comparison_parameter_keys_to_update <<- parameter_keys
    comparison_parameter_desc_to_update <<- parameter_desc

    # Now update the input fields
    updateTextAreaInput(session, "update_comparison_method_name", value = comparison_method_name)
    updateTextAreaInput(session, "update_comparison_method_desc", value = comparison_method_desc)

    # Render the table for prepared parameters
    output$comparison_parameters_to_update <- renderDataTable({
      get_comparison_parameters_to_update()
    })
  })

  # Observes what comparison parameter key the user selects and pre-populates the input fields
  observe({
    row_selected <- input$comparison_parameters_to_update_rows_selected

    # Get the the parameter key and desc from the prepared values
    parameter_key  <- comparison_parameter_keys_to_update[row_selected]
    parameter_desc <- comparison_parameter_desc_to_update[row_selected]

    # Now update the input fields
    updateTextAreaInput(session, "comparison_parameter_key_update",  value = parameter_key)
    updateTextAreaInput(session, "comparison_parameter_desc_update", value = parameter_desc)
  })

  # Updates an existing record in our prepared parameters to update
  observeEvent(input$update_prepared_comparison_method_parameters_to_update, {
    # Get the values that we're inserting into a new record + the selected row
    #----#
    row_selected   <- input$comparison_parameters_to_update_rows_selected
    parameter_key  <- input$comparison_parameter_key_update
    parameter_desc <- input$comparison_parameter_desc_update
    #----#

    # Error Handling
    #----#
    # Make sure the same parameter key is not being used
    if(parameter_key %in% comparison_parameter_keys_to_update && comparison_parameter_keys_to_update[row_selected] != parameter_key){
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
    comparison_parameter_keys_to_update[row_selected] <<- parameter_key
    comparison_parameter_desc_to_update[row_selected] <<- parameter_desc
    #----#

    # Update user input fields to make them blank!
    #----#
    updateTextAreaInput(session, "comparison_parameter_key_update",  value = "")
    updateTextAreaInput(session, "comparison_parameter_desc_update", value = "")
    #----#

    # Update Data Tables and UI Renders
    #----#
    output$comparison_parameters_to_update <- renderDataTable({
      get_comparison_parameters_to_update()
    })
    #----#

    # Show success notification
    #----#
    showNotification("Prepared Parameter Key Successfully Updated", type = "message", closeButton = FALSE)
    #----#
  })

  # Updates the comparison method and parameters of the selected row
  observeEvent(input$update_comparison_method_and_parameters, {
    # Get the user provided method name, description, and selected row to update
    comparison_method_name <- input$update_comparison_method_name
    comparison_method_desc <- input$update_comparison_method_desc
    selected_row <- input$currently_added_comparison_methods_and_parameters_rows_selected

    # Get the acceptance method id from the selected row
    df <- dbGetQuery(linkage_metadata_conn, paste('SELECT * from comparison_methods
                                             ORDER BY comparison_method_id ASC'))

    comparison_method_id <- df[selected_row, "comparison_method_id"]

    # Get the parameter IDs using the selected acceptance method id
    df <- dbGetQuery(linkage_metadata_conn, paste('SELECT * from comparison_method_parameters
                                                WHERE comparison_method_id =', comparison_method_id,
                                                  'ORDER BY parameter_id ASC'))
    parameter_ids <- df$parameter_id

    # Error checks
    #----#
    # Make Sure the acceptance method inputs are all valid
    if(comparison_method_name == "" || comparison_method_desc == ""){
      showNotification("Failed to Update Comparison Method - Some Comparison Method Inputs are Missing", type = "error", closeButton = FALSE)
      return()
    }

    # Make sure there exist acceptance parameters that are being added with this acceptance methods
    if(length(comparison_parameter_keys_to_update) == 0 || length(comparison_parameter_desc_to_update) == 0){
      showNotification("Failed to Update Comparison Method - Missing Parameters to Update With Comparison Method", type = "error", closeButton = FALSE)
      return()
    }

    # Make sure no other acceptance method shares the same name
    get_query <- dbSendQuery(linkage_metadata_conn, 'SELECT * FROM comparison_methods
                                                  WHERE method_name = ? AND comparison_method_id != ?;')
    dbBind(get_query, list(comparison_method_name, comparison_method_id))
    output_df <- dbFetch(get_query)
    num_of_databases <- nrow(output_df)
    dbClearResult(get_query)
    if(num_of_databases != 0){
      showNotification("Failed to Update Comparison Method - Comparison Method Already Exists", type = "error", closeButton = FALSE)
      return()
    }
    #----#

    # Create a new entry query for entering into the database
    successful <- TRUE
    #----#
    tryCatch({
      # Begin a transaction for the acceptance methods & parameters insertions
      dbBegin(linkage_metadata_conn)

      # Query for updating the acceptance method
      update_query <- paste("UPDATE comparison_methods
                          SET method_name = ?, description = ?
                          WHERE comparison_method_id = ?")
      update <- dbSendStatement(linkage_metadata_conn, update_query)
      dbBind(update, list(comparison_method_name, comparison_method_desc, comparison_method_id))
      dbClearResult(update)

      # Insert each parameter key and description into the database
      for (index in 1:length(parameter_ids)) {
        # Get the parameter key, description, and ID for updating
        parameter_key <- comparison_parameter_keys_to_update[index]
        description   <- comparison_parameter_desc_to_update[index]
        parameter_id  <- parameter_ids[index]

        # Update the parameters
        update_query <- paste("UPDATE comparison_method_parameters
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
      successful <- FALSE
      dbRollback(linkage_metadata_conn)
      showNotification("Failed to Update Comparison Method & Parameters - An Error Occurred While Inserting", type = "error", closeButton = FALSE)
      return()
    })

    # If we didn't successfully update the acceptance method, then return
    if(!successful) return()
    #----#

    # Reset the prepared parameters and keys
    #----#
    comparison_parameter_keys_to_update <<- c()
    comparison_parameter_desc_to_update <<- c()
    #----#

    # Update Data Tables and UI Renders
    #----#
    output$currently_added_comparison_methods_and_parameters <- renderDataTable({
      get_comparison_methods_and_parameters()
    })
    #----#

    # Show success notification
    #----#
    showNotification("Comparison Method & Parameters Successfully Updated", type = "message", closeButton = FALSE)
    #----#
  })
  #-------------------------------------------#
  #----
  #-------------------------------------------------#

  #-- COMPARISON RULES PAGE EVENTS --#
  #----
  # Create a global variable for which comparison method we're wanting to add a rule for, and
  # as well as the PAGE we came from
  comparison_method_id_add_rule <- 1
  comparison_rules_return_page  <- "comparison_methods_page"

  # Back button will bring you back to whichever page you came from
  observeEvent(input$comparison_rules_back, {
    # Show the page we need to return to
    nav_show("main_navbar", comparison_rules_return_page)

    # Show return to the page you came from
    updateNavbarPage(session, "main_navbar", selected = comparison_rules_return_page)
  })

  # Function for creating the table of parameters to be added
  get_comparison_rules <- function(){
    comparison_method_id <- comparison_method_id_add_rule

    # Query to get all acceptance method information from the 'comparison_method_parameters' table
    query <- paste('SELECT crp.comparison_rule_id, parameter_id, parameter FROM comparison_rules cr
                   JOIN comparison_rules_parameters crp ON cr.comparison_rule_id = crp.comparison_rule_id
                   WHERE comparison_method_id =', comparison_method_id)
    df <- dbGetQuery(linkage_metadata_conn, query)

    # Aggregate parameters by comparison_rule_id
    df <- df %>%
      group_by(comparison_rule_id) %>%
      summarise(parameters = paste(parameter, collapse = ", ")) %>%
      ungroup()

    # With our data frame, we'll rename some of the columns to look better (we can always drop the ID if we want)
    names(df)[names(df) == 'comparison_rule_id'] <- 'Comparison Rule No.'
    names(df)[names(df) == 'parameters'] <- 'Parameter Values'

    # Put it into a data table now
    dt <- datatable(df, selection = 'none', rownames = FALSE, options = list(lengthChange = FALSE, dom = 'tp'))
  }

  # Renders the data table of comparison parameters that are to be added
  output$currently_added_comparison_rules <- renderDataTable({
    get_comparison_rules()
  })

  # Performs the query and UI construction for the comparison rule inputs
  get_comparison_rules_inputs <- function(){
    # Get the parameter IDs, keys, and descriptions of the inputs we need
    query <- paste('SELECT * from comparison_method_parameters
                   WHERE comparison_method_id =', comparison_method_id_add_rule)
    df <- dbGetQuery(linkage_metadata_conn, query)

    # Get the number of inputs we'll need
    num_inputs <- nrow(df)

    # Construct the list of inputs
    comparison_rule_input_list <- lapply(1:(num_inputs), function(index){
      # Using the current index, grab all the parameter information and provide a
      # numeric input for the user to enter their data.
      parameter_key  <- df[index, "parameter_key"]
      parameter_desc <- df[index, "description"]

      fluidPage(
        fluidRow(
          column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
             numericInput(paste0("comparison_rules_input_", index), label = h5(strong(parameter_key)),
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

  # Renders the UI inputs for the selected comparison method
  output$comparison_rules_inputs <- renderUI({
    get_comparison_rules_inputs()
  })

  # Attempts to add the comparison rule using the provided input values
  observeEvent(input$add_comparison_rule, {
    # Get the parameter IDs, keys, and descriptions of the inputs we need
    query <- paste('SELECT * from comparison_method_parameters
                   WHERE comparison_method_id =', comparison_method_id_add_rule)
    df <- dbGetQuery(linkage_metadata_conn, query)

    # Get the number of inputs we'll be adding
    num_inputs <- nrow(df)
    parameter_ids <- df$parameter_id

    # Error handling
    #----#
    # Error Handling to make sure all inputs are filled
    for(index in 1:(num_inputs)){
      # Get the input value for each input
      input_val <- input[[paste0("comparison_rules_input_", index)]]
      # Ensure it isn't null
      if(is.na(input_val)){
        # If we throw an error because of timeout, or bad insert, then rollback and return
        showNotification("Failed to Add Comparison Rule - Some Input(s) Are Missing", type = "error", closeButton = FALSE)
        return()
      }
    }

    # Lastly, we'll make sure this rule doesn't already exist
    df <- data.frame()
    for (index in 1:(num_inputs)) {
      # Get the parameter to input
      parameter <- input[[paste0("comparison_rules_input_", index)]]

      # Get the parameter ID
      parameter_id <- parameter_ids[index]

      # Check if the database has this eact match
      get_query <- dbSendQuery(linkage_metadata_conn, 'SELECT * FROM comparison_rules_parameters
                                                  WHERE parameter_id = ? AND parameter = ?;')
      dbBind(get_query, list(parameter_id, parameter))
      output_df <- dbFetch(get_query)
      dbClearResult(get_query)
      df <- rbind(df, output_df)
    }

    # Group by the comparison_rule_id
    df_grouped <- df %>% group_by(comparison_rule_id) %>% filter(n() == num_inputs)

    # If it contains exactly those parameters, then there will be a row in the grouped df, so return
    if(nrow(df_grouped) > 0){
      showNotification("Failed to Add Comparison Rule - Comparison Rule Already Exists", type = "error", closeButton = FALSE)
      return()
    }
    #----#

    # Add all the necessary acceptance rule information
    successful <- TRUE
    #----#
    tryCatch({
      # Start a transaction
      dbBegin(linkage_metadata_conn)

      # Start by creating a new acceptance rule
      new_entry_query <- paste("INSERT INTO comparison_rules (comparison_method_id)",
                               "VALUES(?);")
      new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
      dbBind(new_entry, list(comparison_method_id_add_rule))
      dbClearResult(new_entry)

      # Add the dataset fields to the other table after we insert basic information
      #----#
      # Get the most recently inserted comparison_rule_id value
      comparison_rule_id <- dbGetQuery(linkage_metadata_conn, "SELECT last_insert_rowid() AS comparison_rule_id;")$comparison_rule_id

      # Insert each parameter value into the database
      for (index in 1:(num_inputs)) {
        # Get the parameter to input
        parameter <- input[[paste0("comparison_rules_input_", index)]]

        # Get the parameter ID
        parameter_id <- parameter_ids[index]

        insert_field_query <- "INSERT INTO comparison_rules_parameters (comparison_rule_id, parameter_id, parameter) VALUES (?, ?, ?);"
        insert_field_stmt <- dbSendStatement(linkage_metadata_conn, insert_field_query)
        dbBind(insert_field_stmt, list(comparison_rule_id, parameter_id, parameter))
        dbClearResult(insert_field_stmt)
      }

      # End a transaction
      dbCommit(linkage_metadata_conn)

    },
    error = function(e){
      # If we throw an error because of timeout, or bad insert, then rollback and return
      successful <- FALSE
      dbRollback(linkage_metadata_conn)
      showNotification("Failed to Add Comparison Rule - An Error Occurred While Inserting", type = "error", closeButton = FALSE)
      return()
    })

    # If we didn't successfully add the acceptance rule, then return
    if(!successful) return()
    #----#

    # Update Data Tables and UI Renders
    #----#
    output$currently_added_comparison_rules <- renderDataTable({
      get_comparison_rules()
    })
    output$comparison_rules_inputs <- renderUI({
      get_comparison_rules_inputs()
    })
    #----#

    # Show success notification
    #----#
    showNotification("Comparison Rule Successfully Created", type = "message", closeButton = FALSE)
    #----#

  })
  #----
  #----------------------------------#

  #-- LINKAGE RULES PAGE EVENTS --#
  #----
  linkage_rules_return_page  <- "home_page"

  # Back button will bring you back to whichever page you came from
  observeEvent(input$linkage_rules_back, {
    # Show the page we need to return to
    nav_show("main_navbar", linkage_rules_return_page)

    # Return to the page you came from
    updateNavbarPage(session, "main_navbar", selected = linkage_rules_return_page)
  })

  # Gets the linkage rules from the database and puts them into a data table
  get_linkage_rules <- function(){
    # Query to get all linkage rule information from the 'linkage_rules' table
    query <- paste('SELECT * FROM linkage_rules
               ORDER BY linkage_rule_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    # For each row in the data frame, we're going to make the rules easier to read and select
    for(row_num in 1:nrow(df)){
      # Get the current row
      row <- df[row_num,]

      # We'll start with "Alternative Field"
      alt_field_val <- row$alternate_field_value
      if(is.na(alt_field_val)){
        row$alternate_field_value <- "1st Field Value"
      }
      else{
        row$alternate_field_value <- paste0(scales::ordinal(as.numeric(alt_field_val)), " Field Value")
      }

      # Next we'll handle the "Integer Variance"
      int_variance <- row$integer_value_variance
      if(is.na(int_variance)){
        row$integer_value_variance <- "±0"
      }
      else{
        row$integer_value_variance <- paste0("±", int_variance)
        row$substring_length <- "Does Not Apply"
        row$standardize_names <- "Does Not Apply"
      }

      # Next we'll handle "Name Substring"
      name_substring <- row$substring_length
      if(is.na(name_substring) && is.na(int_variance)){
        row$substring_length <- "Entire Name"
      }else if (!is.na(name_substring) && is.na(int_variance)){
        row$substring_length <- paste0("First ", name_substring, " character(s)")
      }

      # Re-enter our modified row back into the linkage rules
      df[row_num,] <- row
    }

    # With standardized names, we'll replace the [0, 1] with [No, Yes]
    df[is.na(df)] <- "No"
    df$standardize_names <- str_replace(df$standardize_names, "1", "Yes")

    # With our data frame, we'll rename some of the columns to look better
    names(df)[names(df) == 'alternate_field_value'] <- 'Alternative Field'
    names(df)[names(df) == 'integer_value_variance'] <- 'Integer Variance'
    names(df)[names(df) == 'substring_length'] <- 'Name Substring'
    names(df)[names(df) == 'standardize_names'] <- 'Standardize Names'

    # Drop the linkage_rule_id
    df <- subset(df, select = -c(linkage_rule_id))

    # Put it into a data table now
    dt <- datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE))
  }

  # Renders the data table of comparison parameters that are to be added
  output$currently_added_linkage_rules <- renderDataTable({
    get_linkage_rules()
  })

  # Adds a new linkage rule to the database
  observeEvent(input$add_linkage_rule, {
    # Get the values the user provided
    alternate_field_value  <- input$add_alternate_field_number
    integer_value_variance <- input$add_integer_value_variance
    substring_length       <- input$add_substring_length
    standardize_names      <- input$add_name_standardization

    # Error handle to make sure we don't end up putting invalid values into the 'Linkage Rules' table
    #----#
    # First, we'll make sure that the numeric values provided are actually numeric (can't even happen if we use a numericInput() in shiny)
    if(!is.na(alternate_field_value) && is.na(suppressWarnings(as.numeric(alternate_field_value)))){
      showNotification("Failed to Create Linkage Rule - Alternate Field Value Input is not Numeric", type = "error", closeButton = FALSE)
      return()
    }
    if(!is.na(integer_value_variance) && is.na(suppressWarnings(as.numeric(integer_value_variance)))){
      showNotification("Failed to Create Linkage Rule - Integer Value Variance Input is not Numeric", type = "error", closeButton = FALSE)
      return()
    }
    if(!is.na(substring_length) && is.na(suppressWarnings(as.numeric(substring_length)))){
      showNotification("Failed to Create Linkage Rule - Substring Length Input is not Numeric", type = "error", closeButton = FALSE)
      return()
    }

    # Next, we'll make sure that if a numeric value is provided, that it is valid by setting it to default values (NA)
    if(!is.na(alternate_field_value) && as.numeric(alternate_field_value) <= 1){
      alternate_field_value <- NA
    }
    if(!is.na(integer_value_variance) && as.numeric(integer_value_variance) <= 0){
      integer_value_variance <- NA
    }
    if(!is.na(substring_length) && as.numeric(substring_length) <= 0){
      substring_length <- NA
    }
    if(standardize_names == 1){
      standardize_names <- NA
    }

    # Next, if all values were left empty after this, we'll return throw an error
    if(is.na(alternate_field_value) && is.na(integer_value_variance) && is.na(substring_length) && is.na(standardize_names)){
      showNotification("Failed to Create Linkage Rule - All Inputs are Missing", type = "error", closeButton = FALSE)
      return()
    }

    # Next, we'll make sure that only one type of Name or Numerical rule can be chosen at a time
    if(!is.na(integer_value_variance) && !is.na(substring_length)){
      showNotification("Failed to Create Linkage Rule - Cannot Apply Both String and Numerical Rules to a Field (Drop One or the Other)", type = "error", closeButton = FALSE)
      return()
    }
    if(!is.na(integer_value_variance) && !is.na(standardize_names)){
      showNotification("Failed to Create Linkage Rule - Cannot Apply Both String and Numerical Rules to a Field (Drop One or the Other)", type = "error", closeButton = FALSE)
      return()
    }

    # Lastly, we'll make sure this rule doesn't already exist
    # Modify the query to handle NULL values
    get_query <- dbSendQuery(linkage_metadata_conn, '
                              SELECT * FROM linkage_rules
                              WHERE (alternate_field_value = ? OR (alternate_field_value IS NULL AND ? IS NULL))
                              AND (integer_value_variance = ? OR (integer_value_variance IS NULL AND ? IS NULL))
                              AND (substring_length = ? OR (substring_length IS NULL AND ? IS NULL))
                              AND (standardize_names = ? OR (standardize_names IS NULL AND ? IS NULL));')
    # Bind the values to the query
    dbBind(get_query, list(alternate_field_value, alternate_field_value,
                           integer_value_variance, integer_value_variance,
                           substring_length, substring_length,
                           standardize_names, standardize_names))
    output_df <- dbFetch(get_query)
    num_of_databases <- nrow(output_df)
    dbClearResult(get_query)
    if(num_of_databases != 0){
      showNotification("Failed to Add Linkage Rule - Linkage Rule Already Exists", type = "error", closeButton = FALSE)
      return()
    }
    #----#

    # Add the new user provided values to the database as a new linkage rule
    #----#
    new_entry_query <- paste("INSERT INTO linkage_rules (alternate_field_value, integer_value_variance, substring_length, standardize_names)",
                             "VALUES(?, ?, ?, ?);")
    new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
    dbBind(new_entry, list(alternate_field_value, integer_value_variance, substring_length, standardize_names))
    dbClearResult(new_entry)
    #----#

    # Update user input fields to make them blank!
    #----#
    updateNumericInput(session, "add_alternate_field_number", value = NA)
    updateNumericInput(session, "add_integer_value_variance", value = NA)
    updateNumericInput(session, "add_substring_length", value = NA)
    updateSelectInput(session, "add_name_standardization", selected = 1)
    #----#

    # Update Data Tables and UI Renders
    #----#
    output$currently_added_linkage_rules <- renderDataTable({
      get_linkage_rules()
    })
    output$blocking_keys_add_linkage_rules <- renderDataTable({
      get_linkage_rules()
    })
    output$matching_keys_add_linkage_rules <- renderDataTable({
      get_linkage_rules()
    })
    #----#

    # Show success notification
    #----#
    showNotification("Linkage Rule Successfully Created", type = "message", closeButton = FALSE)
    #----#
  })
  #----
  #-------------------------------#

  observeEvent(input$file_test_input, {
    #shinyFiles::shinyDirChoose(input = input, id = file_test_input, session = session) # This needs to use a shinyDirButton() call and use its ID
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
