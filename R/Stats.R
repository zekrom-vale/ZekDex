#' Generate Pokemon Statistics
#'
#' This function scrapes Pokemon statistics from Bulbapedia and returns a list of two data frames: one in long format and one in wide format. If `write = TRUE`, it also writes these data frames to csv files.
#'
#' @param write Logical, if `TRUE`, writes the data frames to csv files. Default is `FALSE`.
#' @param root The root directory where the csv file will be written if `write = TRUE`. Default is "data/".
#' @param file The name of the csv file to be written if `write = TRUE`. Default is "PokemonStats".
#' @param fileWide The name of the wide format csv file to be written if `write = TRUE`. Default is "PokemonStatsWide".
#' @return A list of two data frames: PokemonStats (long format) and PokemonStatsWide (wide format).
#' @importFrom purrr map map2 reduce
#' @importFrom dplyr select rename mutate bind_rows
#' @importFrom tidyr pivot_wider
#' @importFrom readr write_csv
#' @importFrom stringr str_extract
#' @importFrom magrittr "%>%"
#' @importFrom pkgload is_loading
#' @export
gen_stats = function(
		write = FALSE,
		root = "data/",
		file = "PokemonStats",
		fileWide = "PokemonStatsWide"
	){
	if(is_loading()) return()
	check_rvest()

	# Stats
	URL = "https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_base_stats_(Generation_II-V)"
	HTML = scrape_page(URL)
	URLS = rvest::html_elements(HTML, css = 'table')[[1]]|>
		rvest::html_elements('a[title^="List of Pok\u00E9mon by base stats"]')|>
		rvest::html_attr(name="href")|>
		paste0("https://bulbapedia.bulbagarden.net", b=_)|>
		c(URL)

	HTMLS = URLS|>
		map(scrape_page)

	gens = str_extract(URLS, "\\(Generation_(.*)\\)", group = 1)
	stats = map2(HTMLS, gens, function(HTML, gen){
		# HTML = HTMLS[[6]]; gen = "II-V"
		table = rvest::html_table(HTML)

		table[[(length(table)-3)]]|>
			select(-2)|>
			rename(ndex=1, name = "Pok\u00E9mon")|>
			mutate(
				# Fix ndex to int
				ndex = as_int(ndex),
				Gen = gen
			)
	})|>
		bind_rows()

	pokemon = read_data("PokemonNational", root, g="nationalDex")|>
		select(ndex, name)|>
		distinct()

	# TODO regenerate nationalDex data
	# Extract subset data stats = ZekDex::stats
	stats = stats|>
		# Rename the 'name' column to 'form'
		rename(form = name)|>
		# Join the 'stats' and 'pokemon' datasets by 'ndex'
		left_join(pokemon, by = "ndex")|>
		# Extract the 'form', 'MegaOrPrimal', and 'Mega' information from the 'form' column
		extract(form, into = c("form", "MegaOrPrimal", "Mega"), regex = "^(.*?)(?:(?= (Mega|Primal) )(.*))?$")|>
		mutate(
			# Extract the regional form from the 'form' column and trim any leading/trailing whitespace
			regional = str_trim(str_extract(form, regionalForm(re=TRUE))),
			# Remove the regional form and Pokémon name from the 'form' column
			form = str_remove(form, paste0(regionalForm(re=TRUE), "\\s*", name)),
			# If 'form' contains parentheses, extract the text within the parentheses; otherwise, keep 'form' as is
			form = if_else(str_detect(form, "\\([^()]+\\)"), str_extract(form, "\\(([^()]+)\\)", group = 1), form, NA_character_),
			# Remove the Pokémon name from the 'form' column and trim any leading/trailing whitespace
			form = str_trim(str_remove(form, name)),
			# For 'form', 'MegaOrPrimal', and 'Mega' columns
			across(
				c(form, MegaOrPrimal, Mega, regional),
				# Trim any leading/trailing whitespace and replace empty strings with NA
				.fns = ~if_else(str_trim(.) == "", NA_character_, str_trim(.), NA_character_)
			),
			across(c(MegaOrPrimal, Gen), factor)
		)|>
		# Rename the 'Sp. Attack' and 'Sp. Defense' columns to 'SpAttack' and 'SpDefense', respectively
		rename(SpAttack = `Sp. Attack`, SpDefense = `Sp. Defense`)|>
		# Reorder the columns
		select(ndex, name, form, regional, everything())

	statsWide = stats|>
		pivot_wider(names_from = "Gen", values_from = c("HP", "Attack", "Defense", "Speed", "Special", "Total", "Average", "SpAttack", "SpDefense"))|>
		drop_na_columns()

	if(write){
		save_data("stats", root, file)
		save_data("statsWide", root, fileWide)
	}
	list(stats, statsWide)
}
