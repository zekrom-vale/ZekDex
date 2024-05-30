# Generate Catch Rate Pokémon Data (`gen_catch`)

This function scrapes data from Bulbapedia''s "List of Pokémon by catch rate" page and returns a tibble of the data.
It also has the option to write the data to a file.

## Paramaters
 - `write` Logical. If TRUE, the function will write the data to a file. Default is FALSE.
 - `root` Character. The root directory where the file will be saved. Default is "data/".
 - `file` Character. The name of the file where the data will be saved. Default is "PokemonCatch".
 - `return` A tibble of the scraped Pokémon data.

## Usage
```r
gen_catch(write = FALSE, root = "data/", file = "PokemonCatch")
```