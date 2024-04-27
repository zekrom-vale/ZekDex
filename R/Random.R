#' Returns a random Pokemon type
#'
#' @param n The number of random types to return. If n is less than 0, it returns "Zekrom".
#' @param replace Should sampling be with replacement?
#' @param types The data frame containing the Pokemon types. By default, it uses the "PokemonNational" data from the "ZekDex" package.
#' @importFrom utils data
#' @return A vector of random Pokemon types
#' @export
randomType = function(n=1, replace = FALSE, types = PokemonNational){
	if(n < 0) return("Zekrom")
	sample(types, n, replace = replace)
}


#' Returns a random Pokemon
#'
#' @param n How many
#' @param type Filter on type
#' @param type2 Filter on type2
#' @param swap Allow type to match type2 and vicea-versa
#' @param replace Should sampling be with replacement?
#' @param p What column to return (Ndex, English, form, form2, type, type2 can be used)
#' @param data Override the data (Must have type and type2 (If type 2 is not ANY or swap is TRUE))
#'
#' @examples
#' # Get a random Pokemon
#' randomPokemon()
#' # > "Koraidon"
#'
#' # Get a random Dragon type
#' randomPokemon(type = "Dragon")
#' # > "Zekrom"
#'
#' # Get 6 random Dragon Pokemon
#' randomPokemon(6, type = "Dragon")
#' # > c("Dragapult", "Jangmo-o", "Rayquaza", "Zekrom", "Garchomp", "Haxorus")
#'
#' # Get a random Dragon-Electric Pokemon
#' randomPokemon(type = "Dragon", type2 = "Electric")
#' # > "Zekrom"
#'
#' # Get a random Dragon-Electric or Electric-Dragon Pokemon
#' randomPokemon(type = "Dragon", type2 = "Electric", swap = TRUE)
#' # > "Miraidon"
#'
#' # Get All random Dragon-\* or \*-Dragon Pokemon
#' randomPokemon(n = -1, type = "Dragon", swap = TRUE)
#' # > "Zekrom", "Dreepy", "Guzzlord", "Archaludon", "Dragonite", "Raging Bolt",
#' # > "Frigibax", "Zweilous", "Goodra", "Rayquaza", "Regidrago", "Garchomp",
#' # > "Kingdra", "Roaring Moon", "Drakloak", "Jangmo-o", "Bagon", "Eternatus",
#' # > "Turtonator", "Altaria", "Goomy", "Baxcalibur", "Hydreigon", "Druddigon",
#' # > "Hydrapple", "Miraidon", "Dragapult", "Salamence", "Drampa", "Fraxure",
#' # > "Duraludon", "Zygarde", "Cyclizar", "Haxorus", "Dipplin", "Dratini",
#' # > "Dracovish", "Noibat", "Gouging Fire", "Latios", "Kyurem", "Latias",
#' # > "Palkia", "Walking Wake", "Kommo-o", "Sliggoo", "Vibrava", "Giratina",
#' # > "Dracozolt", "Flygon", "Tyrunt", "Shelgon", "Tatsugiri", "Dragalge",
#' # > "Axew", "Zygarde50", "Arctibax", "Tyrantrum", "Flapple", "Gible",
#' # > "Deino", "Applin", "Exeggutor", "Hakamo-o", "Noivern", "Koraidon",
#' # > "Dragonair", "Dialga", "Gabite", "Appletun", "Reshiram", "Naganadel",
#' # > "Zygarde10"
#'
#' # Return the dex number instead
#' randomPokemon(n = -1, type = "Dragon", swap = TRUE, p = "Ndex")
#' # > 1011, 1019, 371, 633, 634, 841, 334, 691,
#' # > 644, 718, 782, 381, 445, 804, 840, 704,
#' # > 799, 886, 380, 330, 842, 880, 714, 147,
#' # > 895, 646, 635, 705, 884, 1018, 967, 384,
#' # > 372, 373, 621, 780, 696, 887, 483, 1008,
#' # > 882, 706, 697, 1005, 784, 610, 978, 998,
#' # > 890, 997, 148, 443, 715, 776, 230, 611,
#' # > 783, 996, 1020, 103, 643, 1009, 487, 329,
#' # > 885, 612, 444, 149, 1021, 1007, 484

