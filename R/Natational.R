#' Generate the National Dex
#'
#' This function generates a tibble of the National Dex by reading the 'PokemonNational.csv' file and scraping data from Bulbapedia. It extracts the tables from the HTML content, cleans the column names of the dataframe, and combines all dataframes into one. If `write = TRUE`, it also writes the tibble to a csv file.
#'
#' @param write Logical, if `TRUE`, writes the tibble to a csv file. Default is `FALSE`.
#' @param root The root directory where the file will be written if `write = TRUE`. Default is "data/".
#' @param file The name of the file (without extension) to be written if `write = TRUE`. Default is "PokemonNational".
#' @return A tibble of the National Dex.
#' @export
#'
#' @importFrom dplyr mutate select filter bind_rows case_when if_else rename
#' @importFrom tidyr extract
#' @importFrom purrr map discard
#' @importFrom tibble tibble
#' @importFrom stringr str_remove_all str_detect
#' @importFrom rvest read_html html_table html_element html_elements html_attr
#' @importFrom janitor clean_names
#' @importFrom pkgload is_loading
gen_national = function(write = FALSE, root = "data/", file = "PokemonNational"){
	if(pkgload::is_loading()) return()
	# Import the required package 'rvest' for web scraping
	if(!requireNamespace("rvest", quietly = TRUE))stop("rvest required.  Use install.packages(\"rvest\")")
	# Check if the 'janitor' package is installed. If not, stop the function and ask the user to install it.
	if(!requireNamespace("janitor", quietly = TRUE))stop("janitor required.  Use install.packages(\"janitor\")")

	# Read the HTML content from the specified URL
	HTML = rvest::read_html("https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_National_Pok%C3%A9dex_number")

	# Extract the tables from the HTML content
	i = 0
	nationalDex = rvest::html_table(HTML)|>
		# Apply a function to each element of the list (each table)
		map(function(df){
			# Clean the column names of the dataframe
			df = janitor::clean_names(df)
			# If any of the specified strings are in the column names, return NULL
			if(any(c("lists_of_pokemon", "x1", "x12") %in% names(df)))return(NULL)
			i <<- i + 1
			# Otherwise, return the dataframe with genration added
			df|>
				mutate(
					generation = i
				)
		})|>
		# Remove NULL elements from the list
		discard(is.null)|>
		# Combine all dataframes in the list into one dataframe
		bind_rows()|>
		# Select all columns except 'ms'
		select(-ms)|>
		# Rename the 'type_2' column to 'type2'
		rename(type2 = "type_2")|>
		# Deal with forms
		# The regex pattern is divided into three main capture groups:
		# (\\p{L}[\\p{Ll}\u2640\u2642']+(?:[\\-.: ] ?[[:upper:]]?[[:lower:].]*)?): This is the first capture group.
			# It matches a word character (\\p{L})
			# Followed by a sequence of lowercase letters ([\\p{Ll}]), the female (\u2640) and male (\u2642) symbols, or an apostrophe (')
			# Followed by an optional non-capturing group.
				# The non-capturing group matches a hyphen, dot, colon, or space
				# Optionally followed by a space
				# An optional uppercase letter
				# And zero or more lowercase letters or dot (\\.).

		# ([^()\\n\\r]+)?: This is the second capture group.
			# It matches one or more of any characters except parentheses, newline (\\n), and carriage return (\\r).
			# This group is optional, meaning it will match even if this group is not present in the string.

		# (?:\\(([^()]+)\\))?: This is the third capture group.
			# It matches a literal opening parenthesis (\\()
			# Followed by one or more of any characters except parentheses
			# And a literal closing parenthesis (\\)).
			# The entire group is optional, meaning it will match even if this group is not present in the string.
	extract(
		pokemon, # Fix NidoranM/F, Farfetch'd, and Mime Jr.
		regex = "(\\p{L}[\\p{Ll}\u2640\u2642']+(?:[\\-.: ] ?[[:upper:]]?[[:lower:].]*)?)([^()\\n\\r]+)?(?:\\(([^()]+)\\))?",
		into = c("pokemon", "form", "form2")
	)|>
		# Fix duplicate types and clean up the 'ndex', 'form', and 'form2' columns
		mutate(
			type2 = if_else(type == type2, NA_character_, type2, missing = type2),
			ndex = as.integer(str_remove_all(ndex, "[^\\d]")),
			form2 = if_else(form2 == "", NA_character_, form2, NA_character_),
			# Arceus technically not correct
			# Koraidon and Miraidon forms are incomplete
			# Furfrou does not have the trimed forms
			form = case_when(
				# Fix Groudon and Kyoger. Fix Porygon2
				form == pokemon | form == "" | ndex == 233 ~ NA_character_,
				# Fix Genesect ndex == 649
				ndex == 649 ~ form2,
				.default = form
			),
			# TODO extract from https://bulbapedia.bulbagarden.net/wiki/Alolan_form
			# Fix Genesect ndex == 649
			form2 = if_else(ndex == 649, NA_character_, form2),

			# fix Porygon2
			pokemon = if_else(ndex == 233, "Porygon2", pokemon),

			# Move Alolan Galarian Hisuian Paldean forms to form 2
			temp = if_else(str_detect(form, regionalForm(re=TRUE)), form, NA_character_, NA_character_),
			form = if_else(is.na(temp), form, form2),
			form2 = if_else(is.na(temp), form2, temp),
			temp = NULL
		)|>
		# Rename
		rename(name = "pokemon", regional = "form2")

	# Add is legendary
	HTML = rvest::read_html("https://bulbapedia.bulbagarden.net/wiki/Zekrom_(Pok%C3%A9mon)")
	legendary = HTML|>
		rvest::html_element(css = 'div[class="roundy"]:last-of-type')|>
		rvest::html_elements(css = 'a')|>
		rvest::html_attr("title")|>
		discard(~ str_detect(., "Legendary|Generation|Mythical|Ultra Beast"))

	# Add is mythical
	HTML = rvest::read_html("https://bulbapedia.bulbagarden.net/wiki/Zeraora_(Pok%C3%A9mon)")
	mythical = HTML|>
		rvest::html_element(css = 'div[class="roundy"]:last-of-type')|>
		rvest::html_elements(css = 'a')|>
		rvest::html_attr("title")|>
		discard(~ str_detect(., "Legendary|Generation|Mythical|Ultra Beast"))
	# Add is Ultra Beast

	HTML = rvest::read_html("https://bulbapedia.bulbagarden.net/wiki/Nihilego_(Pok%C3%A9mon)")
	ultraBeast = HTML|>
		rvest::html_element(css = 'div[class="roundy"]:last-of-type')|>
		rvest::html_elements(css = ':not(small)>a')|>
		rvest::html_attr("title")|>
		discard(~ str_detect(., "Legendary|Generation|Mythical|Ultra Beast"))

	nationalDex = nationalDex|>
		mutate(
			isLegendary = name %in% legendary,
			isMythical = name %in% mythical,
			isUltraBeast = name %in% ultraBeast
		)

	# Add groups
	groups = read_data("PokemonGroups", root)
	nationalDex = nationalDex|>
		left_join(groups, by = "name")

	# If 'write' is TRUE, write the 'nationalDex' dataframe to a CSV file
	if(write)save_data("nationalDex", root, file)

	# Return the 'nationalDex' dataframe
	nationalDex
}
