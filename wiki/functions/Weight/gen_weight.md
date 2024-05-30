# Generate Pokemon Weight Data (`gen_weight`)

Function to scrape and generate Pokemon weight data from Bulbapedia.

## Paramaters
 - `write` A logical value indicating whether to write the data to a file.
 - `root` The root directory where the file should be saved.
 - `file` The name of the file where the data should be saved.
 - `return` A tibble containing the Pokemon weight data.

## Usage
```r
gen_weight(write = FALSE, root = "data/", file = "PokemonWeight")
```