#'
#' @importFrom dplyr enquo mutate filter pull
#' @importFrom glue glue
#' @importFrom utils data
#' @importFrom dplyr pull
#' @export
randomPokemon = function(
		n=1,
		...,
		p = English,
		replace = FALSE
	){
	# Quosure to capture the expression for later evaluation
	p=dplyr::enquo(p)

	# If n is less than -1, return a specific Pokemon
	if(n < -1){
		warning(glue::glue("n == {n}: hot swapping to Zekrom"))
		return(randomPokemon(n = -1, type = "Dragon", type2 = "Electric"), data=data)
	}

	# Pull the specified column from the data, remove duplicates, and store it in data
	data = filterByType(...)|>
		pull(!!p)|>
		unique()

	# If data is empty, return an empty character vector
	if(length( data) == 0)return(character(0))

	# If n is -1, return all elements in data
	if(n == -1)return(sample(data, length(data)))

	# Otherwise, return n random elements from data
	sample(data, n, replace = replace)
}

#' Returns a tibble with filtered Pokemon
#'
#' @param type Filter on type
#' @param type2 Filter on type2
#' @param swap Allow type to match type2 and vicea-versa
#' @param data Override the data (Must have type and type2 (If type 2 is not ANY or swap is TRUE))
#' @export
filterByType = function(
		type = "ANY",
		type2 = "ANY",
		swap = FALSE,
		data = nationalDex
){
	# Define a constant for "ANY"
	ANY = "ANY"

	# Store the input parameters in local variables
	argType = type
	argType2 = type2

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
	data
}

