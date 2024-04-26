#' Returns a random Pokemon type
#'
#' @param n The number of random types to return. If n is less than 0, it returns "Zekrom".
#' @param replace Should sampling be with replacement?
#' @param types The data frame containing the Pokemon types. By default, it uses the "PokemonNational" data from the "ZekDex" package.
#' @importFrom utils data
#' @return A vector of random Pokemon types
#' @export
randomType = function(n=1, replace = FALSE, types = data("PokemonNational", package = "ZekDex")){
	if(n < 0) return("Zekrom")
	sample(types, n, replace = replace)
}


#' Returns a random Pokemon
#'
#' @param n How many
#' @param type Filter on type
#' @param type2 Filter on type2
#' @param swap Allow type to match type2 and vicea-versa
#' @param replace Allow duplicates from sample (Ie replace what is pulled)
#' @param p What column to return (Ndex, English, form, form2, type, type2 can be used)
#' @param data Override the data (Must have type and type2 (If type 2 is not ANY or swap is TRUE))
#'
#' @examples
#' # Get a random Pokemon
#' randomPokemon()
#' # > [1] "Koraidon"
#'
#' # Get a random Dragon type
#' randomPokemon(type = "Dragon")
#' > [1] "Zekrom"
#'
#' # Get 6 random Dragon Pokemon
#' randomPokemon(6, type = "Dragon")
#' # > [1] "Dragapult" "Jangmo-o" "Rayquaza" "Zekrom" "Garchomp" "Haxorus"
#' # Get a random Dragon-Electric Pokemon
#' randomPokemon(type = "Dragon", type2 = "Electric")
#' # > [1] "Zekrom"
#'
#' # Get a random Dragon-Electric or Electric-Dragon Pokemon
#' randomPokemon(type = "Dragon", type2 = "Electric", swap = TRUE)
#' # > [1] "Miraidon"
#'
#' # Get All random Dragon-\* or \*-Dragon Pokemon
#' randomPokemon(n = -1, type = "Dragon", swap = TRUE)
#' # > [1] "Zekrom" "Dreepy" "Guzzlord" "Archaludon" "Dragonite" "Raging Bolt" "Frigibax" "Zweilous" "Goodra"
#' # > [10] "Rayquaza" "Regidrago" "Garchomp" "Kingdra" "Roaring Moon" "Drakloak" "Jangmo-o" "Bagon" "Eternatus"
#' # > [19] "Turtonator" "Altaria" "Goomy" "Baxcalibur" "Hydreigon" "Druddigon" "Hydrapple" "Miraidon" "Dragapult"
#' # > [28] "Salamence" "Drampa" "Fraxure" "Duraludon" "Zygarde" "Cyclizar" "Haxorus" "Dipplin" "Dratini"
#' # > [37] "Dracovish" "Noibat" "Gouging Fire" "Latios" "Kyurem" "Latias" "Palkia" "Walking Wake" "Kommo-o"
#' # > [46] "Sliggoo" "Vibrava" "Giratina" "Dracozolt" "Flygon" "Tyrunt" "Shelgon" "Tatsugiri" "Dragalge"
#' # > [55] "Axew" "Zygarde50" "Arctibax" "Tyrantrum" "Flapple" "Gible" "Deino" "Applin" "Exeggutor"
#' # > [64] "Hakamo-o" "Noivern" "Koraidon" "Dragonair" "Dialga" "Gabite" "Appletun" "Reshiram" "Naganadel"
#' # > [73] "Zygarde10"
#'
#' # Return the dex number instead
#' randomPokemon(n = -1, type = "Dragon", swap = TRUE, p = Ndex)
#' # > [1] "#1011" "#1019" "#0371" "#0633" "#0634" "#0841" "#0334" "#0691" "#0644" "#0718" "#0782" "#0381" "#0445" "#0804" "#0840" "#0704" "#0799"
#' # > [18] "#0886" "#0380" "#0330" "#0842" "#0880" "#0714" "#0147" "#0895" "#0646" "#0635" "#0705" "#0884" "#1018" "#0967" "#0384" "#0372" "#0373"
#' # > [35] "#0621" "#0780" "#0696" "#0887" "#0483" "#1008" "#0882" "#0706" "#0697" "#1005" "#0784" "#0610" "#0978" "#0998" "#0890" "#0997" "#0148"
#' # > [52] "#0443" "#0715" "#0776" "#0230" "#0611" "#0783" "#0996" "#1020" "#0103" "#0643" "#1009" "#0487" "#0329" "#0885" "#0612" "#0444" "#0149"
#' # > [69] "#1021" "#1007" "#0484"
#'
#' @importFrom dplyr enquo mutate filter pull
#' @importFrom glue glue
#' @importFrom utils data
randomPokemon = function(
		n=1,
		type = "ANY",
		type2 = "ANY",
		swap = FALSE,
		p = English,
		replace = FALSE,
		data = data("PokemonNational", package = "ZekDex")
	){
	# Quosure to capture the expression for later evaluation
	p=dplyr::enquo(p)

	# Define a constant for "ANY"
	ANY = "ANY"

	# Store the input parameters in local variables
	argType = type
	argType2 = type2

	# If n is less than -1, return a specific Pokemon
	if(n < -1){
		warning(glue::glue("n == {n}: hot swapping to Zekrom"))
		return(randomPokemon(n = -1, type = "Dragon", type2 = "Electric"), data=data)
	}

	# If swap is TRUE, modify the type2 column in the data
	if(swap){
		data =  data|> mutate(
			# If type2 is NA, replace it with type, otherwise keep it as type2
			type2 = if_else(is.na(type2), type, type2, type)
		)
		# If both argType and argType2 are not "ANY", filter the data where type equals argType and type2 equals argType2
		if(argType != ANY && argType2 != ANY){
			data =  data|> filter(
				type == argType & type2 == argType2
				|
				type == argType2 & type2 == argType
			)
		}
		# If only argType is not "ANY", filter the data where type equals argType
		else if(argType != ANY){
			data =  data|> filter(
				type == argType | type2 == argType
			)
		}
		# If only argType2 is not "ANY", filter the data where type equals argType2
		else if(argType2 != ANY){
			data =  data|> filter(
				type == argType2 | type2 == argType2
			)
		}
	}
	# If swap is FALSE
	else{
		# If argType is not "ANY", filter the data where type equals argType
		if(argType != ANY){
			data =  data|> filter(type == argType)
		}
		# If argType2 is not "ANY", filter the data where type2 equals argType2
		if(argType2 != ANY){
			if(is.na(argType2)) data =  data|> filter(is.na(type2))
			else  data =  data|>filter(type2 == argType2)
		}
	}
	# Pull the specified column from the data, remove duplicates, and store it in data
	data = data|>
		pull(!!p)|>
		unique()

	# If data is empty, return an empty character vector
	if(length( data) == 0)return(character(0))

	# If n is -1, return all elements in data
	if(n == -1)return(sample(data, length(data)))

	# Otherwise, return n random elements from data
	sample(data, n, replace = replace)
}
