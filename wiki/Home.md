# Welcome to the ZekDex Wiki!

ZekDex is an R package that provides comprehensive datasets about Pokémon.
It's a valuable resource for both Pokémon enthusiasts and data scientists.
The package includes a wide array of datasets that cover various aspects of Pokémon, making it a unique and rich resource.

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
devtools::install_github("zekrom-vale/ZekDex")

# Or, install the main branch of the package ZekDex (May be in an unusable state)
devtools::install_github("zekrom-vale/ZekDex", ref = "main")

# Or, install a specific version of the package ZekDex using a tag
# For example, to install version v0.1.3-beta:
devtools::install_github("zekrom-vale/ZekDex", ref = "v0.1.3-beta")
```

## Download and Extract

Here's how you can download and extract these files using Python, Command Prompt (cmd), and Shell:

### Python

You can use the `requests` and `zipfile` libraries in Python to download and extract the zip file:

```python
import requests, zipfile, io

url = "https://raw.githubusercontent.com/zekrom-vale/ZekDex/stable/data/data.zip"
response = requests.get(url)
zip_file = zipfile.ZipFile(io.BytesIO(response.content))
zip_file.extractall("data") # path to the extraction directory
```

### Command Prompt (cmd)

In Windows, you can use `curl` to download the file and `tar` to extract it:

```cmd
curl -L -o data.tar.gz "https://raw.githubusercontent.com/zekrom-vale/ZekDex/stable/data/data.tar.gz"
tar -xvzf data.tar.gz -C "data" :: path to the extraction directory
```

### Shell

In Unix-based systems, you can use `wget` to download the file and `tar` to extract it:

```bash
wget "https://raw.githubusercontent.com/zekrom-vale/ZekDex/stable/data/data.tar.gz"
tar -xvzf data.tar.gz -C "data" # path to the extraction directory
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



For more details about each dataset, please visit the respective pages.

## License

This package is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International Public License (CC BY-NC-SA 4.0). This license allows for redistribution and adaptation of the work under the following terms:

- **Attribution**: You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
- **NonCommercial**: You may not use the material for commercial purposes.
- **ShareAlike**: If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original.

## Attribution

Data used in this project is sourced from [Bulbagarden](https://bulbagarden.net/home/).

The data has been extracted using rvest, cleaned, and reformatted to be easily readable and usable in R and other applications.
As well as used in R functions as described in the man documentation or by using the help `?` in R.
Note that errors may occur in cleaning/reformating and should be reported as an issue on [GitHub](https://github.com/zekrom-vale/ZekDex/issues).

### License

The data is licensed under the [Creative Commons Attribution-NonCommercial-ShareAlike 2.5 Generic (CC BY-NC-SA 2.5)](https://creativecommons.org/licenses/by-nc-sa/2.5/).

### Acknowledgements

We would like to express our gratitude to the contributors of [Bulbagarden](https://bulbagarden.net/home/) for collecting and maintaining the Pokémon data that we use in this project.
All `gen_*()` functions caches the HTML and only request changed content from Bulbagarden.

Please note that this project is not affiliated with, endorsed by, or directly associated with Bulbagarden or the official Pokémon franchise.
