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
gen_type = function(write = FALSE, path = system.file("data/PokemonTypes.csv", package = "ZekDex")){
	# Read the CSV file 'PokemonNational.csv' from the 'data' directory
	nat = data("PokemonNational", package = "ZekDex")
	if(nat == "PokemonNational")nat = read_csv(system.file("data/PokemonNational.csv", package = "ZekDex"))

	# Extract the 'type' column from 'nat' using 'pull', concatenate it with the 'type2' column using 'c',
	# remove duplicate values using 'unique', and remove NA values using 'discard(is.na)'
	types = pull(nat, type)|>
		c(pull(nat, type2))|>
		unique()|>
		discard(is.na)

	# Convert the 'types' vector into a tibble (a type of dataframe) with a single column named 'types'
	types = tibble(types = types)

	# If 'write' is TRUE, write the 'types' tibble to a CSV file named 'PokemonTypes.csv' in the 'data' directory
	if(write)write_csv(types, path)

	# Return the 'types' tibble
	types
}

