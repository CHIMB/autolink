% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/populate_linkage_metadata.R
\name{create_new_metadata}
\alias{create_new_metadata}
\title{Create New Metadata}
\usage{
create_new_metadata(file_name, output_folder)
}
\arguments{
\item{file_name}{The file name for what the new .sqlite metadata file will be called.}

\item{output_folder}{A path to the output folder, where the new metadata file will be output.}
}
\description{
The create_new_metadata() function will run all the insert and create queries to build
the tables and provide some initial metadata values. The function takes two parameters,
one for the file name that the user will want it to be called, and one for where the
file will be output.
}
\examples{
create_new_metadata("my_new_metadata", "path/to/folder")
}
