% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Util.R
\name{paste_non_unique}
\alias{paste_non_unique}
\title{Paste Non-Unique Elements}
\usage{
paste_non_unique(vec1, vec2, sep = "")
}
\arguments{
\item{vec1}{A vector of elements to be pasted with \code{vec2} if the
corresponding element in \code{vec2} is not unique.}

\item{vec2}{A vector of elements to be checked for uniqueness.}

\item{sep}{A character string to separate the terms. Default is "".}
}
\value{
A vector where each element is either an element from \code{vec1}
(if the corresponding element in \code{vec2} is unique) or a string resulting from
pasting together the corresponding elements from \code{vec1} and \code{vec2}
(if the element in \code{vec2} is not unique).
}
\description{
This function pastes together elements from two vectors (\code{vec1} and \code{vec2})
if the corresponding element in \code{vec2} is not unique. If the element in \code{vec2}
is unique, it returns the corresponding element from \code{vec1}.
}
\examples{
vec1 = c("apple", "banana", "cherry")
vec2 = c("fruit", "fruit", "fruit")
ZekDex:::paste_non_unique(vec1, vec2, sep = " ")
}
