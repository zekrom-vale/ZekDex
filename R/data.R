# This file contains information about the generated datasets, there is no code in this file

#' National PokeDex
#'
#' Pokemon National dex information
#'
#' @format A data frame with 12 variables:
#' \describe{
#'   \item{ndex}{`integer` National Pokedex number.}
#'   \item{name}{`character` Name of the Pokemon.}
#'   \item{form}{`character` Form of the Pokemon. NA if the Pokemon does not have a special form.}
#'   \item{regional}{`character` Regional form of the Pokemon. NA if the Pokemon does not have a regional form.}
#'   \item{type}{`character` Primary type of the Pokemon.}
#'   \item{type2}{`character` Secondary type of the Pokemon. NA if the Pokemon does not have a secondary type.}
#'   \item{generation}{`integer` The generation the Pokemon was introduced in.}
#'   \item{isLegendary}{`logical` Whether the Pokemon is Legendary.}
#'   \item{isMythical}{`logical` Whether the Pokemon is Mythical.}
#'   \item{isUltraBeast}{`logical` Whether the Pokemon is an Ultra Beast.}
#'   \item{family}{`character` Legendary / Mythical family group of the Pokemon. NA if the Pokemon does not belong to a family group.}
#'   \item{size}{`character` Legendary / Mythical family size. NA if the Pokemon does not belong to a family group.}
#' }
#' @source Bulbapedia
#' @examples
#' data(nationalDex)
"nationalDex"

#' Legendary and Mythical Pokémon Groupings
#'
#' A dataset containing Legendary and Mythical Pokémon categorized by their family groupings and sizes.
#'
#' @format A data frame with 3 variables:
#' \describe{
#'   \item{family}{`character` The family grouping of the Pokémon. Examples include 'Tao trio', 'Super-ancient Pokémon', 'Paradox duo', etc.}
#'   \item{name}{`character` The name of the individual Pokémon within the family grouping.}
#'   \item{size}{`character` The size category of the family grouping. Categories include 'duos', 'trios', 'quartets', and 'quintets'.}
#' }
#' @source Bulbapedia
#' @examples
#' data(groups)
"groups"

#' Pokemon Data
#'
#' Base stats of Pokémon including various forms / sizes of Pokémon.
#'
#' @format A data frame with 91 rows and 11 variables:
#' \describe{
#'   \item{ndex}{`integer` National Pokédex number}
#'   \item{name}{`character` Pokémon name}
#'   \item{HP}{`integer` Hit Points}
#'   \item{Attack}{`integer` Attack strength}
#'   \item{Defense}{`integer` Defensive strength}
#'   \item{Speed}{`integer` Speed}
#'   \item{Special}{`integer` Special attack or special defense strength}
#'   \item{Total}{`integer` Total of all stats}
#'   \item{Average}{`numeric` Average of all stats}
#'   \item{Gen}{`factor` Generation}
#'   \item{SpAttack}{`integer` Special Attack strength (NA for Gen I)}
#'   \item{SpDefense}{`integer` Special Defense strength (NA for Gen I)}
#' }
#' @source Bulbapedia
"stats"

#' Pokemon Evolution Dataset
#'
#' Pokemon evolution and family information.
#' This dataset is good if you want to know the evolution tree.
#'
#' @format A data frame with the following variables:
#' \describe{
#'   \item{family}{`character` The family to which the Pokemon belongs.}
#'   \item{base}{`character` The prior form of the pokemon or the base form}
#'   \item{form}{`character` The specific form of the Pokemon. NA if not applicable.}
#'   \item{method}{`character` The method of evolution.}
#'   \item{evo}{`character` The next stage of the Pokemon.}
#'   \item{evoForm}{`character` The form of next stage of the Pokemon. NA if not applicable.}
#'   \item{transition}{`character` The transition stage of the Pokemon.}
#'   \item{first}{`character` The first form of the Pokemon.}
#'   \item{firstForm}{`character` The specific first form of the Pokemon. NA if not applicable.}
#'   \item{regional}{`character` The regional form of the Pokemon. NA if not applicable.}
#'   \item{evoRegional}{`character` The regional evolved form of the Pokemon. NA if not applicable.}
#'   \item{firstRegional}{`character` The regional first form of the Pokemon. NA if not applicable.}
#' }
#' @source Bulbapedia
"family"

