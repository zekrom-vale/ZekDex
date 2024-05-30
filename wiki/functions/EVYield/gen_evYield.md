# Generate EV Yield (`gen_evYield`)

This function scrapes data from Bulbapedia to generate a dataframe of Pokémon effort value yields by generation.

## Paramaters
 - `write` A logical value indicating whether to write the output dataframe to a file. Default is FALSE.
 - `root` A character string specifying the root directory where the output file will be saved. Default is "data/".
 - `file` A character string specifying the name of the output file. Default is "PokemonEVYield".
 - `return` A dataframe of Pokémon effort value yields by generation.

## Usage
```r
gen_evYield(write = FALSE, root = "data/", file = "PokemonEVYield")
```