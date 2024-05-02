# ZekDex

ZekDex is an R package that provides datasets about Pokémon, including National Dex information, Legendary and Mythical Pokémon groupings, base stats, evolution and family information, and more. It also includes functions to generate random Pokémon.

## Datasets

The package includes the following datasets:

### nationalDex
Pokemon National dex information
- `ndex` (`integer`):  National Pokedex number.
- `name` (`character`): Name of the Pokemon.
- `form` (`character`): Form of the Pokemon. NA if the Pokemon does not have a special form.
- `regional` (`character`): Regional form of the Pokemon. NA if the Pokemon does not have a regional form.
- `type` (`character`): Primary type of the Pokemon.
- `type2` (`character`): Secondary type of the Pokemon. NA if the Pokemon does not have a secondary type.
- `generation` (`integer`): The generation the Pokemon was introduced in.
- `isLegendary` (`logical`): Whether the Pokemon is Legendary.
- `isMythical` (`logical`): Whether the Pokemon is Mythical.
- `isUltraBeast` (`logical`): Whether the Pokemon is an Ultra Beast.
- `family` (`character`): Legendary / Mythical family group of the Pokemon. NA if the Pokemon does not belong to a family group.
- `size` (`character`): Legendary / Mythical family size. NA if the Pokemon does not belong to a family group.

### groups
Legendary and Mythical Pokémon Groupings
- `family` (`character`): The family grouping of the Pokémon. Examples include 'Tao trio', 'Super-ancient Pokémon', 'Paradox duo', etc.
- `name` (`character`): The name of the individual Pokémon within the family grouping.
- `size` (`character`): The size category of the family grouping. Categories include 'duos', 'trios', 'quartets', and 'quintets'.

### stats
Base stats of Pokémon
- `ndex` (`integer`): National Pokédex number
- `name` (`character`): Pokémon name
- `HP` (`integer`): Hit Points
- `Attack` (`integer`): Attack strength
- `Defense` (`integer`): Defensive strength
- `Speed` (`integer`): Speed
- `Special` (`integer`): Special attack or special defense strength
- `Total` (`integer`): Total of all stats
- `Average` (`numeric`): Average of all stats
- `Gen` (`factor`): Generation
- `SpAttack` (`integer`): Special Attack strength (NA for Gen I)
- `SpDefense` (`integer`): Special Defense strength (NA for Gen I)

### family
Pokemon evolution and family information
- `family` (`character`): The family to which the Pokemon belongs.
- `base` (`character`): The prior form of the pokemon or the base form
- `form` (`character`): The specific form of the Pokemon. NA if not applicable.
- `method` (`character`): The method of evolution.
- `evo` (`character`): The next stage of the Pokemon.
- `evoForm` (`character`): The form of next stage of the Pokemon. NA if not applicable.
- `transition` (`character`): The transition stage of the Pokemon.
- `first` (`character`): The first form of the Pokemon.
- `firstForm` (`character`): The specific first form of the Pokemon. NA if not applicable.
- `regional` (`character`): The regional form of the Pokemon. NA if not applicable.
- `evoRegional` (`character`): The regional evolved form of the Pokemon. NA if not applicable.
- `firstRegional` (`character`): The regional first form of the Pokemon. NA if not applicable.

### familyLong
Extended Pokémon family information
- `family.x` (`character`): The family of the Pokemon
- `transition` (`character`): The transition stage of the Pokemon
- `first` (`character`): The first form of the Pokemon
- `firstForm` (`character`): The first form of the Pokemon if it has multiple forms
- `firstRegional` (`character`): The first regional form of the Pokemon
- `name` (`character`): The name of the Pokemon
- `form` (`character`): The form of the Pokemon
- `regional` (`character`): The regional form of the Pokemon
- `stage` (`character`): The stage of the Pokemon
- `family.y` (`character`): The legendary family of the Pokemon
- `size` (`character`): The size of the legendary family

### languages
Pokémon National Dex information in multiple languages
- `ndex` (`integer`): National Pokedex number.
- `name` (`character`): Name of the Pokemon.
- `form` (`character`): Form of the Pokemon. NA if the Pokemon does not have a special form.
- `regional` (`character`): Regional form of the Pokemon. NA if the Pokemon does not have a regional form.
- `type` (`character`): Primary type of the Pokemon.
- `type2` (`character`): Secondary type of the Pokemon. NA if the Pokemon does not have a secondary type.
- `generation` (`integer`): The generation the Pokemon was introduced in.
- `isLegendary` (`logical`): Whether the Pokemon is Legendary.
- `isMythical` (`logical`): Whether the Pokemon is Mythical.
- `isUltraBeast` (`logical`): Whether the Pokemon is an Ultra Beast.
- `family` (`character`): Legendary / Mythical family group of the Pokemon. NA if the Pokemon does not belong to a family group.
- `size` (`character`): Legendary / Mythical family size. NA if the Pokemon does not belong to a family group.
- `Japanese_Kana` (`character`): Japanese Kana name of the Pokemon.
- `Japanese_Hepburn` (`character`): Japanese Hepburn name of the Pokemon.
- `Japanese_Trademarked` (`character`): Japanese Trademarked name of the Pokemon.
- `German_german` (`character`): German name of the Pokemon.
- `French_french` (`character`): French name of the Pokemon.
- `Spanish_spanish` (`character`): Spanish name of the Pokemon.
- `Italian_italian` (`character`): Italian name of the Pokemon.
- `Korean_Hangul` (`character`): Korean Hangul name of the Pokemon.
- `Korean_Revised` (`character`): Korean Revised name of the Pokemon.
- `Korean_McCune-Reischauer` (`character`): Korean McCune-Reischauer name of the Pokemon.
- `Korean_Official` (`character`): Korean Official name of the Pokemon.
- `Chinese_Traditional` (`character`): Chinese Traditional name of the Pokemon.
- `Chinese_Simplified` (`character`): Chinese Simplified name of the Pokemon.
- `Chinese_Pinyin` (`character`): Chinese Pinyin name of the Pokemon.
- `Chinese_Yale` (`character`): Chinese Yale name of the Pokemon.
- `Chinese_Former names` (`character`): Chinese Former names of the Pokemon.
- `Brazilian_Portuguese_brazilian_portuguese` (`character`): Brazilian Portuguese name of the Pokemon.
- `Turkish_turkish` (`character`): Turkish name of the Pokemon.
- `Russian_Cyrillic` (`character`): Russian Cyrillic name of the Pokemon.
- `Russian_Romanization` (`character`): Russian Romanization name of the Pokemon.
- `Thai_Thai` (`character`): Thai name of the Pokemon.
- `Thai_RTGS` (`character`): Thai RTGS name of the Pokemon.
- `Hindi_Devanāgarī` (`character`): Hindi Devanāgarī name of the Pokemon.
- `Hindi_Transliteration` (`character`): Hindi Transliteration name of the Pokemon.
- `Hindi_Romanization` (`character`): Hindi Romanization name of the Pokemon.

