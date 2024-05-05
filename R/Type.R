#' Generates Pokémon Types from Scratch
#'
#' This function generates a tibble of Pokémon types by reading the 'PokemonNational.csv' file and extracting the 'type' and 'type2' columns. It removes duplicate and NA values to create a unique list of Pokémon types. If `write = TRUE`, it also writes the tibble to a csv file.
#'
#' @param write Logical, if `TRUE`, writes the tibble to a csv file. Default is `FALSE`.
#' @param path The path where the csv file will be written if `write = TRUE`. Default is `system.file("data/PokemonTypes.csv", package = "ZekDex")`.
#' @return A tibble with a single column named 'types' containing unique Pokémon types.
#' @export
#'
#' @importFrom readr read_csv write_csv
#' @importFrom dplyr filter pull
#' @importFrom purrr discard
#' @importFrom tibble tibble
#' @importFrom utils data
#' @importFrom pkgload is_loading
gen_type = function(write = FALSE, root = "data/", file = "PokemonTypes"){
	if(pkgload::is_loading()) return()
	national = read_data("PokemonNational", root, g="nationalDex")

	# Extract the 'type' column from 'national' using 'pull', concatenate it with the 'type2' column using 'c',
	# remove duplicate values using 'unique', and remove NA values using 'discard(is.na)'
	types = pull(national, type)|>
		c(pull(national, type2))|>
		unique()|>
		discard(is.na)

	# Convert the 'types' vector into a tibble (a type of dataframe) with a single column named 'types'
	types = tibble(types = types)

	# If 'write' is TRUE, write the 'types' tibble to a CSV file named 'PokemonTypes.csv' in the 'data' directory
	if(write)save_data("types", root, file)

	# Return the 'types' tibble
	types
}

#' Generate Pokémon Type Chart
#'
#' This function generates a Pokémon type chart by scraping data from Bulbapedia.
#' It creates two versions of the chart: a wide version and a long version.
#' The wide version has defending types as columns and attacking types as rows.
#' The long version is a reshaped version of the wide chart with three columns: attacking type, defending type, and effectiveness.
#'
#' @param write Logical value indicating whether to write the generated charts to files. Default is FALSE.
#' @param root Character string specifying the root directory where the files should be written. Default is "data/".
#' @param file Character string specifying the filename for the long version of the chart. Default is "PokemonTypeChart".
#' @param fileWide Character string specifying the filename for the wide version of the chart. Default is "PokemonTypeChartWide".
#' @importFrom rvest read_html
#' @importFrom rvest html_table
#' @importFrom tibble as_tibble
#' @importFrom dplyr select
#' @importFrom dplyr rename
#' @importFrom dplyr mutate
#' @importFrom dplyr filter
#' @importFrom tidyr pivot_longer
#' @importFrom stringr str_remove
#' @importFrom stringr str_remove_all
#' @return A list containing two data frames: 'typeChart' and 'typeChartWide'.
gen_type_chart = function(write = FALSE, root = "data/", file = "PokemonTypeChart", fileWide = "PokemonTypeChartWide"){
	HTML = rvest::read_html("https://bulbapedia.bulbagarden.net/wiki/Type")
	# Columns are Defending type
	# Rows are Attacking type
	typeChartWide = rvest::html_table(HTML)[[2]]|>
		as_tibble(.name_repair = "unique")|>
		select(-1)|>
		.name_from_row(1, prepend = "Defending_", test = FALSE)|>
		rename(Attacking = 1)|>
		mutate(
			across(starts_with("Defending_"), function(x){
				# Find "½×" set to .5 else remove non digits and cast to numeric
				if_else(x == "\u00BD\u00D7", .5, as.numeric(str_remove_all(x, "[^\\d.]")))
			})
		)|>
		filter(!is.na(Defending_Dragon))

	typeChart = typeChartWide|>
		pivot_longer(
			cols = starts_with("Defending_"),
			names_to = "Defending",
			values_to = "Effectiveness"
		)|>
		mutate(Defending = str_remove(Defending, "Defending_"))

	if(write)save_data("typeChart", root, file)
	if(write)save_data("typeChartWide", root, fileWide)
	list(typeChart, typeChartWide)
}


