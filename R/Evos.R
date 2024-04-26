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
gen_evos = function(write = FALSE, root = "data/", file = "PokemonEvolution"){
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
				rename(Family = X1, Base = X2, Method = X3, Evo = X5, Method2 = X6, Evo2 = X8)
		})|>
		bind_rows()

	evTable = # Bind the rows together
		bind_rows(
			# First Evolution
			evTable|>
				select(Family, Base, Method, Evo)|>
				mutate(Transition = "First"),
			# Second Evolution
			evTable|>
				select(Family, Base = Evo, Method = Method2, Evo = Evo2)|>
				# Fix Pokemon with only 1 evolution
				filter(!is.na(Evo))|>
				mutate(Transition = "Second")
		)

	# Fix unknown
	PokemonEvolution = evTable|>
		filter(Family != "Unown")|>
		bind_rows(
			evTable|>
				filter(Family == "Unown")|>
				mutate(Evo = NA_character_),
			evTable|>
				filter(Family == "Unown")|>
				mutate(
					Base = Evo,
					Evo = NA_character_
				)|>
				drop_na(Base)
		)|>
		drop_na(Base)|>
		mutate(
			# Remove family
			Family = str_remove(Family, " family\\*?"),
			# Remove  →
			Method = str_remove(Method, " \u2192"),
			Transition = if_else(is.na(Evo), "None", Transition)
		)

	if(write)save_data(PokemonEvolution, root, file)
}
