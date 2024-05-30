# Generate Regional Pokedex (`gen_reginal`)

This function generates a tibble of the regional Pokedex by scraping data from Bulbapedia. It extracts the URLs of the regional Pokedex pages from the HTML, reads the HTML of each regional Pokedex page, and combines the regional Pokedex data with the national Pokedex data.

## Paramaters
 - `write` Logical, if `TRUE`, writes the tibble to a csv file. Default is `FALSE`.
 - `root` The root directory where the csv file will be written if `write = TRUE`. Default is "data/".
 - `file` The name of the csv file to be written if `write = TRUE`. Default is "PokemonRegional".
 - `return` A tibble of regional dexes.

## Usage
```r
gen_reginal(write = FALSE, root = "data/", file = "PokemonRegional")
```