% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/linkage_helper_functions.R
\name{convert_name_case}
\alias{convert_name_case}
\title{Convert Name Cases}
\usage{
convert_name_case(string_to_convert)
}
\arguments{
\item{string_to_convert}{A string value that is the word being converted.}
}
\description{
The convert_name_case() function will take in a single string value, and convert it to
either lower case, upper case, or title case depending on how it should be displayed in
a report
}
\examples{
converted_word <- convert_name_case('phin')
print(converted_word) # Prints PHIN
}
