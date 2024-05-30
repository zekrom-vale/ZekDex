# Generate Pokemon Height Data (`gen_height`)

Function to scrape and generate Pokemon height data from Bulbapedia.

## Paramaters
 - `write` A logical value indicating whether to write the data to a file.
 - `root` The root directory where the file should be saved.
 - `file` The name of the file where the data should be saved.
 - `return` A tibble containing the Pokemon height data.

## Usage
```r
gen_height(write = FALSE, root = "data/", file = "PokemonHeight")
```