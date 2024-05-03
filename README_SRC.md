# ZekDex -- This is the source file of the README.md to be compiled into the README.md

ZekDex is an R package that provides datasets about Pokémon, including National Dex information,
Legendary and Mythical Pokémon groupings, base stats, evolution and family information, and more.
It also includes functions to generate random Pokémon.

ZekDex aims to provide upto data and accurate iformation about Pokémon based off of Bulbapedia.
As of writing this it includes generations I-IX and allows users to generate upto date iformation if this ever falls behind.

## Installation

You can install the package from GitHub with:

```r
# If devtools is not installed:
install.packages("devtools")
# Install the package ZekDex from https://github.com/zekrom-vale/ZekDex
devtools::install_github("zekrom-vale/ZekDex")
```

## Datasets

The package includes the following datasets:

<<<<<DATASETS>>>>> -- To be replaced with the datasets in R/data.R

You can load any dataset with the `data()` function. For example, `data(nationalDex)`.

## Functions

The package provides the following functions:

- `randomPokemon()`: Returns a random Pokémon. This function takes the following parameters:
  - `n` (`integer`): How many Pokémon to return.
  - `p` (`character`): What column to return (ndex, name, form, regional, type, type2 can be used).
  - `replace` (`logical`): Should sampling be with replacement?

- `randomPokemonGen()`: Returns a random Pokémon generator. This function takes the following parameters:
  - `p` (`character`): What column to return (ndex, name, form, regional, type, type2 can be used).
  - `replace` (`logical`): Should sampling be with replacement?
  - `size` (`integer`): The number of random Pokémon to generate on each call.

- `gen_*()`: Regenerates parts of the dataset
  - `write` (`logical`): Should it write the data to a file?  (Recomended to save the output if `FALSE` as this takes time)
  - `root` (`character`): Where to look for files and write them
  - `file` (`character`): Where to save the data without extention if `write == TRUE`
  - `file*` (`character`): Same as file but for other datasets generated
  - NOTE: These functions scrape Bulbapedia, do not call them more then once.  Save the data to file and use it, updating only when required.

## License

This package is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International Public License.
For more details, see the [LICENSE](LICENSE) file.

## Data Formats

The data is provided in .rda format for use in this R package.
You can also find .csv files for use in other programs in the /data directory.

<<<<<ATTRIBUTION>>>>> -- To be replaced with ATTRIBUTION.md