#' List of Effectiveness Values
#'
#' This list contains various sets of effectiveness values used in different Pokémon games.
#' Each set of values represents a different game or game mechanic.
#'
#' @format list
#' @source Bulbapedia
#' @export
#' @examples
#' effectiveness_list$Standard
#' effectiveness_list$LegendsArceus
#' effectiveness_list$MysteryDungeonRedBlue
#' effectiveness_list$ExplorersTimeDarknessSky
#' effectiveness_list$ErraticIQskill
#' effectiveness_list$Rumble
#' effectiveness_list$Shuffle
#' effectiveness_list$GO
#' effectiveness_list$GO2018
#' effectiveness_list$GO2017
effectiveness_list = list(
	Standard =                 c(  0, 0.25, 0.5, 1, 2  , 4),
	LegendsArceus =            c(  0, 0.4,  0.5, 1, 2  , 2.5),
	MysteryDungeonRedBlue =    c(0.5, 0.5,  0.9, 1, 1.5, 1.5), #??
	ExplorersTimeDarknessSky = c(0.5, 0.5,  0.7, 1, 1.4, 1.4), #??
	ErraticIQskill =           c(0.5, 0.25, 0.5, 1, 1.7, 1.7), #??
	Rumble =                   c(0.6, 0.7,  0.8, 1, 1.2, 1.4),
	Shuffle =                  c(0.5, 0.5,  0.5, 1, 2  , 2),
	GO =                       1.6**(-3:2), # -3 may be wrong
	GO2018 =                   1.4**(-3:2), # -3 may be wrong
	GO2017 =                   1.25**(-3:2) # -3 may be wrong
)

#' List of STAB Multipliers
#'
#' This list contains various Same Type Attack Bonus (STAB) multipliers used in different Pokémon games.
#' Each multiplier represents a different game or game mechanic.
#'
#' @format list
#' @source Bulbapedia
#' @export
#' @examples
#' stab_multiplyer$Standard
#' stab_multiplyer$Adaptability
#' stab_multiplyer$LegendsArceus
#' stab_multiplyer$Terastallized
#' stab_multiplyer$AdaptabilityTerastallized
#' stab_multiplyer$MysteryDungeon
#' stab_multiplyer$GO
#' stab_multiplyer$GO2017
stab_multiplyer = list(
	Standard = 1.5,
	Adaptability = 2,
	LegendsArceus = 1.25,
	Terastallized = 2,
	AdaptabilityTerastallized = 2.25,
	MysteryDungeon = 1.5,
	GO = 1.2,
	GO2017 = 1.25
)

#' Compute Effectiveness Function
#'
#' This function computes the effectiveness of an attack based on the effectiveness value and the effectiveness list.
#' It uses a logarithmic mapping to determine the effectiveness.
#'
#' @param eft Numeric value representing the effectiveness of an attack.
#' @param efect Numeric vector representing the effectiveness list. Default is effectiveness_list$Standard.
#' @param stab Logical value indicating whether the attack is of the same type as the attacker. Default is FALSE.
#' @param stab_multiplyer Numeric value representing the STAB multiplier. Default is stab_multiplyer$Standard.
#' @return Numeric value representing the computed effectiveness.
#' @export
#' @examples
#' efect_fun(2, effectiveness_list$Standard)
efect_fun = function(eft, efect = effectiveness_list$Standard, stab = FALSE, stab_multiplyer = stab_multiplyer$Standard){
	# 2*2 = 4
	# 2*1 = 2
	# 1*1 = 1
	# .5*2 = 1
	# .5*.5 = .25
	# 0 * n = 0
	if(eft == 0)return(ifelse(stab, efect[1]*stab_multiplyer, efect[1]))
	maping = log2(eft*4)+2
	if(maping < 2 || maping > 6 || maping%%1 != 0)stop(paste("Got maping =", maping))
	ifelse(stab, efect[maping]*stab_multiplyer, efect[maping])
}

