# Generate Pokémon Type Chart (`gen_type_chart`)

This function generates a Pokémon type chart by scraping data from Bulbapedia.
It creates two versions of the chart: a wide version and a long version.
The wide version has defending types as columns and attacking types as rows.
The long version is a reshaped version of the wide chart with three columns: attacking type, defending type, and effectiveness.

## Paramaters
 - `write` Logical value indicating whether to write the generated charts to files. Default is FALSE.
 - `root` Character string specifying the root directory where the files should be written. Default is "data/".
 - `file` Character string specifying the filename for the long version of the chart. Default is "PokemonTypeChart".
 - `fileWide` Character string specifying the filename for the wide version of the chart. Default is "PokemonTypeChartWide".
 - `return` A list containing two data frames: ''typeChart'' and ''typeChartWide''.

## Usage
```r
gen_type_chart(
  write = FALSE,
  root = "data/",
  file = "PokemonTypeChart",
  fileWide = "PokemonTypeChartWide"
)
```