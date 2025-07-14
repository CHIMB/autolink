
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Automated Data Linkage <img src="man/figures/chimb_logo.jpg" align="right" height="138" />

<br><br><br>

# Introduction

`autolink` provides an easy and user friendly way for data analysts to
develop linkage algorithms and use them to perform data linkage tests.
With the package allowing for testing out multiple algorithms per
dataset, to help data analysts achieve an ideal and successful linkage
rate.

This package would be most beneficial in the field of data science,
specifically data-linkage and data analysis as the `datalink` package
would help make algorithm design and the testing process more
streamlined, as the end-user of the package would not be required to
make any programmatic changes to an R script and instead would only need
to mix-and-match different blocking and matching variables, and what
rules they would like for each. Doing so until a desired linkage rate is
achieved.

# Installation

## R Studio Installation

To install `autolink` from GitHub, begin by installing and loading the
`devtools` package:

``` r
# install.packages("devtools")
library(devtools)
```

Afterwards, you may install the automated data linkage package using
`install_github()`:

``` r
devtools::install_github("CHIMB/autolink")
```

## Local Installation

To install `autolink` locally from GitHub, select the most recent
release from the right-hand tab on the GitHub repository page. Download
the <b>Source code (zip)</b> file, then move over to RStudio. You may
then run the code:

``` r
path_to_pkg <- file.choose() # Select the unmodified package you downloaded from GitHub.
devtools::install_local(path_to_pkg)
```

# Usage

## Generating Empty Metadata File

To begin working with the `autolink` package, begin by creating an empty
linkage metadata file:

``` r
output_dir <- choose.dir() # Select the output directory where the .SQLite file should go.
autolink::create_new_metadata("linkage_metadata", output_dir)
```

## Working With The GUI

With an empty file, you may begin adding datasets, algorithms, and
iteration specific iteration to the metadata file by using the provided
R Shiny application. To begin using the application, make the following
call in your R environment:

``` r
linkage_file <- file.choose() # Select the .SQLite file you wish to modify.
autolink::start_linkage_metadata_ui(linkage_file, "Data Analyst")
```

Within the GUI, you may first add the file paths to the data sets you
wish to use for the linkage process. Once uploaded, you can select a
pair of uploaded data sets to add algorithms to, of which you can add,
modify, and disable any number of passes you wish. If you are uncertain
with what exactly the GUI has to offer, considering reading the **User
Documentation** on the package found below.

## Running Algorithms

Once your algorithms have been created, you may run it either through
the GUI, or by calling it programmatically as such:

``` r
left_dataset  <- file.choose() # The left dataset you plan on using.
right_dataset <- file.choose() # The right dataset (spine) you plan on using.
metadata_file <- file.choose() # The .SQLite file that contains all saved information.
algorithm_ids <- c(1,3,4)      # The algorithm(s) ID you want to run under the dataset pair.
extra_params  <- create_extra_parameters_list(...) # Any number of optional/extra parameters you may want (export options & data).
```

# Additional Information & Documentation

For more details on how the architecture of the package is structured
and how the stored algorithms are pulled and used to link data, consider
reading the [<b>Developer Facing Documentation
(474KB)</b>](https://github.com/CHIMB/autolink/blob/main/docs/DEVELOPER_DOCUMENTATION_AUTOMATED_LINKAGE.pdf).

For more details on how to work function calls, how to navigate the
pages of the user interface, and how to make changes, or add new
information to the metadata, consider reading the [<b>User Facing
Documentation
(978KB)</b>](https://github.com/CHIMB/autolink/blob/main/docs/USER_DOCUMENTATION_AUTOMATED_LINKAGE.pdf).

For examples of reports that can be generated using both the `autolink`
and `linkrep` package, download and view the sample [Final
Report](https://github.com/CHIMB/autolink/raw/main/docs/Sample%20Final%20Report.pdf)
and [Sensitivity Analysis
Report](https://github.com/CHIMB/autolink/raw/main/docs/Sample%20Sensitivity%20Analysis%20Report.pdf)
which uses fake/synthetic data to better help showcase the elements that
make up each report. The reports generated here use two synthetic
datasets, both of which can be downloaded, with the [Left
Dataset](https://github.com/CHIMB/autolink/raw/main/data/syndataA_final.csv)
containing 150 records that have a corresponding link to one of the 250
records in the [Right
Dataset](https://github.com/CHIMB/autolink/raw/main/data/syndataB_final.csv).
