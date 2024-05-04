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
#' @importFrom base if_else
#' @importFrom base as.numeric
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
#' efectivness_list$Standard
#' efectivness_list$LegendsArceus
#' efectivness_list$MysteryDungeonRedBlue
#' efectivness_list$ExplorersTimeDarknessSky
#' efectivness_list$ErraticIQskill
#' efectivness_list$Rumble
#' efectivness_list$Shuffle
#' efectivness_list$GO
#' efectivness_list$GO2018
#' efectivness_list$GO2017
efectivness_list = list(
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

#' Compute Effectiveness Function
#'
#' This function computes the effectiveness of an attack based on the effectiveness value and the effectiveness list.
#' It uses a logarithmic mapping to determine the effectiveness.
#'
#' @param eft Numeric value representing the effectiveness of an attack.
#' @param efect Numeric vector representing the effectiveness list. Default is efectivness_list$Standard.
#' @return Numeric value representing the computed effectiveness.
#' @export
#' @examples
#' efect_fun(2, efectivness_list$Standard)
efect_fun = function(eft, efect = efectivness_list$Standard){
	# 2*2 = 4
	# 2*1 = 2
	# 1*1 = 1
	# .5*2 = 1
	# .5*.5 = .25
	# 0 * n = 0
	if(eft == 0)return(efect[1])
	maping = log2(eft*4)+2
	if(maping < 2 || maping > 6 || maping%%1 != 0)stop(paste("Got maping =", maping))
	efect[maping]
}

#' Compute Effectiveness of an Attack
#'
#' This function computes the effectiveness of an attack against a defender.
#' It uses the type chart to determine the effectiveness of the attack.
#'
#' @param attack Character string representing the attacking type.
#' @param defender Character vector representing the defending types.
#' @param efect Numeric vector representing the effectiveness list. Default is efectivness_list$Standard.
#' @importFrom dplyr filter
#' @importFrom dplyr pull
#' @return Numeric value representing the effectiveness of the attack.
#' @export
#' @examples
#' efectivness("Fire", c("Grass", "Bug"), efectivness_list$Standard)
efectivness = function(attack, defender, efect = efectivness_list$Standard){
	eft1 = typeChart|>
		filter(Attacking == attack & Defending == defender[1])|>
		pull(Effectiveness)
	if(is.na(defender[2]))return(efect_fun(eft1, efect))
	eft2 = typeChart|>
		filter(Attacking == attack & Defending == defender[2])|>
		pull(Effectiveness)

	efect_fun(eft1 * eft2, efect)
}

