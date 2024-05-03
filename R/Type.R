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
			names_to = "Defending"
		)|>
		mutate(Defending = str_remove(Defending, "Defending_"))

	if(write)save_data("typeChart", root, file)
	if(write)save_data("typeChartWide", root, fileWide)
}
