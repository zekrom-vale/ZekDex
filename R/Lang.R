#' Generate the National Dex with Other Language Data
#'
#' This function generates a tibble of the National Dex with language information by reading the 'PokemonNational.csv' file and scraping data from Bulbapedia. It extracts language links and reads the HTML pages to compute the languages. It cleans the tables from each language and combines them into one dataframe. If `write = TRUE`, it also writes the tibble to a csv file.
#'
#' @param write Logical, if `TRUE`, writes the tibble to a csv file. Default is `FALSE`.
#' @param path The path where the csv file will be written if `write = TRUE`. Default is `system.file("data/PokemonLang.csv", package = "ZekDex")`.
#' @return A tibble of the National Dex with language information.
#' @export
#'
#' @importFrom purrr map map2 reduce
#' @importFrom dplyr select left_join group_by group_modify mutate across bind_rows rename filter
#' @importFrom readr read_csv write_csv
#' @importFrom stringr str_extract
#' @importFrom glue glue
#' @importFrom utils data
#' @importFrom tidyr everything
#' @importFrom tidyselect matches where
#' @importFrom magrittr "%>%"
#' @importFrom tibble as_tibble
gen_lang = function(write = FALSE, root = "data/", file = "PokemonLang"){
	if(pkgload::is_loading()) return()
	if(!requireNamespace("rvest", quietly = TRUE))stop("rvest required.  Use install.packages(\"rvest\")")

	national = read_data("PokemonNational", root)

	# Extract HTML table data
	HTML = rvest::read_html("https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_National_Pok%C3%A9dex_number")

	# Extract language links
	URLS = rvest::html_elements(HTML, css = 'table tr:nth-of-type(2) [href^="/wiki/List_of_"]')|>
		rvest::html_attr("href")|>
		paste0("https://bulbapedia.bulbagarden.net", b=_)

	# Read the HTML pages
	HTMLS = URLS|>
		map(rvest::read_html)

	# Compute the languages
	langs = paste0(
		str_extract(URLS, "List_of_(.*)_Pok%C3%A9mon", group = 1),
		"_"
	)

	# Clean the tables from each language (Note extraneous tables exist)
	pokeList = map2(HTMLS, langs, function(HTML, lang){
		table = rvest::html_table(HTML)

		table[1:(length(table)-3)]|>
			name_from_row(1, prepend = lang)|>
			bind_rows()|>
			# Discard junk columns
			select(!matches(glue::glue("^{lang}(by National Pokédex|\\.{3}\\d+|X\\d+|by National|MS|English \\u2022 Japanese)")))|>
			# Drop all columns that are NA as some tables are not wanted
			drop_all_na()|>
			# Drop all na columns
			drop_na_columns()|>
			# Rename the first and 2ed column to be standard
			rename(ndex = 1, name = 2)|>
			# Fix ndex to int
			mutate(
				ndex = as.integer(str_remove_all(ndex, "[^\\d]"))
			)
	})

	# Combine the df list into one df
	languages =  pokeList|>
		reduce(function(acc, cur){
			left_join(acc, cur, by = c("ndex", "name"), relationship = "many-to-many")
		}, .init = national)|>
		# Still some columns that are all NA
		drop_na_columns()|>
		# Hindi_Romanization is duplicating values
		group_by(ndex, name, form, regional)|>
		# Apply a function to each group
		group_modify(function(x, y){
			# If the group has only one row, return it as is
			if(dim(x)[1]==1) return(x)
			# Otherwise, filter out rows where 'Hindi_Romanization' is NA
			x|>
				filter(!is.na(Hindi_Romanization ))
		})|>
		mutate(across(
			where(is.character),
			~ if_else(.=="", NA_character_, ., NA_character_)
		))

	if(write)save_data("languages", root, file)
	languages
}