#' Compute Effectiveness of an Attack
#'
#' This function computes the effectiveness of an attack against a defender.
#' It uses the type chart to determine the effectiveness of the attack.
#'
#' @param attack Character string representing the attacking type.
#' @param defender Character vector representing the defending types.
#' @param efect Numeric vector representing the effectiveness list. Default is effectiveness_list$Standard.
#' @param stab Logical value indicating whether the attack is of the same type as the attacker. Default is FALSE.
#' @param stab_mult Numeric value representing the STAB multiplier. Default is stab_multiplyer$Standard.
#' @importFrom dplyr filter
#' @importFrom dplyr pull
#' @return Numeric value representing the effectiveness of the attack.
#' @export
#' @examples
#' effectiveness("Fire", c("Grass", "Bug"), effectiveness_list$Standard)
effectiveness = function(attack, defender, stab = FALSE, stab_mult = stab_multiplyer$Standard, efect = effectiveness_list$Standard){
	if(!(attack %in% types$types))stop(paste("Attack type not found:", attack))
	if(!all((defender %in% types$types)))stop(paste("Defender type not found:", defender))
	eft1 = typeChart|>
		filter(Attacking == attack & Defending == defender[1])|>
		pull(Effectiveness)
	if(is.na(defender[2]))return(efect_fun(eft1, efect, stab = stab, stab_mult = stab_mult))
	eft2 = typeChart|>
		filter(Attacking == attack & Defending == defender[2])|>
		pull(Effectiveness)
	efect_fun(eft1 * eft2, efect, stab = stab, stab_mult = stab_mult)
}


#' Compute Effectiveness of an Attack for a Pokémon
#'
#' This function computes the effectiveness of an attack against a specific Pokémon.
#' It uses the type chart to determine the effectiveness of the attack.
#'
#' @param attack Character string representing the attacking type.
#' @param pokemon Either a character string representing the Pokémon's name or a data frame containing Pokémon data.
#' @param regional Character string representing the regional form of the Pokémon. Default is NA.
#' @param form Character string representing the form of the Pokémon. Default is NA.
#' @param efect Numeric vector representing the effectiveness list. Default is effectiveness_list$Standard.
#' @param stab Logical value indicating whether the attack is of the same type as the attacker. Default is FALSE.
#' @param stab_mult Numeric value representing the STAB multiplier. Default is stab_multiplyer$Standard.
#' @importFrom dplyr filter
#' @importFrom dplyr select
#' @importFrom purrr pmap
#' @return Numeric value representing the effectiveness of the attack.
#' @export
#' @examples
#' effectivenessPokemon("Fire", "Zekrom", efect = effectiveness_list$Standard)
effectivenessPokemon = function(attack, pokemon, regional=NA_character_, form=NA_character_, efect = effectiveness_list$Standard, stab = FALSE, stab_mult = stab_multiplyer$Standard){
	inner_effectivenessPokemon = function(attack, pokemon, efect){
		if(dim(pokemon)[1]==0)stop("Empty tibble")
		type = pokemon|>
			select(type, type2)|>
			pmap(function(...) as.character(c(...)))
		return(
			Vectorize(effectiveness, vectorize.args = "defender")(attack, type, efect = efect, stab = stab, stab_mult = stab_mult)
		)
	}

	# If passed a dataframe
	if(is.data.frame(pokemon)){
		return(inner_effectivenessPokemon(attack, pokemon, efect))
	}
	r = regional
	f = form
	dex = nationalDex|>
		filter(name == pokemon)
	if(!is.na(regional))dex = dex|>
		filter(regional == r)
	else dex = dex|>
		filter(is.na(regional))
	if(!is.na(form))dex = dex|>
		filter(form == f)
	else dex = dex|>
		filter(is.na(form))
	if(dim(dex)[1]==0)stop(paste("Pokemon not found:", pokemon, regional, form))

	return(inner_effectivenessPokemon(attack, dex, efect))
}

#' Compute STAB Multiplier for an Attack
#'
#' This function computes the Same Type Attack Bonus (STAB) multiplier for an attack.
#' It is to be used with the `effectiveness` and `effectivenessPokemon` functions instead of passing a parameter.
#'
#' @param effectiveness Numeric value representing the effectiveness of an attack.
#' @param stab_multiplyer Numeric value representing the STAB multiplier. Default is stab_multiplyer$Standard.
#' @return Numeric value representing the effectiveness of the attack with the STAB multiplier applied.
#' @export
#' @examples
#' effectivenessPokemon("Fire", "Zekrom")|>
#'   stab()
stab = function(effectiveness, stab_multiplyer = stab_multiplyer$Standard){
	effectiveness * stab_multiplyer
}

