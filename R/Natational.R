#' Generate the National Dex
#'
#' This function generates a tibble of the National Dex by reading the 'PokemonNational.csv' file and scraping data from Bulbapedia. It extracts the tables from the HTML content, cleans the column names of the dataframe, and combines all dataframes into one. If `write = TRUE`, it also writes the tibble to a csv file.
#'
#' @param write Logical, if `TRUE`, writes the tibble to a csv file. Default is `FALSE`.
#' @param path The path where the csv file will be written if `write = TRUE`. Default is `system.file("data/PokemonNational.csv", package = "ZekDex")`.
#' @return A tibble of the National Dex.
#' @export
#'
#' @importFrom readr read_csv write_csv
#' @importFrom dplyr mutate select filter
#' @importFrom purrr map discard
#' @importFrom tibble tibble
#' @importFrom stringr str_remove_all
#' @importFrom janitor clean_names
#' @importFrom rvest read_html html_table
#' @examples
#' gen_national()
gen_national = function(write = FALSE, path = system.file("data/PokemonNational.csv", package = "ZekDex")){
	# Import the required package 'rvest' for web scraping
	if(!requireNamespace("rvest", quietly = TRUE))stop("rvest required.  Use install.packages(\"rvest\")")

	# Read the HTML content from the specified URL
	HTML = rvest::read_html("https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_National_Pok%C3%A9dex_number")

	# Extract the tables from the HTML content
	national = rvest::html_table(HTML)|>
		# Apply a function to each element of the list (each table)
		map(function(df){
			# Clean the column names of the dataframe
			df = janitor::clean_names(df)
			# If any of the specified strings are in the column names, return NULL
			if(any(c("lists_of_pokemon", "x1", "x12") %in% names(df)))return(NULL)
			# Otherwise, return the dataframe
			df
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
		# (\\w[[:lower:]\\d]+(?:[\\-.: ] ?[[:upper:]][[:lower:]]*)?): This is the first capture group.
		# \\w[[:lower:]\\d]+: Matches one or more word characters (\\w), lowercase letters ([[:lower:]]), or digits (\\d).
		# (?:[\\-.: ] ?[[:upper:]]?[[:lower:]]*)?: This is a non-capturing group (indicated by ?:), which means it groups the included pattern but does not create a separate capture group for it. It matches zero or one occurrence of the following pattern:
		# [\\-.: ] ?: Matches a hyphen, dot, colon, or space, followed by an optional space.
		# [[:upper:]]?[[:lower:]]*: Matches an optional uppercase letter followed by zero or more lowercase letters.
		# ([\\w\\- :]+)?: This is the second capture group.
		# \\w\\- :: Matches any word character, hyphen, or space.
		# +: Matches one or more of the preceding element.
		# ?: Makes the entire second capture group optional, meaning it will match even if this group is not present in the string.
		# (?:\\(([^()]+)\\))?: This is the third capture group.
	# \\( and \\): Matches the literal parentheses “(” and “)”.
	# [^()]+: Matches one or more of any characters except parentheses.
	# The entire group is made optional by the trailing ?.
	extract(
		pokemon,
		regex = "(\\w[[:lower:]\\d]+(?:[\\-.: ] ?[[:upper:]]?[[:lower:]]*)?)([\\w\\- :]+)?(?:\\(([^()]+)\\))?",
		into = c("pokemon", "form", "form2")
	)|>
		# Fix duplicate types and clean up the 'ndex', 'form', and 'form2' columns
		mutate(
			type2 = if_else(type == type2, NA_character_, type2, missing = type2),
			ndex = as.integer(str_remove_all(ndex, "[^\\d]")),
			form = if_else(form == "", NA_character_, form, NA_character_),
			form2 = if_else(form2 == "", NA_character_, form2, NA_character_)
		)|>
		# Rename the 'ndex' column to 'Ndex' and the 'pokemon' column to 'English'
		rename(Ndex="ndex", English = "pokemon")

	# If 'write' is TRUE, write the 'national' dataframe to a CSV file
	if(write)write_csv(national, path)

	# Return the 'national' dataframe
	national
}
