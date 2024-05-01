#' Pokemon Data
#'
#' Pokemon National dex information
#'
#' @format A data frame with 12 variables:
#' \describe{
#'   \item{ndex}{National Pokedex number. Integer.}
#'   \item{name}{Name of the Pokemon. Character.}
#'   \item{form}{Form of the Pokemon. Character. NA if the Pokemon does not have a special form.}
#'   \item{regional}{Regional form of the Pokemon. Character. NA if the Pokemon does not have a regional form.}
#'   \item{type}{Primary type of the Pokemon. Character.}
#'   \item{type2}{Secondary type of the Pokemon. Character. NA if the Pokemon does not have a secondary type.}
#'   \item{generation}{The generation the Pokemon was introduced in. Integer.}
#'   \item{isLegendary}{Whether the Pokemon is Legendary. Logical.}
#'   \item{isMythical}{Whether the Pokemon is Mythical. Logical.}
#'   \item{isUltraBeast}{Whether the Pokemon is an Ultra Beast. Logical.}
#'   \item{family}{Legendary / Mythical family group of the Pokemon. Character. NA if the Pokemon does not belong to a family group.}
#'   \item{size}{Legendary / Mythical family size. NA if the Pokemon does not belong to a family group.}
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
#'   \item{family}{The family grouping of the Pokémon. Character. Examples include 'Tao trio', 'Super-ancient Pokémon', 'Paradox duo', etc.}
#'   \item{name}{The name of the individual Pokémon within the family grouping. Character.}
#'   \item{size}{The size category of the family grouping. Character. Categories include 'duos', 'trios', 'quartets', and 'quintets'.}
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
#'   \item{Sp. Attack}{\code{integer} Special Attack strength (NA for Gen I)}
#'   \item{Sp. Defense}{\code{integer} Special Defense strength (NA for Gen I)}
#' }
#' @source Bulbapedia
"stats"

#' Pokemon Evolution Dataset
#'
#' This dataset contains evolution and family information.
#'
#' @format A data frame with the following variables:
#' \describe{
#'   \item{family}{Character. The family to which the Pokemon belongs.}
#'   \item{base}{Character. The prior form of the pokemon or the base form}
#'   \item{form}{Character. The specific form of the Pokemon. NA if not applicable.}
#'   \item{method}{Character. The method of evolution.}
#'   \item{evo}{Character. The next stage of the Pokemon.}
#'   \item{evoForm}{Character. The form of next stage of the Pokemon. NA if not applicable.}
#'   \item{transition}{Character. The transition stage of the Pokemon.}
#'   \item{first}{Character. The first form of the Pokemon.}
#'   \item{firstForm}{Character. The specific first form of the Pokemon. NA if not applicable.}
#'   \item{regional}{Character. The regional form of the Pokemon. NA if not applicable.}
#'   \item{evoRegional}{Character. The regional evolved form of the Pokemon. NA if not applicable.}
#'   \item{firstRegional}{Character. The regional first form of the Pokemon. NA if not applicable.}
#' }
#' @source Bulbapedia
"family"

#' Pokemon Dataset
#'
#' This dataset contains evolution and family information.
#'
#' @format A data frame with the following variables:
#' \describe{
#'   \item{family.x}{The family of the Pokemon}
#'   \item{transition}{The transition stage of the Pokemon}
#'   \item{first}{The first form of the Pokemon}
#'   \item{firstForm}{The first form of the Pokemon if it has multiple forms}
#'   \item{firstRegional}{The first regional form of the Pokemon}
#'   \item{name}{The name of the Pokemon}
#'   \item{form}{The form of the Pokemon}
#'   \item{regional}{The regional form of the Pokemon}
#'   \item{stage}{The stage of the Pokemon}
#'   \item{family.y}{The legendary family of the Pokemon}
#'   \item{size}{The size of the legendary family}
#' }
#' @source Bulbapedia
"familyLong"

