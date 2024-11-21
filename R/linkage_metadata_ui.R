# UI ----
linkage_ui <- fluidPage(

  #-- Loading Screens --#
  #----
  # LOAD 1 (Nothing done yet)
  div(
    id = "loading_screen",
    fluidPage(
      h2("Loading, please wait..."),
    ),
    style = "text-align: center; margin-top: 20%;",
  ),

  # LOAD 2 (hiding tabs)
  hidden(
    div(
      id = "loading_screen_2",
      fluidPage(
        h2("Loading, please wait..."),
        h4("Hiding Tabs..."),
      ),
      style = "text-align: center; margin-top: 20%;",
    )
  ),

  # LOAD 3 (loading datasets)
  hidden(
    div(
      id = "loading_screen_3",
      fluidPage(
        h2("Loading, please wait..."),
        h4("Loading the Datasets Page..."),
      ),
      style = "text-align: center; margin-top: 20%;",
    )
  ),

  # LOAD 4 (loading linkage methods)
  hidden(
    div(
      id = "loading_screen_4",
      fluidPage(
        h2("Loading, please wait..."),
        h4("Loading the Linkage Methods Page..."),
      ),
      style = "text-align: center; margin-top: 20%;",
    )
  ),

  # LOAD 5 (loading linkage algorithms)
  hidden(
    div(
      id = "loading_screen_5",
      fluidPage(
        h2("Loading, please wait..."),
        h4("Loading the Testable Linkage Algorithms Page..."),
      ),
      style = "text-align: center; margin-top: 20%;",
    )
  ),

  # LOAD 6 (loading archived linkage algorithms)
  hidden(
    div(
      id = "loading_screen_6",
      fluidPage(
        h2("Loading, please wait..."),
        h4("Loading the Archived Linkage Algorithms Page..."),
      ),
      style = "text-align: center; margin-top: 20%;",
    )
  ),

  # LOAD 7 (loading published linkage algorithms)
  hidden(
    div(
      id = "loading_screen_7",
      fluidPage(
        h2("Loading, please wait..."),
        h4("Loading the Published Linkage Algorithms Page..."),
      ),
      style = "text-align: center; margin-top: 20%;",
    )
  ),

  # LOAD 8 (loading linkage audits)
  hidden(
    div(
      id = "loading_screen_8",
      fluidPage(
        h2("Loading, please wait..."),
        h4("Loading the Saved Performance Measures Page..."),
      ),
      style = "text-align: center; margin-top: 20%;",
    )
  ),

  # LOAD 9 (loading ground truth variables)
  hidden(
    div(
      id = "loading_screen_9",
      fluidPage(
        h2("Loading, please wait..."),
        h4("Loading the Ground Truth Variables Page..."),
      ),
      style = "text-align: center; margin-top: 20%;",
    )
  ),

  # LOAD 10 (loading algorithm output fields)
  hidden(
    div(
      id = "loading_screen_10",
      fluidPage(
        h2("Loading, please wait..."),
        h4("Loading the Algorithm Output Fields Page..."),
      ),
      style = "text-align: center; margin-top: 20%;",
    )
  ),

  # LOAD 11 (loading viewable linkage iterations)
  hidden(
    div(
      id = "loading_screen_11",
      fluidPage(
        h2("Loading, please wait..."),
        h4("Loading the Viewable Linkage Iterations Page..."),
      ),
      style = "text-align: center; margin-top: 20%;",
    )
  ),

  # LOAD 12 (loading modify linkage iterations)
  hidden(
    div(
      id = "loading_screen_12",
      fluidPage(
        h2("Loading, please wait..."),
        h4("Loading the Modify Linkage Iterations Page..."),
      ),
      style = "text-align: center; margin-top: 20%;",
    )
  ),

  # LOAD 13 (loading acceptance method & parameters)
  hidden(
    div(
      id = "loading_screen_13",
      fluidPage(
        h2("Loading, please wait..."),
        h4("Loading the Acceptance Methods & Parameters Page..."),
      ),
      style = "text-align: center; margin-top: 20%;",
    )
  ),

  # LOAD 14 (loading comparison method & parameters)
  hidden(
    div(
      id = "loading_screen_14",
      fluidPage(
        h2("Loading, please wait..."),
        h4("Loading the Comparison Methods & Parameters Page..."),
      ),
      style = "text-align: center; margin-top: 20%;",
    )
  ),

  # LOAD 15 (loading linkage rules)
  hidden(
    div(
      id = "loading_screen_15",
      fluidPage(
        h2("Loading, please wait..."),
        h4("Loading the Linkage Rules Page..."),
      ),
      style = "text-align: center; margin-top: 20%;",
    )
  ),

  # LOAD 16 (loading regenerate report)
  hidden(
    div(
      id = "loading_screen_16",
      fluidPage(
        h2("Loading, please wait..."),
        h4("Loading the Regenerate Report Page..."),
      ),
      style = "text-align: center; margin-top: 20%;",
    )
  ),

  # LOAD 17 (loading run algorithm(s))
  hidden(
    div(
      id = "loading_screen_17",
      fluidPage(
        h2("Loading, please wait..."),
        h4("Loading the Run Algorithm(s) Page..."),
      ),
      style = "text-align: center; margin-top: 20%;",
    )
  ),
  #----
  #---------------------#

  #-- Main Content --#
  hidden(
    div(
      id = "main_content",
      page_navbar(
        # Set the theme of the application
        theme = bs_theme(bootswatch = "spacelab"),
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
                    width: 100% !important;
                    max-width: 750px !important;
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
              .modal-sm {
                width: 50vw !important;  /* Set modal width to 50% of the viewport width */
                max-width: none !important; /* Disable the default max-width */
              }
              .modal-lg {
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
          # Add additional content here...
          tags$style(HTML("
              .navbar-nav {
                display: flex;
                align-items: center;
              }
              .navbar-brand {
                display: flex;
                align-items: center;
              }
              .navbar-brand img {
                vertical-align: middle;
              }
              .navbar {
                min-height: 60px; /* Adjust to your preference */
              }
           ")
          )
        ),
        #----
        title =
          div(
            img(
              src = "figures/autolink_logo_blue_wide_v2.png",
              width = 210,
              height = 70
            )
          ),
        id = 'main_navbar',
        #-- HOME PAGE --#
        #----
        nav_panel(title = "Home", value = "home_page",
          fluidPage(
            HTML("<br><br>"),
            accordion(
              accordion_panel(title = "Welcome",
                "Welcome to the Data Linkage GUI. From this application you can create, modify, and use linkage algorithms on uploaded
                datasets you may end up providing. You are currently on the Home/Welcome page where you are encouraged to read from the
                various dropdowns to understand what the application has to offer and where you can access specific pages."
              ),
              accordion_panel(title = "Step 1: Prepare Datasets",
                "The datasets page should be your first stop upon starting the application for the first time, or upon coming back after
                a long time not using the application. On this page, you can view the uploaded datasets, select an existing dataset to update,
                or add a new dataset.",

                HTML("<br><br>"), # Line break

                "The page will keep a record of the local file location of the dataset when adding your uploaded file so that data linkage may
                be ran from the application. When using the same SQLite file on other PCs, this file location should updated by clicking on the
                desired row and uploading the file from the new location.",

                HTML("<br><br>"), # Line break

                "When uploading a file, you can see the uploaded files field names and class types before submitting the dataset so that you
                can verify the dataset you're uploading is valid."
              ),
              accordion_panel(title = "Step 2: Review Linkage Methods",
                "The linkage methods page should be your next stop after reviewing, updating, or adding datasets, and provides a table of the
                currently usable linkage methods that can be used when creating the individual passes of a linkage algorithm in the next step.",

                HTML("<br><br>"), # Line break

                HTML("Additionally, you may create your own linkage class in R and create a method here to have the package dynamically call your custom
                      linkage class. To do so, you must follow the naming and return guidelines found on the <b>datalink</b> GitHub page."),

                HTML("<br><br>"), # Line break

                "After the class is successfully created, the Implementation/Class Name input should match the name of the R class you created EXACTLY,
                filling in the other information to your liking which will be output when generating the optional linkage reports, and for selecting
                a linkage method in a later algorithm creation step."
              ),
              accordion_panel(title = "Step 3: Create & Modify Your Algorithms",
                "The linkage algorithms page is the third and final stop after reviewing all the datasets and linkage methods available for use.
                This page allows you to select a left and right dataset that you'd like to link, followed by the creation or modification of empty
                linkage algorithms.",

                HTML("<br><br>"), # Line break

                "From the existing algorithms, select one to perform any varying number of metadata related modifications such as adding, modifying,
                or dropping passes from the algorithm, adding ground truth variables, or selecting which fields should be output.",

                HTML("<br><br>"), # Line break

                "Once an algorithm is completed to your liking, you may progress to the Run Algorithm(s) page and select from your list of created algorithms
                on which you'd like to run, tailoring all kinds of output to personal preference.",

                HTML("<br><br>"), # Line break

                "To see what other pages are accessible from the linkage algorithms page, consider looking at the other drop down in case you are having
                trouble any specific page."
              ),
              accordion_panel(title = "Additional Actions",
                "If you are having trouble finding a specific page within the GUI, consider finding the page title here and follow the steps outlined below.",

                HTML("<br><br>"), # Line break

                # RUN ALGORITHM(S) PAGE
                h5(strong("Run Algorithm(s) Page")),
                HTML("<ul>
                        <li>Home > Linkage Algorithms Tab</li>
                        <li>Linkage Algorithms > Run Algorithm(s) Page Button</li>
                      </ul>"),

                HTML("<br>"), # Line break

                # REGNERATE REPORT PAGE
                h5(strong("Regenerate Report(s) Page")),
                HTML("<ul>
                        <li>Home > Linkage Algorithms Tab</li>
                        <li>Linkage Algorithms > Select Existing Algorithm To Regenerate Report Of</li>
                        <li>Selected Linkage Algorithm > Regenerate Report Button</li>
                      </ul>"),

                HTML("<br>"), # Line break

                # GROUND TRUTH VARIABLES PAGE
                h5(strong("Ground Truth Variables Page")),
                HTML("<ul>
                        <li>Home > Linkage Algorithms Tab</li>
                        <li>Linkage Algorithms > Select Existing Algorithm</li>
                        <li>Selected Linkage Algorithm > Ground Truth Variables Button</li>
                     </ul>"),

                HTML("<br>"), # Line break

                # ALGORITHM OUTPUT PAGE
                h5(strong("Algorithm Output Page")),
                HTML("<ul>
                        <li>Home > Linkage Algorithms Tab</li>
                        <li>Linkage Algorithms > Select Existing Algorithm</li>
                        <li>Selected Linkage Algorithm > Algorithm Output Button</li>
                     </ul>"),

                HTML("<br>"), # Line break

                # SAVED PERFORMANCE MEASURES PAGE
                h5(strong("Saved Performance Measures Page")),
                HTML("<ul>
                        <li>Home > Linkage Algorithms Tab</li>
                        <li>Linkage Algorithms > Select Existing Algorithm</li>
                        <li>Selected Linkage Algorithm > Saved Performance Measures Button</li>
                     </ul>"),

                HTML("<br>"), # Line break

                # ALGORITHM PASSES
                h5(strong("Algorithm Passes Page")),
                HTML("<ul>
                        <li>Home > Linkage Algorithms Tab</li>
                        <li>Linkage Algorithms > Select Existing Algorithm</li>
                        <li>Selected Linkage Algorithm > Algorithm Passes Button</li>
                      </ul>"),

                HTML("<br>"), # Line break

                # MODIFY ALGORITHM PASSES/ITERATIONS PAGE
                h5(strong("Modify Algorithm Passes/Iterations Page")),
                HTML("<ul>
                        <li>Home > Linkage Algorithms Tab</li>
                        <li>Linkage Algorithms > Select Existing Algorithm</li>
                        <li>Selected Linkage Algorithm > Algorithm Passes Button</li>
                        <li>Algorithm Passes > Add New Iteration Button</li>
                        <li><b>OR,</b> Selecting an Existing Iteration and Pressing the Modify Button</li>
                        <li><b>OR,</b> Selecting a Previously Used Iteration and Pressing the Review And Add Iteration Button</li>
                      </ul>"),

                HTML("<br>"), # Line break

                # CREATE LINKAGE RULE PAGE
                h5(strong("Create Linkage Rule Page")),
                HTML("<ul>
                        <li>Home > Linkage Algorithms Tab</li>
                        <li>Linkage Algorithms > Select Existing Algorithm</li>
                        <li>Selected Linkage Algorithm > Algorithm Passes Button</li>
                        <li>Algorithm Passes > Modify Algorithm Passes/Iteration Page</li>
                        <li>Step 3: Select the Blocking Variables > Pencil Button Next to Linkage Rules</li>
                        <li>Linkage Rules Pop-up > Create New Linkage Rule Button</li>
                      </ul>"),

                HTML("<br>"), # Line break

                # ADD/MODIFY COMPARISON METHODS AND PARAMETERS PAGE
                h5(strong("Add and Modify Comparison Methods & Parameters Page")),
                HTML("<ul>
                        <li>Home > Linkage Algorithms Tab</li>
                        <li>Linkage Algorithms > Select Existing Algorithm</li>
                        <li>Selected Linkage Algorithm > Algorithm Passes Button</li>
                        <li>Algorithm Passes > Modify Algorithm Passes/Iteration Page</li>
                        <li>Step 4: Select the Matching Variables > Pencil Button Next to Comparison Rules</li>
                        <li>Comparison Rules Pop-up > Create Comparison Method Button</li>
                      </ul>"),

                HTML("<br>"), # Line break

                # ADD/MODIFY ACCEPTANCE METHODS AND PARAMETERS PAGE
                h5(strong("Add and Modify Acceptance Methods & Parameters Page")),
                HTML("<ul>
                        <li>Home > Linkage Algorithms Tab</li>
                        <li>Linkage Algorithms > Select Existing Algorithm</li>
                        <li>Selected Linkage Algorithm > Algorithm Passes Button</li>
                        <li>Algorithm Passes > Modify Algorithm Passes/Iteration Page</li>
                        <li>Step 6: Select the Acceptance Rule > Pencil Button Next to Acceptance Rule</li>
                        <li>Acceptance Rules Pop-up > Create Acceptance Method Button</li>
                      </ul>"),
              ),
            ),

            HTML("<br><br>"), # Line break
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
                  actionButton("toggle_dataset", "Toggle Selected Dataset", class = "btn-success", width = validateCssUnit(300), icon = shiny::icon("toggle-off")),

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
                height = 550,
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
                    column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                      # Label for the uploaded file name
                      div(style = "margin-right: 10px;", "Uploaded File (Path):"),
                    )),
                    column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                      # Boxed text output for showing the uploaded file name
                      div(style = "flex-grow: 1; border: 1px solid #ccc; padding: 5px; background-color: #f9f9f9;",
                        textOutput("uploaded_file_name_update")
                      ),
                      # Upload button
                      actionButton("update_dataset_file", label = "", shiny::icon("upload")), #or use 'upload'

                      # Add the popover manually
                      h1(tooltip(bs_icon("question-circle"),
                                 paste("The dataset you plan on using to perform data linkage should be uploaded here.",
                                       "The column names will be grabbed from the first row in the source dataset for",
                                       "future use when creating linkage algorithms and passes."),
                                 placement = "right",
                                 options = list(container = "body")))
                    ))
                  ),
                ),

                # Card for viewing the selected fields
                card(card_header("View Selected Dataset Fields", class = "bg-dark"),
                  dataTableOutput("selected_dataset_fields")
                )
              ),

              fluidRow(
                column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                  actionButton("update_dataset", "Update Dataset", class = "btn-success", width = validateCssUnit(300), icon = shiny::icon("pen")),
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
                height = 550,

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
                     selectInput("add_dataset_is_fwf", label = "Is The Dataset of Fixed-Width Format?",
                                 choices = list("No" = 1,
                                                "Yes" = 2),
                                 selected = 1,
                                 width = validateCssUnit(500)),

                     # Add the popover manually
                     h1(tooltip(bs_icon("question-circle"),
                                paste("If the dataset being used for linkage is fwf, select yes before uploading the",
                                      "dataset so that the column widths can be extracted for confirmation."),
                                placement = "right",
                                options = list(container = "body")))
                   )),
                   column(width = 12, div(style = "display: flex; align-items: center;",
                     fluidRow(
                        column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                          # Label for the uploaded file name
                          div(style = "margin-right: 10px;", "Uploaded File (Path):"),
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
                  column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                    dataTableOutput("uploaded_dataset_fields"),
                  )),

                  # If the user has submitted a dataset file, they can also change the widths (IF A ROW IS SELECTED)
                  fluidRow(
                    column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                      numericInput("update_field_width_input", label = "Field Width:",
                                   value = NULL, width = validateCssUnit(300)),
                    )),
                    column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                      actionButton("update_field_width_btn", "Update Field Width", class = "btn-warning"),
                    ))
                  ),
                )
              ),

              fluidRow(
                column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                  actionButton("add_dataset", "Add Dataset", class = "btn-success", width = validateCssUnit(300), icon = shiny::icon("plus")),
                ))
              ),
              HTML("<br><br>"),
            )
          )
        ),
        #----
        #-------------------#

        #-- LINKAGE METHODS PAGE --#
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
                actionButton("add_linkage_method", "Add Linkage Method", class = "btn-success", width = validateCssUnit(300), icon = shiny::icon("plus")),
              ))
            )
          )
        ),
        #----
        #--------------------------#

        #-- TESTING LINKAGE ALGORITHMS PAGE --#
        #----
        nav_panel(title = "Testable Linkage Algorithms", value = "linkage_algorithms_page",
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

                HTML("<br>"), # White space

                # Column layout for all buttons
                layout_column_wrap(
                  width = 1/4,
                  height = 185,
                  heights_equal = "all",

                  # Card for Regenerating Linkage Reports
                  card(
                    full_screen = FALSE,
                    card_body(
                      fluidRow(
                        column(width = 12, div(style = "display: flex; justify-content: center; align-items: center; margin-top: 35px",
                            actionButton("run_algorithm_alt", "Run Algorithm(s)...", class = "btn-warning", width = validateCssUnit(300), icon = shiny::icon("file-waveform")),
                          )
                        ),
                        column(width = 12, div(style = "display: flex; justify-content: center; align-items: center; margin-top: 15px",
                            actionButton("go_to_regenerate_report", "Regenerate Report...", class = "btn-warning", width = validateCssUnit(300), icon = shiny::icon("arrows-rotate")),
                          )
                        )
                      )
                    )
                  ),

                  # CARD FOR ARCHIVING AND PUBLISHING ALGORITHMS
                  card(
                    full_screen = FALSE,
                    card_body(
                      fluidRow(
                        column(width = 12, div(style = "display: flex; justify-content: center; align-items: center; margin-top: 35px",
                            actionButton("archive_algorithm", "Archive Selected Algorithm", class = "btn-danger", width = validateCssUnit(300), icon = shiny::icon("box-archive")),
                          )
                        ),
                        column(width = 12, div(style = "display: flex; justify-content: center; align-items: center; margin-top: 15px",
                            actionButton("publish_algorithm", "Publish Selected Algorithm", class = "btn-success", width = validateCssUnit(300), icon = shiny::icon("scroll")),
                          )
                        )
                      )
                    )
                  ),

                  # Create a card for the buttons
                  card(
                    full_screen = FALSE,
                    card_body(
                      fluidRow(
                        column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                            actionButton("toggle_algorithm", "Set as Default Algorithm", class = "btn-success", width = validateCssUnit(300), icon = shiny::icon("toggle-on")),
                          )
                        ),
                        column(width = 12, div(style = "display: flex; justify-content: center; align-items: center; margin-top: 15px",
                            actionButton("toggle_algorithm_for_testing", "Toggle for Testing", class = "btn-success", width = validateCssUnit(300), icon = shiny::icon("toggle-off")),
                          )
                        ),
                        column(width = 12, div(style = "display: flex; justify-content: center; align-items: center; margin-top: 15px",
                            actionButton("linkage_algorithms_to_view_linkage_iterations", "Algorithm Passes...", class = "btn-success", width = validateCssUnit(300), icon = shiny::icon("list")),
                          )
                        )
                      )
                    )
                  ),

                  # Create a card for editing/viewing algorithm output information
                  card(
                    full_screen = FALSE,
                    card_body(
                      fluidRow(
                        column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                            actionButton("linkage_algorithms_to_ground_truth", "Ground Truth Variables...", class = "btn-info", width = validateCssUnit(300), icon = shiny::icon("square-check")),
                          )
                        ),
                        column(width = 12, div(style = "display: flex; justify-content: center; align-items: center; margin-top: 15px",
                            actionButton("linkage_algorithms_to_algorithm_output", "Algorithm Output...", class = "btn-info", width = validateCssUnit(300), icon = shiny::icon("file-export")),
                          )
                        ),
                        column(width = 12, div(style = "display: flex; justify-content: center; align-items: center; margin-top: 15px",
                            actionButton("linkage_algorithms_to_audits", "Performance Measures...", class = "btn-info", width = validateCssUnit(300), icon = shiny::icon("chart-simple")),
                          )
                        )
                      )
                    )
                  )
                ),
              ),

              # Line break to separate the table and new algorithm input
              HTML("<br><br>"),

              # Conditional panel for if a row wasn't selected
              conditionalPanel(
                condition = "input.currently_added_linkage_algorithms_rows_selected <= 0",

                # Card for the run algorithms, archived algorithms, and published algorithms pages
                div(style = "display: flex; justify-content: center; align-items: center;",
                  card(
                    width = 1,
                    height = 85,
                    full_screen = FALSE,
                    card_body(
                      fluidRow(
                        column(width = 4, div(style = "display: flex; justify-content: right; align-items: center;",
                            actionButton("run_default_algorithm", "Run Algorithm(s)...", class = "btn-warning", width = validateCssUnit(400), icon = shiny::icon("file-waveform")),
                          )
                        ),
                        column(width = 4, div(style = "display: flex; justify-content: center; align-items: center;",
                            actionButton("move_to_archived_algorithms", "Archived Algorithms...", class = "btn-info", width = validateCssUnit(400), icon = shiny::icon("box-archive")),
                          )
                        ),
                        column(width = 4, div(style = "display: flex; justify-content: left; align-items: center;",
                            actionButton("move_to_published_algorithms", "Published Algorithms...", class = "btn-info", width = validateCssUnit(400), icon = shiny::icon("scroll")),
                          )
                        )
                      ),
                    )
                  )
                ),

                # Line break between sections
                HTML("<br><br>"),

                # Section for adding a new algorithm
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
                    actionButton("add_linkage_algorithm", "Add Linkage Algorithm", class = "btn-success", width = validateCssUnit(300), icon = shiny::icon("plus")),
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
                    actionButton("update_linkage_algorithm", "Update Linkage Algorithm", class = "btn-success", width = validateCssUnit(300), icon = shiny::icon("pen")),
                  ))
                )
              )
            ),

            #White space for the final button
            HTML("<br><br>"),
          )
        ),
        #----
        #-------------------------------------#

        #-- ARCHIVED LINKAGE ALGORITHMS PAGE --#
        #----
        nav_panel(title = "Archived Linkage Algorithms", value = "archived_linkage_algorithms_page",
          fluidPage(
            # Put the back button on this page in the top left corner
            fluidRow(
              column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                actionButton("archived_linkage_algorithms_back", "Return to Testable Algorithms Page", icon = shiny::icon("arrow-left-long")),
              ))
            ),

            # Line break
            HTML("<br>"),

            # Generate the table
            h5(strong("Select an Archived Algorithm to Restore")),
            h6(p(strong("Note: "), paste("An algorithm can't be restored if there is one enabled for testing that uses the same name/descriptor"))),
            fluidRow(
              column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                dataTableOutput("archived_linkage_algorithms"),
              )),
            ),

            # Line break
            HTML("<br>"),

            # Conditional panel for if a row was selected
            conditionalPanel(
              condition = "input.archived_linkage_algorithms_rows_selected > 0",

              # Table for showing the algorithm details (so the user does not need to restore the algorithm first)
              h5(strong("Details of selected algorithm")),
              fluidRow(
                # Card for the data table
                card(
                  full_screen = TRUE,
                  height = 500,
                  column(width = 12, div(style = "display: flex; justify-content: center; align-items: center; font-size: 0.9vw;",
                    dataTableOutput("archived_linkage_algorithms_details"),
                  )),
                )
              ),

              # Line break
              HTML("<br>"),

              # Button for restoring the algorithm
              fluidRow(
                column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                  actionButton("restore_linkage_algorithm", "Restore Linkage Algorithm", class = "btn-success", width = validateCssUnit(300), icon = shiny::icon("plus")),
                ))
              )
            ),
            #White space for the final button
            HTML("<br><br>"),
          )
        ),
        #----
        #--------------------------------------#

        #-- PUBLISHED LINKAGE ALGORITHMS PAGE --#
        #----
        nav_panel(title = "Published Linkage Algorithms", value = "published_linkage_algorithms_page",
          fluidPage(
            shinyjs::useShinyjs(), # Added this so that we can disable buttons (IF IT BREAKS THINGS DELETE IT)

            # Put the back button on this page in the top left corner
            fluidRow(
              column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                actionButton("published_linkage_algorithms_back", "Return to Testable Algorithms Page", icon = shiny::icon("arrow-left-long")),
              ))
            ),

            # Line break
            HTML("<br>"),

            # Generate the table
            h5(strong("Select a published algorithm to unpublish")),
            h6(p(strong("Note: "), paste("An algorithm can't be unpublished if there is one enabled for testing that uses the same name/descriptor"))),
            fluidRow(
              column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                dataTableOutput("published_linkage_algorithms"),
              )),
            ),

            # Line break
            HTML("<br>"),

            # Conditional panel for if a row WAS selected
            conditionalPanel(
              condition = "input.published_linkage_algorithms_rows_selected > 0",

              # Table for showing the algorithm details (so the user does not need to restore the algorithm first)
              h5(strong("Details of selected algorithm")),
              fluidRow(
                # Card for the data table
                card(
                  full_screen = TRUE,
                  height = 500,
                  column(width = 12, div(style = "display: flex; justify-content: center; align-items: center; font-size: 0.9vw;",
                    dataTableOutput("published_linkage_algorithms_details"),
                  )),
                )
              ),

              # Un-publish button
              fluidRow(
                column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                  actionButton("unpublish_linkage_algorithm", "Unpublish Linkage Algorithm", class = "btn-success", width = validateCssUnit(300), icon = shiny::icon("plus")),
                ))
              )
            ),

            # Conditional panel for if a row WASN'T selected
            conditionalPanel(
              condition = "input.published_linkage_algorithms_rows_selected <= 0",

              # Title and subtitle for running & saving the published algorithms
              h5(strong("Or, run all published algorithms and save linkage data to the output folder defined below")),
              h6(p(strong("Note: "), paste("An algorithm can't be unpublished if there is one enabled for testing that uses the same name/descriptor"))),

              # Create a fluid row for the output folder input & "RUN" button
              div(style = "display: flex; justify-content: center; align-items: center;",
                card(card_header("Add Linkage Output Fields", class = 'bg-dark'),
                  fluidRow(
                    # Choose output folder here (MAYBE SAVE THE USERS LAST USED FOLDER AND IF THEY WANT TO CHANGE IT THEY CAN DO IT HERE)
                    column(width = 12, div(style = "display: flex; justify-content: center; align-items: left;",
                      # Boxed text output for showing the uploaded folder name
                      div(style = "border: 1px solid #ccc; padding: 5px; background-color: #f9f9f9;",
                          textOutput("selected_published_algorithms_output_dir")
                      ),
                      # Upload Button
                      shinyDirButton("published_algorithms_output_dir", label = "", icon = icon("folder-open"), title = 'Please Select a Directory')
                    )),
                    column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                      helpText(HTML(paste0("Select a folder where all output will be saved.<br><br>Data will be saved as a singular <b>.RData</b> file ",
                                           "containing a variety of linkage information, including the linked and unlinked records pairs, algorithm summary, ",
                                           "performance measures, and missing data indicators.<br><br>")),
                               style = "width: 400px;")
                    )),

                    # Run Button
                    column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                      actionButton("run_published_linkage_algorithms", "Run & Save All Published Algorithms", class = "btn-success", width = validateCssUnit(400), icon = shiny::icon("circle-play")),
                    ))
                  )
                )
              )
            ),

            #White space for the final button
            HTML("<br><br>")
          )
        ),
        #----
        #---------------------------------------#

        #-- LINKAGE AUDITS PAGE --#
        #----
        nav_panel(title = "Linkage Audits", value = "audits_page",
          fluidPage(
            # Put the back button on this page in the top left corner
            fluidRow(
              column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                actionButton("linkage_audits_back", "Return to Testable Algorithms Page", icon = shiny::icon("arrow-left-long")),
              ))
            ),

            # Line break to give the back button some space
            HTML("<br>"),

            # Render the data table of currently available iterations
            h5(strong("Select A Saved Performance Entry to View & Export:")),

            # UI date range input
            fluidRow(
              column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                  dateRangeInput("audit_date_range", label = "Limit Audit Date Range", start = "1983-01-01", end = NULL),
                )
              )
            ),

            # Card for the data table
            layout_column_wrap(
              width = NULL,
              style = css(grid_template_columns = '2fr 1fr;'),
              height = 500,
              # CARD FOR AUDIT SELECTION
              card(
                full_screen = TRUE,
                height = 500,
                page_fillable(
                  column(
                    width = 12,
                    div(
                      style = "margin-bottom: 10px;",  # Add spacing below the buttons
                      actionButton("select_all_audit", "Select All", class = "btn btn-primary btn-sm"),
                      actionButton("select_none_audit", "Select None", class = "btn btn-secondary btn-sm")
                    ),
                    dataTableOutput("algorithm_specific_audits"),
                  )
                )
              ),
              # CARD FOR DEFINITIONS
              card(
                height = 500,
                uiOutput("selected_algorithm_performances_measures")
              )
            ),

            # If A ROW IS SELECTED, the user can export the results by clicking the button
            conditionalPanel(
              # THIS WAS BROKEN BEFORE, IF SOMETHING KEEPS BREAKING JUST USE "input.algorithm_specific_audits_rows_selected > 0"!
              condition = "typeof input.algorithm_specific_audits_rows_selected !== 'undefined' && input.algorithm_specific_audits_rows_selected.length > 0",

              # Export Audit Button
              fluidRow(
                column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                    actionButton("export_selected_audit", label = "Export Audit", class = "btn-success", width = validateCssUnit(300), icon = shiny::icon("file-export"))
                  )
                ),
              )
            ),

            # Line break at the bottom
            HTML("<br><br>")
          )
        ),
        #----
        #-------------------------#

        #-- VIEW LINKAGE ITERATIONS PAGE --#
        #----
        nav_panel(title = "View Linkage Iterations", value = "view_linkage_iterations_page",
          fluidPage(
            # Put the back button on this page in the top left corner
            fluidRow(
              column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                actionButton("view_linkage_iterations_back",  "Return to Testable Algorithms Page", icon = shiny::icon("arrow-left-long")),
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
                  height = 80,
                  full_screen = FALSE,
                  card_body(
                    fluidRow(
                      column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                          actionButton("add_new_linkage_iteration", "Add New Iteration", class = "btn-success", width = validateCssUnit(300), icon = shiny::icon("plus")),
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
                          actionButton("add_existing_linkage_iteration", "Review And Add Iteration", class = "btn-success", width = validateCssUnit(300), icon = shiny::icon("plus")),
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
                  card_header("Iteration Specific Information", class = "bg-dark"),
                  card_body(
                    fluidRow(
                      column(width = 6, div(style = "display: flex; justify-content: right; align-items: center;",
                          actionButton("toggle_linkage_iteration", "Toggle Selected Iteration", class = "btn-success", width = validateCssUnit(300), icon = shiny::icon("toggle-off")),
                        )
                      ),
                      column(width = 6, div(style = "display: flex; justify-content: left; align-items: center;",
                          actionButton("modify_linkage_iteration", "Modify Selected Iteration", class = "btn-warning", width = validateCssUnit(300), icon = shiny::icon("file-pen")),
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
        #----------------------------------#

        #-- ADD LINKAGE ITERATIONS PAGE --#
        #----
        nav_panel(title = "Modify Linkage Iterations", value = "add_linkage_iterations_page",
          fluidPage(
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
                  column(width = 4, div(style = "display: flex; justify-content: right; align-items: center;",
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
                  column(width = 4, div(style = "display: flex; justify-content: center; align-items: center;",
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
                  column(width = 4, div(style = "display: flex; justify-content: left; align-items: center;",
                      uiOutput("add_iteration_linkage_method_input"),

                      # Add the popover manually
                      h1(tooltip(bs_icon("question-circle"),
                                 paste("The linkage method determines which class will perform the data linkage process."),
                                 placement = "right",
                                 options = list(container = "body")))
                    )
                  )
                )
              )
            ),

            # Line break between the previous card
            HTML("<br>"),

            # CARD FOR GENERAL INFORMATION
            h5(strong("Step 2: Select a Name Standardization Dataset")),
            h6(p(strong("NOTE: "), "Name standardization will only be applied if the user selects the 'Standardize Names' linkage rule.")),
            # Create a card for editing/viewing algorithm output information
            #column(width = 6, offset = 3,  # Control the card's width and center it
            div(style = "display: flex; justify-content: center; align-items: center;",
              card(
                width = 1,
                height = 150,
                full_screen = FALSE,
                card_header("Create New Linkage Iteration", class = "bg-dark"),
                card_body(
                  fluidRow(
                    column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                      # Label for the selected dataset
                      div(style = "margin-right: 10px;", "Standardization Dataset:"),
                    )),
                    column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                      # Boxed text output for showing the selected dataset
                      div(style = "flex-grow: 1; border: 1px solid #ccc; padding: 5px; background-color: #f9f9f9;",
                        textOutput("selected_standardization_dataset")
                      ),
                      # Add standardization dataset button
                      actionButton("prepare_standardization_dataset", label = "", shiny::icon("pencil"), class = "btn-circle btn-green"),
                      # Remove standardization dataset button
                      actionButton("remove_standardization_dataset", label = "", shiny::icon("eraser"), class = "btn-circle btn-red"),
                    ))
                  )
                )
              )
            ),

            # Line break between the previous card
            HTML("<br>"),

            # CARD FOR BLOCKING VARIABLES
            h5(strong("Step 3: Select the Blocking Variables")),
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
                        actionButton("prepare_blocking_variables", "Add Blocking Variables", class = "btn-success", width = validateCssUnit(300), icon = shiny::icon("plus")),
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
                        actionButton("prepare_blocking_variables_update", "Update Blocking Variables", class = "btn-warning", width = validateCssUnit(300), icon = shiny::icon("pen")),
                      )
                    ),
                    column(width = 6, div(style = "display: flex; justify-content: left; align-items: center;",
                        actionButton("drop_blocking_variables", "Drop Blocking Variables", class = "btn-danger", width = validateCssUnit(300), icon = shiny::icon("trash-can")),
                      )
                    )
                  )
                )
              )
            ),

            # LINE BREAK BETWEEN CARDS
            HTML("<br>"),

            # CARD FOR MATCHING VARIABLES
            h5(strong("Step 4: Select the Matching Variables")),
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
                        actionButton("prepare_matching_variables", "Add Matching Variables", class = "btn-success", width = validateCssUnit(300), icon = shiny::icon("plus")),
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
                        actionButton("prepare_matching_variables_update", "Update Matching Variables", class = "btn-warning", width = validateCssUnit(300), icon = shiny::icon("pen")),
                      )
                    ),
                    column(width = 6, div(style = "display: flex; justify-content: left; align-items: center;",
                        actionButton("drop_matching_variables", "Drop Matching Variables", class = "btn-danger", width = validateCssUnit(300), icon = shiny::icon("trash-can")),
                      )
                    )
                  )
                )
              )
            ),

            # LINE BREAK BETWEEN CARDS
            HTML("<br>"),

            # CARD FOR PREVIWING THE PASS
            h5(strong("Step 5: Preview the Algorithm & Passes")),
            card(card_header("Preview Algorithm Pass", class = "bg-dark"), height = 150,
              card_body(
                column(width = 12, div(style = "display: flex; justify-content: center; align-items: center; margin-top: 15px",
                    actionButton("preview_algorithm", "Save and Preview The Passes", class = "btn-success", width = validateCssUnit(300), icon = shiny::icon("floppy-disk")),
                  )
                )
              )
            ),

            # LINE BREAK BETWEEN CARDS
            HTML("<br>"),

            # CARD FOR ACCEPTANCE RULE
            h5(strong("Step 6: Select the Acceptance Rule")),
            card(card_header("Acceptance Rule", class = "bg-dark"), height = 150,
              card_body(
                column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
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
            ),

            # Two buttons for returning w/out saving, and for adding the new iteration
            fluidRow(
              column(width = 6, div(style = "display: flex; justify-content: right; align-items: center;",
                  actionButton("return_from_add_iterations", "Return Without Saving", class = "btn-danger", width = validateCssUnit(300), icon = shiny::icon("rectangle-xmark")),
                )
              ),
              column(width = 6, div(style = "display: flex; justify-content: left; align-items: center;",
                  actionButton("save_iteration", "Save and Modify Iteration", class = "btn-success", width = validateCssUnit(300), icon = shiny::icon("floppy-disk")),
                )
              ),
            ),

            # Final line break
            HTML("<br><br>")
          )
        ),
        #----
        #---------------------------------#

        #-- GROUND TRUTH VARIABLES PAGE --#
        #----
        nav_panel(title = "Ground Truth Variables", value = "ground_truth_variables_page",
          fluidPage(
            # Put the back button on this page in the top left corner
            fluidRow(
              column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                actionButton("modify_ground_truth_back", "Return to Testable Algorithms Page", icon = shiny::icon("arrow-left-long")),
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
              card(width = 1, height = 350, full_screen = FALSE, card_header("Add Ground Truth Variables", class = "bg-dark"),
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
                            div(style = "margin-right: 10px;", "Comparison Rule:"),
                          )),
                          column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                            # Boxed text output for showing the uploaded file name
                            div(style = "flex-grow: 1; border: 1px solid #ccc; padding: 5px; background-color: #f9f9f9;",
                              textOutput("selected_ground_truth_comparison_rule")
                            ),
                            # Add linkage rule button
                            actionButton("prepare_ground_truth_comparison_rule", label = "", shiny::icon("pencil"), class = "btn-circle btn-green"),
                            # Remove linkage rule button
                            actionButton("remove_ground_truth_comparison_rule", label = "", shiny::icon("eraser"), class = "btn-circle btn-red"),
                          ))
                        )
                      )
                    ),
                    column(width = 3, div(style = "display: flex; justify-content: center; align-items: center; margin-top: 15px;",
                        actionButton("add_ground_truth", "Add Ground Truth Pair", class = "btn-success", width = validateCssUnit(300), icon = shiny::icon("plus")),
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
              div(style = "display: flex; justify-content: center; align-items: center;",
                card(width = 0.25, max_height = 125, full_screen = FALSE, card_header("Drop Ground Truth Variables", class = "bg-dark"),
                  fluidPage(
                    column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                        actionButton("drop_ground_truth", "Drop Ground Truth Pair", class = "btn-danger", width = validateCssUnit(300), icon = shiny::icon("trash-can")),
                      )
                    )
                  )
                )
              )
            )
          )
        ),
        #----
        #---------------------------------#

        #-- LINKAGE ALGORITHM OUTPUT FIELDS PAGE --#
        #----
        nav_panel(title = "Linkage Algorithm Output Fields", value = "linkage_algorithm_output_page",
          fluidPage(
            # Put the back button on this page in the top left corner
            fluidRow(
              column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                actionButton("linkage_algorithm_output_back", "Return to Testable Algorithms Page", icon = shiny::icon("arrow-left-long")),
              ))
            ),

            # Line break to give the back button some space
            HTML("<br>"),

            # Render the data table of this algorithms ground truth variables
            h5(strong("Select The Linkage Algorithm Output Field(s) to Drop:")),
            h6(p(strong("NOTE: "), "No duplicate fields allowed.")),
            dataTableOutput("currently_added_algorithm_output_fields"),

            # Line break
            HTML("<br>"),

            # If no row is selected, the user can enter a new output field + type OR use another algorithms output fields
            conditionalPanel(
              condition = "input.currently_added_algorithm_output_fields_rows_selected <= 0",

              # Select between manually adding output fields, or use an existing algorithms output fields
              fluidRow(
                column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                    radioButtons("algorithm_output_add_type", strong("Select Output Field Add Type:"),
                                 c("Manually Add Output Fields" = 1,
                                   "Use Existing Algorithms Output Fields" = 2),
                                 width = validateCssUnit(500))
                  )
                ),
              ),

              # If the user would like to manually add output fields:
              conditionalPanel(
                condition = 'input.algorithm_output_add_type == 1',

                # Show a card input here which will allow users to select a left field, right field, and linkage rule to add
                layout_column_wrap(
                  width = 1/2,
                  height = 550,
                  # CARD FOR SELECTING THE FIELD TYPE
                  card(full_screen = TRUE, card_header("Add Linkage Output Fields", class = 'bg-dark'),
                    fluidPage(
                      fluidRow(
                        column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                            selectInput("linkage_algorithm_output_field_type", label = "Field Type:",
                            choices = list("Generic/Pass-Through" = 1,
                                           "Date (Year)" = 2,
                                           "Age" = 3,
                                           "Postal Code Initials" = 4,
                                           "Name Length" = 5,
                                           "Number of Names" = 6,
                                           "Derived Age" = 7,
                                           "Standardized Values" = 8,
                                           "Forward Sortation Area (FSA)" = 9),
                            selected = 1,
                            width = validateCssUnit(500)),
                          )
                        ),
                      )
                    )
                  ),
                  # CARD FOR THE INPUT UI
                  card(full_screen = TRUE, card_header("Add Linkage Output Fields", class = 'bg-dark'),
                    fluidPage(
                      fluidRow(
                        column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                            textAreaInput("linkage_algorithm_output_field_label", label = "Output Dataset Field Label:", value = "",
                                          width = validateCssUnit(500), resize = "none"),
                          )
                        ),
                        column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                            uiOutput("linkage_algorithm_output_field_input"),
                          )
                        ),
                        column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                            actionButton("add_linkage_algorithm_output_field", "Add Output Field", class = "btn-success", width = validateCssUnit(300), icon = shiny::icon("plus")),
                          )
                        )
                      )
                    )
                  ),
                )
              ),

              # If the user would like to use a previous algorithms output fields
              conditionalPanel(
                condition = 'input.algorithm_output_add_type == 2',

                # CARD FOR SELECTING THE FIELD TYPE
                card(full_screen = TRUE, card_header("Use Existing Algorithm's Output Fields", class = 'bg-dark'),
                height = 600,
                  fluidPage(
                    fluidRow(
                      column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                          uiOutput("usable_previous_algorithm_outputs")
                        )
                      ),
                      column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                          dataTableOutput("selected_algorithm_output_fields")
                        )
                      ),
                      column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                          actionButton("use_selected_algorithms_fields", "Use Selected Algorithm's Output Fields", class = "btn-success", width = validateCssUnit(400), icon = shiny::icon("plus")),
                        )
                      )
                    )
                  )
                ),
              )
            ),
            # If a row is selected, the user can drop the selected pair of ground truth variables
            conditionalPanel(
              condition = "input.currently_added_algorithm_output_fields_rows_selected > 0",

              # Show a card for users to drop the selected row
              div(style = "display: flex; justify-content: center; align-items: center;",
                card(width = 0.25, max_height = 125, full_screen = FALSE, card_header("Drop Linkage Output Fields", class = 'bg-dark'),
                  fluidPage(
                    column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                        actionButton("drop_linkage_algorithm_output_field", "Drop Output Field", class = "btn-danger", width = validateCssUnit(300), icon = shiny::icon("trash-can")),
                      )
                    )
                  )
                )
              )
            )
          )
        ),
        #----
        #------------------------------------------#

        #-- ACCEPTANCE METHODS PAGE --#
        #----
        nav_panel(title = "Acceptance Methods", value = "acceptance_methods_page",
          fluidPage(
            # Put the back button on this page in the top left corner
            fluidRow(
              column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                actionButton("acceptance_methods_back", "Return to Modify Iterations Page", icon = shiny::icon("arrow-left-long")),
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
                          actionButton("prepare_acceptance_method_parameters_to_add", "Add Acceptance Parameter", class = "btn-success", width = validateCssUnit(300), icon = shiny::icon("plus")),
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
                          actionButton("update_prepared_acceptance_method_parameters_to_add", "Update Acceptance Parameter", class = "btn-warning", width = validateCssUnit(300), icon = shiny::icon("pen")),
                        )),
                        column(width = 6, div(style = "display: flex; justify-content: left; align-items: left;",
                          actionButton("drop_prepared_acceptance_method_parameters_to_add", "Drop Acceptance Parameter", class = "btn-danger", width = validateCssUnit(300), icon = shiny::icon("trash-can")),
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
                  actionButton("add_acceptance_method_and_parameters", "Add Acceptance Method & Parameters", class = "btn-success", width = validateCssUnit(400), icon = shiny::icon("plus")),
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
                          actionButton("update_prepared_acceptance_method_parameters_to_update", "Update Acceptance Parameter", class = "btn-warning", width = validateCssUnit(300), icon = shiny::icon("pen")),
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
                  actionButton("update_acceptance_method_and_parameters", "Update Acceptance Method & Parameters", class = "btn-warning", width = validateCssUnit(400), icon = shiny::icon("pen")),
                ))
              ),
              # Final line break
              HTML("<br><br>")
            )
          )
        ),
        #----
        #-----------------------------#

        #-- COMPARISON METHODS PAGE --#
        #----
        nav_panel(title = "Comparison Methods", value = "comparison_methods_page",
          fluidPage(
            # Put the back button on this page in the top left corner
            fluidRow(
              column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                actionButton("comparison_methods_back", "Return to Modify Iterations Page", icon = shiny::icon("arrow-left-long")),
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
                           actionButton("prepare_comparison_method_parameters_to_add", "Add Comparison Parameter", class = "btn-success", width = validateCssUnit(300), icon = shiny::icon("plus")),
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
                           actionButton("update_prepared_comparison_method_parameters_to_add", "Update Comparison Parameter", class = "btn-warning", width = validateCssUnit(300), icon = shiny::icon("pen")),
                         )),
                         column(width = 6, div(style = "display: flex; justify-content: left; align-items: left;",
                           actionButton("drop_prepared_comparison_method_parameters_to_add", "Drop Comparison Parameter", class = "btn-danger", width = validateCssUnit(300), icon = shiny::icon("trash-can")),
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
                  actionButton("add_comparison_method_and_parameters", "Add Comparison Method & Parameters", class = "btn-success", width = validateCssUnit(400), icon = shiny::icon("plus")),
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
                           actionButton("update_prepared_comparison_method_parameters_to_update", "Update Comparison Parameter", class = "btn-warning", width = validateCssUnit(300), icon = shiny::icon("pen")),
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
                                       actionButton("update_comparison_method_and_parameters", "Update Comparison Method & Parameters", class = "btn-warning", width = validateCssUnit(400), icon = shiny::icon("pen")),
                ))
              ),
              # Final line break
              HTML("<br><br>")
            )
          )
        ),
        #----
        #-----------------------------#

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

        #-- REGENERATE REPORTS PAGE --#
        #----
        nav_panel(title = "Regenerate Report", value = "regenerate_report_page",
          fluidPage(
            shinyjs::useShinyjs(), # Added this so that we can disable buttons (IF IT BREAKS THINGS DELETE IT)

            # Put the back button on this page in the top left corner
            fluidRow(
              column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                actionButton("regenerate_report_back", "Return to Testable Algorithms Page", icon = shiny::icon("arrow-left-long")),
              ))
            ),

            # Line break
            HTML("<br>"),

            ### STEP 1
            h5(strong("Step 1: Select the Saved Data Date(s) to Regenerate")),
            h6(p(strong("Note: "), paste("A minimum of one saved linkage data dates must be selected."))),
            # Create a card for the output location
            div(style = "display: flex; justify-content: center; align-items: center;",
              card(
                width = 1,
                height = 400,
                full_screen = FALSE,
                card_header("Select Saved Data to Regenerate", class = 'bg-dark'),
                card_body(
                  fluidRow(
                    column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                      dataTableOutput("select_saved_data_to_regenerate"),
                    )),
                  ),
                )
              )
            ),

            # Line break
            HTML("<br><br>"),

            ### STEP 2
            h5(strong("Step 2: Provide the Output Folder")),
            # Create a card for the output location
            div(style = "display: flex; justify-content: center; align-items: center;",
                card(
                  width = 1,
                  height = 150,
                  full_screen = FALSE,
                  card_header("Supply Output Location", class = 'bg-dark'),
                  card_body(
                    fluidRow(
                      column(width = 12, div(style = "display: flex; justify-content: center; align-items: left;",
                        # Boxed text output for showing the uploaded folder name
                        div(style = "border: 1px solid #ccc; padding: 5px; background-color: #f9f9f9;",
                          textOutput("uploaded_regenerated_report_output_dir")
                        ),
                        # Upload Button
                        shinyDirButton("regenerated_report_output_dir", label = "", icon = icon("folder-open"), title = 'Please Select a Directory')
                      )),
                      column(width = 12, div(style = "display: flex; justify-content: center; align-items: left;",
                        helpText("Select a folder where the regenerated linkage report will be placed.")
                      ))
                    ),
                  )
                )
            ),

            HTML("<br>"), # Spacing

            ### STEP 3
            h5(strong("Step 3: Regenerate Linkage Report")),
            # Create a card for editing/viewing algorithm output information
            div(style = "display: flex; justify-content: center; align-items: center;",
                card(
                  width = 1,
                  height = 125,
                  full_screen = FALSE,
                  card_header("Regenerate Linkage Report for the Selected Algorithm", class = 'bg-dark'),
                  card_body(
                    fluidRow(
                      column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                        actionButton("regenerate_report_btn", "Regenerate Report", class = "btn-success", width = validateCssUnit(300), icon = shiny::icon("file-pdf"))
                      ))
                    ),
                  )
                )
            ),
            HTML("<br>"), # Spacing
          )
        ),
        #----
        #-----------------------------#

        #-- RUN LINKAGE ALGORITHM PAGE --#
        #----
        nav_panel(title = "Run Algorithm", value = "run_algorithm_page",
          fluidPage(
            shinyjs::useShinyjs(), # Added this so that we can disable buttons (IF IT BREAKS THINGS DELETE IT)

            # Put the back button on this page in the top left corner
            fluidRow(
              column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                actionButton("run_algorithm_back", "Back", icon = shiny::icon("arrow-left-long")),
              ))
            ),

            # Line break to give the back button some breathing room
            HTML("<br><br>"),

            ### STEP 1
            h5(strong("Step 1: Select the Algorithm(s) to Run")),
            h6(p(strong("Note: "), paste("A minimum of one algorithm must be selected."))),
            # Create a card for the output location
            div(style = "display: flex; justify-content: center; align-items: center;",
              card(
                width = 1,
                height = 600,
                full_screen = FALSE,
                card_header("Select Algorithms to Run", class = 'bg-dark'),
                page_fillable(
                  column(
                    width = 12,
                    div(
                      style = "margin-bottom: 10px;",  # Add spacing below the buttons
                      actionButton("select_all_run", "Select All", class = "btn btn-primary btn-sm"),
                      actionButton("select_none_run", "Select None", class = "btn btn-secondary btn-sm")
                    ),
                    dataTableOutput("select_linkage_algorithms_to_run"),
                  )
                )
              )
            ),

            HTML("<br>"), # Spacing

            ### STEP 2
            h5(strong("Step 2: Provide the Output Folder")),
            # Create a card for the output location
            div(style = "display: flex; justify-content: center; align-items: center;",
              card(
                width = 1,
                height = 150,
                full_screen = FALSE,
                card_header("Supply Output Location", class = 'bg-dark'),
                card_body(
                  fluidRow(
                    column(width = 12, div(style = "display: flex; justify-content: center; align-items: left;",
                      # Boxed text output for showing the uploaded folder name
                      div(style = "border: 1px solid #ccc; padding: 5px; background-color: #f9f9f9;",
                        textOutput("uploaded_linkage_output_dir")
                      ),
                      # Upload Button
                      shinyDirButton("linkage_output_dir", label = "", icon = icon("folder-open"), title = 'Please Select a Directory')
                    )),
                    column(width = 12, div(style = "display: flex; justify-content: center; align-items: left;",
                      helpText("Select a folder where all output will be saved.")
                    ))
                  ),
                )
              )
            ),

            HTML("<br>"), # Spacing

            ### STEP 2
            h5(strong("Step 3: Select the Type of Linkage Quality Report")),
            # Create a card for the linkage quality report type
            div(style = "display: flex; justify-content: center; align-items: center;",
              card(
                width = 1,
                height = 250,
                full_screen = FALSE,
                card_header("Report Type", class = 'bg-dark'),
                card_body(
                  fluidRow(
                    column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                      # Radio button for selecting report type
                      radioButtons(
                        inputId = "linkage_report_type",
                        label = "Choose Linkage Report Type:",
                        choices = list(
                          "No Report" = 1,
                          "Intermediate Report" = 2,
                          "Final Report" = 3
                        )
                      ),
                      helpText("Select a report type to see more information about what is included in each.")
                    )),
                    column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                      # Boxed text output for showing the uploaded folder name
                      div(style = "border: 1px solid #ccc; padding: 5px; background-color: #f9f9f9;",
                         textOutput("linkage_report_type_help")
                      ),
                    ))
                  ),
                )
              )
            ),

            HTML("<br>"), # Spacing

            ### STEP 4
            h5(strong("Step 4: Select Export Options")),
            # Create a card for editing/viewing algorithm output information
            column(width = 6, offset = 3,  # Control the card's width and center it
              div(style = "display: flex; justify-content: center; align-items: center;",
                card(
                  width = NULL,  # Remove the width inside the card and control it from the column
                  height = 460,
                  full_screen = FALSE,
                  card_header("Optional Export Options", class = 'bg-dark'),
                  card_body(
                    fluidRow(
                      column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                        helpText("Per Pass CSV output of the linked pairs that were selected.")
                      )),
                      column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                        checkboxInput("output_linked_iterations_pairs", "Output Linked Iteration Pairs", FALSE)
                      )),
                      column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                        helpText("Per Pass CSV output of the unlinked pairs before pairs were selected.")
                      )),
                      column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                        checkboxInput("output_unlinked_iteration_pairs", "Output Unlinked Iteration Pairs", FALSE)
                      )),
                      column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                        helpText("Singular CSV output of each pass of the algorithm, including the fields used, acceptance threshold, and linkage rate.")
                      )),
                      column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                        checkboxInput("generate_algorithm_summary", "Algorithm Summary", FALSE)
                      )),
                      column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                        helpText("Singular CSV output of performance metrics calculated during the linkage process if a ground truth was provided for the algorithm.")
                      )),
                      column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                        checkboxInput("calculate_performance_measures", "Performance Measures", FALSE)
                      )),
                      column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                        helpText("Per Pass PNG plots of the linkage algorithm and its acceptance threshold distribution.")
                      )),
                      column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                        checkboxInput("generate_threshold_plots", "Histograms", FALSE)
                      )),
                    )
                  )
                )
              )
            ),

            ### STEP 5
            h5(strong("Step 5: Select Output Options")),
            # Create a card for editing/viewing algorithm output information
            column(width = 6, offset = 3,  # Control the card's width and center it
              div(style = "display: flex; justify-content: center; align-items: center;",
                card(
                  width = NULL,  # Remove the width inside the card and control it from the column
                  height = 300,
                  full_screen = FALSE,
                  card_header("Optional Output Options", class = 'bg-dark'),
                  card_body(
                    fluidRow(
                      column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                        helpText("Includes the unlinked record pairs that appear in the linkage data or the linkage quality report.")
                      )),
                      column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                        checkboxInput("include_unlinked_records", "Unlinked Pairs in Final Output", FALSE)
                      )),
                      column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                        helpText("Collects missing data indicators of the output fields to be placed in the linkage report.")
                      )),
                      column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                        checkboxInput("create_missing_data_indicators", "Missing Data Indicators", FALSE)
                      )),
                      column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                        helpText("Collects and saves the linkage performance of the algorithms being ran, to be used for future auditing purposes.")
                      )),
                      column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                        checkboxInput("save_audit_performance", "Save Algorithm Performance", FALSE)
                      ))
                    )
                  )
                )
              )
            ),

            HTML("<br>"), # Spacing

            ### STEP 6
            h5(strong("Step 6: Retain Record Linkage Data")),
            # Create a card for saving the results obtained during record linkage
            column(width = 6, offset = 3,  # Control the card's width and center it
              div(style = "display: flex; justify-content: center; align-items: center;",
               card(
                  width = NULL,  # Remove the width inside the card and control it from the column
                  height = 170,
                  full_screen = FALSE,
                  card_header("Retain Record Linkage Results?", class = 'bg-dark'),
                  card_body(
                    fluidRow(
                      column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                        helpText(paste0("Retain the linked data results that will be generated for the algorithms being ",
                                        "ran in the packages 'AppData' folder to be used for regenerating future reports."))
                      )),
                      column(width = 12, div(style = "display: flex; justify-content: left; align-items: left;",
                        checkboxInput("save_all_linkage_results", "Save All Linkage Results?", FALSE)
                      ))
                    )
                  )
                )
              )
            ),

            HTML("<br>"), # Spacing

            ### STEP 7
            h5(strong("Step 7: Run Record Linkage for the Selected Algorithm(s)")),
            # Create a card for editing/viewing algorithm output information
            div(style = "display: flex; justify-content: center; align-items: center;",
              card(
                width = 1,
                height = 150,
                full_screen = FALSE,
                card_header("Run Record Linkage", class = 'bg-dark'),
                card_body(
                  fluidRow(
                    column(width = 12, div(style = "display: flex; justify-content: center; align-items: center; margin-top: 15px",
                      actionButton("run_linkage_btn", "Run Linkage", class = "btn-success", width = validateCssUnit(300), icon = shiny::icon("circle-play"))
                    ))
                  ),
                )
              )
            ),

            HTML("<br>"), # Spacing
          )
        ),
        #----
        #--------------------------------#

        nav_spacer(),
        nav_menu(
          title = "Links",
          align = "right",
          nav_item(tags$a("GitHub", href = "https://github.com/CHIMB/datalink"))
        )
      )
    )
  )
  #------------------#
)
# Script/Server
linkage_server <- function(input, output, session, linkage_metadata_conn, metadata_file_path, username){
  # Change loading screen
  hideElement("loading_screen")
  showElement("loading_screen_2")

  #-- HIDING PAGES EVENTS --#
  # Initially hide some tabs we don't need the users to access
  nav_hide('main_navbar', 'linkage_rule_page')
  nav_hide('main_navbar', 'view_linkage_iterations_page')
  nav_hide('main_navbar', 'add_linkage_iterations_page')
  nav_hide('main_navbar', 'acceptance_methods_page')
  nav_hide('main_navbar', 'comparison_methods_page')
  nav_hide('main_navbar', 'ground_truth_variables_page')
  nav_hide('main_navbar', 'audits_page')
  nav_hide('main_navbar', 'linkage_algorithm_output_page')
  nav_hide('main_navbar', 'run_algorithm_page')
  nav_hide('main_navbar', 'regenerate_report_page')
  nav_hide('main_navbar', 'archived_linkage_algorithms_page')
  nav_hide('main_navbar', 'published_linkage_algorithms_page')

  # If the user goes off of an inner tab, hide it
  observeEvent(input$main_navbar, {
    # Get the tabs that are not necessary for the user
    tabs_to_hide <- c("linkage_rule_page", "view_linkage_iterations_page", "add_linkage_iterations_page",
                      "acceptance_methods_page", "comparison_methods_page", "ground_truth_variables_page", "audits_page",
                      "linkage_algorithm_output_page", "run_algorithm_page", "regenerate_report_page",
                      "archived_linkage_algorithms_page", "published_linkage_algorithms_page")
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

  # Show the next loading screen
  hideElement("loading_screen_2")
  showElement("loading_screen_3")

  #-- DATASETS PAGE EVENTS --#
  #----
  # Global variable for the uploaded dataset fields
  uploaded_fields_df <- data.frame(
    field_name = character(),
    field_type = character(),
    field_width = numeric()
  )

  names(uploaded_fields_df)[names(uploaded_fields_df) == 'field_name'] <- 'Field Name'
  names(uploaded_fields_df)[names(uploaded_fields_df) == 'field_type'] <- 'Field Type'
  names(uploaded_fields_df)[names(uploaded_fields_df) == 'field_width'] <- 'Field Width'

  # Reactive value for the file path (ADD)
  file_path <- reactiveValues(
    path=NULL
  )

  # Reactive value for the file path (UPDATE)
  file_path_update <- reactiveValues(
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
    names(df)[names(df) == 'is_fwf'] <- 'Is Fixed-Width'
    names(df)[names(df) == 'enabled_for_linkage'] <- 'Enabled'
    names(df)[names(df) == 'dataset_location'] <- 'Local Dataset File Location'

    # With datasets, we'll replace the enabled [0, 1] with [No, Yes]
    df$Enabled <- str_replace(df$Enabled, "0", "No")
    df$Enabled <- str_replace(df$Enabled, "1", "Yes")

    # With datasets, we'll replace the yes of fwf [1, 2] with [No, Yes]
    df[["Is Fixed-Width"]] <- str_replace(df[["Is Fixed-Width"]] , "1", "No")
    df[["Is Fixed-Width"]] <- str_replace(df[["Is Fixed-Width"]] , "2", "Yes")

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
         stop("Unsupported file format")  # Error if unsupported file type
      )
    },
    error = function(e){
      column_names <<- NULL
    })

    # Return the extracted column names
    return(column_names)
  }

  # Function to read in a file, extract the column types, and return them
  read_dataset_col_types <- function(file_path) {
    # Extract the file extension
    file_extension <- tools::file_ext(file_path)

    # Create a vector for the column names
    column_types <- c()

    # Try to extract them
    tryCatch({
      # Based on file extension, attempt to read only the first row (column names)
      column_types <- switch(tolower(file_extension),
         "csv" = {
           # Read only the header from a CSV file
           sapply(data.table::fread(file_path, nrows = 100), class)
         },
         "txt" = {
           # Read only the header from a TXT file
           sapply(data.table::fread(file_path, nrows = 100), class)
         },
         "sas7bdat" = {
           # Read only the header from a SAS7BDAT file
           sapply(haven::read_sas(file_path, n_max = 100), class)
         },
         "xlsx" = {
           # Read only the first row from an Excel file
           sapply(readxl::read_excel(file_path, n_max = 100), class)
         },
         "xls" = {
           # Read only the first row from an older Excel file
           sapply(readxl::read_excel(file_path, n_max = 100), class)
         },
         stop("Unsupported file format")  # Error if unsupported file type
      )

      # Extract the first element of each variable
      column_types <- sapply(column_types,"[[",1)
    },
    error = function(e){
      column_types <<- NULL
    })

    # Return the extracted column names
    return(column_types)
  }

  # Renders the Data table of currently added datasets
  output$currently_added_datasets <- renderDataTable({
    get_datasets()
  })

  # Renders the selected dataset fields based on what dataset the user selected
  output$selected_dataset_fields <- renderDataTable({
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

    # Construct a data frame
    df_temp <- data.frame(
      field_name = df$field_name,
      field_type = df$field_type,
      field_width = df$field_width
    )

    # Re-label the data frame
    names(df_temp)[names(df_temp) == 'field_name'] <- 'Field Name'
    names(df_temp)[names(df_temp) == 'field_type'] <- 'Field Type'
    names(df_temp)[names(df_temp) == 'field_width'] <- 'Field Width'

    # Put it into a data table now
    dt <- datatable(df_temp, selection = 'none', rownames = FALSE, options = list(lengthChange = FALSE, dom = 'tp'))
  })

  # Renders the uploaded dataset fields based on the file the user provided
  output$uploaded_dataset_fields <- renderDataTable({
    # Put it into a data table now
    dt <- datatable(uploaded_fields_df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE, dom = 'tp'))
  })

  # Observes if the user uploads a file or changes the type to fwf
  observe({
    data_is_fwf <- input$add_dataset_is_fwf
    input_file  <- file_path$path

    # Make sure the input file is not null
    if(is.null(input_file)){
      uploaded_fields_df <<- data.frame(
        field_name = character(),
        field_type = character(),
        field_width = numeric()
      )

      # Renders the uploaded dataset fields based on the file the user provided
      output$uploaded_dataset_fields <- renderDataTable({
        # get the uploaded fields df
        df <- uploaded_fields_df
        names(df)[names(df) == 'field_name'] <- 'Field Name'
        names(df)[names(df) == 'field_type'] <- 'Field Type'
        names(df)[names(df) == 'field_width'] <- 'Field Width'

        # Put it into a data table now
        dt <- datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE, dom = 'tp'))
      })

      # Retrn
      return()
    }

    # If the data is fwf, handle it differently
    if(data_is_fwf == 2){
      # Use fwf_empty to guess column positions
      col_positions <- fwf_empty(input_file)

      # Extract the start and end positions of each column
      start_positions <- col_positions$begin
      end_positions <- col_positions$end
      col_names <- col_positions$col_names

      # Read the first line to get the total length of a line
      first_line <- read_lines(input_file, n_max = 1)
      line_length <- nchar(first_line)

      # Handle the case where the last 'end' position is NA (column goes to the end of the line)
      end_positions[is.na(end_positions)] <- line_length

      # Calculate the column widths
      col_widths <- end_positions - start_positions + 1

      # Now try to get the column types
      col_types <- sapply(read_fwf(input_file, fwf_empty(input_file), n_max = 1, show_col_types = FALSE), class)

      # Construct a data frame
      df <- data.frame(
        field_name = col_names,
        field_type = col_types,
        field_width = col_widths
      )

      # Replace the global df with the one we read in
      uploaded_fields_df <<- df

      # Renders the uploaded dataset fields based on the file the user provided
      output$uploaded_dataset_fields <- renderDataTable({
        # get the uploaded fields df
        df <- uploaded_fields_df
        names(df)[names(df) == 'field_name'] <- 'Field Name'
        names(df)[names(df) == 'field_type'] <- 'Field Type'
        names(df)[names(df) == 'field_width'] <- 'Field Width'

        # Put it into a data table now
        dt <- datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE, dom = 'tp'))
      })
    }
    else{
      # Get the field_names and column types
      col_names <- read_dataset_columns(input_file)
      col_types <- read_dataset_col_types(input_file)

      # Make sure the col_names and types are valid
      if(is.null(col_names) || is.null(col_types)) return()

      # Make Sure the length of column names and types are the same
      if(length(col_names) != length(col_types)) return()

      # Construct a data frame
      df <- data.frame(
        field_name = col_names,
        field_type = col_types,
        field_width = NA
      )

      # Replace the global df with the one we read in
      uploaded_fields_df <<- df

      # Renders the uploaded dataset fields based on the file the user provided
      output$uploaded_dataset_fields <- renderDataTable({
        # get the uploaded fields df
        df <- uploaded_fields_df
        names(df)[names(df) == 'field_name'] <- 'Field Name'
        names(df)[names(df) == 'field_type'] <- 'Field Type'
        names(df)[names(df) == 'field_width'] <- 'Field Width'

        # Put it into a data table now
        dt <- datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE, dom = 'tp'))
      })
    }
  })

  # Observes when the user selects a row, which will pre-populate the width input field
  observeEvent(input$uploaded_dataset_fields_rows_selected, {
    # Get the row selected
    row_selected <- input$uploaded_dataset_fields_rows_selected

    # Verify that it's not null
    if(is.null(row_selected)) return()

    # Pre-populate the input with that selected width
    width <- uploaded_fields_df$field_width[row_selected]
    updateNumericInput(session, "update_field_width_input", value = width)
  })

  # Observes when the user updates a selected width input row
  observeEvent(input$update_field_width_btn, {
    # Get the row selected
    row_selected <- input$uploaded_dataset_fields_rows_selected

    # Verify that it's not null
    if(is.null(row_selected)){
      showNotification("Failed to Update Width - Row Must Be Selected", type = "error", closeButton = FALSE)
      return()
    }

    # Get the input width
    width <- input$update_field_width_input

    # Make sure that its not missing
    if(is.na(width) || width <= 0){
      showNotification("Failed to Update Width - Width Must Be >= 1", type = "error", closeButton = FALSE)
      return()
    }

    # Update the width
    uploaded_fields_df$field_width[row_selected] <<- width

    # Renders the uploaded dataset fields based on the file the user provided
    output$uploaded_dataset_fields <- renderDataTable({
      # get the uploaded fields df
      df <- uploaded_fields_df
      names(df)[names(df) == 'field_name'] <- 'Field Name'
      names(df)[names(df) == 'field_type'] <- 'Field Type'
      names(df)[names(df) == 'field_width'] <- 'Field Width'

      # Put it into a data table now
      dt <- datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE, dom = 'tp'))
    })

    # Show a success message
    showNotification("Successfully Updated Field Width", type = "message", closeButton = FALSE)
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

  # Allows user to upload a file for grabbing column names and storing path
  observeEvent(input$add_dataset_file,{
    tryCatch({
      file_path$path <- file.choose()
    },
    error = function(e){
      file_path$path <- NULL
    })
  })

  # Allows user to upload a file for updating path
  observeEvent(input$update_dataset_file,{
    tryCatch({
      file_path_update$path <- file.choose()
    },
    error = function(e){
      file_path_update$path <- NULL
    })
  })

  # Render the uploaded file
  observe({
    uploaded_file_add    <- file_path$path
    uploaded_file_update <- file_path_update$path

    # Uploaded dataset file (ADD)
    if(is.null(uploaded_file_add)){
      output$uploaded_file_name <- renderText({
        "No File Uploaded"
      })
    }
    else{
      output$uploaded_file_name <- renderText({
        uploaded_file_add
      })
    }

    # Uploaded dataset file (UPDATE)
    if(is.null(uploaded_file_update)){
      output$uploaded_file_name_update <- renderText({
        "No File Uploaded"
      })
    }
    else{
      output$uploaded_file_name_update <- renderText({
        uploaded_file_update
      })
    }
  })

  # Adds a new dataset to the database
  observeEvent(input$add_dataset, {
    # Get the values that we're inserting into a new record
    #----#
    dataset_code   <- input$add_dataset_code
    dataset_name   <- input$add_dataset_name
    dataset_vers   <- input$add_dataset_version
    dataset_is_fwf <- input$add_dataset_is_fwf
    dataset_file   <- file_path$path
    #----#

    # Error Handling
    #----#
    # Make sure the inputs are good
    if(dataset_code == "" || dataset_name == "" || is.na(dataset_vers) || is.null(dataset_file)){
      showNotification("Failed to Add Dataset - Some Inputs are Missing", type = "error", closeButton = FALSE)
      return()
    }

    # Make sure the uploaded file is actually a file
    if(!file.exists(dataset_file)){
      showNotification("Failed to Add Dataset - File Does Not Exist", type = "error", closeButton = FALSE)
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

    # Make sure we have columnst to upload
    if(nrow(uploaded_fields_df) <= 0) {
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
      new_entry_query <- paste("INSERT INTO datasets (dataset_code, dataset_name, version, is_fwf, enabled_for_linkage, dataset_location)",
                               "VALUES(?, ?, ?, ?, 1, ?);")
      new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
      dbBind(new_entry, list(dataset_code, dataset_name, dataset_vers, dataset_is_fwf, dataset_file))
      dbClearResult(new_entry)
      #----#

      # Add the dataset fields to the other table after we insert basic information
      #----#
      # Get the most recently inserted dataset_id value
      dataset_id <- dbGetQuery(linkage_metadata_conn, "SELECT last_insert_rowid() AS dataset_id;")$dataset_id

      # Insert each column name into the dataset_fields table
      for (index in 1:nrow(uploaded_fields_df)) {
        # Grab the dataset columns, column types, and widths
        col_name  <- uploaded_fields_df$field_name[index]
        col_type  <- uploaded_fields_df$field_type[index]
        col_width <- uploaded_fields_df$field_width[index]

        insert_field_query <- "INSERT INTO dataset_fields (dataset_id, field_name, field_type, field_width) VALUES (?, ?, ?, ?);"
        insert_field_stmt <- dbSendStatement(linkage_metadata_conn, insert_field_query)
        dbBind(insert_field_stmt, list(dataset_id, col_name, col_type, col_width))
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
    uploaded_fields_df <<- data.frame(
      field_name = character(),
      field_type = character(),
      field_width = numeric()
    )
    # Renders the uploaded dataset fields based on the file the user provided
    output$uploaded_dataset_fields <- renderDataTable({
      # get the uploaded fields df
      df <- uploaded_fields_df
      names(df)[names(df) == 'field_name'] <- 'Field Name'
      names(df)[names(df) == 'field_type'] <- 'Field Type'
      names(df)[names(df) == 'field_width'] <- 'Field Width'

      # Put it into a data table now
      dt <- datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE, dom = 'tp'))
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
    dataset_path <- df[row_selected, "dataset_location"]

    # Convert the version string to a number
    version <- sub('.', '', version)
    version_num <- as.numeric(version)

    # Now update the input fields
    updateTextAreaInput(session, "update_dataset_code",    value = dataset_code)
    updateTextAreaInput(session, "update_dataset_name",    value = dataset_name)
    updateNumericInput(session,  "update_dataset_vers",    value = version_num)
    output$uploaded_file_name_update <- renderText({
      dataset_path
    })
    file_path_update$path <- dataset_path
  })

  # Updates an existing record in the 'datasets' table
  observeEvent(input$update_dataset, {
    # Get the values that we're updating an existing record of
    #----#
    dataset_code <- input$update_dataset_code
    dataset_name <- input$update_dataset_name
    dataset_vers <- input$update_dataset_vers
    selected_row <- input$currently_added_datasets_rows_selected
    dataset_file <- file_path_update$path

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
      showNotification("Failed to Update Dataset - Dataset Code Already in Use", type = "error", closeButton = FALSE)
      return()
    }

    # Make sure the inputs are good
    if(dataset_code == "" || dataset_name == "" || is.na(dataset_vers) || is.null(dataset_file)){
      showNotification("Failed to Update Dataset - Some Inputs are Missing", type = "error", closeButton = FALSE)
      return()
    }

    # Make sure the dataset file exists
    if(!file.exists(dataset_file)){
      showNotification("Failed to Update Dataset - File Does Not Exist", type = "error", closeButton = FALSE)
      return()
    }
    #----#

    # Create a query for updating the dataset
    #----#
    dataset_vers <- paste0("v", dataset_vers)
    update_query <- paste("UPDATE datasets
                          SET dataset_code = ?, dataset_name = ?, version = ?, dataset_location = ?
                          WHERE dataset_id = ?")
    update <- dbSendStatement(linkage_metadata_conn, update_query)
    dbBind(update, list(dataset_code, dataset_name, dataset_vers, dataset_file, selected_dataset_id))
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

    # Send a success notification
    #----#
    showNotification("Dataset Successfully Updated", type = "message", closeButton = FALSE)
    #----#
  })
  #----
  #--------------------------#

  # Show the next loading screen
  hideElement("loading_screen_3")
  showElement("loading_screen_4")

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
                             "VALUES(?, ?, ?, ?);")
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

  # Show the next loading screen
  hideElement("loading_screen_4")
  showElement("loading_screen_5")

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
                                               'AND archived = 0 AND published = 0',
                                               'ORDER BY algorithm_id ASC;'))

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

    # Query to get all linkage algorithm information from the 'linkage_algorithm' table
    query <- paste('SELECT * FROM linkage_algorithms
                    WHERE dataset_id_left =', left_dataset_id, ' AND dataset_id_right =', right_dataset_id,
                   'AND archived = 0 AND published = 0',
                   'ORDER BY algorithm_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    # With our data frame, we'll rename some of the columns to look better
    names(df)[names(df) == 'algorithm_name'] <- 'Algorithm Name'
    names(df)[names(df) == 'modified_date'] <- 'Modified Date'
    names(df)[names(df) == 'modified_by'] <- 'Modified By'

    # With algorithms, we'll replace the enabled [0, 1] with [No, Yes]
    df$enabled <- str_replace(df$enabled, "0", "No")
    df$enabled <- str_replace(df$enabled, "1", "Yes")
    df$enabled_for_testing <- str_replace(df$enabled_for_testing, "0", "No")
    df$enabled_for_testing <- str_replace(df$enabled_for_testing, "1", "Yes")

    # Rename the remaining columns
    names(df)[names(df) == 'enabled'] <- 'Active Algorithm'
    names(df)[names(df) == 'enabled_for_testing'] <- 'Enabled for Sensitivity Testing'

    # Drop the algorithm_id, dataset_id_left, and dataset_id_right value
    df <- subset(df, select = -c(algorithm_id, dataset_id_left, dataset_id_right, published, archived))

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
                                                  WHERE dataset_id_left = ? AND dataset_id_right = ? AND algorithm_name = ? AND archived = 0;')
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
    new_entry_query <- paste("INSERT INTO linkage_algorithms (dataset_id_left, dataset_id_right, algorithm_name, modified_date, modified_by, enabled, enabled_for_testing, archived, published)",
                             "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?);")
    new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
    dbBind(new_entry, list(left_dataset_id, right_dataset_id, algorithm_name, modified_date, modified_by, 0, 1, 0, 0))
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
    query <- paste('SELECT * FROM linkage_algorithms
                    WHERE dataset_id_left =', left_dataset_id, ' AND dataset_id_right =', right_dataset_id,
                   'AND archived = 0 AND published = 0',
                   'ORDER BY algorithm_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

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
                                                  WHERE dataset_id_left = ? AND dataset_id_right = ? AND algorithm_name = ? AND algorithm_id != ? AND archived = 0;')
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
    query <- paste('SELECT * FROM linkage_algorithms
                    WHERE dataset_id_left =', left_dataset_id, ' AND dataset_id_right =', right_dataset_id,
                   'AND archived = 0 AND published = 0',
                   'ORDER BY algorithm_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

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
        showNotification("Failed to Set Algorithm as Default - Algorithm with the same name is already enabled", type = "error", closeButton = FALSE)
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
      showNotification("Algorithm Successfully Removed from being the Default Linkage Algorithm", type = "message", closeButton = FALSE)
    }else{
      showNotification("Algorithm Successfully Set as the Default Linkage Algorithm", type = "message", closeButton = FALSE)
    }
    #----#
  })

  # Toggle the selected linkage algorithm to be used for testing
  observeEvent(input$toggle_algorithm_for_testing, {
    # Get the row that we're supposed to be toggling
    #----#
    left_dataset_id  <- input$linkage_algorithm_left_dataset
    right_dataset_id <- input$linkage_algorithm_right_dataset
    selected_row     <- input$currently_added_linkage_algorithms_rows_selected
    query <- paste('SELECT * FROM linkage_algorithms
                    WHERE dataset_id_left =', left_dataset_id, ' AND dataset_id_right =', right_dataset_id,
                   'AND archived = 0 AND published = 0',
                   'ORDER BY algorithm_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    algorithm_id <- df[selected_row, "algorithm_id"]
    algorithm_name <- df[selected_row, "algorithm_name"]
    enabled_value <- df[selected_row, "enabled_for_testing"]
    #----#

    # Create a query for updating the enabled value of the record
    #----#
    if(enabled_value == 1){
      update_query <- paste("UPDATE linkage_algorithms
                          SET enabled_for_testing = 0
                          WHERE algorithm_id = ?")
      update <- dbSendStatement(linkage_metadata_conn, update_query)
      dbBind(update, list(algorithm_id))
      dbClearResult(update)
    }else{
      # Error handling - don't allow user to have two algorithms enabled with the same name
      #----#
      get_query <- dbSendQuery(linkage_metadata_conn, 'SELECT * FROM linkage_algorithms WHERE algorithm_name = ? AND enabled_for_testing = 1;')
      dbBind(get_query, list(algorithm_name))
      output_df <- dbFetch(get_query)
      enabled_databases <- nrow(output_df)
      dbClearResult(get_query)

      if(is.na(enabled_databases) || is.null(enabled_databases) || enabled_databases != 0){
        showNotification("Failed to Enabled Algorithm for Testing - Algorithm with the same name is already enabled", type = "error", closeButton = FALSE)
        return()
      }
      #----#

      # Set the selected algorithm ID to be enabled
      update_query <- paste("UPDATE linkage_algorithms
                          SET enabled_for_testing = 1
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
      showNotification("Algorithm Successfully Disabled from Testing", type = "message", closeButton = FALSE)
    }else{
      showNotification("Algorithm Successfully Enabled for Testing", type = "message", closeButton = FALSE)
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
                                               'AND archived = 0 AND published = 0',
                                               'ORDER BY algorithm_id ASC;'))

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
                                               'AND archived = 0 AND published = 0',
                                               'ORDER BY algorithm_id ASC;'))

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

    # Clear the selected rows
    selected_rows_audit$selected <- NULL

    # Show the iterations page
    nav_show('main_navbar', 'audits_page')
    updateNavbarPage(session, "main_navbar", selected = "audits_page")
  })

  # View and edit the algorithm output fields
  observeEvent(input$linkage_algorithms_to_algorithm_output, {
    # Get the selected row
    left_dataset_id  <- input$linkage_algorithm_left_dataset
    right_dataset_id <- input$linkage_algorithm_right_dataset
    selected_row     <- input$currently_added_linkage_algorithms_rows_selected
    df <- dbGetQuery(linkage_metadata_conn, paste('SELECT * from linkage_algorithms
                                                WHERE dataset_id_left =', left_dataset_id, 'AND dataset_id_right =', right_dataset_id,
                                               'AND archived = 0 AND published = 0',
                                               'ORDER BY algorithm_id ASC;'))

    # Grab the algorithm id
    algorithm_id <- df[selected_row, "algorithm_id"]

    # Update the global variable for the acceptance method id and the return page
    algorithm_output_fields_algorithm_id <<- algorithm_id
    algorithm_output_fields_dataset_id   <<- left_dataset_id
    algorithm_output_fields_return_page  <<- "linkage_algorithms_page"

    # Update the table of iterations on that page
    output$currently_added_algorithm_output_fields <- renderDataTable({
      get_algorithm_output_fields()
    })
    updateSelectInput(session, "linkage_algorithm_output_field_type", selected = 2)
    updateSelectInput(session, "linkage_algorithm_output_field_type", selected = 1)

    # Update the available previous algorithms output fields table
    output$usable_previous_algorithm_outputs <- renderUI({
      # Perform query using linkage_metadata_conn
      query_result <- dbGetQuery(linkage_metadata_conn, paste("SELECT * from linkage_algorithms WHERE dataset_id_left =", left_dataset_id,
                                                              "AND dataset_id_right =", right_dataset_id,
                                                              "AND algorithm_id !=", algorithm_id))

      # Extract columns from query result
      choices <- setNames(query_result$algorithm_id, query_result$algorithm_name)

      # Create select input with dynamic choices
      span(selectizeInput("previous_algorithm_output_ids", label = "Algorithm's Output Fields to Use:",
        choices = choices, multiple = FALSE, width = validateCssUnit(500),
        options = list(
          placeholder = "Select the Previously Used Algorithm's Output Fields",
          onInitialize = I('function() { this.setValue(""); }')
        )))
    })

    # Show the iterations page
    nav_show('main_navbar', 'linkage_algorithm_output_page')
    updateNavbarPage(session, "main_navbar", selected = "linkage_algorithm_output_page")
  })

  # Run algorithm button
  observeEvent(input$run_default_algorithm, {
    # Get the selected row
    left_dataset_id  <- input$linkage_algorithm_left_dataset
    right_dataset_id <- input$linkage_algorithm_right_dataset

    # Update global variables
    run_algorithm_left_dataset_id  <<- left_dataset_id
    run_algorithm_right_dataset_id <<- right_dataset_id
    run_algorithm_return_page      <<- "linkage_algorithms_page"

    # Re-render data table
    output$select_linkage_algorithms_to_run <- renderDataTable({
      get_linkage_algorithms_to_run()
    })

    # Clear the selected rows
    selected_rows_run$selected <- NULL

    # Update the return button'
    updateActionButton(session, "run_algorithm_back", label = "Return to View Algorithms Page", icon = shiny::icon("arrow-left-long"))

    # Show the iterations page
    nav_show('main_navbar', 'run_algorithm_page')
    updateNavbarPage(session, "main_navbar", selected = "run_algorithm_page")
  })

  # Run algorithm button (ALT)
  observeEvent(input$run_algorithm_alt, {
    # Get the selected row
    left_dataset_id  <- input$linkage_algorithm_left_dataset
    right_dataset_id <- input$linkage_algorithm_right_dataset

    # Update global variables
    run_algorithm_left_dataset_id  <<- left_dataset_id
    run_algorithm_right_dataset_id <<- right_dataset_id
    run_algorithm_return_page      <<- "linkage_algorithms_page"

    # Re-render data table
    output$select_linkage_algorithms_to_run <- renderDataTable({
      get_linkage_algorithms_to_run()
    })

    # Clear the selected rows
    selected_rows_run$selected <- NULL

    # Update the return button'
    updateActionButton(session, "run_algorithm_back", label = "Return to View Algorithms Page", icon = shiny::icon("arrow-left-long"))

    # Show the iterations page
    nav_show('main_navbar', 'run_algorithm_page')
    updateNavbarPage(session, "main_navbar", selected = "run_algorithm_page")
  })

  # Move to the "Regenerate Report Page"
  observeEvent(input$go_to_regenerate_report, {
    # Get the row that we're supposed to be toggling
    #----#
    left_dataset_id  <- input$linkage_algorithm_left_dataset
    right_dataset_id <- input$linkage_algorithm_right_dataset
    selected_row     <- input$currently_added_linkage_algorithms_rows_selected
    df <- dbGetQuery(linkage_metadata_conn, paste('SELECT * from linkage_algorithms
                                                WHERE dataset_id_left =', left_dataset_id, 'AND dataset_id_right =', right_dataset_id,
                                               'AND archived = 0 AND published = 0',
                                               'ORDER BY algorithm_id ASC;'))

    algorithm_id <- df$algorithm_id[selected_row]
    #----#

    # Set global variables
    #----#
    algorithm_ids_to_regenerate        <<- c(algorithm_id)
    regenerate_report_left_dataset_id  <<- left_dataset_id
    regenerate_report_right_dataset_id <<- right_dataset_id
    regenerate_report_return_page      <<- "linkage_algorithms_page"
    #----#

    # Re-render some tables
    #----#
    output$select_saved_data_to_regenerate <- renderDataTable({
      get_data_to_regenerate()
    })
    #----#

    # Switch pages
    #----#
    nav_show('main_navbar', 'regenerate_report_page')
    updateNavbarPage(session, "main_navbar", selected = "regenerate_report_page")
    #----#
  })

  # Pop-up for confirming if you'd like to archive the algorithm
  observeEvent(input$archive_algorithm, {
    showModal(modalDialog(
      title="Are You Sure That You Want To Archive The Selected Algorithm?",
      easyClose = T,
      footer = NULL,
      fluidPage(
        fluidRow(
          column(width = 6, div(style = "display: flex; justify-content: right; align-items: center;",
              actionButton("archive_algorithm_confirm", "Yes", class = "btn-danger", width = validateCssUnit(200), icon = shiny::icon("check")),
            )
          ),
          column(width = 6, div(style = "display: flex; justify-content: left; align-items: center;",
              actionButton("archive_algorithm_cancel", "No", width = validateCssUnit(200), icon = shiny::icon("xmark")),
            )
          )
        )
      ),
      size = "s"
    ))

    # If the user says no, then remove the modal
    observeEvent(input$archive_algorithm_cancel, {
      removeModal()
    })
  })

  # Archive the selected algorithm
  observeEvent(input$archive_algorithm_confirm, {
    # Remove the dialog modal
    removeModal()

    # Get the row that we're supposed to be toggling
    #----#
    left_dataset_id  <- input$linkage_algorithm_left_dataset
    right_dataset_id <- input$linkage_algorithm_right_dataset
    selected_row     <- input$currently_added_linkage_algorithms_rows_selected
    query <- paste('SELECT * FROM linkage_algorithms
                    WHERE dataset_id_left =', left_dataset_id, ' AND dataset_id_right =', right_dataset_id,
                   'AND archived = 0 AND published = 0',
                   'ORDER BY algorithm_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    algorithm_id <- df[selected_row, "algorithm_id"]
    #----#

    # Create a query for updating the enabled value of the record
    #----#
    update_query <- paste("UPDATE linkage_algorithms
                        SET archived = 1
                        WHERE algorithm_id = ?")
    update <- dbSendStatement(linkage_metadata_conn, update_query)
    dbBind(update, list(algorithm_id))
    dbClearResult(update)
    #----#

    # Re-render data tables and reset UI
    #----#
    output$currently_added_linkage_algorithms <- renderDataTable({
      get_linkage_algorithms()
    })
    #----#

    # Send a success notification
    #----#
    showNotification("Algorithm Successfully Archived", type = "message", closeButton = FALSE)
    #----#
  })

  # Pop-up for confirming if you'd like to publish the algorithm
  observeEvent(input$publish_algorithm, {
    showModal(modalDialog(
      title="Are You Sure That You Want To Publish The Selected Algorithm?",
      easyClose = T,
      footer = NULL,
      fluidPage(
        fluidRow(
          column(width = 6, div(style = "display: flex; justify-content: right; align-items: center;",
              actionButton("publish_algorithm_confirm", "Yes", class = "btn-success", width = validateCssUnit(200), icon = shiny::icon("check")),
            )
          ),
          column(width = 6, div(style = "display: flex; justify-content: left; align-items: center;",
              actionButton("publish_algorithm_cancel", "No", width = validateCssUnit(200), icon = shiny::icon("xmark")),
            )
          )
        )
      ),
      size = "s"
    ))

    # If the user says no, then remove the modal
    observeEvent(input$publish_algorithm_cancel, {
      removeModal()
    })
  })

  # Publish the selected algorithm after confirming
  observeEvent(input$publish_algorithm_confirm, {
    # Remove the dialog modal
    removeModal()

    # Get the row that we're supposed to be toggling
    #----#
    left_dataset_id  <- input$linkage_algorithm_left_dataset
    right_dataset_id <- input$linkage_algorithm_right_dataset
    selected_row     <- input$currently_added_linkage_algorithms_rows_selected
    query <- paste('SELECT * FROM linkage_algorithms
                    WHERE dataset_id_left =', left_dataset_id, ' AND dataset_id_right =', right_dataset_id,
                   'AND archived = 0 AND published = 0',
                   'ORDER BY algorithm_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    algorithm_id <- df[selected_row, "algorithm_id"]
    #----#

    # Create a query for updating the enabled value of the record
    #----#
    update_query <- paste("UPDATE linkage_algorithms
                        SET published = 1
                        WHERE algorithm_id = ?")
    update <- dbSendStatement(linkage_metadata_conn, update_query)
    dbBind(update, list(algorithm_id))
    dbClearResult(update)
    #----#

    # Re-render data tables and reset UI
    #----#
    output$currently_added_linkage_algorithms <- renderDataTable({
      get_linkage_algorithms()
    })
    #----#

    # Send a success notification
    #----#
    showNotification("Algorithm Successfully Published", type = "message", closeButton = FALSE)
    #----#
  })

  # Move to the "Archived Algorithms Page"
  observeEvent(input$move_to_archived_algorithms, {
    # Get the row that we're supposed to be toggling
    #----#
    left_dataset_id  <- input$linkage_algorithm_left_dataset
    right_dataset_id <- input$linkage_algorithm_right_dataset
    #----#

    # Set global variables
    #----#
    archived_algorithms_left_dataset_id  <<- left_dataset_id
    archived_algorithms_right_dataset_id <<- right_dataset_id
    archived_algorithms_return_page      <<- "linkage_algorithms_page"
    #----#

    # Render tables
    #----#
    output$archived_linkage_algorithms <- renderDataTable({
      get_archived_linkage_algorithms()
    })
    #----#

    # Switch pages
    #----#
    nav_show('main_navbar', 'archived_linkage_algorithms_page')
    updateNavbarPage(session, "main_navbar", selected = "archived_linkage_algorithms_page")
    #----#
  })

  # Move to the "Published Algorithms Page"
  observeEvent(input$move_to_published_algorithms, {
    # Get the row that we're supposed to be toggling
    #----#
    left_dataset_id  <- input$linkage_algorithm_left_dataset
    right_dataset_id <- input$linkage_algorithm_right_dataset
    #----#

    # Set global variables
    #----#
    published_algorithms_left_dataset_id  <<- left_dataset_id
    published_algorithms_right_dataset_id <<- right_dataset_id
    published_algorithms_return_page      <<- "linkage_algorithms_page"
    #----#

    # Render tables
    #----#
    output$published_linkage_algorithms <- renderDataTable({
      get_published_linkage_algorithms()
    })
    #----#

    # Switch pages
    #----#
    nav_show('main_navbar', 'published_linkage_algorithms_page')
    updateNavbarPage(session, "main_navbar", selected = "published_linkage_algorithms_page")
    #----#
  })
  #----
  #------------------------------------#

  # Show the next loading screen
  hideElement("loading_screen_5")
  showElement("loading_screen_6")

  #-- ARCHIVED LINKAGE ALGORITHMS PAGE EVENTS --#
  #----
  # Set up global variables for this page
  archived_algorithms_left_dataset_id  <- 0
  archived_algorithms_right_dataset_id <- 0
  archived_algorithms_return_page      <- "linkage_algorithms_page"

  # Back button will bring you back to whichever page you came from
  observeEvent(input$archived_linkage_algorithms_back, {
    # Show return to the page you came from
    updateNavbarPage(session, "main_navbar", selected = archived_algorithms_return_page)
  })

  # Query and output for getting the selected linkage algorithms
  get_archived_linkage_algorithms <- function(){
    left_dataset_id  <- archived_algorithms_left_dataset_id
    right_dataset_id <- archived_algorithms_right_dataset_id

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
                   'AND archived = 1 AND published = 0',
                   'ORDER BY algorithm_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    # With our data frame, we'll rename some of the columns to look better
    names(df)[names(df) == 'algorithm_name'] <- 'Algorithm Name'
    names(df)[names(df) == 'modified_date'] <- 'Modified Date'
    names(df)[names(df) == 'modified_by'] <- 'Modified By'

    # Drop the algorithm_id, dataset_id_left, and dataset_id_right value
    df <- subset(df, select = -c(algorithm_id, dataset_id_left, dataset_id_right, published,
                                 archived, enabled, enabled_for_testing))

    # Put it into a data table now
    dt <- datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE))
  }

  # Render the data table for all archived linkage algorithms of the desired 2 datasets
  output$archived_linkage_algorithms <- renderDataTable({
    get_archived_linkage_algorithms()
  })

  # Observes which row the user selected and shows the selected algorithms info
  observeEvent(input$archived_linkage_algorithms_rows_selected, {
    # Get the selected row
    selected_row <- input$archived_linkage_algorithms_rows_selected

    # Make sure the row is not null
    if(is.null(selected_row)) return()

    # If not null, get the selected algorithm ID
    query <- paste('SELECT * FROM linkage_algorithms
                    WHERE dataset_id_left =', archived_algorithms_left_dataset_id, ' AND dataset_id_right =', archived_algorithms_right_dataset_id,
                   'AND archived = 1 AND published = 0',
                   'ORDER BY algorithm_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)
    algorithm_id <- df[selected_row, "algorithm_id"]

    # Render the table
    output$archived_linkage_algorithms_details <- renderDataTable({
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
          matching_left_fields = character(),
          standardization_file_id = numeric()
        )
      }

      # With our data frame, we'll rename some of the columns to look better
      names(df)[names(df) == 'iteration_name'] <- 'Iteration Name'
      names(df)[names(df) == 'iteration_num'] <- 'Iteration Order'
      names(df)[names(df) == 'linkage_method_id'] <- 'Linkage Method'
      names(df)[names(df) == 'acceptance_rule_id'] <- 'Acceptance Rules'
      names(df)[names(df) == 'blocking_left_fields'] <- 'Blocking Keys'
      names(df)[names(df) == 'matching_left_fields'] <- 'Matching Keys'

      # Drop the algorithm_id, dataset_id_left, and dataset_id_right value
      df <- subset(df, select = -c(algorithm_id, iteration_id, standardization_file_id, modified_date, modified_by, enabled))

      # Reorder the columns so that 'Blocking Keys' and 'Matching Keys' come after 'Linkage Method'
      df <- df[, c('Iteration Name', 'Iteration Order', 'Linkage Method', 'Blocking Keys', 'Matching Keys',
                   'Acceptance Rules')]

      # Put it into a data table now
      dt <- datatable(df, selection = 'none', rownames = FALSE, options = list(lengthChange = FALSE, dom = 'tp'))
    })
  })

  # Allow for un-archiving the selected algorithm
  observeEvent(input$restore_linkage_algorithm, {
    # Get the row that we're supposed to be toggling
    #----#
    left_dataset_id  <- archived_algorithms_left_dataset_id
    right_dataset_id <- archived_algorithms_right_dataset_id
    selected_row     <- input$archived_linkage_algorithms_rows_selected
    query <- paste('SELECT * FROM linkage_algorithms
                    WHERE dataset_id_left =', left_dataset_id, ' AND dataset_id_right =', right_dataset_id,
                   'AND archived = 1 AND published = 0',
                   'ORDER BY algorithm_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    algorithm_id <- df[selected_row, "algorithm_id"]
    algorithm_name <- df[selected_row, "algorithm_name"]
    #----#

    # Error handling - don't allow user to have two algorithms enabled with the same name
    #----#
    get_query <- dbSendQuery(linkage_metadata_conn, 'SELECT * FROM linkage_algorithms WHERE algorithm_name = ? AND archived = 0 AND published = 0;')
    dbBind(get_query, list(algorithm_name))
    output_df <- dbFetch(get_query)
    enabled_databases <- nrow(output_df)
    dbClearResult(get_query)

    if(is.na(enabled_databases) || is.null(enabled_databases) || enabled_databases != 0){
      showNotification("Failed to Restore Algorithm - Algorithm Name is Being Used by a Testing Algorithm", type = "error", closeButton = FALSE)
      return()
    }
    #----#

    # Set the selected algorithm ID to be enabled
    update_query <- paste("UPDATE linkage_algorithms
                        SET archived = 0
                        WHERE algorithm_id = ?")
    update <- dbSendStatement(linkage_metadata_conn, update_query)
    dbBind(update, list(algorithm_id))
    dbClearResult(update)
    #----#

    # Re-render data tables and reset UI
    #----#
    output$archived_linkage_algorithms <- renderDataTable({
      get_archived_linkage_algorithms()
    })
    output$currently_added_linkage_algorithms <- renderDataTable({
      get_linkage_algorithms()
    })
    #----#

    # Send a success notification
    #----#
    showNotification("Algorithm Successfully Restored", type = "message", closeButton = FALSE)
    #----#
  })
  #----
  #---------------------------------------------#

  # Show the next loading screen
  hideElement("loading_screen_6")
  showElement("loading_screen_7")

  #-- PUBLISHED LINKAGE ALGORITHMS PAGE EVENTS --#
  #----
  published_algorithms_left_dataset_id  <- 0
  published_algorithms_right_dataset_id <- 0
  published_algorithms_return_page      <- "linkage_algorithms_page"

  # Get the computer volumes
  volumes <- getVolumes()()

  # Linkage Output Directory Chooser
  shinyDirChoose(input, 'published_algorithms_output_dir', roots=volumes, filetypes=c('', 'txt'), allowDirCreate = F)

  # Output text box for the selected output directory
  output$selected_published_algorithms_output_dir <- renderText({
    "No Folder Has Been Chosen"
  })

  # Observes which published linkage output directory was chosen
  observeEvent(input$published_algorithms_output_dir, {
    # Get the output linkage directory
    output_dir <- parseDirPath(volumes, input$published_algorithms_output_dir)

    # Render the output text
    if(identical(output_dir, character(0))){
      output$selected_published_algorithms_output_dir <- renderText({
        "No Folder Has Been Chosen"
      })
    }
    else{
      output$selected_published_algorithms_output_dir <- renderText({
        output_dir
      })
    }
  })

  # Back button will bring you back to whichever page you came from
  observeEvent(input$published_linkage_algorithms_back, {
    # Show return to the page you came from
    updateNavbarPage(session, "main_navbar", selected = published_algorithms_return_page)
  })

  # Query and output for getting the selected linkage algorithms
  get_published_linkage_algorithms <- function(){
    left_dataset_id  <- published_algorithms_left_dataset_id
    right_dataset_id <- published_algorithms_right_dataset_id

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
                   'AND archived = 0 AND published = 1',
                   'ORDER BY algorithm_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    # With our data frame, we'll rename some of the columns to look better
    names(df)[names(df) == 'algorithm_name'] <- 'Algorithm Name'
    names(df)[names(df) == 'modified_date'] <- 'Modified Date'
    names(df)[names(df) == 'modified_by'] <- 'Modified By'

    # Drop the algorithm_id, dataset_id_left, and dataset_id_right value
    df <- subset(df, select = -c(algorithm_id, dataset_id_left, dataset_id_right, published,
                                 archived, enabled, enabled_for_testing))

    # Put it into a data table now
    dt <- datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE))
  }

  # Render the data table for all published linkage algorithms of the desired 2 datasets
  output$published_linkage_algorithms <- renderDataTable({
    get_published_linkage_algorithms()
  })

  # Observes which row the user selected and shows the selected algorithms info
  observeEvent(input$published_linkage_algorithms_rows_selected, {
    # Get the selected row
    selected_row <- input$published_linkage_algorithms_rows_selected

    # Make sure the row is not null
    if(is.null(selected_row)) return()

    # If not null, get the selected algorithm ID
    query <- paste('SELECT * FROM linkage_algorithms
                    WHERE dataset_id_left =', published_algorithms_left_dataset_id, ' AND dataset_id_right =', published_algorithms_right_dataset_id,
                   'AND archived = 0 AND published = 1',
                   'ORDER BY algorithm_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)
    algorithm_id <- df[selected_row, "algorithm_id"]

    # Render the table
    output$published_linkage_algorithms_details <- renderDataTable({
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
          matching_left_fields = character(),
          standardization_file_id = numeric()
        )
      }

      # With our data frame, we'll rename some of the columns to look better
      names(df)[names(df) == 'iteration_name'] <- 'Iteration Name'
      names(df)[names(df) == 'iteration_num'] <- 'Iteration Order'
      names(df)[names(df) == 'linkage_method_id'] <- 'Linkage Method'
      names(df)[names(df) == 'acceptance_rule_id'] <- 'Acceptance Rules'
      names(df)[names(df) == 'blocking_left_fields'] <- 'Blocking Keys'
      names(df)[names(df) == 'matching_left_fields'] <- 'Matching Keys'

      # Drop the algorithm_id, dataset_id_left, and dataset_id_right value
      df <- subset(df, select = -c(algorithm_id, iteration_id, standardization_file_id, modified_date, modified_by, enabled))

      # Reorder the columns so that 'Blocking Keys' and 'Matching Keys' come after 'Linkage Method'
      df <- df[, c('Iteration Name', 'Iteration Order', 'Linkage Method', 'Blocking Keys', 'Matching Keys',
                   'Acceptance Rules')]

      # Put it into a data table now
      dt <- datatable(df, selection = 'none', rownames = FALSE, options = list(lengthChange = FALSE, dom = 'tp'))
    })
  })

  # Allow for un-publishing the selected algorithm
  observeEvent(input$unpublish_linkage_algorithm, {
    # Get the row that we're supposed to be toggling
    #----#
    left_dataset_id  <- published_algorithms_left_dataset_id
    right_dataset_id <- published_algorithms_right_dataset_id
    selected_row     <- input$published_linkage_algorithms_rows_selected
    query <- paste('SELECT * FROM linkage_algorithms
                    WHERE dataset_id_left =', left_dataset_id, ' AND dataset_id_right =', right_dataset_id,
                   'AND archived = 0 AND published = 1',
                   'ORDER BY algorithm_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    algorithm_id <- df[selected_row, "algorithm_id"]
    algorithm_name <- df[selected_row, "algorithm_name"]
    #----#

    # Error handling - don't allow user to have two algorithms enabled with the same name
    #----#
    get_query <- dbSendQuery(linkage_metadata_conn, 'SELECT * FROM linkage_algorithms WHERE algorithm_name = ? AND archived = 0 AND published = 0;')
    dbBind(get_query, list(algorithm_name))
    output_df <- dbFetch(get_query)
    enabled_databases <- nrow(output_df)
    dbClearResult(get_query)

    if(is.na(enabled_databases) || is.null(enabled_databases) || enabled_databases != 0){
      showNotification("Failed to Unpublish Algorithm - Algorithm Name is Being Used by a Testing Algorithm", type = "error", closeButton = FALSE)
      return()
    }
    #----#

    # Set the selected algorithm ID to be enabled
    update_query <- paste("UPDATE linkage_algorithms
                        SET published = 0
                        WHERE algorithm_id = ?")
    update <- dbSendStatement(linkage_metadata_conn, update_query)
    dbBind(update, list(algorithm_id))
    dbClearResult(update)
    #----#

    # Re-render data tables and reset UI
    #----#
    output$published_linkage_algorithms <- renderDataTable({
      get_published_linkage_algorithms()
    })
    output$currently_added_linkage_algorithms <- renderDataTable({
      get_linkage_algorithms()
    })
    #----#

    # Send a success notification
    #----#
    showNotification("Algorithm Successfully Unpublished", type = "message", closeButton = FALSE)
    #----#
  })

  # Run and save all published algorithms
  observeEvent(input$run_published_linkage_algorithms, {
    # Disable this button
    disable("run_published_linkage_algorithms")

    # Use `withProgress` to display and update the progress bar
    successful <- withProgress(message = "Running Published Linkage Algorithms...", value = 0, {

      # Define progress callback function
      progress_callback <- function(progress_value, message = NULL) {
        incProgress(progress_value, message)
      }

      # Set the initial progress
      incProgress(0)

      # Get the folder and file inputs
      output_dir <- parseDirPath(volumes, input$published_algorithms_output_dir)

      # Get the algorithm IDs of all published algorithms
      query <- paste('SELECT * FROM linkage_algorithms
                      WHERE dataset_id_left =', published_algorithms_left_dataset_id, ' AND dataset_id_right =', published_algorithms_right_dataset_id,
                     'AND published = 1',
                     'ORDER BY algorithm_id ASC;')
      df <- dbGetQuery(linkage_metadata_conn, query)
      algorithm_ids  <- df$algorithm_id

      #-- Error Handling --#
      # We need to make sure the user supplied an output folder
      if(identical(output_dir, character(0))){
        showNotification("Failed to Run Published Algorithms - Missing Output Folder", type = "error", closeButton = FALSE)
        return(FALSE)
      }
      # Make sure at least one algorithm was selected
      if(length(algorithm_ids) <= 0){
        showNotification("Failed to Run Published Algorithms - No Algorithms are Currently Published", type = "error", closeButton = FALSE)
        return(FALSE)
      }
      #--------------------#

      # Get the parameters that will be passed to the linkage function
      left_dataset   <- dbGetQuery(linkage_metadata_conn, paste0('SELECT * FROM datasets WHERE dataset_id = ', published_algorithms_left_dataset_id))$dataset_location
      right_dataset  <- dbGetQuery(linkage_metadata_conn, paste0('SELECT * FROM datasets WHERE dataset_id = ', published_algorithms_right_dataset_id))$dataset_location
      link_metadata  <- metadata_file_path
      extra_params   <- create_extra_parameters_list(linkage_output_folder = output_dir, include_unlinked_records = T, data_linker = username,
                                                     save_all_linkage_results = T, collect_missing_data_indicators = T)

      # Run the algorithms
      try_catch_success <- TRUE
      tryCatch({
        # Run the linkage algorithms
        results <- run_main_linkage(left_dataset, right_dataset, link_metadata, algorithm_ids, extra_params, progress_callback)

        # Save the data from the results
        linked_data_list                     <- results[["linked_data"]]
        algorithm_ids                        <- results[["linked_algorithm_ids"]]
        linked_data_algorithm_names          <- results[["linked_algorithm_names"]]
        linkage_algorithm_summary_list       <- results[["algorithm_summaries"]]
        linkage_algorithm_footnote_list      <- results[["algorithm_footnotes"]]
        intermediate_performance_measures_df <- results[["performance_measures"]]
        intermediate_missing_indicators_df   <- results[["missing_data_indicators"]]

        # We will go through each of the algorithm IDs and save the data to an .Rdata file that can be used later
        for(index in 1:length(algorithm_ids)){
          # Get the current information for this algorithm
          linked_data    <- linked_data_list[[index]]
          algorithm_id   <- algorithm_ids[index]
          algorithm_name <- linked_data_algorithm_names[index]
          algorithm_summ <- linkage_algorithm_summary_list[[index]]
          algorithm_foot <- linkage_algorithm_footnote_list[[index]]
          performance_df <- as.data.frame(intermediate_performance_measures_df[intermediate_performance_measures_df$algorithm_name == algorithm_name, ])

          # Format the timestamp to avoid invalid characters
          timestamp <- format(Sys.time(), "%Y-%m-%d %Hh-%Mm-%Ss")

          # Construct the file name and path
          file_name <- paste0(algorithm_name, " [", algorithm_id, "] (", timestamp, ").RData")
          file_path <- file.path(output_dir, file_name)

          # Save the data for this algorithm
          save(linked_data, algorithm_id, algorithm_name, algorithm_summ,
               algorithm_foot, performance_df, intermediate_missing_indicators_df, file=file_path)
        }
      },
      error = function(e){
        # If we fail, let the user know why
        try_catch_success <<- FALSE
        showNotification(paste0("Linkage Failed - ", geterrmessage()), type = "error", closeButton = FALSE)
        return()
      })

      # If we failed the try catch, then let the user know
      if(try_catch_success != TRUE) return(FALSE)

      # Finalize progress
      incProgress(1, detail = "Linkage completed.")

      # Return true
      return(TRUE)
    })

    # Check if we were successful, otherwise return
    if(successful != TRUE){
      Sys.sleep(2)
      enable("run_published_linkage_algorithms")
      return()
    }

    # If we succeed, let the user know where they can find their information
    showNotification(paste0("Published Linkage Succeeded - Check the Output Folder for RData Files"), type = "message", closeButton = FALSE)

    # Call garbage collector after we finish processing
    gc()
    Sys.sleep(2)

    enable("run_published_linkage_algorithms")
    return()
  })
  #----
  #----------------------------------------------#

  # Show the next loading screen
  hideElement("loading_screen_7")
  showElement("loading_screen_8")

  #-- VIEW/EXPORT LINKAGE AUDITS PAGE EVENTS --#
  #----
  # Global variables for the linkage audits page
  linkage_audits_algorithm_id <- 1
  linkage_audits_return_page  <- "linkage_algorithms_page"

  # Reactive values to track selected rows
  selected_rows_audit <- reactiveValues(selected = NULL)

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
    names(audit_df)[names(audit_df) == 'audit_date']                <- 'Audit Date'
    names(audit_df)[names(audit_df) == 'performance_measures_json'] <- 'Performance Measures'
    names(audit_df)[names(audit_df) == 'audit_time']                <- 'Audit Time'

    # Reorder the columns
    audit_df <- audit_df[, c(1, 2, 4, 3)]

    # Put it into a data table now
    #dt <- datatable(audit_df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE))
    dt <- datatable(audit_df, selection = list(mode = "multiple", selected = selected_rows_audit$selected), rownames = FALSE, options = list(lengthChange = FALSE))
    return(dt)
  }

  # Handle 'Select All' button click
  observeEvent(input$select_all_audit, {
    # Update selected rows to include all rows
    selected_rows_audit$selected <- seq_len(nrow(get_audit_information()$x$data))
  })

  # Handle 'Select None' button click
  observeEvent(input$select_none_audit, {
    # Clear the selected rows
    selected_rows_audit$selected <- NULL
  })

  # Renders the table of audit information
  output$algorithm_specific_audits <- renderDataTable({
    get_audit_information()
  })

  # Observe Whenever the user selects a new data range and re-render the table
  observe({
    # If the user changes either the lower or upper date, re-render
    lower_date   <- input$audit_date_range[1]
    upper_date   <- input$audit_date_range[2]

    # Clear the selected rows
    selected_rows_audit$selected <- NULL

    # Re-render the audit table
    output$algorithm_specific_audits <- renderDataTable({
      get_audit_information()
    })
  })

  # Update `selected_rows_audit` when a row is clicked manually
  observe({
    selected_rows_audit$selected <- input$algorithm_specific_audits_rows_selected
  })

  # Render the UI output using 'lapply' to print out each list item
  output$selected_algorithm_performances_measures <- renderUI({
    # Convert the JSON to a data frame for manipulation
    performance_measures_list <- list()
    performance_measures_list[["Linkage Rate"]] <- ""
    performance_measures_list[["Time to Completion (s)"]] <- ""
    performance_measures_list[["PPV"]] <- ""
    performance_measures_list[["NPV"]] <- ""
    performance_measures_list[["Sensitivity"]] <- ""
    performance_measures_list[["Specificity"]] <- ""
    performance_measures_list[["F1 Score"]] <- ""
    performance_measures_list[["FDR"]] <- ""
    performance_measures_list[["FOR"]] <- ""

    # For each list value, add some 'help' text if it matches one of the name we expect
    performance_measures_help <- c()
    for(list_name in names(performance_measures_list)){
      # Value for the help text
      help_text <- ""

      # If the name is "Linkage Rate":
      if(list_name == "Linkage Rate"){
        help_text <- paste0("The Linkage Rate is the percentage (%) of source records that were successfully linked to the opposite dataset.")
      }
      # If the name is "Time to Completion":
      else if(list_name == "Time to Completion (s)"){
        help_text <- paste0("The time that all passes took to complete in seconds.")
      }
      # If the name is "PPV":
      else if(list_name == "PPV"){
        help_text <- paste0("Positive Predictive Value (PPV) is the proportion (%) of predicted positive matches that are truly positive.")
      }
      # If the name is "NPV":
      else if(list_name == "NPV"){
        help_text <- paste0("Negative Predictive Value (NPV) is the proportion (%) of predicted negative matches that are truly negative.")
      }
      # If the name is "Sensitivity":
      else if(list_name == "Sensitivity"){
        help_text <- paste0("Sensitivity is the proportion (%) of positive matches the algorithm correctly identified.")
      }
      # If the name is "Specificity":
      else if(list_name == "Specificity"){
        help_text <- paste0("Specificity is the proportion (%) of negative matches the algorithm correctly identified.")
      }
      # If the name is "F1 Score":
      else if(list_name == "F1 Score"){
        help_text <- paste0("The F1 Score is a summary measure (%) of the performance of the predicitive ability on the postitive class. ",
                            "It summarizes PPV and Sensitivity into a single number using a harmonic mean.")
      }
      # If the name is "FDR":
      else if(list_name == "FDR"){
        help_text <- paste0("False Discovery Rate (FDR) is the proportion (%) of incorrect links among all detected links.")
      }
      # If the name is "FOR":
      else if(list_name == "FOR"){
        help_text <- paste0("False Omission Rate (FOR) is the proportion (%) of missed correct links among all actual links.")
      }
      # Otherwise, no help text is needed
      else{
        help_text <- ""
      }

      # Append the help text
      performance_measures_help <- append(performance_measures_help, help_text)
    }

    # Generate the performance measures list and return it
    performance_measures_ui <- lapply(1:(length(performance_measures_list)), function(index){
      fluidRow(
        column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                               # Label for the performance value
                               div(style = "margin-right: 10px;", HTML(paste0("<b>", names(performance_measures_list[index]), "</b>")))
        )),
        # column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
        #   # Boxed text output for showing the uploaded file name
        #   div(style = "border: 1px solid #ccc; padding: 5px; background-color: #f9f9f9; width: 250px",
        #       paste0(performance_measures_list[[index]])
        #   )
        # )),
        column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                               # Help text for the performance measure
                               helpText(performance_measures_help[index], style = "width: 400px;")
        )),
        HTML("<br><br>")
      )
    })
  })

  # Observes when the user exports a selected audit
  observeEvent(input$export_selected_audit, {
    # Get the user input information (ID, date ranges)
    selected_rows <- input$algorithm_specific_audits_rows_selected
    algorithm_id  <- linkage_audits_algorithm_id
    lower_date    <- input$audit_date_range[1]
    upper_date    <- input$audit_date_range[2]

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
    algorithm_name <- get_algorithm_name(linkage_metadata_conn, algorithm_id)

    # Create a data frame of the data frame to export
    export_df <- data.frame()

    # For each of the selected rows, get and bind information by rows
    for(selected_row in selected_rows){
      # Get the performance measure information
      audit_by                  <- audit_df$audit_by[selected_row]
      audit_date                <- audit_df$audit_date[selected_row]
      audit_time                <- audit_df$audit_time[selected_row]
      performance_measures_json <- audit_df$performance_measures_json[selected_row]

      # Create a data frame which will contain the auditing information to export
      export_df_temp <- data.frame(matrix(ncol = 0, nrow = 1))

      # Add the date and author as columns
      export_df_temp[["Audited By"]]    <- audit_by
      export_df_temp[["Date of Audit"]] <- audit_date
      export_df_temp[["Time of Audit"]] <- audit_time

      # Convert the performance measures_json to a data frame
      performance_measures_df <- jsonlite::fromJSON(performance_measures_json, simplifyDataFrame = TRUE)

      # Bind the columns
      export_df_temp <- cbind(export_df_temp, performance_measures_df)

      # Bind the rows
      export_df <- bind_rows(export_df, export_df_temp)
    }

    # Get user input by requiring them to supply a directory for output
    output_dir <- choose.dir(getwd(), "Choose a Folder")

    # Two things can happen, if no directory is chosen, or NA happens, write it to the working directory, otherwise use user input
    if(!is.na(output_dir)){
      # Define base file name
      base_filename <- paste0(algorithm_name, ' Performance Measures (', format(Sys.time(), "%Y-%m-%d %Hh-%Mm-%Ss"), ')')

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

  # Show the next loading screen
  hideElement("loading_screen_8")
  showElement("loading_screen_9")

  #-- MODIFY GROUND TRUTH VARIABLES PAGE EVENTS --#
  #----
  modify_ground_truth_algorithm_id     <- 1
  modify_ground_truth_left_dataset_id  <- 1
  modify_ground_truth_right_dataset_id <- 1
  modify_ground_truth_return_page      <- "linkage_algorithms_page"

  # Some global variables for the linkage rule that needs to be added
  ground_truth_comparison_rule_to_add     <- NA

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
                WHERE gt.dataset_id_left =', modify_ground_truth_left_dataset_id, 'AND gt.dataset_id_right =', modify_ground_truth_right_dataset_id,
                   'ORDER BY gt.parameter_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    # Loop through each row in the dataframe to replace the linkage_rule_id with the method name and parameters
    for (i in 1:nrow(df)) {
      # Get the comparison_rule_id for the current row
      comparison_rule_id <- df$comparison_rule_id[i]
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
        df$comparison_rule_id[i] <- method_with_params
      }
    }

    # With our data frame, we'll rename some of the columns to look better
    names(df)[names(df) == 'right_field_name'] <- 'Right Dataset Field'
    names(df)[names(df) == 'left_field_name'] <- 'Left Dataset Field'
    names(df)[names(df) == 'comparison_rule_id'] <- 'Comparison Rules'

    # Drop the algorithm_id, parameter_id, and dataset field ID columns from the table
    df <- subset(df, select = -c(dataset_id_left, dataset_id_right, parameter_id, right_dataset_field_id, left_dataset_field_id))

    # Reorder the columns
    df <- df[, c('Right Dataset Field', 'Left Dataset Field', 'Comparison Rules')]

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

  ### COMPARISON RULE EVENTS ###
  #----#
  # Selecting an comparison rule for the iteration
  observeEvent(input$prepare_ground_truth_comparison_rule, {
    # Generates the table of acceptance methods
    output$add_comparison_method_ground_truth <- renderDataTable({
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
            dataTableOutput("add_comparison_method_ground_truth")
          ),

          # Card for the comparison rules UI
          card(card_header("Comparison Rule Inputs", class = "bg-dark"),
            uiOutput("ground_truth_comparison_rule_add_inputs")
          )
        ),

        # OPTION 1: User may enter a new comparison method & parameters
        conditionalPanel(
          condition = "input.add_comparison_method_ground_truth_rows_selected <= 0",
          HTML("<br>"),

          # Button for moving the user to the comparison methods page
          fluidRow(
            h5(strong("Or, create a new comparison method below:")),
            column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                actionButton("add_ground_truth_to_add_comparison_methods", "Create Comparison Method", class = "btn-info"),
              )
            ),
          )
        ),

        # OPTION 2: User can submit which comparison rule they'd like to use
        conditionalPanel(
          condition = "input.add_comparison_method_ground_truth_rows_selected > 0",
          HTML("<br>"),

          # Button for moving the user to the comparison rules page
          fluidRow(
            column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                actionButton("prepare_ground_truth_comparison_rule_to_add", "Add Comparison Rule", class = "btn-success"),
              )
            )
          )
        ),
      ),
      size = "l"  # Large modal size to fit both tables
    ))
  })

  # Generates the table of comparison methods
  output$add_comparison_method_ground_truth <- renderDataTable({
    get_comparison_methods_and_parameters()
  })

  # Generates the dynamic comparison rule inputs
  observeEvent(input$add_comparison_method_ground_truth_rows_selected, {
    selected_row <- input$add_comparison_method_ground_truth_rows_selected

    if (!is.null(selected_row)) {
      # Perform a query to get the comparison methods
      query <- paste('SELECT * from comparison_methods')
      df <- dbGetQuery(linkage_metadata_conn, query)
      # Retrieve the comparison method id of the selected row
      selected_method <- df$comparison_method_id[selected_row]

      output$ground_truth_comparison_rule_add_inputs <- renderUI({
        modify_iteration_get_comparison_rule_inputs(selected_method, "modify_ground_truth_comparison_rule_input")
      })
    }
    else{
      output$ground_truth_comparison_rule_add_inputs <- renderUI({

      })
    }
  })

  # Selects the comparison rule the user wanted
  observeEvent(input$prepare_ground_truth_comparison_rule_to_add, {
    # Get the selected row
    selected_row <- input$add_comparison_method_ground_truth_rows_selected

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
      input_val <- input[[paste0("modify_ground_truth_comparison_rule_input", index)]]
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
      parameter <- input[[paste0("modify_ground_truth_comparison_rule_input", index)]]

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
          parameter <- input[[paste0("modify_ground_truth_comparison_rule_input", index)]]

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
      output$selected_ground_truth_comparison_rule <- renderText({
        method_with_params
      })
    }

    # Set the global variable
    ground_truth_comparison_rule_to_add <<- comparison_rule_id

    # Dismiss the modal
    removeModal()
  })

  # Remove the comparison rule for this ground truth variable
  observeEvent(input$remove_ground_truth_comparison_rule, {
    # Set the global variable value to NA
    ground_truth_comparison_rule_to_add <<- NA

    # Render the text output to not include anything
    output$selected_ground_truth_comparison_rule <- renderText({
      " "
    })
  })

  # Brings the user to the comparison methods page
  observeEvent(input$add_ground_truth_to_add_comparison_methods, {

    # Set the return page to the add linkage iterations page
    comparison_methods_return_page <<- "ground_truth_variables_page"

    # Show the linkage rule page
    nav_show("main_navbar", "comparison_methods_page")

    # Brings you to the linkage rules page
    updateNavbarPage(session, "main_navbar", selected = "comparison_methods_page")
  })
  #----#

  ### ADD/DROP EVENTS ###
  #----#
  # Adds the provided ground truth fields + linkage rule into the database
  observeEvent(input$add_ground_truth, {
    algorithm_id           <- modify_ground_truth_algorithm_id
    left_dataset_field_id  <- input$left_ground_truth_field
    right_dataset_field_id <- input$right_ground_truth_field
    comparison_rule_id     <- ground_truth_comparison_rule_to_add

    # Error handling
    #----#
    # Make sure a left and right dataset was passed
    if(left_dataset_field_id == '' || right_dataset_field_id == ''){
      showNotification("Failed to Add Ground Truth Variables - Missing Ground Truth Field Input(s)", type = "error", closeButton = FALSE)
      return()
    }

    # Convert the left and right dataset ID to integers
    left_dataset_field_id  <- as.numeric(left_dataset_field_id)
    right_dataset_field_id <- as.numeric(right_dataset_field_id)

    # Make sure this ground truth variable isn't already being used
    get_query <- dbSendQuery(linkage_metadata_conn, 'SELECT * FROM ground_truth_variables
                                                  WHERE right_dataset_field_id = ? AND left_dataset_field_id = ? AND dataset_id_left = ? AND dataset_id_right = ?;')
    dbBind(get_query, list(right_dataset_field_id, left_dataset_field_id, modify_ground_truth_left_dataset_id, modify_ground_truth_right_dataset_id))
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
    new_entry_query <- paste("INSERT INTO ground_truth_variables (dataset_id_left, dataset_id_right, right_dataset_field_id, left_dataset_field_id, comparison_rule_id)",
                             "VALUES(?, ?, ?, ?, ?);")
    new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
    dbBind(new_entry, list(modify_ground_truth_left_dataset_id, modify_ground_truth_right_dataset_id, right_dataset_field_id, left_dataset_field_id, comparison_rule_id))
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
    output$selected_ground_truth_comparison_rule <- renderText({
      ""
    })
    ground_truth_comparison_rule_to_add <<- NA
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
                                                   WHERE dataset_id_left =', modify_ground_truth_left_dataset_id,
                                                  'AND dataset_id_right =', modify_ground_truth_right_dataset_id,
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

  # Show the next loading screen
  hideElement("loading_screen_9")
  showElement("loading_screen_10")

  #-- LINKAGE ALGORITHM OUTPUT FIELDS PAGE EVENTS --#
  #----
  # Reactive value for the standardization file path (ADD)
  standardization_file_path_algorithm_output <- reactiveValues(
    path=NULL
  )

  # Global variables
  algorithm_output_fields_algorithm_id <- 1
  algorithm_output_fields_dataset_id   <- 1
  algorithm_output_fields_return_page  <- "linkage_algorithms_page"

  # Back button will bring you back to whichever page you came from
  observeEvent(input$linkage_algorithm_output_back, {
    # Show return to the page you came from
    updateNavbarPage(session, "main_navbar", selected = algorithm_output_fields_return_page)
  })

  # Function for creating the table of the currently selected algorithms iterations
  get_algorithm_output_fields <- function(){
    algorithm_id <- algorithm_output_fields_algorithm_id

    # Query to get blocking variables with left and right dataset field names
    df <- dbGetQuery(linkage_metadata_conn, "
                    SELECT of.output_field_id, of.dataset_label, of.field_type, df.field_name, standardization_lookup_id
                    FROM output_fields of
                    JOIN output_field_parameters ofp ON of.output_field_id = ofp.output_field_id
                    JOIN dataset_fields df ON ofp.dataset_field_id = df.field_id
                    WHERE of.algorithm_id = ?
                    ORDER BY ofp.output_field_id ASC, ofp.parameter_id ASC", params = list(algorithm_id))

    # Group the data frame
    df <- df %>%
      group_by(output_field_id) %>%
      summarise(
        dataset_label = paste(unique(dataset_label), collapse = ", "),
        field_type = paste(unique(field_type), collapse = ", "),
        field_name = paste(unique(field_name), collapse = ", "),
        standardization_lookup_id = paste(unique(standardization_lookup_id), collapse = ", ")
      ) %>%
      ungroup()

    # Get the standardization file for each output field (if there is one)
    if(nrow(df) > 0){
      for(row_num in 1:nrow(df)){
        # Get the standardizing ID for this row
        standardizing_id <- suppressWarnings(as.numeric(df$standardization_lookup_id[row_num]))

        # If the ID is not NA, then get the label
        if(!is.na(standardizing_id) && !is.na(standardizing_id) && is.numeric(standardizing_id)){
          # Get the file label
          file_label <- dbGetQuery(linkage_metadata_conn, "SELECT * FROM name_standardization_files WHERE standardization_file_id = ?",
                                   params = list(standardizing_id))$standardization_file_label

          # Put the label back into the data frame
          df$standardization_lookup_id[row_num] <- file_label
        }
        else{
          df$standardization_lookup_id[row_num] <- ""
        }
      }
    }

    # Change the field type by replacing it with values
    df$field_type[df$field_type == 1]  <- 'General/Pass-Through'
    df$field_type[df$field_type == 2]  <- 'Date (Year)'
    df$field_type[df$field_type == 3]  <- 'Age'
    df$field_type[df$field_type == 4]  <- 'Postal Code Initials'
    df$field_type[df$field_type == 5]  <- 'Name Length'
    df$field_type[df$field_type == 6] <- 'Number of Names'
    df$field_type[df$field_type == 7]  <- 'Derived Age'
    df$field_type[df$field_type == 8] <- 'Standardized Values'
    df$field_type[df$field_type == 9] <- 'Forward Sortation Area (FSA)'

    # With our data frame, we'll rename some of the columns to look better
    names(df)[names(df) == 'field_name'] <- 'Field Source Name(s)'
    names(df)[names(df) == 'dataset_label'] <- 'Field Output Label'
    names(df)[names(df) == 'field_type'] <- 'Field Type'
    names(df)[names(df) == 'standardization_lookup_id'] <- 'Standardization File'

    # Drop the output field if
    df <- select(df, -output_field_id)

    # Put it into a data table now
    dt <- datatable(df, selection = 'single', rownames = FALSE, options = list(lengthChange = FALSE, dom = 'tp'))
  }

  # Renders the data table of iterations that can be modified
  output$currently_added_algorithm_output_fields <- renderDataTable({
    get_algorithm_output_fields()
  })

  # Renders the UI for the left ground truth field add select input
  output$linkage_algorithm_output_field_input <- renderUI({
    get_algorithm_output_fields_input()
  })

  # Checks which field type the user selected and changes the UI input
  observeEvent(input$linkage_algorithm_output_field_type, {
    # Get the field type
    field_type <- input$linkage_algorithm_output_field_type

    # Render the UI based on the field type
    # FIELD TYPE == 7 (Derived Age)
    if(field_type == 7){
      # Derived age requires 2 inputs
      output$linkage_algorithm_output_field_input <- renderUI({
        # Perform query using linkage_metadata_conn
        query_result <- dbGetQuery(linkage_metadata_conn, paste("SELECT * from dataset_fields WHERE dataset_id =", algorithm_output_fields_dataset_id))

        # Extract columns from query result
        choices <- setNames(query_result$field_id, query_result$field_name)

        # Create a fluid page
        fluidPage(
          # Fluid row to have both select inputs in the same row
          fluidRow(
            column(width = 6, div(style = "display: flex; justify-content: right; align-items: center;",
                # Create select input with dynamic choices
                span(selectizeInput("algorithm_output_field_bdate", label = "Birth Date Field:",
                                    choices = choices, multiple = FALSE, width = validateCssUnit(300),
                                    options = list(
                                      placeholder = 'Select the Birth Date Field',
                                      onInitialize = I('function() { this.setValue(""); }')
                                    )))
              )
            ),
            column(width = 6, div(style = "display: flex; justify-content: left; align-items: center;",
                # Create select input with dynamic choices
                span(selectizeInput("algorithm_output_field_cdate", label = "Capture Date Field:",
                                    choices = choices, multiple = FALSE, width = validateCssUnit(300),
                                    options = list(
                                      placeholder = 'Select the Date of Capture Field',
                                      onInitialize = I('function() { this.setValue(""); }')
                                    )))
              )
            ),
          )
        )
      })
    }
    # FIELD TYPE == 8 (Standardize Values)
    else if (field_type == 8){
      # Standardize Inputs requires a select input & file select
      output$linkage_algorithm_output_field_input <- renderUI({
        # Perform query using linkage_metadata_conn
        query_result <- dbGetQuery(linkage_metadata_conn, paste("SELECT * from dataset_fields WHERE dataset_id =", algorithm_output_fields_dataset_id))

        # Extract columns from query result
        choices <- setNames(query_result$field_id, query_result$field_name)

        # Create a fluid page for the input
        fluidPage(
          # Create a fluid row for organizing the inputs
          fluidRow(
            column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                # Create select input with dynamic choices
                span(selectizeInput("algorithm_output_field_standardize", label = "Standardizing Field:",
                                    choices = choices, multiple = FALSE, width = validateCssUnit(300),
                                    options = list(
                                      placeholder = 'Select the Field to Be Standardized',
                                      onInitialize = I('function() { this.setValue(""); }')
                                    )))
              )
            ),
            column(width = 6, offset = 3, div(style = "display: flex; justify-content: left; align-items: left;",
              # Label for the uploaded file name
              div(style = "margin-right: 10px;", "Uploaded File:"),
            )),
            column(width = 6, offset = 3, div(style = "display: flex; justify-content: center; align-items: center;",
              # Boxed text output for showing the uploaded file name
              div(style = "flex-grow: 1; border: 1px solid #ccc; padding: 5px; background-color: #f9f9f9;",
                textOutput("uploaded_standardization_file_algorithm_output")
              ),
              # Upload button
              actionButton("upload_standardization_file_algorithm_output", label = "", shiny::icon("upload")), #or use 'upload'
            )),
            column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
              helpText(paste0(
                "The uploaded file should contain the two following columns, 'common' which are the values that can appear ",
                "in the dataset being used, along with the 'unique' column which is what the common dataset values will map ",
                "to when standardization takes place during output."
              ), style = "width: 350px;")
            )),
          )
        )
      })
    }
    # FIELD TYPE == 1, 2, 3, 4, 5, 6, 9 (Only requires one input)
    else{
      # All other field types require just the input field
      output$linkage_algorithm_output_field_input <- renderUI({
        # Perform query using linkage_metadata_conn
        query_result <- dbGetQuery(linkage_metadata_conn, paste("SELECT * from dataset_fields WHERE dataset_id =", algorithm_output_fields_dataset_id))

        # Extract columns from query result
        choices <- setNames(query_result$field_id, query_result$field_name)

        # Create select input with dynamic choices
        span(selectizeInput("algorithm_output_field", label = "Output Dataset Field:",
                            choices = choices, multiple = FALSE, width = validateCssUnit(300),
                            options = list(
                              placeholder = 'Select an Output Field',
                              onInitialize = I('function() { this.setValue(""); }')
                            )))
      })
    }
  })

  # Allows user to upload a file for grabbing column names and storing path
  observeEvent(input$upload_standardization_file_algorithm_output,{
    tryCatch({
      standardization_file_path_algorithm_output$path <- file.choose()
    },
    error = function(e){
      standardization_file_path_algorithm_output$path <- NULL
    })
  })

  # Render the uploaded file
  observe({
    uploaded_file_add <- standardization_file_path_algorithm_output$path

    # Uploaded dataset file (ADD)
    if(is.null(uploaded_file_add)){
      output$uploaded_standardization_file_algorithm_output <- renderText({
        "No File Uploaded"
      })
    }
    else{
      output$uploaded_standardization_file_algorithm_output <- renderText({
        basename(uploaded_file_add)
      })
    }
  })

  # Renders the table for the output fields that we can use from a previously used algorithm
  observeEvent(input$previous_algorithm_output_ids, {
    # Get the selected algorithm
    algorithm_id <- input$previous_algorithm_output_ids

    # If the algorithm id is valid, look up the table, otherwise return
    if(algorithm_id == "") return()

    # Render the data table
    output$selected_algorithm_output_fields <- renderDataTable({
      # Query to get blocking variables with left and right dataset field names
      df <- dbGetQuery(linkage_metadata_conn, "
                    SELECT of.output_field_id, of.dataset_label, of.field_type, df.field_name, standardization_lookup_id
                    FROM output_fields of
                    JOIN output_field_parameters ofp ON of.output_field_id = ofp.output_field_id
                    JOIN dataset_fields df ON ofp.dataset_field_id = df.field_id
                    WHERE of.algorithm_id = ?
                    ORDER BY ofp.output_field_id ASC, ofp.parameter_id ASC", params = list(algorithm_id))

      # Group the data frame
      df <- df %>%
        group_by(output_field_id) %>%
        summarise(
          dataset_label = paste(unique(dataset_label), collapse = ", "),
          field_type = paste(unique(field_type), collapse = ", "),
          field_name = paste(unique(field_name), collapse = ", "),
          standardization_lookup_id = paste(unique(standardization_lookup_id), collapse = ", ")
        ) %>%
        ungroup()

      # Get the standardization file for each output field (if there is one)
      if(nrow(df) > 0){
        for(row_num in 1:nrow(df)){
          # Get the standardizing ID for this row
          standardizing_id <- suppressWarnings(as.numeric(df$standardization_lookup_id[row_num]))

          # If the ID is not NA, then get the label
          if(!is.na(standardizing_id) && !is.na(standardizing_id) && is.numeric(standardizing_id)){
            # Get the file label
            file_label <- dbGetQuery(linkage_metadata_conn, "SELECT * FROM name_standardization_files WHERE standardization_file_id = ?",
                                     params = list(standardizing_id))$standardization_file_label

            # Put the label back into the data frame
            df$standardization_lookup_id[row_num] <- file_label
          }
          else{
            df$standardization_lookup_id[row_num] <- ""
          }
        }
      }

      # Change the field type by replacing it with values
      df$field_type[df$field_type == 1]  <- 'General/Pass-Through'
      df$field_type[df$field_type == 2]  <- 'Date'
      df$field_type[df$field_type == 3]  <- 'Age'
      df$field_type[df$field_type == 4]  <- 'Postal Code Initials'
      df$field_type[df$field_type == 5]  <- 'Name Length'
      df$field_type[df$field_type == 6] <- 'Number of Names'
      df$field_type[df$field_type == 7]  <- 'Derived Age'
      df$field_type[df$field_type == 8] <- 'Standardized Values'
      df$field_type[df$field_type == 9] <- 'Forward Sortation Area (FSA)'

      # With our data frame, we'll rename some of the columns to look better
      names(df)[names(df) == 'field_name'] <- 'Field Source Name(s)'
      names(df)[names(df) == 'dataset_label'] <- 'Field Output Label'
      names(df)[names(df) == 'field_type'] <- 'Field Type'
      names(df)[names(df) == 'standardization_lookup_id'] <- 'Standardization File'

      # Drop the output field if
      df <- select(df, -output_field_id)

      # Put it into a data table now
      dt <- datatable(df, selection = 'none', rownames = FALSE, options = list(lengthChange = FALSE, dom = 'tp'))
    })
  })

  # Adds the output fields using a previously used algorithm's output fields
  observeEvent(input$use_selected_algorithms_fields, {
    # Get the selected algorithm
    algorithm_id <- input$previous_algorithm_output_ids

    # If the algorithm id is invalid, return
    if(algorithm_id == ""){
      showNotification("Failed to Add Linkage Algorithm Output Field(s) - No Algorithm Is Selected", type = "error", closeButton = FALSE)
      return()
    }

    # If it is valid, look up the field types, labels, IDs, etc.
    df <- dbGetQuery(linkage_metadata_conn, "
                    SELECT of.output_field_id, of.dataset_label, of.field_type, ofp.dataset_field_id, ofp.parameter_id, standardization_lookup_id
                    FROM output_fields of
                    JOIN output_field_parameters ofp ON of.output_field_id = ofp.output_field_id
                    JOIN dataset_fields df ON ofp.dataset_field_id = df.field_id
                    WHERE of.algorithm_id = ?
                    ORDER BY ofp.output_field_id ASC, ofp.parameter_id ASC", params = list(algorithm_id))


    # Start a transaction, we must first delete the fields for this algorithm, then add the selected algorithms fields
    tryCatch({
      # Start the transaction
      dbBegin(linkage_metadata_conn)

      # Delete the current output fields
      df_delete <- dbGetQuery(linkage_metadata_conn, "
                      SELECT of.output_field_id, of.dataset_label, of.field_type, ofp.dataset_field_id, ofp.parameter_id, standardization_lookup_id
                      FROM output_fields of
                      JOIN output_field_parameters ofp ON of.output_field_id = ofp.output_field_id
                      JOIN dataset_fields df ON ofp.dataset_field_id = df.field_id
                      WHERE of.algorithm_id = ?
                      ORDER BY ofp.output_field_id ASC, ofp.parameter_id ASC", params = list(algorithm_output_fields_algorithm_id))
      output_field_ids_to_delete <- unique(df_delete$output_field_id)

      # Delete each of the output_field_ids from both tables
      for(output_field_id in output_field_ids_to_delete){
        # Delete the fields in both tables using a transaction
        #----#
        delete_query <- paste("DELETE FROM output_field_parameters
                          WHERE output_field_id = ?")
        delete <- dbSendStatement(linkage_metadata_conn, delete_query)
        dbBind(delete, list(output_field_id))
        dbClearResult(delete)

        delete_query <- paste("DELETE FROM output_fields
                          WHERE output_field_id = ?")
        delete <- dbSendStatement(linkage_metadata_conn, delete_query)
        dbBind(delete, list(output_field_id))
        dbClearResult(delete)
        #----#
      }

      # Loop through each UNIQUE output_field_id and add the records to both the output fields & parameters table
      for(output_field_id in unique(df$output_field_id)){
        # Get the fields for inserting
        dataset_label  <- unique(df$dataset_label[df$output_field_id == output_field_id])
        field_type     <- unique(df$field_type[df$output_field_id == output_field_id])
        standard_id    <- unique(df$standardization_lookup_id[df$output_field_id == output_field_id])
        dataset_fields <- unique(df$dataset_field_id[df$output_field_id == output_field_id])
        parameter_ids  <- unique(df$parameter_id[df$output_field_id == output_field_id])

        # First, insert into the output fields page
        new_entry_query <- paste("INSERT INTO output_fields (algorithm_id, dataset_label, field_type, standardization_lookup_id)",
                                 "VALUES(?, ?, ?, ?);")
        new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
        dbBind(new_entry, list(algorithm_output_fields_algorithm_id, dataset_label, field_type, standard_id))
        dbClearResult(new_entry)

        # Get the most recently created output_field_id
        output_field_id <- dbGetQuery(linkage_metadata_conn, "SELECT last_insert_rowid() AS output_field_id;")$output_field_id

        # Next, insert into the parameters page
        for(index in 1:length(parameter_ids)){
          new_entry_query <- paste("INSERT INTO output_field_parameters (output_field_id, parameter_id, dataset_field_id)",
                                   "VALUES(?, ?, ?);")
          new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
          dbBind(new_entry, list(output_field_id, parameter_ids[index], dataset_fields[index]))
          dbClearResult(new_entry)
        }
      }

      # Commit the transaction
      dbCommit(linkage_metadata_conn)

      # Update Data Tables and UI Renders
      #----#
      output$currently_added_algorithm_output_fields <- renderDataTable({
        get_algorithm_output_fields()
      })
      #----#

      # Show success notification
      #----#
      showNotification("Linkage Algorithm Output Field(s) Successfully Added", type = "message", closeButton = FALSE)
      #----#
    },
    error = function(e){
      # Rollback if an error occurs
      dbRollback(linkage_metadata_conn)
      showNotification(paste0("Failed to Add Linkage Algorithm Output Field(s) - ", e), type = "error", closeButton = FALSE)
      return()
    })
  })

  # Adds the provided output field, label, and type into the database
  observeEvent(input$add_linkage_algorithm_output_field, {
    # Get the input values
    algorithm_id      <- algorithm_output_fields_algorithm_id
    dataset_label     <- trimws(input$linkage_algorithm_output_field_label)
    field_type        <- input$linkage_algorithm_output_field_type

    # Make sure valid inputs were passed
    if(dataset_label == ''){
      showNotification("Failed to Add Linkage Algorithm Output Field - Missing Output Label", type = "error", closeButton = FALSE)
      return()
    }

    # Convert dataset id and field type to integers
    field_type <- as.numeric(field_type)

    # Start a transaction for adding the fields
    tryCatch({
      # Start the transaction
      dbBegin(linkage_metadata_conn)

      # DERIVED AGE INSERTIONS
      if(field_type == 7){
        # Get the inputs
        bdate_field <- as.numeric(input$algorithm_output_field_bdate)
        cdate_field <- as.numeric(input$algorithm_output_field_cdate)

        # Validate inputs
        if(is.na(bdate_field) || is.na(cdate_field)){
          showNotification("Failed to Add Linkage Algorithm Output Field - Missing Output Field(s)", type = "error", closeButton = FALSE)
          stop()
        }

        # Create a new entry query for entering into the database
        new_entry_query <- paste("INSERT INTO output_fields (algorithm_id, dataset_label, field_type, standardization_lookup_id)",
                                 "VALUES(?, ?, ?, ?);")
        new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
        dbBind(new_entry, list(algorithm_id, dataset_label, field_type, NA))
        dbClearResult(new_entry)

        # Get the most recently created output_field_id
        output_field_id <- dbGetQuery(linkage_metadata_conn, "SELECT last_insert_rowid() AS output_field_id;")$output_field_id

        # Add the parameters to our output_field_parameters table
        new_entry_query <- paste("INSERT INTO output_field_parameters (output_field_id, parameter_id, dataset_field_id)",
                                 "VALUES(?, ?, ?);")
        new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
        dbBind(new_entry, list(output_field_id, 1, bdate_field))
        dbClearResult(new_entry)

        new_entry_query <- paste("INSERT INTO output_field_parameters (output_field_id, parameter_id, dataset_field_id)",
                                 "VALUES(?, ?, ?);")
        new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
        dbBind(new_entry, list(output_field_id, 2, cdate_field))
        dbClearResult(new_entry)

        ## Reset Data Tables, UI Renders, and global variables
        #----#
        output$currently_added_algorithm_output_fields <- renderDataTable({
          get_algorithm_output_fields()
        })
        updateSelectInput(session, "linkage_algorithm_output_field_type", selected = 2)
        updateSelectInput(session, "linkage_algorithm_output_field_type", selected = 1)
        updateTextAreaInput(session, "linkage_algorithm_output_field_label", value = "")
        standardization_file_path_algorithm_output$path <- NULL
        #----#

        # Show success notification
        #----#
        showNotification("Linkage Algorithm Output Field Successfully Added", type = "message", closeButton = FALSE)
        #----#
      }
      # STANDARDIZING FIELD INSERTIONS
      else if(field_type == 8){
        # Get the inputs
        standardize_field    <- as.numeric(input$algorithm_output_field_standardize)
        standardization_file <- standardization_file_path_algorithm_output$path

        # Validate inputs
        if(is.na(standardize_field)){
          showNotification("Failed to Add Linkage Algorithm Output Field - Missing Output Field", type = "error", closeButton = FALSE)
          stop()
        }

        # Verify that the uploaded file exists (still), and that it is a valid dataset
        if(is.null(standardization_file) || !file.exists(standardization_file) || file_ext(standardization_file) != "csv"){
          showNotification("Failed to Add Linkage Algorithm Output Field - Standardizing File is not a CSV File", type = "error", closeButton = FALSE)
          stop()
        }

        # Check if the database has this dataset, if it does, don't upload it and select it instead, otherwise save it
        file_name <- paste0(file_path_sans_ext(basename(standardization_file)), ".rds")
        name_standardization_label <- str_replace_all(file_name, "[[:punct:]]", " ") # Remove punctuation
        name_standardization_label <- paste0(trimws(str_to_title(name_standardization_label)), " Standardizing Dataset") # Set to title-case

        # Query to determine if the standardization file already exists
        query <- 'SELECT * from name_standardization_files
              WHERE standardization_file_name = ?'
        df <- dbGetQuery(linkage_metadata_conn, query, params = file_name)
        standardization_id <- 0
        if(nrow(df) > 0){
          # Read in the CSV
          standardization_dataset <- fread(standardization_file)

          # Verify that it has the columns "unique" and "common"
          dataset_col_names <- colnames(standardization_dataset)
          if(!("unique" %in% dataset_col_names) || !("common" %in% dataset_col_names)){
            showNotification("Failed to Add Linkage Algorithm Output Field - Standardizing File is Missing the Necessary Columns", type = "error", closeButton = FALSE)
            rm(standardization_dataset)
            gc()
            stop()
          }

          # Get the ID
          standardization_id <- df$standardization_file_id

          # Save as .rds in package data folder
          saveRDS(standardization_dataset, file.path(system.file(package = "datalink", "data"), file_name))
        }
        else{
          # Read in the CSV
          standardization_dataset <- fread(standardization_file)

          # Verify that it has the columns "unique" and "common"
          dataset_col_names <- colnames(standardization_dataset)
          if(!("unique" %in% dataset_col_names) || !("common" %in% dataset_col_names)){
            showNotification("Failed to Save Standardization Dataset - Dataset is Missing Columns", type = "error", closeButton = FALSE)
            rm(standardization_dataset)
            gc()
            return()
          }

          # Extract the file name without the extension and apply a ".rds" extension for the output
          standardization_file <- paste0(file_path_sans_ext(basename(standardization_file)), ".rds")

          # Query to add a new row to the database for storing the dataset
          new_entry_query <- paste("INSERT INTO name_standardization_files (standardization_file_label, standardization_file_name)",
                                   "VALUES(?, ?);")
          new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
          dbBind(new_entry, list(name_standardization_label, standardization_file))
          dbClearResult(new_entry)

          # Get the ID
          standardization_id <- dbGetQuery(linkage_metadata_conn, "SELECT last_insert_rowid() AS standardization_file_id;")$standardization_file_id

          # Save as .rds in package data folder
          saveRDS(standardization_dataset, file.path(system.file(package = "datalink", "data"), standardization_file))
        }

        # Create a new entry query for entering into the database
        new_entry_query <- paste("INSERT INTO output_fields (algorithm_id, dataset_label, field_type, standardization_lookup_id)",
                                 "VALUES(?, ?, ?, ?);")
        new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
        dbBind(new_entry, list(algorithm_id, dataset_label, field_type, standardization_id))
        dbClearResult(new_entry)

        # Get the most recently created output_field_id
        output_field_id <- dbGetQuery(linkage_metadata_conn, "SELECT last_insert_rowid() AS output_field_id;")$output_field_id

        # Add the parameter to our output_field_parameters table
        new_entry_query <- paste("INSERT INTO output_field_parameters (output_field_id, parameter_id, dataset_field_id)",
                                 "VALUES(?, ?, ?);")
        new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
        dbBind(new_entry, list(output_field_id, 1, standardize_field))
        dbClearResult(new_entry)

        ## Reset Data Tables, UI Renders, and global variables
        #----#
        output$currently_added_algorithm_output_fields <- renderDataTable({
          get_algorithm_output_fields()
        })
        updateSelectInput(session, "linkage_algorithm_output_field_type", selected = 2)
        updateSelectInput(session, "linkage_algorithm_output_field_type", selected = 1)
        updateTextAreaInput(session, "linkage_algorithm_output_field_label", value = "")
        standardization_file_path_algorithm_output$path <- NULL
        #----#

        # Show success notification
        #----#
        showNotification("Linkage Algorithm Output Field Successfully Added", type = "message", closeButton = FALSE)
        #----#
      }
      # ALL OTHER TYPES
      else{
        # Get the inputs
        output_field <- as.numeric(input$algorithm_output_field)

        # Validate inputs
        if(is.na(output_field)){
          showNotification("Failed to Add Linkage Algorithm Output Field - Missing Output Field", type = "error", closeButton = FALSE)
          stop()
        }

        # Create a new entry query for entering into the database
        new_entry_query <- paste("INSERT INTO output_fields (algorithm_id, dataset_label, field_type, standardization_lookup_id)",
                                 "VALUES(?, ?, ?, ?);")
        new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
        dbBind(new_entry, list(algorithm_id, dataset_label, field_type, NA))
        dbClearResult(new_entry)

        # Get the most recently created output_field_id
        output_field_id <- dbGetQuery(linkage_metadata_conn, "SELECT last_insert_rowid() AS output_field_id;")$output_field_id

        # Add the parameters to our output_field_parameters table
        new_entry_query <- paste("INSERT INTO output_field_parameters (output_field_id, parameter_id, dataset_field_id)",
                                 "VALUES(?, ?, ?);")
        new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
        dbBind(new_entry, list(output_field_id, 1, output_field))
        dbClearResult(new_entry)

        ## Reset Data Tables, UI Renders, and global variables
        #----#
        output$currently_added_algorithm_output_fields <- renderDataTable({
          get_algorithm_output_fields()
        })
        updateSelectInput(session, "linkage_algorithm_output_field_type", selected = 2)
        updateSelectInput(session, "linkage_algorithm_output_field_type", selected = 1)
        updateTextAreaInput(session, "linkage_algorithm_output_field_label", value = "")
        standardization_file_path_algorithm_output$path <- NULL
        #----#

        # Show success notification
        #----#
        showNotification("Linkage Algorithm Output Field Successfully Added", type = "message", closeButton = FALSE)
        #----#
      }

      # Commit the transaction
      dbCommit(linkage_metadata_conn)
    },
    error = function(e){
      # Rollback if an error occurs
      dbRollback(linkage_metadata_conn)
      return()
    })
  })

  # Drops the selected pair of ground truth fields
  observeEvent(input$drop_linkage_algorithm_output_field, {
    # Get the algorithm ID and selected row
    algorithm_id <- algorithm_output_fields_algorithm_id
    selected_row <- input$currently_added_algorithm_output_fields_rows_selected

    # Query to get the output fields per field id
    df <- dbGetQuery(linkage_metadata_conn, "
                    SELECT of.output_field_id, of.dataset_label, of.field_type, df.field_name, standardization_lookup_id
                    FROM output_fields of
                    JOIN output_field_parameters ofp ON of.output_field_id = ofp.output_field_id
                    JOIN dataset_fields df ON ofp.dataset_field_id = df.field_id
                    WHERE of.algorithm_id = ?
                    ORDER BY ofp.output_field_id ASC, ofp.parameter_id ASC", params = list(algorithm_id))

    # Group the data frame
    df <- df %>%
      group_by(output_field_id) %>%
      summarise(
        dataset_label = paste(unique(dataset_label), collapse = ", "),
        field_type = paste(unique(field_type), collapse = ", "),
        field_name = paste(unique(field_name), collapse = ", "),
        standardization_lookup_id = paste(unique(standardization_lookup_id), collapse = ", ")
      ) %>%
      ungroup()

    # Get the fields to delete
    output_field_id  <- df$output_field_id[selected_row]

    # Create a new entry query for deleting the blocking variable
    #----#
    tryCatch({
      # Start a transaction
      dbBegin(linkage_metadata_conn)

      # Delete the fields in both tables using a transaction
      #----#
      delete_query <- paste("DELETE FROM output_field_parameters
                          WHERE output_field_id = ?")
      delete <- dbSendStatement(linkage_metadata_conn, delete_query)
      dbBind(delete, list(output_field_id))
      dbClearResult(delete)

      delete_query <- paste("DELETE FROM output_fields
                          WHERE output_field_id = ?")
      delete <- dbSendStatement(linkage_metadata_conn, delete_query)
      dbBind(delete, list(output_field_id))
      dbClearResult(delete)
      #----#

      # Update Data Tables and UI Renders
      #----#
      output$currently_added_algorithm_output_fields <- renderDataTable({
        get_algorithm_output_fields()
      })
      #----#

      # Show success notification
      #----#
      showNotification("Linkage Algorithm Output Field Successfully Deleted", type = "message", closeButton = FALSE)
      #----#

      # Finish a transaction
      dbCommit(linkage_metadata_conn)
    },
    error = function(e){
      #Roll back and provide an error message if deletion failed
      dbRollback(linkage_metadata_conn)
      showNotification("Failed to Delete Algorithm Output Field - Try Again", type = "error", closeButton = FALSE)
      return()
    })
  })
  #----
  #-------------------------------------------------#

  # Show the next loading screen
  hideElement("loading_screen_10")
  showElement("loading_screen_11")

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
        matching_left_fields = character(),
        standardization_file_id = numeric()
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
    df <- subset(df, select = -c(algorithm_id, iteration_id, standardization_file_id))

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
    standardization_dataset_to_add <<- NA
    output$selected_iteration_acceptance_rule <- renderText({
      " "
    })
    output$selected_standardization_dataset <- renderText({
      "Default Standardization Dataset"
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

    iteration_name          <- df_temp$iteration_name
    iteration_num           <- df_temp$iteration_num
    linkage_method_id       <- df_temp$linkage_method_id
    acceptance_rule_id      <- df_temp$acceptance_rule_id
    standardization_file_id <- df_temp$standardization_file_id

    # Pre-populate the general information from the database
    updateTextAreaInput(session, "add_iteration_name", value = iteration_name)
    updateNumericInput(session, "add_iteration_order", value = iteration_num)
    updateSelectizeInput(session, "add_iteration_linkage_method", selected = linkage_method_id)
    iteration_acceptance_rule_to_add <<- acceptance_rule_id
    standardization_dataset_to_add <<- standardization_file_id
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
    if(!is.na(standardization_file_id)){
      # Get the standardization dataset name
      standardization_dataset_name <- dbGetQuery(linkage_metadata_conn, paste0('SELECT * FROM name_standardization_files
                                                                               WHERE standardization_file_id = ', standardization_file_id))$standardization_file_label
      # Render the text output
      output$selected_standardization_dataset <- renderText({
        standardization_dataset_name
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

    iteration_name          <- df_temp$iteration_name
    iteration_num           <- df_temp$iteration_num
    linkage_method_id       <- df_temp$linkage_method_id
    acceptance_rule_id      <- df_temp$acceptance_rule_id
    standardization_file_id <- df_temp$standardization_file_id

    # Pre-populate the general information from the database
    updateTextAreaInput(session, "add_iteration_name", value = iteration_name)
    updateNumericInput(session, "add_iteration_order", value = iteration_num)
    updateSelectizeInput(session, "add_iteration_linkage_method", selected = linkage_method_id)
    iteration_acceptance_rule_to_add <<- acceptance_rule_id
    standardization_dataset_to_add <<- standardization_file_id
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
    if(!is.na(standardization_file_id)){
      # Get the standardization dataset name
      standardization_dataset_name <- dbGetQuery(linkage_metadata_conn, paste0('SELECT * FROM name_standardization_files
                                                                               WHERE standardization_file_id = ', standardization_file_id))$standardization_file_label
      # Render the text output
      output$selected_standardization_dataset <- renderText({
        standardization_dataset_name
      })
    }

    # Show the add linkage iteration page
    nav_show('main_navbar', 'add_linkage_iterations_page')
    updateNavbarPage(session, "main_navbar", selected = "add_linkage_iterations_page")
  })
  #----
  #-----------------------------------------#

  # Show the next loading screen
  hideElement("loading_screen_11")
  showElement("loading_screen_12")

  #-- ADD LINKAGE ITERATION PAGE EVENTS --#
  #----
  # Reactive value for the standardization file path (ADD)
  standardization_file_path <- reactiveValues(
    path=NULL
  )

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

  # GLOBAL VARIABLE FOR SELECTED STANDARDIZATION DATASET
  standardization_dataset_to_add <- NA

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

  # Remove the standardization dataset for this iteration
  observeEvent(input$remove_standardization_dataset, {
    # Set the global variable value to NA
    standardization_dataset_to_add <<- NA

    # Render the text output
    output$selected_standardization_dataset <- renderText({
      "Default Standardization Dataset"
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
                     choices = choices, multiple = FALSE, width = validateCssUnit(400),
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

  #-- NAME STANDARDIZATION UI EVENTS --#
  observeEvent(input$prepare_standardization_dataset, {
    # Creates the select input UI for available standardization datasets
    output$available_standardization_datasets <- renderUI({
      # Perform query using linkage_metadata_conn
      query_result <- dbGetQuery(linkage_metadata_conn, "SELECT * from name_standardization_files")

      # Extract columns from query result
      choices <- setNames(query_result$standardization_file_id, query_result$standardization_file_label)

      # Go through each of the choices, keep the datasets that exist
      for(choice in choices){
        # Get the dataset file
        dataset_file <- dbGetQuery(linkage_metadata_conn, paste0('SELECT * from name_standardization_files
                                                                  WHERE standardization_file_id = ', choice))$standardization_file_name

        # Get the file path
        file_path <- file.path(system.file(package = "datalink", "data"), dataset_file)

        # If the file path does not exist, drop it from the vector
        if(!file.exists(file_path)){
          # Remove this choice from the list of choices
          choices <- choices[!choices %in% choice]
        }
      }

      # Create select input with dynamic choices
      span(selectizeInput("standardization_dataset_to_use", label = "Select Standardization Dataset:",
                          choices = choices, multiple = FALSE, width = validateCssUnit(300),
                          options = list(
                            placeholder = 'Select a Standardization Dataset',
                            onInitialize = I('function() { this.setValue(""); }')
                          )))
    })

    showModal(modalDialog(
      title = "Choose Acceptance Rule",
      easyClose = TRUE,
      footer = NULL,
      fluidPage(
        # Acceptance rule table
        h5("Upload a New Standardization Dataset, or Select an Existing Dataset:"),
        layout_column_wrap(
          width = 1/2,
          height = 350,

          # Card for uploading a new standardization dataset
          card(card_header("Upload New Standardization Dataset", class = "bg-dark"),
            fluidRow(
              column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                textAreaInput("add_standardization_label", label = "Dataset Label/Identifier:", value = "",
                               width = validateCssUnit(500), resize = "none"),
              )),
              column(width = 6, offset = 3, div(style = "display: flex; justify-content: left; align-items: left;",
                # Label for the uploaded file name
                div(style = "margin-right: 10px;", "Uploaded File:"),
              )),
              column(width = 6, offset = 3, div(style = "display: flex; justify-content: center; align-items: center;",
                # Boxed text output for showing the uploaded file name
                div(style = "flex-grow: 1; border: 1px solid #ccc; padding: 5px; background-color: #f9f9f9;",
                  textOutput("uploaded_standardization_file")
                ),
                # Upload button
                actionButton("upload_standardization_file", label = "", shiny::icon("upload")), #or use 'upload'
              )),
              column(width = 12, div(style = "display: flex; justify-content: center; align-items: center;",
                # Add margin-top to the save button for spacing
                actionButton("select_uploaded_standardization_file", "Save and Use Standardization File",
                             class = "btn-success", width = validateCssUnit(500),
                             style = "margin-top: 15px;"),
              )),
            )
          ),

          # Card for selecting an existing standardization dataset
          card(card_header("Select Existing Standardization Dataset", class = "bg-dark"),
            fluidRow(
              column(width = 6, div(style = "display: flex; justify-content: right; align-items: center;",
                # UI Output for the available standardization datasets
                uiOutput("available_standardization_datasets")
              )),
              column(width = 6, div(style = "display: flex; justify-content: left; align-items: center;",
                actionButton("select_standardization_file", "Use Standardization File",
                              class = "btn-success", width = validateCssUnit(300),
                              style = "margin-top: 15px;"),
              ))
            )
          )
        ),
      ),
      size = "l"  # Large modal size to fit both tables
    ))
  })

  # Allows user to upload a file for grabbing column names and storing path
  observeEvent(input$upload_standardization_file,{
    tryCatch({
      standardization_file_path$path <- file.choose()
    },
    error = function(e){
      standardization_file_path$path <- NULL
    })
  })

  # Render the uploaded file
  observe({
    uploaded_file_add <- standardization_file_path$path

    # Uploaded dataset file (ADD)
    if(is.null(uploaded_file_add)){
      output$uploaded_standardization_file <- renderText({
        "No File Uploaded"
      })
    }
    else{
      output$uploaded_standardization_file <- renderText({
        basename(uploaded_file_add)
      })
    }
  })

  # Saves and selects the name standardization file
  observeEvent(input$select_uploaded_standardization_file, {
    # Get the input data
    name_standardization_label <- trimws(input$add_standardization_label)
    name_standardization_file  <- standardization_file_path$path

    #-- ERROR HANDLING --#
    # Verify that the dataset label/identifier is not blank
    if(name_standardization_label == ""){
      showNotification("Failed to Save Standardization Dataset - Label is Missing", type = "error", closeButton = FALSE)
      return()
    }

    # Verify that the uploaded file exists (still), and that it is a valid dataset
    if(is.null(name_standardization_file) || !file.exists(name_standardization_file) || file_ext(name_standardization_file) != "csv"){
      showNotification("Failed to Save Standardization Dataset - Invalid Input File", type = "error", closeButton = FALSE)
      return()
    }
    #--------------------#

    # Check if the database has this dataset, if it does, don't upload it and select it instead, otherwise save it
    file_name <- paste0(file_path_sans_ext(basename(name_standardization_file)), ".rds")
    query <- 'SELECT * from name_standardization_files
              WHERE standardization_file_name = ?'
    df <- dbGetQuery(linkage_metadata_conn, query, params = file_name)
    if(nrow(df) > 0){
      # Read in the CSV
      name_standardization_dataset <- fread(name_standardization_file)

      # Verify that it has the columns "unique" and "common"
      dataset_col_names <- colnames(name_standardization_dataset)
      if(!("unique" %in% dataset_col_names) || !("common" %in% dataset_col_names)){
        showNotification("Failed to Save Standardization Dataset - Dataset is Missing Columns", type = "error", closeButton = FALSE)
        rm(name_standardization_dataset)
        gc()
        return()
      }

      # Get the ID
      standardization_file_id <- df$standardization_file_id

      # Save as .rds in package data folder
      saveRDS(name_standardization_dataset, file.path(system.file(package = "datalink", "data"), file_name))

      # Save the uploaded dataset and select it
      standardization_dataset_to_add <<- standardization_file_id
      output$selected_standardization_dataset <- renderText({
        df$standardization_file_label
      })

      # Show a success message and return
      showNotification("Name Standardization Dataset Selected Successfully", type = "message", closeButton = FALSE)
      removeModal()
    }
    else{
      # Read in the CSV
      name_standardization_dataset <- fread(name_standardization_file)

      # Verify that it has the columns "unique" and "common"
      dataset_col_names <- colnames(name_standardization_dataset)
      if(!("unique" %in% dataset_col_names) || !("common" %in% dataset_col_names)){
        showNotification("Failed to Save Standardization Dataset - Dataset is Missing Columns", type = "error", closeButton = FALSE)
        rm(name_standardization_dataset)
        gc()
        return()
      }

      # Extract the file name without the extension and apply a ".rds" extension for the output
      name_standardization_file <- paste0(file_path_sans_ext(basename(name_standardization_file)), ".rds")

      # Query to add a new row to the database for storing the dataset
      new_entry_query <- paste("INSERT INTO name_standardization_files (standardization_file_label, standardization_file_name)",
                               "VALUES(?, ?);")
      new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
      dbBind(new_entry, list(name_standardization_label, name_standardization_file))
      dbClearResult(new_entry)

      # Get the ID
      standardization_file_id <- dbGetQuery(linkage_metadata_conn, "SELECT last_insert_rowid() AS standardization_file_id;")$standardization_file_id

      # Save as .rds in package data folder
      saveRDS(name_standardization_dataset, file.path(system.file(package = "datalink", "data"), name_standardization_file))

      # Save the uploaded dataset and select it, then return
      standardization_dataset_to_add <<- standardization_file_id
      output$selected_standardization_dataset <- renderText({
        name_standardization_label
      })

      # Show a success message and return
      showNotification("Name Standardization Dataset Saved Successfully", type = "message", closeButton = FALSE)
      removeModal()
    }
  })

  # Selects the name standardization file (ALREADY SAVED)
  observeEvent(input$select_standardization_file, {
    # Get the selected file
    selected_dataset_id <- input$standardization_dataset_to_use

    # Verify that a dataset was selected
    if(selected_dataset_id == ""){
      return()
    }
    else{
      selected_dataset_id <- as.integer(selected_dataset_id)
    }

    # Get the file name using the dataset ID
    dataset_label <- dbGetQuery(linkage_metadata_conn, paste0('SELECT * from name_standardization_files
                                                               WHERE standardization_file_id = ', selected_dataset_id))$standardization_file_label
    # Set the global variable
    standardization_dataset_to_add <<- selected_dataset_id

    # Render the text output and close the modal
    output$selected_standardization_dataset <- renderText({
      dataset_label
    })
    removeModal()
  })
  #------------------------------------#

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

        #----#

        # Create a new iteration
        #----#
        new_entry_query <- paste("INSERT INTO linkage_iterations (algorithm_id, iteration_name, iteration_num, linkage_method_id, acceptance_rule_id, modified_date, modified_by, enabled, standardization_file_id)",
                                 "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?);")
        new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
        dbBind(new_entry, list(algorithm_id, iteration_name, iteration_priority, linkage_method_id, acceptance_rule_id, modified_date, modified_by, 1, standardization_dataset_to_add))
        dbClearResult(new_entry)
        #----#

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
                          SET iteration_name = ?, iteration_num = ?, linkage_method_id = ?, acceptance_rule_id = ?, modified_date = ?, modified_by = ?, standardization_file_id = ?
                          WHERE iteration_id = ?")
        update <- dbSendStatement(linkage_metadata_conn, update_query)
        dbBind(update, list(iteration_name, iteration_priority, linkage_method_id, acceptance_rule_id, modified_date, modified_by, standardization_dataset_to_add, stored_iteration_id))
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
    standardization_dataset_to_add     <<- NA

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

  # If the user clicks on "Preview Algorithm & Passes", save the iteration and go to the "Run Linkage Page"
  observeEvent(input$preview_algorithm, {
    # Get the user input values
    algorithm_id       <- add_linkage_iterations_algorithm_id
    iteration_name     <- input$add_iteration_name
    iteration_priority <- input$add_iteration_order
    linkage_method_id  <- input$add_iteration_linkage_method
    acceptance_rule_id <- iteration_acceptance_rule_to_add
    modified_by <- username
    modified_date <- format(Sys.Date(), format = "%Y-%m-%d")

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

        #----#

        # Create a new iteration
        #----#
        new_entry_query <- paste("INSERT INTO linkage_iterations (algorithm_id, iteration_name, iteration_num, linkage_method_id, acceptance_rule_id, modified_date, modified_by, enabled, standardization_file_id)",
                                 "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?);")
        new_entry <- dbSendStatement(linkage_metadata_conn, new_entry_query)
        dbBind(new_entry, list(algorithm_id, iteration_name, iteration_priority, linkage_method_id, acceptance_rule_id, modified_date, modified_by, 1, standardization_dataset_to_add))
        dbClearResult(new_entry)
        #----#

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
                          SET iteration_name = ?, iteration_num = ?, linkage_method_id = ?, acceptance_rule_id = ?, modified_date = ?, modified_by = ?, standardization_file_id = ?
                          WHERE iteration_id = ?")
        update <- dbSendStatement(linkage_metadata_conn, update_query)
        dbBind(update, list(iteration_name, iteration_priority, linkage_method_id, acceptance_rule_id, modified_date, modified_by, standardization_dataset_to_add, stored_iteration_id))
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
    standardization_dataset_to_add     <<- NA

    # Update the table of iterations on the 'view iterations' page
    output$currently_added_linkage_iterations <- renderDataTable({
      get_linkage_iterations_view()
    })
    output$previously_used_iterations <- renderDataTable({
      get_linkage_iterations_add_existing()
    })

    # Update the global variable for the acceptance method id and the return page
    run_algorithm_left_dataset_id  <<- add_linkage_iterations_left_dataset_id
    run_algorithm_right_dataset_id <<- add_linkage_iterations_right_dataset_id
    run_algorithm_return_page      <<- "view_linkage_iterations_page"

    # Re-render the algorithms data table
    output$select_linkage_algorithms_to_run <- renderDataTable({
      get_linkage_algorithms_to_run()
    })

    # Update the return button'
    updateActionButton(session, "run_algorithm_back", label = "Return to View Iterations Page", icon = shiny::icon("arrow-left-long"))

    # Show the iterations page
    nav_show('main_navbar', 'run_algorithm_page')
    updateNavbarPage(session, "main_navbar", selected = "run_algorithm_page")
  })
  #---------------------------#

  #----
  #---------------------------------------#

  # Show the next loading screen
  hideElement("loading_screen_12")
  showElement("loading_screen_13")

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

  # Show the next loading screen
  hideElement("loading_screen_13")
  showElement("loading_screen_14")

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

  # Show the next loading screen
  hideElement("loading_screen_14")
  showElement("loading_screen_15")

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

  # Show the next loading screen
  hideElement("loading_screen_15")
  showElement("loading_screen_16")

  #-- REGENERATE REPORT PAGE EVENTS --#
  #----
  # Variables for this page
  algorithm_ids_to_regenerate <- c()
  regenerate_report_left_dataset_id <- 1
  regenerate_report_right_dataset_id <- 1
  regenerate_report_return_page  <- "linkage_algorithms_page"

  # Helper function to help generate the table of dates and timestamps
  generate_saved_data_df <- function(){
    # Get the algorithm ID
    algorithm_id_to_regenerate <- algorithm_ids_to_regenerate[1]

    # Get the saved data
    all_data_files <- list.files(system.file(package = "datalink", "data"))

    # Keep only data files that have our Algorithm ID in brackets
    for(index in 1:length(all_data_files)){
      # Get the current data file
      curr_data_file <- all_data_files[index]

      # Extract the algorithm ID
      result <- sub('.*\\[(.*)\\].*', '\\1', curr_data_file)

      # Try to convert this value to numeric and compare it
      result_algo_id <- suppressWarnings(as.numeric(result))

      # If the pulled algorithm ID matches, then keep it and put it in a data frame
      if(is.na(result_algo_id) || result_algo_id != algorithm_id_to_regenerate){
        all_data_files[index] <- NA
      }
    }

    # Get the non-NA values, and split them into two columns, "Dates" and "Timestamps"
    saved_data_files <- all_data_files[!is.na(all_data_files)]

    # If we have at least one file, then do all this extra work
    saved_data_split <- strsplit(sub('.*\\((.*)\\).*', '\\1', saved_data_files), " ")
    dates      <- sapply(saved_data_split,"[[",1)
    timestamps <- sapply(saved_data_split,"[[",2)

    # For the Non-NA files, create a data frame of the "Date" and "Time"
    saved_data_df <- data.frame(
      date = dates,
      time = timestamps
    )

    # Re-order the saved data by date and then timestamp
    if(nrow(saved_data_df) > 0){
      saved_data_df <- saved_data_df[order(saved_data_df$date),]
      saved_data_df <- saved_data_df[order(saved_data_df$time),]
    }
    else{
      saved_data_df <- data.frame(
        date = character(),
        time = character()
      )
    }

    # Return the data frame
    return(saved_data_df)
  }

  # Query and output for getting the selected linkage algorithms
  get_data_to_regenerate <- function(){
    # Get the saved data
    saved_data_df <- generate_saved_data_df()

    # With our data frame, we'll rename some of the columns to look better
    names(saved_data_df)[names(saved_data_df) == 'date'] <- 'Saved Date'
    names(saved_data_df)[names(saved_data_df) == 'time'] <- 'Saved Timestamp'

    # Put it into a data table now
    dt <- datatable(saved_data_df, selection = 'multiple', rownames = FALSE, options = list(lengthChange = FALSE))
  }

  # Render the data table for the linkage algorithms of the desired 2 datasets
  output$select_saved_data_to_regenerate <- renderDataTable({
    get_data_to_regenerate()
  })

  # Initialize the selected file and folder to be empty
  output$uploaded_regenerated_report_output_dir <- renderText({
    "No Folder Has Been Chosen"
  })

  # Get the computer volumes
  volumes <- getVolumes()()

  # Linkage Output Directory Chooser
  shinyDirChoose(input, 'regenerated_report_output_dir', roots=volumes, filetypes=c('', 'txt'), allowDirCreate = F)

  # Observes which linkage output directory was chosen
  observeEvent(input$regenerated_report_output_dir, {
    # Get the output linkage directory
    output_dir <- parseDirPath(volumes, input$regenerated_report_output_dir)

    # Render the output text
    if(identical(output_dir, character(0))){
      output$uploaded_regenerated_report_output_dir <- renderText({
        "No Folder Has Been Chosen"
      })
    }
    else{
      output$uploaded_regenerated_report_output_dir <- renderText({
        output_dir
      })
    }
  })

  # Back button
  observeEvent(input$regenerate_report_back, {
    # Show the page we need to return to
    nav_show("main_navbar", regenerate_report_return_page)

    # Return to the page you came from
    updateNavbarPage(session, "main_navbar", selected = regenerate_report_return_page)
  })

  # Attempts to run the linkage algorithms the user chose
  observeEvent(input$regenerate_report_btn, {
    # Disable this button
    disable("regenerate_report_btn")

    # Get the saved data to obtain the algorithms being re-generated
    saved_data_df <- generate_saved_data_df()

    # Get the selected rows
    selected_rows <- input$select_saved_data_to_regenerate_rows_selected

    # If no rows were selected, return
    # Make sure a output folder was provided
    if(length(selected_rows) <= 0){
      showNotification("Failed to Regenerate Reports - No Rows are Selected", type = "error", closeButton = FALSE)
      Sys.sleep(2)
      enable("regenerate_report_btn")
      return()
    }

    # Get the date and timestamp values
    dates <- saved_data_df$date[selected_rows]
    times <- saved_data_df$time[selected_rows]

    # Get the algorithm name
    algorithm_id_to_regenerate <- algorithm_ids_to_regenerate[1]
    algo_name <- get_algorithm_name(linkage_metadata_conn, algorithm_id_to_regenerate)

    # Create a vector of the files to regenerate, and construct their full names
    files_to_regenerate <- c()
    for(index in 1:length(selected_rows)){
      # Create the full file name
      file_name <- paste0(algo_name, " [", algorithm_id_to_regenerate, "] (", dates[index], " ", times[index], ").RData")

      # Append the file name
      files_to_regenerate <- append(file_name, files_to_regenerate)
    }
    print(files_to_regenerate)

    # Create variables for the number of steps
    total_steps  <- length(files_to_regenerate)*2
    current_step <- 1

    # Start a progress bar
    withProgress(message = "Regenerating Linkage Report...", value = 0, {

      # Get the folder and file inputs
      output_dir <- parseDirPath(volumes, input$regenerated_report_output_dir)

      # Make sure a output folder was provided
      if(identical(output_dir, character(0))){
        showNotification("Failed to Regenerate Reports - Missing Output Folder", type = "error", closeButton = FALSE)
        Sys.sleep(2)
        enable("regenerate_report_btn")
        return()
      }

      # Get the algorithm that we're regenerating
      algorithm_id <- algorithm_ids_to_regenerate[1]

      # For each of our algorithms that we want to have regenerated, individually generate the reports
      for(saved_data in files_to_regenerate){
        # Progress for reading in this algorithms data
        progress_value <- 1/(total_steps+1)
        incProgress(progress_value, paste0("Step [", current_step, "/", total_steps, "] Loading Saved Data for ", saved_data))
        current_step <- current_step + 1

        # Get the file path where the .RData file should be
        saved_file_path <- file.path(system.file(package = "datalink", "data"), saved_data)

        # Make sure the file exists
        if(!file.exists(saved_file_path)){
          progress_value <- 1/(total_steps+1)
          incProgress(progress_value, paste0("Step [", current_step, "/", total_steps, "] Skipping Regenerating Report for ", saved_data))
          current_step <- current_step + 1
          showNotification(paste0("Failed to Regenerate Report - Saved Data [", saved_data, "] Does Not Exist, Skipping."), type = "error", closeButton = FALSE)
        }
        else{
          ### Load the RData file in
          load(saved_file_path)

          ### Get the data individually
          linked_data             <- get("linked_data")
          algorithm_name          <- get("algorithm_name")
          algorithm_summary       <- get("algorithm_summ")
          algorithm_footers       <- get("algorithm_foot")
          performance_measures    <- get("performance_df")
          performance_measures_footnotes <- c("PPV = Positive predictive value, NPV = Negative predictive value.")
          missing_data_indicators <- get("intermediate_missing_indicators_df")

          ### Get the dataset names
          left_dataset_name <- dbGetQuery(linkage_metadata_conn,
                                          paste0('SELECT * FROM datasets where dataset_id = ', regenerate_report_left_dataset_id))$dataset_name
          right_dataset_name <- dbGetQuery(linkage_metadata_conn,
                                          paste0('SELECT * FROM datasets where dataset_id = ', regenerate_report_right_dataset_id))$dataset_name

          ### Initialize the report variables
          strata_vars <- colnames(linked_data)[!(colnames(linked_data) == "stage")]
          ground_truth_df <- get_ground_truth_fields(linkage_metadata_conn, algorithm_id)
          ground_truth_fields <- paste(ground_truth_df$left_dataset_field, collapse = ", ")

          # If we have no performance measures, then ignore them
          if(nrow(performance_measures) <= 0){
            performance_measures <- NULL
            performance_measures_footnotes <- NULL
            ground_truth_fields <- NULL
          }

          # If we have no missing data indicators, ignore them
          display_missing_data_ind <- T
          if(nrow(missing_data_indicators) <= 0){
            missing_data_indicators  <- NULL
            display_missing_data_ind <- F
          }

          ### If we considered other algorithms, add them to the report appendix
          considered_algo_summary_list           <- list()
          considered_algo_summary_footnotes_list <- list()
          considered_algo_summary_table_names    <- c()

          # Check if this algorithm is the "Default" algorithm, if so, then we can
          # get the considered algorithms
          default_algorithm <- dbGetQuery(linkage_metadata_conn, paste0('SELECT * FROM linkage_algorithms
                                                                      WHERE algorithm_id = ', algorithm_id))

          if(default_algorithm$enabled == 1){
            # Get the left and right dataset IDs
            left_dataset_id  <- default_algorithm$dataset_id_left
            right_dataset_id <- default_algorithm$dataset_id_right

            # Get the algorithms enabled for testing
            enabled_algorithms <- dbGetQuery(linkage_metadata_conn, paste0('SELECT algorithm_id FROM linkage_algorithms
                                                                 WHERE enabled_for_testing = 1 AND enabled = 0 AND archived = 0 AND published = 0
                                                                 AND dataset_id_left = ', left_dataset_id, ' AND dataset_id_right = ', right_dataset_id,
                                                                ' ORDER BY algorithm_id ASC'))$algorithm_id

            # Loop through each algorithm and create a table for its iterations
            for(tested_algorithm_id in enabled_algorithms){
              # Create an empty algorithm summary for binding
              considered_algo_summary <- data.frame(
                pass = character(),
                linkage_implementation = character(),
                blocking_variables = character(),
                matching_variables = character(),
                acceptance_threshold = character()
              )
              considered_algo_summary_footnotes <- c()

              # Get the algorithm name
              considered_algorithm_name <- get_algorithm_name(linkage_metadata_conn, tested_algorithm_id)
              considered_algo_summary_table_names <- append(considered_algo_summary_table_names, considered_algorithm_name)

              # Get the list of iteration IDs for the current algorithm
              enabled_iterations <- dbGetQuery(linkage_metadata_conn, paste0('SELECT iteration_id FROM linkage_iterations
                                                                   WHERE algorithm_id = ', tested_algorithm_id,
                                                                             ' ORDER by iteration_id ASC'))$iteration_id

              # Set a variable for counting the current pass
              curr_pass <- 1

              # Loop through each iteration ID to make our algorithm summary
              for(tested_iteration_id in enabled_iterations){
                # Get the implementation name
                linkage_method <- get_linkage_technique(linkage_metadata_conn, tested_iteration_id)
                linkage_method_desc <- get_linkage_technique_description(linkage_metadata_conn, tested_iteration_id)
                linkage_footnote <- paste0(linkage_method, ' = ', linkage_method_desc)
                considered_algo_summary_footnotes <- append(considered_algo_summary_footnotes, linkage_footnote)
                considered_algo_summary_footnotes <- unique(considered_algo_summary_footnotes)

                # Get the blocking variables
                blocking_fields_df <- get_blocking_keys(linkage_metadata_conn, tested_iteration_id)
                blocking_fields <- paste(blocking_fields_df$left_dataset_field, collapse = ", ")

                # Get the matching variables
                matching_query <- paste('SELECT field_name, comparison_rule_id FROM matching_variables
                                JOIN dataset_fields on field_id = left_dataset_field_id
                                WHERE iteration_id =', tested_iteration_id)
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

                matching_fields <- paste(matching_df$field_name, collapse = ", ")

                # Get the acceptance threshold
                acceptance_query <- paste('SELECT * FROM linkage_iterations
                                 WHERE iteration_id =', tested_iteration_id,
                                          'ORDER BY iteration_num ASC;')
                acceptance_df <- dbGetQuery(linkage_metadata_conn, acceptance_query)
                acceptance_rule_id <- acceptance_df$acceptance_rule_id
                acceptance_threshold <- ""

                # Make the rules more readable
                if (nrow(acceptance_df) > 0 && !is.na(acceptance_rule_id)) {
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
                  acceptance_threshold <- method_with_params
                }

                # Create a data frame for the current passes summary
                temp_algo_summary <- data.frame(
                  pass = as.integer(curr_pass),
                  linkage_implementation = linkage_method,
                  blocking_variables = blocking_fields,
                  matching_variables = matching_fields,
                  acceptance_threshold = acceptance_threshold
                )

                # Bind this summary
                considered_algo_summary <- rbind(considered_algo_summary, temp_algo_summary)

                # Update the current pass
                curr_pass <- curr_pass + 1
              }

              # Label the considered algorithm summary
              label(considered_algo_summary$pass)                   <- "Pass"
              label(considered_algo_summary$linkage_implementation) <- "Linkage Technique"
              label(considered_algo_summary$blocking_variables)     <- "Blocking Scheme"
              label(considered_algo_summary$matching_variables)     <- "Matching Criteria"
              label(considered_algo_summary$acceptance_threshold)   <- "Acceptance Threshold"

              # Once we finish this considered algorithm summary, save it to a list
              considered_algo_summary_list[[length(considered_algo_summary_list)+1]] <- considered_algo_summary
              considered_algo_summary_footnotes_list[[length(considered_algo_summary_footnotes_list)+1]] <- considered_algo_summary_footnotes
            }
          }

          # Finally, if we don't have any enabled algorithms, set the input values to NULL
          if(length(considered_algo_summary_list) <= 0 || length (considered_algo_summary_footnotes_list) <= 0 || length(considered_algo_summary_table_names) <= 0){
            considered_algo_summary_footnotes_list <- NULL
            considered_algo_summary_list <- NULL
            considered_algo_summary_table_names <- NULL
          }

          # Attempt to generate the report
          tryCatch({
            # Set the initial progress
            progress_value <- 1/(total_steps+1)
            incProgress(progress_value, paste0("Step [", current_step, "/", total_steps, "] Regenerating Report for ", saved_data))
            current_step <- current_step + 1

            # Load the 'linkrep' library and generate a linkage quality report
            library("linkrep")

            # Clean the report file name
            cleaned_filename <- gsub("\\s*\\[.*\\]|\\.RData$", "", saved_data)

            final_linkage_quality_report(linked_data, algorithm_name, "", left_dataset_name,
                                         paste0("the ", right_dataset_name), output_dir, username, "datalink (Record Linkage)",
                                         "link_indicator", strata_vars, strata_vars, save_linkage_rate = F,
                                         algorithm_summary_data = algorithm_summary, algorithm_summary_tbl_footnotes = algorithm_footers,
                                         performance_measures_data = performance_measures, performance_measures_tbl_footnotes = performance_measures_footnotes,
                                         ground_truth = ground_truth_fields,
                                         considered_algorithm_summary_data = considered_algo_summary_list, considered_algorithm_summary_tbl_footnotes = considered_algo_summary_footnotes_list,
                                         considered_algorithm_summary_table_names = considered_algo_summary_table_names,
                                         missing_data_indicators = missing_data_indicators, display_missingness_table = display_missing_data_ind,
                                         R_version = as.character(getRversion()), linkrep_package_version = as.character(packageVersion("linkrep")),
                                         report_file_name = cleaned_filename)


            # If we succeed, let the user know where they can find their information
            showNotification(paste0("Regenerating Report Succeeded - Check the Output Folder for Data [", output_dir, "]"), type = "message", closeButton = FALSE)

            # Call garbage collector after we finish processing
            gc()

            # Detach the package
            detach("package:linkrep", unload = TRUE)
          },
          error = function(e){
            # Detach the package
            detach("package:linkrep", unload = TRUE)

            # If we fail, let the user know why
            showNotification(paste0("Regenerating Report Failed - ", geterrmessage()), type = "error", closeButton = FALSE)
            Sys.sleep(2)
            enable("regenerate_report_btn")
            return()
          })
        }
      }
    })

    # Enable the button
    enable("regenerate_report_btn")
  })
  #----
  #-----------------------------------#

  # Show the next loading screen
  hideElement("loading_screen_16")
  showElement("loading_screen_17")

  #-- RUN LINKAGE ALGORITHMS PAGE EVENTS --#
  #----
  # Variables for this page
  algorithms_to_run <- c()
  run_algorithm_left_dataset_id <- 1
  run_algorithm_right_dataset_id <- 1
  run_algorithm_return_page  <- "linkage_algorithms_page"

  # Reactive values to track selected rows
  selected_rows_run <- reactiveValues(selected = NULL)

  # Initialize the selected file and folder to be empty
  output$uploaded_linkage_standardize_names_file <- renderText({
    "No File Has Been Chosen"
  })
  output$uploaded_linkage_output_dir <- renderText({
    "No Folder Has Been Chosen"
  })

  # Query and output for getting the selected linkage algorithms
  get_linkage_algorithms_to_run <- function(){
    left_dataset_id  <- run_algorithm_left_dataset_id
    right_dataset_id <- run_algorithm_right_dataset_id

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
                   'AND archived = 0 AND published = 0',
                   'ORDER BY algorithm_id ASC;')
    df <- dbGetQuery(linkage_metadata_conn, query)

    # With our data frame, we'll rename some of the columns to look better
    names(df)[names(df) == 'algorithm_name'] <- 'Algorithm Name'
    names(df)[names(df) == 'modified_date'] <- 'Modified Date'
    names(df)[names(df) == 'modified_by'] <- 'Modified By'

    # With algorithms, we'll replace the enabled [0, 1] with [No, Yes]
    df$enabled <- str_replace(df$enabled, "0", "No")
    df$enabled <- str_replace(df$enabled, "1", "Yes")
    df$enabled_for_testing <- str_replace(df$enabled_for_testing, "0", "No")
    df$enabled_for_testing <- str_replace(df$enabled_for_testing, "1", "Yes")

    # Rename the remaining columns
    names(df)[names(df) == 'enabled'] <- 'Active Algorithm'
    names(df)[names(df) == 'enabled_for_testing'] <- 'Enabled for Sensitivity Testing'

    # Drop the algorithm_id, dataset_id_left, and dataset_id_right value
    df <- subset(df, select = -c(algorithm_id, dataset_id_left, dataset_id_right, published, archived))

    # Put it into a data table now
    dt <- datatable(df, selection = list(mode = "multiple", selected = selected_rows_run$selected), rownames = FALSE, options = list(lengthChange = FALSE))
  }

  # Render the data table for the linkage algorithms of the desired 2 datasets
  output$select_linkage_algorithms_to_run <- renderDataTable({
    get_linkage_algorithms_to_run()
  })

  # Handle 'Select All' button click
  observeEvent(input$select_all_run, {
    # Update selected rows to include all rows
    selected_rows_run$selected <- seq_len(nrow(get_linkage_algorithms_to_run()$x$data))
  })

  # Handle 'Select None' button click
  observeEvent(input$select_none_run, {
    # Clear the selected rows
    selected_rows_run$selected <- NULL
  })

  # Update `selected_rows_run` when a row is clicked manually
  observe({
    selected_rows_run$selected <- input$select_linkage_algorithms_to_run_rows_selected
  })

  # Get the computer volumes
  volumes <- getVolumes()()

  # Linkage Output Directory Chooser
  shinyDirChoose(input, 'linkage_output_dir', roots=volumes, filetypes=c('', 'txt'), allowDirCreate = F)

  # Observes which linkage output directory was chosen
  observeEvent(input$linkage_output_dir, {
    # Get the output linkage directory
    output_dir <- parseDirPath(volumes, input$linkage_output_dir)

    # Render the output text
    if(identical(output_dir, character(0))){
      output$uploaded_linkage_output_dir <- renderText({
        "No Folder Has Been Chosen"
      })
    }
    else{
      output$uploaded_linkage_output_dir <- renderText({
        output_dir
      })
    }
  })

  # Linkage Name Standardizing File Chooser
  shinyFileChoose(input, 'standardize_names_file', roots=volumes, filetypes=c('csv'))

  # Back button
  observeEvent(input$run_algorithm_back, {
    # Show the page we need to return to
    nav_show("main_navbar", run_algorithm_return_page)

    # Return to the page you came from
    updateNavbarPage(session, "main_navbar", selected = run_algorithm_return_page)
  })

  # Observes which linkage output directory was chosen
  observeEvent(input$standardize_names_file, {
    # Get the output linkage directory
    file_path <- input$standardize_names_file

    # Render the output text
    if(is.integer(file_path)){
      output$uploaded_linkage_standardize_names_file <- renderText({
        "No File Has Been Chosen"
      })
    }
    else{
      file_path <- parseFilePaths(volumes, file_path)$datapath
      output$uploaded_linkage_standardize_names_file <- renderText({
        file_path
      })
    }
  })

  # Observes which linkage report type was chosen
  observeEvent(input$linkage_report_type, {
    # Render the text
    if(input$linkage_report_type == 1){
      output$linkage_report_type_help <- renderText({
        "No linkage quality report will be generated for any algorithm(s) that are being run."
      })
    }
    else if(input$linkage_report_type == 2){
      output$linkage_report_type_help <- renderText({
        "The intermediate report will generate a singular report for all algorithms being run. Information includes
        a linked data summary, linkage rate summary, linkage algorithm summary, and a performance metrics table and plot."
      })
    }
    else if(input$linkage_report_type == 3){
      output$linkage_report_type_help <- renderText({
        "The final report will generate a full quality report for each algorithm being ran. Information includes
        a linked data summary, linkage rate summary, linkage algorithm summary, and a performance metrics table and plot."
      })
    }
  })

  # Attempts to run the linkage algorithms the user chose
  observeEvent(input$run_linkage_btn, {
    # Disable this button
    disable("run_linkage_btn")

    # Use `withProgress` to display and update the progress bar
    successful <- withProgress(message = "Running Linkage Algorithms...", value = 0, {

      # Define progress callback function
      progress_callback <- function(progress_value, message = NULL) {
        incProgress(progress_value, message)
      }

      # Set the initial progress
      incProgress(0)

      # Get the user toggle inputs
      output_linked_iterations_pairs  <- input$output_linked_iterations_pairs
      output_unlinked_iteration_pairs <- input$output_unlinked_iteration_pairs
      linkage_report_type             <- as.numeric(input$linkage_report_type)
      generate_algorithm_summary      <- input$generate_algorithm_summary
      calculate_performance_measures  <- input$calculate_performance_measures
      generate_threshold_plots        <- input$generate_threshold_plots
      save_all_linkage_results        <- input$save_all_linkage_results
      save_missing_data_indicators    <- input$create_missing_data_indicators
      include_unlinked_records        <- input$include_unlinked_records
      save_audit_performance          <- input$save_audit_performance

      # Get the folder and file inputs
      output_dir <- parseDirPath(volumes, input$linkage_output_dir)

      # Get the selected rows and the corresponding algorithm IDs
      selected_rows <- input$select_linkage_algorithms_to_run_rows_selected
      query <- paste('SELECT * FROM linkage_algorithms
                    WHERE dataset_id_left =', run_algorithm_left_dataset_id, ' AND dataset_id_right =', run_algorithm_right_dataset_id,
                   'AND archived = 0 AND published = 0',
                   'ORDER BY algorithm_id ASC;')
      df <- dbGetQuery(linkage_metadata_conn, query)
      algorithm_ids  <- df$algorithm_id[selected_rows]

      #-- Error Handling --#
      # We need to make sure the user supplied an output folder
      if(identical(output_dir, character(0))){
        showNotification("Failed to Run Linkage - Missing Output Folder", type = "error", closeButton = FALSE)
        return(FALSE)
      }
      # Make sure at least one algorithm was selected
      if(length(algorithm_ids) <= 0){
        showNotification("Failed to Run Linkage - No Algorithms are Selected", type = "error", closeButton = FALSE)
        return(FALSE)
      }
      #--------------------#

      # Get the parameters that will be passed to the linkage function
      left_dataset   <- dbGetQuery(linkage_metadata_conn, paste0('SELECT * FROM datasets WHERE dataset_id = ', run_algorithm_left_dataset_id))$dataset_location
      right_dataset  <- dbGetQuery(linkage_metadata_conn, paste0('SELECT * FROM datasets WHERE dataset_id = ', run_algorithm_right_dataset_id))$dataset_location
      link_metadata  <- metadata_file_path
      extra_params   <- create_extra_parameters_list(linkage_output_folder = output_dir, output_linkage_iterations = output_linked_iterations_pairs,
                                                     output_unlinked_iteration_pairs = output_unlinked_iteration_pairs, linkage_report_type = linkage_report_type,
                                                     generate_algorithm_summary = generate_algorithm_summary, calculate_performance_measures = calculate_performance_measures,
                                                     data_linker = username, generate_threshold_plots = generate_threshold_plots, save_all_linkage_results = save_all_linkage_results,
                                                     collect_missing_data_indicators = save_missing_data_indicators, include_unlinked_records = include_unlinked_records,
                                                     save_audit_performance = save_audit_performance)

      # Run the algorithms
      try_catch_success <- TRUE
      tryCatch({
        # Run the linkage algorithms
        results <- run_main_linkage(left_dataset, right_dataset, link_metadata, algorithm_ids, extra_params, progress_callback)

        # If the user wanted to save this data then handle that
        if(save_all_linkage_results == T){
          # Get all the linkage results by themselves first
          linked_data_list                     <- results[["linked_data"]]
          algorithm_ids                        <- results[["linked_algorithm_ids"]]
          linked_data_algorithm_names          <- results[["linked_algorithm_names"]]
          linkage_algorithm_summary_list       <- results[["algorithm_summaries"]]
          linkage_algorithm_footnote_list      <- results[["algorithm_footnotes"]]
          intermediate_performance_measures_df <- results[["performance_measures"]]
          intermediate_missing_indicators_df   <- results[["missing_data_indicators"]]
          linked_data_generation_times         <- results[["generated_timestamps"]]

          # We will go through each of the algorithm IDs and save the data to an .Rdata file that can be used later
          for(index in 1:length(algorithm_ids)){
            # Get the current information for this algorithm
            linked_data    <- linked_data_list[[index]]
            algorithm_id   <- algorithm_ids[index]
            algorithm_name <- linked_data_algorithm_names[index]
            algorithm_summ <- linkage_algorithm_summary_list[[index]]
            algorithm_foot <- linkage_algorithm_footnote_list[[index]]
            performance_df <- as.data.frame(intermediate_performance_measures_df[intermediate_performance_measures_df$algorithm_name == algorithm_name, ])
            generated_timestamp <- linked_data_generation_times[index]

            # Construct the file name and path
            file_name <- paste0(algorithm_name, " [", algorithm_id, "] (", generated_timestamp, ").RData")
            file_path <- file.path(system.file(package = "datalink", "data"), file_name)

            # Save the data for this algorithm
            save(linked_data, algorithm_id, algorithm_name, algorithm_summ,
                 algorithm_foot, performance_df, intermediate_missing_indicators_df, file=file_path)
          }
        }
        else{
          rm(results)
          gc()
        }
      },
      error = function(e){
        # If we fail, let the user know why
        try_catch_success <<- FALSE
        showNotification(paste0("Linkage Failed - ", geterrmessage()), type = "error", closeButton = FALSE)
        return()
      })

      # If we failed the try catch, then let the user know
      if(try_catch_success != TRUE) return(FALSE)

      # Finalize progress
      incProgress(1, detail = "Linkage completed.")

      # Return true
      return(TRUE)
    })

    # If we failed, then return
    if(successful == FALSE){
      Sys.sleep(2)
      enable("run_linkage_btn")
      return()
    }

    # If we succeed, let the user know where they can find their information
    showNotification(paste0("Linkage Succeeded - Check the Output Folder for Data [", output_dir, "]"), type = "message", closeButton = FALSE)

    # Call garbage collector after we finish processing
    gc()
    Sys.sleep(2)

    enable("run_linkage_btn")
    return()
  })
  #----
  #----------------------------------------#

  # Show the main content and hide the loading screen
  Sys.sleep(2)
  hideElement("loading_screen_17")
  showElement("main_content")
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
    "matching_variables", "name_standardization_files", "output_fields", "output_field_parameters"
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

  # Calling useShinyjs here so that we can disable and enable buttons during data linkage
  shinyjs::useShinyjs()

  # Add a resource path
  addResourcePath("figures", system.file("help/figures", package = "datalink"))

  # Start the Shiny Application
  shinyApp(ui = linkage_ui,
           server = function(input, output, session){
             linkage_server(input, output, session, linkage_metadata_conn, metadata_file_path, username)
           },
           onStart = function(){
             cat("Data Linkage App - OPENED")
             onStop(function(){
               dbDisconnect(linkage_metadata_conn)
               cat("Data Linkage App - CLOSED")
             })
           })
}
