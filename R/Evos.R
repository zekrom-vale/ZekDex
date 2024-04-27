#' Generate Pokémon Evolution Data
#'
#' This function scrapes Pokémon evolution data from Bulbapedia and returns a data frame. If `write = TRUE`, it also writes the data frame to a csv file.
#'
#' @param write Logical, if `TRUE`, writes the data frame to a csv file. Default is `FALSE`.
#' @param path The path where the csv file will be written if `write = TRUE`. Default is `system.file("data/PokemonEvolution.csv", package = "ZekDex")`.
#' @return A data frame of Pokémon evolution data.
#' @importFrom purrr map pmap_lgl
#' @importFrom dplyr select mutate filter bind_rows across everything
#' @importFrom tidyr fill
#' @importFrom stringr str_remove
#' @importFrom readr write_csv
#' @importFrom magrittr "%>%"
#' @export
gen_evos = function(write = FALSE, root = "data/", file = "PokemonEvolution"){
	if(pkgload::is_loading()) return()
	if(!requireNamespace("rvest", quietly = TRUE))stop("rvest required.  Use install.packages(\"rvest\")")

	# Add Evolution family

	evHTML = rvest::read_html("https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_evolution_family")

	evTable = rvest::html_table(evHTML, header = FALSE)
	# Discard the end tables
	evTable = evTable[1:(length(evTable)-3)]

	all_identical = function(...){
		length(unique(list(...))) == 1
	}
	evTable = evTable|>
		map(function(table){
			# table = evTable[[1]]
			table|>
				mutate(across(everything(), ~if_else(.=="", NA_character_, .)))|>
				fill(X1, .direction = "down")|>
				select(matches("X[^47]"))%>%
				# Filter out rows where all values are equal
				filter(., !pmap_lgl(., all_identical))|>
				rename(family = X1, base = X2, method = X3, evo = X5, method2 = X6, evo2 = X8)
		})|>
		bind_rows()

	evTable = # Bind the rows together
		bind_rows(
			# First Evolution
			evTable|>
				select(family, base, method, evo)|>
				mutate(transition = "First"),
			# Second Evolution
			evTable|>
				select(family, base = evo, method = method2, evo = evo2)|>
				# Fix Pokemon with only 1 evolution
				filter(!is.na(evo))|>
				mutate(transition = "Second")
		)

	# Fix unknown
	evolution = evTable|>
		filter(family != "Unown")|>
		bind_rows(
			evTable|>
				filter(family == "Unown")|>
				mutate(evo = NA_character_),
			evTable|>
				filter(family == "Unown")|>
				mutate(
					base = evo,
					evo = NA_character_
				)|>
				drop_na(base)
		)|>
		drop_na(base)|>
		mutate(
			# Remove family
			family = str_remove(family, " family\\*?"),
			# Remove  →
			method = str_remove(method, " \u2192"),
			transition = if_else(is.na(evo), "None", transition)
		)

	if(write)save_data("evolution", root, file)
	evolution
}
