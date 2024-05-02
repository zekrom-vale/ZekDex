# This file contains information about the generated datasets, there is no code in this file

#' Pokemon Data
#'
#' Pokemon National dex information
#'
#' @format A data frame with 12 variables:
#' \describe{
#'   \item{ndex}{\code{integer} National Pokedex number.}
#'   \item{name}{\code{character} Name of the Pokemon.}
#'   \item{form}{\code{character} Form of the Pokemon. NA if the Pokemon does not have a special form.}
#'   \item{regional}{\code{character} Regional form of the Pokemon. NA if the Pokemon does not have a regional form.}
#'   \item{type}{\code{character} Primary type of the Pokemon.}
#'   \item{type2}{\code{character} Secondary type of the Pokemon. NA if the Pokemon does not have a secondary type.}
#'   \item{generation}{\code{integer} The generation the Pokemon was introduced in.}
#'   \item{isLegendary}{\code{logical} Whether the Pokemon is Legendary.}
#'   \item{isMythical}{\code{logical} Whether the Pokemon is Mythical.}
#'   \item{isUltraBeast}{\code{logical} Whether the Pokemon is an Ultra Beast.}
#'   \item{family}{\code{character} Legendary / Mythical family group of the Pokemon. NA if the Pokemon does not belong to a family group.}
#'   \item{size}{\code{character} Legendary / Mythical family size. NA if the Pokemon does not belong to a family group.}
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
#'   \item{family}{\code{character} The family grouping of the Pokémon. Examples include 'Tao trio', 'Super-ancient Pokémon', 'Paradox duo', etc.}
#'   \item{name}{\code{character} The name of the individual Pokémon within the family grouping.}
#'   \item{size}{\code{character} The size category of the family grouping. Categories include 'duos', 'trios', 'quartets', and 'quintets'.}
#' }
#' @source Bulbapedia
#' @examples
#' data(groups)
"groups"

#' Pokemon Data
#'
#' This dataset contains the base stats of Pokémon.
#'
#' @format A data frame with 91 rows and 11 variables:
#' \describe{
#'   \item{ndex}{\code{integer} National Pokédex number}
#'   \item{name}{\code{character} Pokémon name}
#'   \item{HP}{\code{integer} Hit Points}
#'   \item{Attack}{\code{integer} Attack strength}
#'   \item{Defense}{\code{integer} Defensive strength}
#'   \item{Speed}{\code{integer} Speed}
#'   \item{Special}{\code{integer} Special attack or special defense strength}
#'   \item{Total}{\code{integer} Total of all stats}
#'   \item{Average}{\code{numeric} Average of all stats}
#'   \item{Gen}{\code{factor} Generation}
#'   \item{SpAttack}{\code{integer} Special Attack strength (NA for Gen I)}
#'   \item{SpDefense}{\code{integer} Special Defense strength (NA for Gen I)}
#' }
#' @source Bulbapedia
"stats"

#' Pokemon Evolution Dataset
#'
#' This dataset contains evolution and family information.
#'
#' @format A data frame with the following variables:
#' \describe{
#'   \item{family}{\code{character} The family to which the Pokemon belongs.}
#'   \item{base}{\code{character} The prior form of the pokemon or the base form}
#'   \item{form}{\code{character} The specific form of the Pokemon. NA if not applicable.}
#'   \item{method}{\code{character} The method of evolution.}
#'   \item{evo}{\code{character} The next stage of the Pokemon.}
#'   \item{evoForm}{\code{character} The form of next stage of the Pokemon. NA if not applicable.}
#'   \item{transition}{\code{character} The transition stage of the Pokemon.}
#'   \item{first}{\code{character} The first form of the Pokemon.}
#'   \item{firstForm}{\code{character} The specific first form of the Pokemon. NA if not applicable.}
#'   \item{regional}{\code{character} The regional form of the Pokemon. NA if not applicable.}
#'   \item{evoRegional}{\code{character} The regional evolved form of the Pokemon. NA if not applicable.}
#'   \item{firstRegional}{\code{character} The regional first form of the Pokemon. NA if not applicable.}
#' }
#' @source Bulbapedia
"family"

#' Pokemon Dataset
#'
#' This dataset contains evolution and family information.
#'
#' @format A data frame with the following variables:
#' \describe{
#'   \item{family.x}{\code{character} The family of the Pokemon}
#'   \item{transition}{\code{character} The transition stage of the Pokemon}
#'   \item{first}{\code{character} The first form of the Pokemon}
#'   \item{firstForm}{\code{character} The first form of the Pokemon if it has multiple forms}
#'   \item{firstRegional}{\code{character} The first regional form of the Pokemon}
#'   \item{name}{\code{character} The name of the Pokemon}
#'   \item{form}{\code{character} The form of the Pokemon}
#'   \item{regional}{\code{character} The regional form of the Pokemon}
#'   \item{stage}{\code{character} The stage of the Pokemon}
#'   \item{family.y}{\code{character} The legendary family of the Pokemon}
#'   \item{size}{\code{character} The size of the legendary family}
#' }
#' @source Bulbapedia
"familyLong"

