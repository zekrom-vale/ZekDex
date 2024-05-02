#' Generate Pokemon Statistics
#'
#' This function scrapes Pokemon statistics from Bulbapedia and returns a list of two data frames: one in long format and one in wide format. If `write = TRUE`, it also writes these data frames to csv files.
#'
#' @param write Logical, if `TRUE`, writes the data frames to csv files. Default is `FALSE`.
#' @param path The path where the csv file will be written if `write = TRUE`. Default is `system.file("data/PokemonStats.csv", package = "ZekDex")`.
#' @param pathWide The path where the wide format csv file will be written if `write = TRUE`. Default is `system.file("data/PokemonStatsWide.csv", package = "ZekDex")`.
#' @return A list of two data frames: PokemonStats (long format) and PokemonStatsWide (wide format).
#' @export
#'
#' @importFrom purrr map map2 reduce
#' @importFrom dplyr select rename mutate bind_rows
#' @importFrom tidyr pivot_wider
#' @importFrom readr write_csv
#' @importFrom stringr str_extract
#' @importFrom magrittr "%>%"
#' @importFrom rvest read_html html_table html_elements html_attr
#' @importFrom pkgload is_loading
gen_stats = function(
		write = FALSE,
		root = "data/",
		file = "PokemonStats",
		fileWide = "PokemonStatsWide"
	){
	if(pkgload::is_loading()) return()
	if(!requireNamespace("rvest", quietly = TRUE))stop("rvest required.  Use install.packages(\"rvest\")")

	# Stats
	URL = "https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_base_stats_(Generation_II-V)"
	HTML = rvest::read_html(URL)
	URLS = rvest::html_elements(HTML, css = 'table')[[1]]|>
		rvest::html_elements('a[title^="List of Pok\u00E9mon by base stats"]')|>
		rvest::html_attr(name="href")|>
		paste0("https://bulbapedia.bulbagarden.net", b=_)|>
		c(URL)

	HTMLS = URLS|>
		map(rvest::read_html)

	gens = str_extract(URLS, "\\(Generation_(.*)\\)", group = 1)
	stats = map2(HTMLS, gens, function(HTML, gen){
		# HTML = HTMLS[[6]]; gen = "II-V"
		table = rvest::html_table(HTML)
		table = table[[(length(table)-3)]]|>
			select(-2)|>
			rename(ndex=1, name = "Pok\u00E9mon")|>
			mutate(
				# Fix ndex to int
				ndex = as.integer(str_remove_all(ndex, "[^\\d]")),
				Gen = gen
			)
	})|>
		bind_rows()

	national = read_data("PokemonNational", root)

	pokemon = national|>
		select(ndex, name)|>
		distinct()

	# TODO regenerate nationalDex data
	# Extract subset data stats = ZekDex::stats
	stats = stats|>
		rename(form = name)|>
		# Join by ndex
		left_join(pokemon, by = "ndex")|>
		# Extract the mega / primal information
		extract(form, into = c("form", "MegaOrPrimal", "Mega"), regex = "^(.*?)(?:(?= (Mega|Primal) )(.*))?$")|>
		mutate(
			form = str_trim(str_remove(form, name)),
			# For form, MegaOrPrimal, Mega
			across(
				c(form, MegaOrPrimal, Mega),
				# trim and blank is set to NA
				.fns = ~if_else(str_trim(.) == "", NA_character_, str_trim(.))
			)
		)|>
		rename(SpAttack = `Sp. Attack`, SpDefense = `Sp. Defense`)|>
		# Reorder
		select(ndex, name, everything())


	statsWide = stats|>
		pivot_wider(names_from = "Gen", values_from = c("HP", "Attack", "Defense", "Speed", "Special", "Total", "Average", "Sp. Attack", "Sp. Defense"))


	if(write){
		save_data("stats", root, file)
		save_data("statsWide", root, fileWide)
	}
	list(stats, statsWide)
}