#' Pokemon National Dex Information
#'
#' This dataset contains information about Pokemon from the National Dex.
#'
#' @format A data frame with 37 variables:
#' \describe{
#'   \item{ndex}{National Pokedex number. Integer.}
#'   \item{name}{Name of the Pokemon. Character.}
#'   \item{form}{Form of the Pokemon. Character. NA if the Pokemon does not have a special form.}
#'   \item{regional}{Regional form of the Pokemon. Character. NA if the Pokemon does not have a regional form.}
#'   \item{type}{Primary type of the Pokemon. Character.}
#'   \item{type2}{Secondary type of the Pokemon. Character. NA if the Pokemon does not have a secondary type.}
#'   \item{generation}{The generation the Pokemon was introduced in. Integer.}
#'   \item{isLegendary}{Whether the Pokemon is Legendary. Logical.}
#'   \item{isMythical}{Whether the Pokemon is Mythical. Logical.}
#'   \item{isUltraBeast}{Whether the Pokemon is an Ultra Beast. Logical.}
#'   \item{family}{Legendary / Mythical family group of the Pokemon. Character. NA if the Pokemon does not belong to a family group.}
#'   \item{size}{Legendary / Mythical family size. NA if the Pokemon does not belong to a family group.}
#'   \item{Japanese_Kana}{Japanese Kana name of the Pokemon. Character.}
#'   \item{Japanese_Hepburn}{Japanese Hepburn name of the Pokemon. Character.}
#'   \item{Japanese_Trademarked}{Japanese Trademarked name of the Pokemon. Character.}
#'   \item{German_german}{German name of the Pokemon. Character.}
#'   \item{French_french}{French name of the Pokemon. Character.}
#'   \item{Spanish_spanish}{Spanish name of the Pokemon. Character.}
#'   \item{Italian_italian}{Italian name of the Pokemon. Character.}
#'   \item{Korean_Hangul}{Korean Hangul name of the Pokemon. Character.}
#'   \item{Korean_Revised}{Korean Revised name of the Pokemon. Character.}
#'   \item{Korean_McCune-Reischauer}{Korean McCune-Reischauer name of the Pokemon. Character.}
#'   \item{Korean_Official}{Korean Official name of the Pokemon. Character.}
#'   \item{Chinese_Traditional}{Chinese Traditional name of the Pokemon. Character.}
#'   \item{Chinese_Simplified}{Chinese Simplified name of the Pokemon. Character.}
#'   \item{Chinese_Pinyin}{Chinese Pinyin name of the Pokemon. Character.}
#'   \item{Chinese_Yale}{Chinese Yale name of the Pokemon. Character.}
#'   \item{Chinese_Former names}{Chinese Former names of the Pokemon. Character.}
#'   \item{Brazilian_Portuguese_brazilian_portuguese}{Brazilian Portuguese name of the Pokemon. Character.}
#'   \item{Turkish_turkish}{Turkish name of the Pokemon. Character.}
#'   \item{Russian_Cyrillic}{Russian Cyrillic name of the Pokemon. Character.}
#'   \item{Russian_Romanization}{Russian Romanization name of the Pokemon. Character.}
#'   \item{Thai_Thai}{Thai name of the Pokemon. Character.}
#'   \item{Thai_RTGS}{Thai RTGS name of the Pokemon. Character.}
#'   \item{Hindi_Devanāgarī}{Hindi Devanāgarī name of the Pokemon. Character.}
#'   \item{Hindi_Transliteration}{Hindi Transliteration name of the Pokemon. Character.}
#'   \item{Hindi_Romanization}{Hindi Romanization name of the Pokemon. Character.}
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
#'   \item{ndex}{National Pokedex number.}
#'   \item{name}{Name of the Pokemon.}
#'   \item{form}{Form of the Pokemon.}
#'   \item{regional}{Regional form of the Pokemon.}
#'   \item{type}{Primary type of the Pokemon.}
#'   \item{type2}{Secondary type of the Pokemon.}
#'   \item{generation}{Generation of the Pokemon.}
#'   \item{isLegendary}{Boolean indicating if the Pokemon is Legendary.}
#'   \item{isMythical}{Boolean indicating if the Pokemon is Mythical.}
#'   \item{isUltraBeast}{Boolean indicating if the Pokemon is an Ultra Beast.}
#'   \item{family}{Family of the Pokemon.}
#'   \item{size}{Size of the Pokemon.}
#'   \item{NA_Kanto_Kdex}{Kanto Pokedex number.}
#'   \item{NA_Johto_Jdex}{Johto Pokedex number.}
#'   \item{GenerationIII_Hoenn_Hdex}{Hoenn Pokedex number in Generation III.}
#'   \item{GenerationVI_Hoenn_Hdex}{Hoenn Pokedex number in Generation VI.}
#'   \item{NA_Sinnoh_Sdex}{Sinnoh Pokedex number.}
#'   \item{BlackandWhite_Unova_Udex}{Unova Pokedex number in Black and White.}
#'   \item{Black2andWhite2_Unova_Udex}{Unova Pokedex number in Black 2 and White 2.}
#'   \item{NA_Blueberry_BBdex}{Blueberry Pokedex number.}
#'   \item{NA_Kalos_CeKdex}{Central Kalos Pokedex number.}
#'   \item{NA_Kalos_CoKdex}{Coastal Kalos Pokedex number.}
#'   \item{NA_Kalos_MoKdex}{Mountain Kalos Pokedex number.}
#'   \item{SunandMoon_Alola_Adex}{Alola Pokedex number in Sun and Moon.}
#'   \item{SunandMoon_Alola_Melemele}{Melemele Pokedex number in Sun and Moon.}
#'   \item{SunandMoon_Alola_Akala}{Akala Pokedex number in Sun and Moon.}
#'   \item{SunandMoon_Alola_Ula'ula}{Ula'ula Pokedex number in Sun and Moon.}
#'   \item{SunandMoon_Alola_Poni}{Poni Pokedex number in Sun and Moon.}
#'   \item{UltraSunandUltraMoon_Alola_Adex}{Alola Pokedex number in Ultra Sun and Ultra Moon.}
#'   \item{UltraSunandUltraMoon_Alola_Melemele}{Melemele Pokedex number in Ultra Sun and Ultra Moon.}
#'   \item{UltraSunandUltraMoon_Alola_Akala}{Akala Pokedex number in Ultra Sun and Ultra Moon.}
#'   \item{UltraSunandUltraMoon_Alola_Ula'ula}{Ula'ula Pokedex number in Ultra Sun and Ultra Moon.}
#'   \item{UltraSunandUltraMoon_Alola_Poni}{Poni Pokedex number in Ultra Sun and Ultra Moon.}
#'   \item{NA_Galar_Gdex}{Galar Pokedex number.}
#'   \item{NA_IsleofArmor_IoAdex}{Isle of Armor Pokedex number.}
#'   \item{NA_CrownTundra_CTdex}{Crown Tundra Pokedex number.}
#'   \item{NA_Hisui_LAdex}{Hisui Pokedex number.}
#'   \item{NA_Paldea_Pdex}{Paldea Pokedex number.}
#'   \item{NA_Kitakami_Kdex}{Kitakami Pokedex number.}
#' }
"regionalDex"

#' Pokemon Types Dataset
#'
#' This dataset contains information about various Pokemon types.
#'
#' @format A data frame with one column:
#' \describe{
#'   \item{types}{The types of Pokemon. Possible types include "Grass", "Fire", "Water", "Bug", "Normal", "Dark", "Poison", "Electric", "Ground", "Ice", "Fairy", "Steel", "Fighting", "Psychic", "Rock", "Ghost", "Dragon", "Flying".}
#' }
"types"
