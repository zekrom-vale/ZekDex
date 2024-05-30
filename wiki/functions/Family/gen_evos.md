# Generate Pokémon Evolution Data (`gen_evos`)

This function scrapes Pokémon evolution data from Bulbapedia and returns a data frame. If `write = TRUE`, it also writes the data frame to a csv file.

## Paramaters
 - `write` Logical, if `TRUE`, writes the data frame to a csv file. Default is `FALSE`.
 - `root` The root directory where the csv file will be written if `write = TRUE`. Default is "data/".
 - `file` The name of the csv file to be written if `write = TRUE`. Default is "PokemonFamily".
 - `fileLong` The name of the long format csv file to be written if `write = TRUE`. Default is "PokemonFamilyLong".
 - `return` A data frame of Pokémon evolution data.

## Usage
```r
gen_evos(
  write = FALSE,
  root = "data/",
  file = "PokemonFamily",
  fileLong = "PokemonFamilyLong"
)
```