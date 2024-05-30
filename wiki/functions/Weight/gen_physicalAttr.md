# Generate Physical Attributes of Pokemon (`gen_physicalAttr`)

This function generates a data frame of physical attributes (weight and height) of Pokemon.
It performs two inner joins on the weight and height data frames and combines the results.
The function can optionally write the resulting data frame to a file.

## Paramaters
 - `write` Logical, whether to write the resulting data frame to a file.
 - `root` Character, the root directory where the data files are located.
 - `file` Character, the name of the file to write the resulting data frame to.
 - `fileHeight` Character, the name of the file containing the height data.
 - `fileWeight` Character, the name of the file containing the weight data.
 - `return` A data frame of physical attributes of Pokemon.

## Usage
```r
gen_physicalAttr(
  write = FALSE,
  root = "data/",
  file = "PokemonPhysicalAttr",
  fileHeight = "PokemonHeight",
  fileWeight = "PokemonWeight"
)
```