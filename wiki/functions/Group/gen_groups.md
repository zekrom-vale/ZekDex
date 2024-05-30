# Generate a tibble of legendary/mythical groups of Pokemon (`gen_groups`)

This function scrapes data from Bulbapedia to create a tibble of legendary/mythical groups of Pokemon.

## Paramaters
 - `write` Logical, if TRUE the data is saved to a file, default is FALSE.
 - `root` Character, the root directory where the data file will be saved, default is "data/".
 - `file` Character, the name of the file where the data will be saved, default is "PokemonGroups".
 - `return` A tibble of legendary/mythical groups of Pokemon.

## Usage
```r
gen_groups(write = FALSE, root = "data/", file = "PokemonGroups")
```