#' Pokemon National Dex Information
#'
#' This dataset contains information about Pokemon from the National Dex.
#'
#' @format A data frame with 37 variables:
#' \describe{
#'   \item{ndex}{\code{integer} National Pokedex number.}
#'   \item{name}{\code{character} Name of the Pokemon.}
#'   \item{form}{\code{character} Form of the Pokemon. NA if the Pokemon does not have a special form.}
#'   \item{regional}{\code{character} Regional form of the Pokemon. NA if the Pokemon does not have a regional form.}
#'   \item{type}{\code{character} Primary type of the Pokemon.}
#'   \item{type2}{\code{character} Secondary type of the Pokemon. NA if the Pokemon does not have a secondary type.}
#'   \item{generation}{\code{integer} The generation the Pokemon was introduced in.}
#'   \item{isLegendary}{\code{logical} Whether the Pokemon is Legendary.}
#'   \item{isMythical}{\code{logical} Whether the Pokemon is Mythical.}
#'   \item{isUltraBeast}{\code{logical} Whether the Pokemon is an Ultra Beast.}
#'   \item{family}{\code{character} Legendary / Mythical family group of the Pokemon. NA if the Pokemon does not belong to a family group.}
#'   \item{size}{\code{character} Legendary / Mythical family size. NA if the Pokemon does not belong to a family group.}
#'   \item{Japanese_Kana}{\code{character} Japanese Kana name of the Pokemon.}
#'   \item{Japanese_Hepburn}{\code{character} Japanese Hepburn name of the Pokemon.}
#'   \item{Japanese_Trademarked}{\code{character} Japanese Trademarked name of the Pokemon.}
#'   \item{German_german}{\code{character} German name of the Pokemon.}
#'   \item{French_french}{\code{character} French name of the Pokemon.}
#'   \item{Spanish_spanish}{\code{character} Spanish name of the Pokemon.}
#'   \item{Italian_italian}{\code{character} Italian name of the Pokemon.}
#'   \item{Korean_Hangul}{\code{character} Korean Hangul name of the Pokemon.}
#'   \item{Korean_Revised}{\code{character} Korean Revised name of the Pokemon.}
#'   \item{Korean_McCune-Reischauer}{\code{character} Korean McCune-Reischauer name of the Pokemon.}
#'   \item{Korean_Official}{\code{character} Korean Official name of the Pokemon.}
#'   \item{Chinese_Traditional}{\code{character} Chinese Traditional name of the Pokemon.}
#'   \item{Chinese_Simplified}{\code{character} Chinese Simplified name of the Pokemon.}
#'   \item{Chinese_Pinyin}{\code{character} Chinese Pinyin name of the Pokemon.}
#'   \item{Chinese_Yale}{\code{character} Chinese Yale name of the Pokemon.}
#'   \item{Chinese_Former names}{\code{character} Chinese Former names of the Pokemon.}
#'   \item{Brazilian_Portuguese_brazilian_portuguese}{\code{character} Brazilian Portuguese name of the Pokemon.}
#'   \item{Turkish_turkish}{\code{character} Turkish name of the Pokemon.}
#'   \item{Russian_Cyrillic}{\code{character} Russian Cyrillic name of the Pokemon.}
#'   \item{Russian_Romanization}{\code{character} Russian Romanization name of the Pokemon.}
#'   \item{Thai_Thai}{\code{character} Thai name of the Pokemon.}
#'   \item{Thai_RTGS}{\code{character} Thai RTGS name of the Pokemon.}
#'   \item{Hindi_Devanāgarī}{\code{character} Hindi Devanāgarī name of the Pokemon.}
#'   \item{Hindi_Transliteration}{\code{character} Hindi Transliteration name of the Pokemon.}
#'   \item{Hindi_Romanization}{\code{character} Hindi Romanization name of the Pokemon.}
#' }
#' @source Bulbapedia
#' @examples
#' data(languages)
"languages"

