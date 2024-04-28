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
	# library(tidyverse)
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
				# Method2 could also be evolution type
				rename(family = X1, base = X2, method = X3, evo = X5, method2 = X6, evo2 = X8)
		})|>
		bind_rows()

	# Bind the rows together
	evTable2 = bind_rows(
			# First Evolution
			evTable|>
				mutate(
					transition = "First",
					# Collect method2 if it describes the evolution IE
					# In this case override form with evoForm
					# Shellos 	Shellos 	Level 30 → 	Gastrodon 	Gastrodon 	West Sea
					# Shellos 	Shellos 	Level 30 → 	Gastrodon 	Gastrodon 	East Sea
					# Deerling 	Deerling 	Level 34 → 	Sawsbuck 	Sawsbuck 	Spring Form
					# Deerling 	Deerling 	Level 34 → 	Sawsbuck 	Sawsbuck 	Summer Form
					# Deerling 	Deerling 	Level 34 → 	Sawsbuck 	Sawsbuck 	Autumn Form
					# Deerling 	Deerling 	Level 34 → 	Sawsbuck 	Sawsbuck 	Winter Form
					method2 = if_else(is.na(evo2), method2, NA_character_, method2)
				)|>
				select(family, base, method, evo, evoForm = method2, transition),
			# Second Evolution
			evTable|>
				select(family, base = evo, method = method2, evo = evo2)|>
				# Fix Pokemon with only 1 evolution
				filter(!is.na(evo))|>
				mutate(
					transition = "Second",
					evoForm = NA_character_
				)
		)

	# Fix unknown
	evolution = evTable2|>
		filter(family != "Unown")|>
		bind_rows(
			evTable2|>
				filter(family == "Unown")|>
				mutate(evo = NA_character_),
			evTable2|>
				filter(family == "Unown")|>
				mutate(
					base = evo,
					evo = NA_character_
				)|>
				drop_na(base)
		)|>
		drop_na(base)|>
		mutate(
			# Fix Wormadam evos https://bulbapedia.bulbagarden.net/wiki/Wormadam_(Pok%C3%A9mon)
			# Burmy family Burmy Level 20 (female, Plant Cloak) → Wormadam NA First
			# Burmy family Burmy Level 20 (female, Sandy Cloak) → Wormadam NA First
			# Burmy family Burmy Level 20 (female, Trash Cloak) → Wormadam NA First
			evoForm = case_when(
				is.na(method) ~ NA_character_,
				str_detect(method, "Plant Cloak") ~ "Plant Cloak",
				str_detect(method, "Sandy Cloak") ~ "Sandy Cloak",
				str_detect(method, "Trash Cloak") ~ "Trash Cloak",
				.default = evoForm
			)
		)|>
		extract(
			base,
			into = c("base", "form"),
			regex = "([^()]+)(?:\\(([^()]+)\\))?"
		)|>
		extract(
			evo,
			into = c("evo", "form2"),
			regex = "([^()]+)(?:\\(([^()]+)\\))?"
		)|>
		mutate(
			# Trim form and change "" to NA
			form = if_else(form == "", NA_character_, str_trim(form), form),
			# Trim form2 and change "" to NA
			form2 = if_else(form2 == "", NA_character_, str_trim(form2), NA_character_),

			# Overwrite form with evoForm if it exists
			form = if_else(is.na(evoForm), form, evoForm, form),
			# If evoForm is not NA copy from form2
			evoForm = if_else(is.na(evoForm), form2, evoForm, form2),
			# Drop form2
			form2 = NULL,
			# Remove family
			family = str_remove(family, " family\\*?"),
			# Remove  →
			method = str_remove(method, " \u2192"),
			# Transition is none if evo is NA
			transition = if_else(is.na(evo), "None", transition)
		)

	# Add first evolution TODO add further back in the chain to avoid biding
	evolution = evolution|>left_join(evolution, by=c(base="evo", "family"), relationship = "many-to-many")|>
		select(family, base, method = method.x, evo, transition = transition.x, first = base.y)|>
		mutate(
			first = if_else(is.na(first) & transition != "None", base, first, first)
		)

	if(write)save_data("evolution", root, file)
	evolution
}

# ZekDex::evolution|>left_join(ZekDex::evolution, by=c(base="evo", "family"), relationship = "many-to-many")|>
# 	select(family, base, method = method.x, evo, transition = transition.x, first = base.y)|>
# 	mutate(
# 		first = if_else(is.na(first) & transition != "None", base, first, first)
# 	)|>
# 	distinct()