#' Pokemon Dataset
#'
#' Extended Pokémon family information.
#' This dataset looses the evolution tree, but is good for finding what Pokémon is in each family.
#' TODO fixing the `family.x` and `family.y`
#'
#' @format A data frame with the following variables:
#' \describe{
#'   \item{family.x}{`character` The family of the Pokemon}
#'   \item{transition}{`character` The transition stage of the Pokemon}
#'   \item{first}{`character` The first form of the Pokemon}
#'   \item{firstForm}{`character` The first form of the Pokemon if it has multiple forms}
#'   \item{firstRegional}{`character` The first regional form of the Pokemon}
#'   \item{name}{`character` The name of the Pokemon}
#'   \item{form}{`character` The form of the Pokemon}
#'   \item{regional}{`character` The regional form of the Pokemon}
#'   \item{stage}{`character` The stage of the Pokemon}
#'   \item{family.y}{`character` The legendary family of the Pokemon}
#'   \item{size}{`character` The size of the legendary family}
#' }
#' @source Bulbapedia
"familyLong"

#' Pokémon National Dex information in multiple languages.
#'
#' As of now the language columns are in the format of `<Language>_<language subset>` if there is no subset it's `<Language>_<language>`.
#'
#' @format A data frame with 37 variables:
#' \describe{
#'   \item{ndex}{`integer` National Pokedex number.}
#'   \item{name}{`character` Name of the Pokemon.}
#'   \item{form}{`character` Form of the Pokemon. NA if the Pokemon does not have a special form.}
#'   \item{regional}{`character` Regional form of the Pokemon. NA if the Pokemon does not have a regional form.}
#'   \item{type}{`character` Primary type of the Pokemon.}
#'   \item{type2}{`character` Secondary type of the Pokemon. NA if the Pokemon does not have a secondary type.}
#'   \item{generation}{`integer` The generation the Pokemon was introduced in.}
#'   \item{isLegendary}{`logical` Whether the Pokemon is Legendary.}
#'   \item{isMythical}{`logical` Whether the Pokemon is Mythical.}
#'   \item{isUltraBeast}{`logical` Whether the Pokemon is an Ultra Beast.}
#'   \item{family}{`character` Legendary / Mythical family group of the Pokemon. NA if the Pokemon does not belong to a family group.}
#'   \item{size}{`character` Legendary / Mythical family size. NA if the Pokemon does not belong to a family group.}
#'   \item{Japanese_Kana}{`character` Japanese Kana name of the Pokemon.}
#'   \item{Japanese_Hepburn}{`character` Japanese Hepburn name of the Pokemon.}
#'   \item{Japanese_Trademarked}{`character` Japanese Trademarked name of the Pokemon.}
#'   \item{German}{`character` German name of the Pokemon.}
#'   \item{French}{`character` French name of the Pokemon.}
#'   \item{Spanish}{`character` Spanish name of the Pokemon.}
#'   \item{Italian}{`character` Italian name of the Pokemon.}
#'   \item{Korean_Hangul}{`character` Korean Hangul name of the Pokemon.}
#'   \item{Korean_Revised}{`character` Korean Revised name of the Pokemon.}
#'   \item{Korean_McCune-Reischauer}{`character` Korean McCune-Reischauer name of the Pokemon.}
#'   \item{Korean_Official}{`character` Korean Official name of the Pokemon.}
#'   \item{Chinese_Traditional}{`character` Chinese Traditional name of the Pokemon.}
#'   \item{Chinese_Simplified}{`character` Chinese Simplified name of the Pokemon.}
#'   \item{Chinese_Pinyin}{`character` Chinese Pinyin name of the Pokemon.}
#'   \item{Chinese_Yale}{`character` Chinese Yale name of the Pokemon.}
#'   \item{Chinese_Former names}{`character` Chinese Former names of the Pokemon.}
#'   \item{Brazilian_Portuguese_brazilian_portuguese}{`character` Brazilian Portuguese name of the Pokemon.}
#'   \item{Turkish}{`character` Turkish name of the Pokemon.}
#'   \item{Russian_Cyrillic}{`character` Russian Cyrillic name of the Pokemon.}
#'   \item{Russian_Romanization}{`character` Russian Romanization name of the Pokemon.}
#'   \item{Thai}{`character` Thai name of the Pokemon.}
#'   \item{Thai_RTGS}{`character` Thai RTGS name of the Pokemon.}
#'   \item{Hindi_Devanāgarī}{`character` Hindi Devanāgarī name of the Pokemon.}
#'   \item{Hindi_Transliteration}{`character` Hindi Transliteration name of the Pokemon.}
#'   \item{Hindi_Romanization}{`character` Hindi Romanization name of the Pokemon.}
#' }
#' @source Bulbapedia
#' @examples
#' data(languages)
"languages"

