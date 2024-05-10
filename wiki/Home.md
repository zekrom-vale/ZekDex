# Welcome to the ZekDex Wiki!

ZekDex is an R package that provides comprehensive datasets about Pokémon. It's a valuable resource for both Pokémon enthusiasts and data scientists. The package includes a wide array of datasets that cover various aspects of Pokémon, making it a unique and rich resource.

## Key Features

- **National Dex Information**: A complete listing of Pokémon as per the National Dex.
- **Legendary and Mythical Pokémon Groupings**: Categorizes Pokémon into their respective Legendary and Mythical groups.
- **Base Stats**: Fundamental statistics of each Pokémon, such as their attack power, defense, speed, and more.
- **Evolution and Family Information**: Details about the evolutionary stages of Pokémon and their familial connections.
- **Random Pokémon Generation**: Functions that allow users to generate random Pokémon.
- **Up-to-date Information**: If the package's data ever falls behind, users have the capability to generate up-to-date information.

## Installation

You can install the package from GitHub with:

```r
# If devtools is not installed:
install.packages("devtools")

# Install the stable branch of the package ZekDex (recommended)
devtools::install_github("zekrom-vale/ZekDex", ref = "stable")

# Or, install the main branch of the package ZekDex (May be in an unusable state)
devtools::install_github("zekrom-vale/ZekDex", ref = "main")
```

## Datasets

The package includes the following datasets:

- **nationalDex**: Contains National Pokedex information for each Pokémon.
- **groups**: Categorizes Pokémon into their respective Legendary and Mythical groups.
- **stats**: Fundamental statistics of each Pokémon.
- **family**: Pokémon evolution and family information.
- **familyLong**: Extended Pokémon family information.
- **languages**: Pokémon names in different languages.
- **regionalDex**: Pokémon information in regional Pokedex.
- **types**: Information about various Pokémon types.
- **typeChartWide**: Effectiveness of various attacking Pokémon types against defending types.
- **typeChart**: Detailed effectiveness values for attacks between different Pokémon types.
- **weight**: Information about the weight of various Pokémon.
- **height**: Information about the height of different Pokémon forms.

For more details about each dataset, please visit the respective pages.

## License

This package is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International Public License (CC BY-NC-SA 4.0). This license allows for redistribution and adaptation of the work under the following terms:

- **Attribution**: You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
- **NonCommercial**: You may not use the material for commercial purposes.
- **ShareAlike**: If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original.

## Attribution

Data used in this project is sourced from Bulbagarden.

The data has been extracted using rvest, cleaned, and reformatted to be easily readable and usable in R and other applications. As well as used in R functions as described in the man documentation or by using the help ? in R. Note that errors may occur in cleaning/reformating and should be reported as an issue on GitHub.

The data is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 2.5 Generic (CC BY-NC-SA 2.5).

## Acknowledgements

We would like to express our gratitude to the contributors of Bulbagarden for collecting and maintaining the Pokémon data that we use in this project.

Please note that this project is not affiliated with, endorsed by, or directly associated with Bulbagarden or the official Pokémon franchise.