#' Pokemon Dataset
#'
#' This dataset contains information about various Pokemon.
#'
#' @format A data frame with the following variables:
#' \describe{
#'   \item{ndex}{\code{integer} National Pokedex number.}
#'   \item{name}{\code{character} Name of the Pokemon.}
#'   \item{form}{\code{character} Form of the Pokemon.}
#'   \item{regional}{\code{character} Regional form of the Pokemon.}
#'   \item{type}{\code{character} Primary type of the Pokemon.}
#'   \item{type2}{\code{character} Secondary type of the Pokemon.}
#'   \item{generation}{\code{integer} Generation of the Pokemon.}
#'   \item{isLegendary}{\code{logical} Boolean indicating if the Pokemon is Legendary.}
#'   \item{isMythical}{\code{logical} Boolean indicating if the Pokemon is Mythical.}
#'   \item{isUltraBeast}{\code{logical} Boolean indicating if the Pokemon is an Ultra Beast.}
#'   \item{family}{\code{character} Family of the Pokemon.}
#'   \item{size}{\code{character} Size of the Pokemon.}
#'   \item{NA_Kanto_Kdex}{\code{integer} Kanto Pokedex number.}
#'   \item{NA_Johto_Jdex}{\code{integer} Johto Pokedex number.}
#'   \item{GenerationIII_Hoenn_Hdex}{\code{integer} Hoenn Pokedex number in Generation III.}
#'   \item{GenerationVI_Hoenn_Hdex}{\code{integer} Hoenn Pokedex number in Generation VI.}
#'   \item{NA_Sinnoh_Sdex}{\code{integer} Sinnoh Pokedex number.}
#'   \item{BlackandWhite_Unova_Udex}{\code{integer} Unova Pokedex number in Black and White.}
#'   \item{Black2andWhite2_Unova_Udex}{\code{integer} Unova Pokedex number in Black 2 and White 2.}
#'   \item{NA_Blueberry_BBdex}{\code{integer} Blueberry Pokedex number.}
#'   \item{NA_Kalos_CeKdex}{\code{integer} Central Kalos Pokedex number.}
#'   \item{NA_Kalos_CoKdex}{\code{integer} Coastal Kalos Pokedex number.}
#'   \item{NA_Kalos_MoKdex}{\code{integer} Mountain Kalos Pokedex number.}
#'   \item{SunandMoon_Alola_Adex}{\code{integer} Alola Pokedex number in Sun and Moon.}
#'   \item{SunandMoon_Alola_Melemele}{\code{integer} Melemele Pokedex number in Sun and Moon.}
#'   \item{SunandMoon_Alola_Akala}{\code{integer} Akala Pokedex number in Sun and Moon.}
#'   \item{SunandMoon_Alola_Ula'ula}{\code{integer} Ula'ula Pokedex number in Sun and Moon.}
#'   \item{SunandMoon_Alola_Poni}{\code{integer} Poni Pokedex number in Sun and Moon.}
#'   \item{UltraSunandUltraMoon_Alola_Adex}{\code{integer} Alola Pokedex number in Ultra Sun and Ultra Moon.}
#'   \item{UltraSunandUltraMoon_Alola_Melemele}{\code{integer} Melemele Pokedex number in Ultra Sun and Ultra Moon.}
#'   \item{UltraSunandUltraMoon_Alola_Akala}{\code{integer} Akala Pokedex number in Ultra Sun and Ultra Moon.}
#'   \item{UltraSunandUltraMoon_Alola_Ula'ula}{\code{integer} Ula'ula Pokedex number in Ultra Sun and Ultra Moon.}
#'   \item{UltraSunandUltraMoon_Alola_Poni}{\code{integer} Poni Pokedex number in Ultra Sun and Ultra Moon.}
#'   \item{NA_Galar_Gdex}{\code{integer} Galar Pokedex number.}
#'   \item{NA_IsleofArmor_IoAdex}{\code{integer} Isle of Armor Pokedex number.}
#'   \item{NA_CrownTundra_CTdex}{\code{integer} Crown Tundra Pokedex number.}
#'   \item{NA_Hisui_LAdex}{\code{integer} Hisui Pokedex number.}
#'   \item{NA_Paldea_Pdex}{\code{integer} Paldea Pokedex number.}
#'   \item{NA_Kitakami_Kdex}{\code{integer} Kitakami Pokedex number.}
#' }
#' @source Bulbapedia
"regionalDex"

#' Pokemon Types Dataset
#'
#' This dataset contains information about various Pokemon types.
#'
#' @format A data frame with one column:
#' \describe{
#'   \item{types}{\code{character} The types of Pokemon. Possible types include "Grass", "Fire", "Water", "Bug", "Normal", "Dark", "Poison", "Electric", "Ground", "Ice", "Fairy", "Steel", "Fighting", "Psychic", "Rock", "Ghost", "Dragon", "Flying".}
#' }
#' @source Bulbapedia
"types"
