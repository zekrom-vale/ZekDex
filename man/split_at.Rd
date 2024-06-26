% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Util.R
\name{split_at}
\alias{split_at}
\title{Splits a list at elements that satisfy a condition}
\usage{
split_at(lst, condition)
}
\arguments{
\item{lst}{A list to split.}

\item{condition}{A condition function that returns TRUE for elements where
the list should be split.}
}
\value{
A list of lists, split at elements where the condition is TRUE.
}
\description{
This function splits a list at elements that satisfy a condition.
It returns a list of lists, split at elements where the condition is TRUE.
}
\examples{
\dontrun{
ZekDex:::split_at(list(1, 2, 3, 4, 5), function(x) x \%\% 2 == 0)
}
}
