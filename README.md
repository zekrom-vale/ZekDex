# ZekDex


ZekDex is a comprehensive R package that serves as a rich resource for Pokémon enthusiasts and data scientists alike.
It offers a wide array of datasets about Pokémon, encompassing a multitude of aspects that make these creatures unique.

Key features of ZekDex include:
- **National Dex Information**: This provides a complete listing of Pokémon as per the National Dex, which is a catalogue of Pokémon species in the order they were discovered.
- **Legendary and Mythical Pokémon Groupings**: This categorizes Pokémon into their respective Legendary and Mythical groups, offering insights into their rarity and special attributes.
- **Base Stats**: This includes the fundamental statistics of each Pokémon, such as their attack power, defense, speed, and more per generation.
- **Evolution and Family Information**: This provides details about the evolutionary stages of Pokémon and their familial connections.
- **Random Pokémon Generation**: ZekDex also includes functions that allow users to generate random Pokémon, adding an element of surprise and discovery.
- And much more!

ZekDex is committed to providing up-to-date and accurate information about Pokémon. It draws its data from Bulbapedia, a community-driven Pokémon encyclopedia.
As of the time of writing, ZekDex includes data for Pokémon generations I through IX. 

One of the standout features of ZekDex is its ability to stay current.
If the package's data ever falls behind, users have the capability to generate up-to-date information.
This ensures that ZekDex remains a reliable and timely resource for Pokémon data.

Whether you're a researcher conducting a data analysis project, or a fan interested in the fascinating world of Pokémon,
ZekDex is a valuable tool to have in your R library.

## Data Formats and Accessibility

The datasets incorporated in this package are primarily stored in the `.rda` format, which is a binary format native to R.
This format is particularly beneficial for R users as it allows for efficient storage and quick data loading,
thereby enhancing the overall user experience with this package.

However, we understand that users might want to utilize this data outside the R environment.
To cater to this need, we also provide the data in the universally recognized `.csv` format.
These `.csv` files can be easily imported into various data analysis software and programming languages,
offering users the flexibility to work with the data in an environment of their choice.

You can locate these `.csv` files in the `/data` directory of the package.
This directory has been structured to ensure easy navigation and quick access to the required datasets.

In summary, whether you're working within the R ecosystem or venturing outside it,
we've got you covered with our dual data format availability. Happy data exploring!


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
### National PokeDex (`nationalDex`)
The National PokeDex is a comprehensive database that records information on all Pokémon known to exist,
instead of just ones native in a particular region.


### Legendary and Mythical Pokémon Groupings (`groups`)
This dataset contains information about Legendary and Mythical Pokémon,
which are a special group of Pokémon that are incredibly rare and often very powerful.


### Pokemon Stats (Wide Format) (`statsWide`)
This dataset is a wide format version of the `stats` dataset.


### Pokemon Stats (`stats`)
This dataset contains the base stats of Pokémon, including various forms and sizes of Pokémon.


### Pokemon Evolution Dataset (`family`)
This dataset contains information about Pokémon evolution and family groupings.


### Extended Pokemon Evolution Dataset (`familyLong`)
This dataset contains detailed information about Pokémon evolution and family groupings.


### Pokémon National Dex information in multiple languages (`languages`)
This dataset contains the names of Pokémon in various languages.


### Pokémon Information from the Regional Dex (`regionalDex`)
This dataset contains information about Pokémon as per the Regional Pokédex.


### Pokemon Types Dataset (`types`)
This dataset contains information about various Pokemon types.


### Pokémon Type Effectiveness Dataset (`typeChartWide`)
This dataset provides a matrix of effectiveness multipliers for different types of Pokémon attacks.


### Extended Pokémon Type Effectiveness Dataset (`typeChart`)
This dataset provides detailed effectiveness values for attacks between different Pokémon types.


### Pokemon Weight Dataset (`weight`)
This dataset contains information about the weight of various Pokémon.


### Height Dataset (`height`)
This dataset contains information about the height of different Pokémon forms.


### Physical Attributes of Pokémon (`physicalAttr`)
This dataset provides a comprehensive overview of the physical attributes of Pokémon, including their type,
generation, weight, height, and other characteristics.


### Catch Rate Dataset (`catchRate`)
This dataset provides information about the catch rate of each Pokémon.


### Pokémon Mega Evolution and Primal Reversion (`mega`)
This dataset contains information about Pokémon that can undergo Mega Evolution and Primal Reversion.


### Pokémon Effort Value Yields (`evYield`)
A dataset about Pokémon effort value yields per generation.
When a Pokémon is defeated in battle, it will give effort values to the Pokémon that participated in the battle against it. The values shown below are the effort points that a Pokémon will give in.



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
  - `write` (`logical`): Should it write the data to a file?  (Recomended to save the output as this takes time)
  - `root` (`character`): Where to look for files and write them
  - `file` (`character`): Where to save the data without extention if `write == TRUE`
  - `file*` (`character`): Same as file but for other datasets generated
  - NOTE: These functions scrape Bulbapedia, do not call them more then once.  Save the data to file and use it, updating only when required.

## License

This package is licensed under the **Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International Public License (CC BY-NC-SA 4.0)**. This license allows for redistribution and adaptation of the work under the following terms:

- **Attribution**: You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
- **NonCommercial**: You may not use the material for commercial purposes.
- **ShareAlike**: If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original.

This license is designed to protect the rights of the creators while also promoting openness and collaboration. It ensures that the package can be freely used and adapted, as long as appropriate credit is given and the work is not used for commercial purposes. Furthermore, any adaptations of the work must be shared under the same license, promoting the creation of derivative works that are also freely available.

For more details about the CC BY-NC-SA 4.0 license, you can visit the [official webpage](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en).

Additionally, you can refer to the [LICENSE](LICENSE) file included with the package. This file contains the full text of the license, providing a detailed description of the rights and restrictions associated with the use of the package.

Please ensure that you understand and comply with the terms of the license when using this package. If you have any questions about the license, it's recommended to consult with a legal expert.

## Attribution

Data used in this project is sourced from [Bulbagarden](https://bulbagarden.net/home/).

The data has been extracted using rvest, cleaned, and reformatted to be easily readable and usable in R and other applications.
As well as used in R functions as described in the man documentation or by using the help `?` in R.
Note that errors may occur in cleaning/reformating and should be reported as an issue on [GitHub](https://github.com/zekrom-vale/ZekDex/issues).

### License

The data is licensed under the [Creative Commons Attribution-NonCommercial-ShareAlike 2.5 Generic (CC BY-NC-SA 2.5)](https://creativecommons.org/licenses/by-nc-sa/2.5/).

### Acknowledgements

We would like to express our gratitude to the contributors of [Bulbagarden](https://bulbagarden.net/home/) for collecting and maintaining the Pokémon data that we use in this project.
Under no circumstance should anyone use rvest to attack or slowdown the site.  All `gen_*()` functions are intended to be used only for when major updates occur on Bulbagarden.

Please note that this project is not affiliated with, endorsed by, or directly associated with Bulbagarden or the official Pokémon franchise.
