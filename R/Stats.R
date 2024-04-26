#' Generate Pokémon Statistics
#'
#' This function scrapes Pokemon statistics from Bulbapedia and returns a list of two data frames: one in long format and one in wide format. If `write = TRUE`, it also writes these data frames to csv files.
#'
#' @param write Logical, if `TRUE`, writes the data frames to csv files. Default is `FALSE`.
#' @param path The path where the csv file will be written if `write = TRUE`. Default is `system.file("data/PokemonStats.csv", package = "ZekDex")`.
#' @param pathWide The path where the wide format csv file will be written if `write = TRUE`. Default is `system.file("data/PokemonStatsWide.csv", package = "ZekDex")`.
#' @return A list of two data frames: PokemonStats (long format) and PokemonStatsWide (wide format).
#' @importFrom rvest read_html html_elements html_attr
#' @importFrom purrr map map2
#' @importFrom dplyr select rename mutate bind_rows
#' @importFrom tidyr pivot_wider
#' @importFrom readr write_csv
#' @importFrom stringr str_extract
#' @importFrom utils packageVersion
#' @importFrom base stop
#' @examples
#' gen_stats()
gen_stats = function(write = FALSE, path = system.file("data/PokemonStats.csv", package = "ZekDex"), pathWide = system.file("data/PokemonStatsWide.csv", package = "ZekDex")){
	if(!requireNamespace("rvest", quietly = TRUE))stop("rvest required.  Use install.packages(\"rvest\")")

	# Stats
	URL = "https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_base_stats_(Generation_II-V)"
	HTML = rvest::read_html(URL)
	URLS = rvest::html_elements(HTML, css = 'table')[[1]]|>
		rvest::html_elements('a[title^="List of Pok\\u00E9mon by base stats"]')|>
		rvest::html_attr(name="href")|>
		paste0("https://bulbapedia.bulbagarden.net", b=_)|>
		c(URL)

	HTMLS = URLS|>
		map(rvest::read_html)

	gens = str_extract(URLS, "\\(Generation_(.*)\\)", group = 1)
	PokemonStats = map2(HTMLS, gens, function(HTML, gen){
		# HTML = HTMLS[[6]]; gen = "II-V"
		table = rvest::html_table(HTML)
		table = table[[(length(table)-3)]]|>
			select(-2)|>
			rename(Ndex=1, Name = "Pok\\u00E9mon")|>
			mutate(Gen = gen)
	})|>
		bind_rows()

	PokemonStatsWide = PokemonStats|>
		pivot_wider(names_from = "Gen", values_from = c("HP", "Attack", "Defense", "Speed", "Special", "Total", "Average", "Sp. Attack", "Sp. Defense"))


	if(write)write_csv(PokemonStats, path)
	if(write)write_csv(PokemonStatsWide, pathWide)
	list(PokemonStats, PokemonStatsWide)
}
