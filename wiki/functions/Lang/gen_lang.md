# Generate the National Dex with Other Language Data (`gen_lang`)

This function generates a tibble of the National Dex with language information.

## Paramaters
 - `write` Logical, if `TRUE`, writes the tibble to a csv file. Default is `FALSE`.
 - `root` The root directory where the csv file will be written if `write = TRUE`. Default is "data/".
 - `file` The name of the csv file to be written if `write = TRUE`. Default is "PokemonLang".
 - `return` A tibble of the National Dex with language information.

## Usage
```r
gen_lang(write = FALSE, root = "data/", file = "PokemonLang")
```