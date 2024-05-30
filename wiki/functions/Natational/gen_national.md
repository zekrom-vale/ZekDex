# Generate the National Dex (`gen_national`)

This function generates a tibble of the National Dex by reading the ''PokemonNational.csv'' file and scraping data from Bulbapedia.
It extracts the tables from the HTML content, cleans the column names of the dataframe, and combines all dataframes into one.
If `write = TRUE`, it also writes the tibble to a csv file.

## Paramaters
 - `write` Logical, if `TRUE`, writes the tibble to a csv file. Default is `FALSE`.
 - `root` The root directory where the file will be written if `write = TRUE`. Default is "data/".
 - `file` The name of the file (without extension) to be written if `write = TRUE`. Default is "PokemonNational".
 - `return` A tibble of the National Dex.

## Usage
```r
gen_national(write = FALSE, root = "data/", file = "PokemonNational")
```