### regionalDex
Pokémon information from the Regional Dex
- `ndex` (`integer`): National Pokedex number.
- `name` (`character`): Name of the Pokemon.
- `form` (`character`): Form of the Pokemon. NA if the Pokemon does not have a special form.
- `regional` (`character`): Regional form of the Pokemon. NA if the Pokemon does not have a regional form.
- `type` (`character`): Primary type of the Pokemon.
- `type2` (`character`): Secondary type of the Pokemon. NA if the Pokemon does not have a secondary type.
- `generation` (`integer`): The generation the Pokemon was introduced in.
- `isLegendary` (`logical`): Whether the Pokemon is Legendary.
- `isMythical` (`logical`): Whether the Pokemon is Mythical.
- `isUltraBeast` (`logical`): Whether the Pokemon is an Ultra Beast.
- `family` (`character`): Legendary / Mythical family group of the Pokemon. NA if the Pokemon does not belong to a family group.
- `size` (`character`): Legendary / Mythical family size. NA if the Pokemon does not belong to a family group.
- `NA_Kanto_Kdex` (`integer`): Kanto Pokedex number.
- `NA_Johto_Jdex` (`integer`): Johto Pokedex number.
- `GenerationIII_Hoenn_Hdex` (`integer`): Hoenn Pokedex number in Generation III.
- `GenerationVI_Hoenn_Hdex` (`integer`): Hoenn Pokedex number in Generation VI.
- `NA_Sinnoh_Sdex` (`integer`): Sinnoh Pokedex number.
- `BlackandWhite_Unova_Udex` (`integer`): Unova Pokedex number in Black and White.
- `Black2andWhite2_Unova_Udex` (`integer`): Unova Pokedex number in Black 2 and White 2.
- `NA_Blueberry_BBdex` (`integer`): Blueberry Pokedex number.
- `NA_Kalos_CeKdex` (`integer`): Central Kalos Pokedex number.
- `NA_Kalos_CoKdex` (`integer`): Coastal Kalos Pokedex number.
- `NA_Kalos_MoKdex` (`integer`): Mountain Kalos Pokedex number.
- `SunandMoon_Alola_Adex` (`integer`): Alola Pokedex number in Sun and Moon.
- `SunandMoon_Alola_Melemele` (`integer`): Melemele Pokedex number in Sun and Moon.
- `SunandMoon_Alola_Akala` (`integer`): Akala Pokedex number in Sun and Moon.
- `SunandMoon_Alola_Ula'ula` (`integer`): Ula'ula Pokedex number in Sun and Moon.
- `SunandMoon_Alola_Poni` (`integer`): Poni Pokedex number in Sun and Moon.
- `UltraSunandUltraMoon_Alola_Adex` (`integer`): Alola Pokedex number in Ultra Sun and Ultra Moon.
- `UltraSunandUltraMoon_Alola_Melemele` (`integer`): Melemele Pokedex number in Ultra Sun and Ultra Moon.
- `UltraSunandUltraMoon_Alola_Akala` (`integer`): Akala Pokedex number in Ultra Sun and Ultra Moon.
- `UltraSunandUltraMoon_Alola_Ula'ula` (`integer`): Ula'ula Pokedex number in Ultra Sun and Ultra Moon.
- `UltraSunandUltraMoon_Alola_Poni` (`integer`): Poni Pokedex number in Ultra Sun and Ultra Moon.
- `NA_Galar_Gdex` (`integer`): Galar Pokedex number.
- `NA_IsleofArmor_IoAdex` (`integer`): Isle of Armor Pokedex number.
- `NA_CrownTundra_CTdex` (`integer`): Crown Tundra Pokedex number.
- `NA_Hisui_LAdex` (`integer`): Hisui Pokedex number.
- `NA_Paldea_Pdex` (`integer`): Paldea Pokedex number.
- `NA_Kitakami_Kdex` (`integer`): Kitakami Pokedex number.

### types
Information about various Pokémon types
- `types` (`character`): The types of Pokemon. Possible types include "Grass", "Fire", "Water", "Bug", "Normal", "Dark", "Poison", "Electric", "Ground", "Ice", "Fairy", "Steel", "Fighting", "Psychic", "Rock", "Ghost", "Dragon", "Flying".


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
