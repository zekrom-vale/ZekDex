#' Generate Pokémon Evolution Data
#'
#' This function scrapes Pokémon evolution data from Bulbapedia and returns a data frame. If `write = TRUE`, it also writes the data frame to a csv file.
#'
#' @param write Logical, if `TRUE`, writes the data frame to a csv file. Default is `FALSE`.
#' @param root The root directory where the csv file will be written if `write = TRUE`. Default is "data/".
#' @param file The name of the csv file to be written if `write = TRUE`. Default is "PokemonFamily".
#' @param fileLong The name of the long format csv file to be written if `write = TRUE`. Default is "PokemonFamilyLong".
#' @return A data frame of Pokémon evolution data.
#' @importFrom purrr map pmap_lgl
#' @importFrom dplyr select mutate filter bind_rows across everything
#' @importFrom tidyr fill
#' @importFrom stringr str_remove str_trim
#' @importFrom readr write_csv
#' @importFrom magrittr "%>%"
#' @importFrom pkgload is_loading
#' @export
gen_evos = function(write = FALSE, root = "data/", file = "PokemonFamily", fileLong = "PokemonFamilyLong"){
	if(is_loading()) return()
	check_rvest()

	# Add Evolution family

	HTML = rvest::read_html("https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_evolution_family")

	famTable = rvest::html_table(HTML, header = FALSE)
	# Discard the end tables
	famTable = famTable[1:(length(famTable)-3)]

	all_identical = function(...){
		length(unique(list(...))) == 1
	}
	famTable = famTable|>
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
		bind_rows()|>
		mutate(
			first = if_else(is.na(evo), NA_character_, base, NA_character_)
		)

	# Bind the rows together
	family = bind_rows(
			# First Evolution
			famTable|>
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
				select(family, base, method, evo, evoForm = method2, transition, first),
			# Second Evolution
			famTable|>
				select(family, base = evo, method = method2, evo = evo2, first)|>
				# Fix Pokemon with only 1 evolution
				filter(!is.na(evo))|>
				mutate(
					transition = "Second",
					evoForm = NA_character_
				)
		)

	REGIONAL_REGEX = regionalForm(re = TRUE, ext = TRUE)
	REMOVE_REGEX = glue("[\\s,]*{REGIONAL_REGEX}[\\s,]*")
	EXTRACT_REGEX = "([^()]+)(?:\\(([^()]+)\\))?"

	# Fix unknown
	family = bind_rows(
		family|>
			filter(family != "Unown"),
		family|>
			filter(family == "Unown")|>
			mutate(evo = NA_character_),
		family|>
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
			regex = EXTRACT_REGEX
		)|>
		extract(
			evo,
			into = c("evo", "form2"),
			regex = EXTRACT_REGEX
		)|>
		extract(
			first,
			into = c("first", "firstForm"),
			regex = EXTRACT_REGEX
		)|>
		mutate(
			# Extract the reginal form
			regional = str_extract(form, REGIONAL_REGEX),
			form = str_remove(form, REMOVE_REGEX),

			evoRegional = str_extract(evoForm, REGIONAL_REGEX),
			evoForm = str_remove(evoForm, REMOVE_REGEX),


			firstRegional = str_extract(firstForm, REGIONAL_REGEX),
			firstForm = str_remove(firstForm, REMOVE_REGEX),

			# Trim
			base = str_trim(base),
			evo = str_trim(evo),
			first = str_trim(first)
		)|>
		blank_to_na(form, form2, firstForm)|>
		mutate(
			# Overwrite form with evoForm if it exists
			form = if_else(is.na(evoForm), form, evoForm, form),
			# Overwrite firstForm with evoForm if it exists
			firstForm = if_else(is.na(evoForm), firstForm, evoForm, firstForm),

			# If evoForm is not NA copy from form2
			evoForm = if_else(is.na(evoForm), form2, evoForm, form2),
			# Drop form2
			form2 = NULL,
			# Remove family
			family = str_remove(family, " family\\*?"),
			# Remove  →
			method = str_remove(method, " \u2192"),
			# Transition is none if evo is NA
			transition = if_else(is.na(evo), "None", transition),
			across(matches("[Rr]egional|transition"), factor)
		)

	# Note this will be sorter than national dex as it does not include swapale
	# forms.  Like Giratina Altered Forme/Origin Forme and Darmanitan Standard Mode / Zen Mode etc
	familyLong = family|>
		mutate(
			base = paste("base", base, form, regional, sep = "_"),
			evo = paste("evo", evo, evoForm, evoRegional, sep = "_"),
			form = NULL,
			evoForm = NULL,
			evoRegional = NULL,
			regional = NULL
		)|>
		pivot_longer(cols = c("base", "evo"))|>
		separate(value, into = c("base", "name", "form", "regional"), sep = "_", convert = TRUE)|>
		drop_na(name)|>
		select(-method)|>
		distinct()|>
		mutate(
			stage = case_when(
				transition == "First" & base == "base" ~ 1L,
				transition == "Second" & base == "base" ~ 2L,
				transition == "First" & base == "evo" ~ 2L,
				transition == "Second" & base == "evo" ~ 3L,
				.default = 0L
			)
		)|>
		select(-base)|>
		group_by(name, form)|>
		filter(n()<=1 | transition != "First")|>
		ungroup()

	# Add groups
	groups = read_data("PokemonGroups", root, g="groups")
	familyLong = familyLong|>
		left_join(groups, by = "name")

	if(write)save_data("family", root, file)
	if(write)save_data("familyLong", root, fileLong)
	list(family, familyLong)
}
