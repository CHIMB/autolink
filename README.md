
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Automated Data Linkage <img src="man/figures/chimb_logo.jpg" align="right" height="138" />

<br><br><br>

# Introduction

`datalink` provides an easy and user friendly way for data analysts to
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

To install `datalink` from GitHub, begin by installing and loading the
`devtools` package:

``` r
# install.packages("devtools")
library(devtools)
```

Afterwards, you may install the automated data linkage package using
`install_github()`:

``` r
devtools::install_github("CHIMB/datalink")
```

## Local Installation

To install `datalink` locally from GitHub, select the most recent
release from the right-hand tab on the GitHub repository page. Download
the <b>Source code (zip)</b> file, then move over to RStudio. You may
then run the code:

``` r
path_to_pkg <- file.choose() # Select the unmodified package you downloaded from GitHub.
devtools::install_local(path_to_pkg)
```

# Usage

USAGE/INSTRUCTIONS WILL GO HERE

# Additional Information & Documentation

For more details on how the architecture of the package is structured
and how the stored algorithms are pulled and used to link data, consider
reading the [<b>Developer Facing Documentation
(448.3KB)</b>](https://github.com/CHIMB/datalink/blob/main/docs/).

For more details on how to work function calls, how to navigate the
pages of the user interfaces, and how to make changes, or add new
information to the metadata, consider reading the [<b>User Facing
Documentation
(1.5MB)</b>](https://github.com/CHIMB/datalink/blob/main/docs/).
