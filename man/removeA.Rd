% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Util.R
\name{removeA}
\alias{removeA}
\title{Replaces all accented characters in a string with their unaccented counterparts}
\usage{
removeA(str)
}
\arguments{
\item{str}{The string in which to replace accented characters.}
}
\value{
A string with all accented characters replaced by their unaccented counterparts.
}
\description{
This function takes a string as input and replaces all accented characters with their unaccented counterparts.
It supports a wide range of accented characters, including those with acute, grave, diaeresis, macron, and circumflex accents.
}
\examples{
# Note: This function is not exported, so we use ::: to access it
ZekDex:::removeA("Pokémon") # Returns "Pokemon"
ZekDex:::removeA("résumé") # Returns "resume"
ZekDex:::removeA("naïve") # Returns "naive"
ZekDex:::removeA("élève") # Returns "eleve"
ZekDex:::removeA("hôtel") # Returns "hotel"
ZekDex:::removeA("Mëtàl") # Returns "Metal"
ZekDex:::removeA("Pókémòn") # Returns "Pokemon"
}
