# ZekDex

ZekDex is an R package that provides datasets about Pokémon, including National Dex information, Legendary and Mythical Pokémon groupings, base stats, evolution and family information, and more. It also includes functions to generate random Pokémon.

## Datasets

The package includes the following datasets:

- `nationalDex`: Pokémon National Dex information.
- `groups`: Legendary and Mythical Pokémon groupings.
- `stats`: Base stats of Pokémon.
- `family`: Pokémon evolution and family information.
- `familyLong`: Extended Pokémon family information.
- `languages`: Pokémon National Dex information in multiple languages.
- `regionalDex`: Pokémon information from the Regional Dex.
- `types`: Information about various Pokémon types.

You can load any dataset with the `data()` function. For example, `data(nationalDex)`.

## Functions

The package provides the following functions:

- `randomPokemon()`: Returns a random Pokémon.
- `randomPokemonGen()`: Returns a random Pokémon generator.

## Installation

You can install the package from GitHub with:

```r
devtools::install_github("zekrom-vale/ZekDex")
```

## License

This package is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International Public License. For more details, see the [LICENSE.md](LICENSE.md) file.

## Attribution

The data in this package is sourced from Bulbapedia. For more details on the data sources and their attribution, see the [ATTRIBUTION.md](ATTRIBUTION.md) file.

## Data Formats

The data is provided in .rda format for use in this R package. You can also find .csv files for use in other programs in the /data directory.