#' Pokémon information from the Regional Dex.
#'
#' As of now the regionalDex columns are in the format of `<Game>_<Region>_<DexName>`, `NA` if that data is missing.
#'
#' @format A data frame with the following variables:
#' \describe{
#'   \item{ndex}{`integer` National Pokedex number.}
#'   \item{name}{`character` Name of the Pokemon.}
#'   \item{form}{`character` Form of the Pokemon.}
#'   \item{regional}{`character` Regional form of the Pokemon.}
#'   \item{type}{`character` Primary type of the Pokemon.}
#'   \item{type2}{`character` Secondary type of the Pokemon.}
#'   \item{generation}{`integer` Generation of the Pokemon.}
#'   \item{isLegendary}{`logical` Boolean indicating if the Pokemon is Legendary.}
#'   \item{isMythical}{`logical` Boolean indicating if the Pokemon is Mythical.}
#'   \item{isUltraBeast}{`logical` Boolean indicating if the Pokemon is an Ultra Beast.}
#'   \item{family}{`character` Family of the Pokemon.}
#'   \item{size}{`character` Size of the Pokemon.}
#'   \item{NA_Kanto_Kdex}{`integer` Kanto Pokedex number.}
#'   \item{NA_Johto_Jdex}{`integer` Johto Pokedex number.}
#'   \item{GenerationIII_Hoenn_Hdex}{`integer` Hoenn Pokedex number in Generation III.}
#'   \item{GenerationVI_Hoenn_Hdex}{`integer` Hoenn Pokedex number in Generation VI.}
#'   \item{NA_Sinnoh_Sdex}{`integer` Sinnoh Pokedex number.}
#'   \item{BlackandWhite_Unova_Udex}{`integer` Unova Pokedex number in Black and White.}
#'   \item{Black2andWhite2_Unova_Udex}{`integer` Unova Pokedex number in Black 2 and White 2.}
#'   \item{NA_Blueberry_BBdex}{`integer` Blueberry Pokedex number.}
#'   \item{NA_Kalos_CeKdex}{`integer` Central Kalos Pokedex number.}
#'   \item{NA_Kalos_CoKdex}{`integer` Coastal Kalos Pokedex number.}
#'   \item{NA_Kalos_MoKdex}{`integer` Mountain Kalos Pokedex number.}
#'   \item{SunandMoon_Alola_Adex}{`integer` Alola Pokedex number in Sun and Moon.}
#'   \item{SunandMoon_Alola_Melemele}{`integer` Melemele Pokedex number in Sun and Moon.}
#'   \item{SunandMoon_Alola_Akala}{`integer` Akala Pokedex number in Sun and Moon.}
#'   \item{SunandMoon_Alola_Ula'ula}{`integer` Ula'ula Pokedex number in Sun and Moon.}
#'   \item{SunandMoon_Alola_Poni}{`integer` Poni Pokedex number in Sun and Moon.}
#'   \item{UltraSunandUltraMoon_Alola_Adex}{`integer` Alola Pokedex number in Ultra Sun and Ultra Moon.}
#'   \item{UltraSunandUltraMoon_Alola_Melemele}{`integer` Melemele Pokedex number in Ultra Sun and Ultra Moon.}
#'   \item{UltraSunandUltraMoon_Alola_Akala}{`integer` Akala Pokedex number in Ultra Sun and Ultra Moon.}
#'   \item{UltraSunandUltraMoon_Alola_Ula'ula}{`integer` Ula'ula Pokedex number in Ultra Sun and Ultra Moon.}
#'   \item{UltraSunandUltraMoon_Alola_Poni}{`integer` Poni Pokedex number in Ultra Sun and Ultra Moon.}
#'   \item{NA_Galar_Gdex}{`integer` Galar Pokedex number.}
#'   \item{NA_IsleofArmor_IoAdex}{`integer` Isle of Armor Pokedex number.}
#'   \item{NA_CrownTundra_CTdex}{`integer` Crown Tundra Pokedex number.}
#'   \item{NA_Hisui_LAdex}{`integer` Hisui Pokedex number.}
#'   \item{NA_Paldea_Pdex}{`integer` Paldea Pokedex number.}
#'   \item{NA_Kitakami_Kdex}{`integer` Kitakami Pokedex number.}
#' }
#' @source Bulbapedia
"regionalDex"

#' Pokemon Types Dataset
#'
#' This dataset contains information about various Pokemon types.
#'
#' @format A data frame with one column:
#' \describe{
#'   \item{types}{`character` The types of Pokemon. Possible types include "Grass", "Fire", "Water", "Bug", "Normal", "Dark", "Poison", "Electric", "Ground", "Ice", "Fairy", "Steel", "Fighting", "Psychic", "Rock", "Ghost", "Dragon", "Flying".}
#' }
#' @source Bulbapedia
"types"
