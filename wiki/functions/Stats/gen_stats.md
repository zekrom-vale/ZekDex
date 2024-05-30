# Generate Pokemon Statistics (`gen_stats`)

This function scrapes Pokemon statistics from Bulbapedia and returns a list of two data frames: one in long format and one in wide format. If `write = TRUE`, it also writes these data frames to csv files.

## Paramaters
 - `write` Logical, if `TRUE`, writes the data frames to csv files. Default is `FALSE`.
 - `root` The root directory where the csv file will be written if `write = TRUE`. Default is "data/".
 - `file` The name of the csv file to be written if `write = TRUE`. Default is "PokemonStats".
 - `fileWide` The name of the wide format csv file to be written if `write = TRUE`. Default is "PokemonStatsWide".
 - `return` A list of two data frames: PokemonStats (long format) and PokemonStatsWide (wide format).

## Usage
```r
gen_stats(
  write = FALSE,
  root = "data/",
  file = "PokemonStats",
  fileWide = "PokemonStatsWide"
)
```