#' Returns a random Pokemon Generator
#'
#' @param type Filter on type
#' @param type2 Filter on type2
#' @param swap Allow type to match type2 and vicea-versa
#' @param replace Should sampling be with replacement?
#' @param p What column to return (Ndex, English, form, form2, type, type2 can be used)
#' @param data Override the data (Must have type and type2 (If type 2 is not ANY or swap is TRUE))
#'
#' @importFrom dplyr enquo mutate filter pull
#' @importFrom glue glue
#' @importFrom utils data
#' @importFrom dplyr pull
#' @examples
#' # Create a random Pokemon generator for any type of Pokemon
#' gen_any <- randomPokemonGen()
#' # Generate a random Pokemon
#' coro::resume(gen_any)
#' # > "Rayquaza"
#'
#' # Create a random Pokemon generator for Fire type Pokemon
#' gen_fire <- randomPokemonGen(type = "Fire")
#' # Generate a random Fire type Pokemon
#' coro::resume(gen_fire)
#' # > "Reshiram"
#'
#' # Create a random Pokemon generator for Fire and Flying type Pokemon
#' gen_fire_flying <- randomPokemonGen(type = "Fire", type2 = "Flying")
#' # Generate a random Fire and Flying type Pokemon
#' coro::resume(gen_fire_flying)
#' # > "Charizard"
#'
#' # Create a random Pokemon generator for Fire or Flying type Pokemon
#' gen_dragon_or_electric <- randomPokemonGen(type = "Dragon", type2 = "Electric", swap = TRUE)
#' # Generate a random Fire or Flying type Pokemon
#' coro::resume(gen_dragon_or_electric)
#' # > "Zekrom"
#' coro::resume(gen_dragon_or_electric)
#' # > "Rayquaza"
#'
#' # Create a random Pokemon generator for all Dragon type Pokemon
#' gen_all_dragon <- randomPokemonGen(type = "Dragon", swap = TRUE)
#' # Generate all Dragon type Pokemon
#' while(!is.null(pokemon <- coro::resume(gen_all_dragon))) {
#'   print(pokemon)
#' }
#' # > "Zekrom", "Dreepy", "Guzzlord", "Archaludon", "Dragonite", "Raging Bolt",
#' # > "Frigibax", "Zweilous", "Goodra", "Rayquaza", "Regidrago", "Garchomp",
#' # > "Kingdra", "Roaring Moon", "Drakloak", "Jangmo-o", "Bagon", "Eternatus",
#' # > "Turtonator", "Altaria", "Goomy", "Baxcalibur", "Hydreigon", "Druddigon",
#' # > "Hydrapple", "Miraidon", "Dragapult", "Salamence", "Drampa", "Fraxure",
#' # > "Duraludon", "Zygarde", "Cyclizar", "Haxorus", "Dipplin", "Dratini",
#' # > "Dracovish", "Noibat", "Gouging Fire", "Latios", "Kyurem", "Latias",
#' # > "Palkia", "Walking Wake", "Kommo-o", "Sliggoo", "Vibrava", "Giratina",
#' # > "Dracozolt", "Flygon", "Tyrunt", "Shelgon", "Tatsugiri", "Dragalge",
#' # > "Axew", "Zygarde50", "Arctibax", "Tyrantrum", "Flapple", "Gible",
#' # > "Deino", "Applin", "Exeggutor", "Hakamo-o", "Noivern", "Koraidon",
#' # > "Dragonair", "Dialga", "Gabite", "Appletun", "Reshiram", "Naganadel",
#' # > "Zygarde10"
#'
#' # Return the dex number instead
#' gen_dex <- randomPokemonGen(type = "Dragon", swap = TRUE, p = Ndex)
#' # Generate all Dragon type Pokemon dex numbers
#' while(!coro::exhausted(gen_dex)) {
#'   pokemon = coro::resume(gen_dex)
#'   print(pokemon)
#' }
#' # > 1011, 1019, 371, 633, 634, 841, 334, 691,
#' # > 644, 718, 782, 381, 445, 804, 840, 704,
#' # > 799, 886, 380, 330, 842, 880, 714, 147,
#' # > 895, 646, 635, 705, 884, 1018, 967, 384,
#' # > 372, 373, 621, 780, 696, 887, 483, 1008,
#' # > 882, 706, 697, 1005, 784, 610, 978, 998,
#' # > 890, 997, 148, 443, 715, 776, 230, 611,
#' # > 783, 996, 1020, 103, 643, 1009, 487, 329,
#' # > 885, 612, 444, 149, 1021, 1007, 484
#'
#' # Create a random Pokemon generator for Dragon type Pokemon with replacement
#' gen_dragon_replace <- randomPokemonGen(type = "Dragon", replace = TRUE)
#' # Generate 5 random Dragon type Pokemon with replacement
#' replicate(5, coro::resume(gen_dragon_replace))
#' # > "Zekrom" "Rayquaza" "Garchomp" "Zekrom" "Haxorus"
#' @export
randomPokemonGen = function(
		...,
		p = English,
		replace = FALSE
){
	if(pkgload::is_loading()) return()
	if(!requireNamespace("coro", quietly = TRUE))stop("coro required.  Use install.packages(\"coro\")")
	# enquo to capture the expression for later evaluation
	p=dplyr::enquo(p)

	# Pull the specified column from the data, remove duplicates, and store it in data
	data = filterByType(...)|>
		pull(!!p)|>
		unique()

	# If data is empty, return an empty character vector
	if(length(data) == 0)return(character(0))

	# Create a generator
	if(replace){
		coro::generator(function(){
			while(TRUE){
				yield(sample(data))
			}
		})
	} else {
		coro::generator(function(){
			while(length(data) >= 0){
				item = sample(data)
				data = setdiff(data, item)
				yield(item)
			}
		})
	}
}
