% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Random.R
\name{filterByType}
\alias{filterByType}
\title{Returns a tibble with filtered Pokemon}
\usage{
filterByType(type = "ANY", type2 = "ANY", swap = FALSE, data = nationalDex)
}
\arguments{
\item{type}{Filter on type}

\item{type2}{Filter on type2}

\item{swap}{Allow type to match type2 and vicea-versa}

\item{data}{Override the data (Must have type and type2 (If type 2 is not ANY or swap is TRUE))}
}
\description{
Returns a tibble with filtered Pokemon
}
