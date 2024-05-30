# Generates Pokémon Types from Scratch (`gen_type`)

This function generates a tibble of Pokémon types by scraping the Bulbapedia website. It extracts the types from the HTML table on the page and creates a unique list of Pokémon types. It also adds two additional types, ''Stellar'' and ''???''. If `write = TRUE`, it writes the tibble to a CSV file.

## Paramaters
 - `write` Logical, if `TRUE`, writes the tibble to a CSV file. Default is `FALSE`.
 - `root` The root directory where the CSV file will be written if `write = TRUE`. Default is `"data/"`.
 - `file` The name of the CSV file to be written if `write = TRUE`. Default is `"PokemonTypes"`.
 - `return` A tibble with a single column named ''types'' containing unique Pokémon types.

## Usage
```r
gen_type(write = FALSE, root = "data/", file = "PokemonTypes")
```