# Generate Mega Evolution and Primal Reversion Data (`gen_mega`)

This function scrapes data from Bulbapedia about Mega Evolutions and Primal Reversions in Pokémon.
It processes the data and optionally writes it to a CSV file.

## Paramaters
 - `write` Logical, if TRUE, the function writes the data to a CSV file. Default is FALSE.
 - `root` Character, the root directory where the CSV file will be saved. Default is "data/".
 - `file` Character, the name of the CSV file. Default is "PokemonMega".
 - `return` A dataframe containing the Mega Evolution and Primal Reversion data.

## Usage
```r
gen_mega(write = FALSE, root = "data/", file = "PokemonMega")
```