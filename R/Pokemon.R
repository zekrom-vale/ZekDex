# WIP


#' Scrape Pokémon Data from Bulbapedia
#'
#' This function scrapes Pokémon data from Bulbapedia and saves the HTML content of each Pokémon's page as an RDS file in the specified directory.
#'
#' @param path The directory where the RDS files will be saved. Default is "E:\\html\\".
#' @return None. This function does not return anything but saves the HTML content of each Pokémon's page as an RDS file in the specified directory.
#' @importFrom purrr map
#' @importFrom stringr str_extract
#' @importFrom readr write_rds read_rds
scrape_pokemon = function(path = "E:\\html\\"){
	if(is_loading()) return()
	check_rvest()
	HTML = scrape_page("https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_National_Pok%C3%A9dex_number")

	URLS = rvest::html_elements(HTML, css = 'a[href$="_(Pok%C3%A9mon)"]')|>
		rvest::html_attr("href")|>
		unique()|>
		paste0("https://bulbapedia.bulbagarden.net", b=_)

	map(URLS, function(URL){
		Sys.sleep(sample(1:10, 1))
		HTML = scrape_page(URL)
		write_rds(as.character(HTML), paste0(path, str_extract(URL, "wiki/(.*)_\\(Pok\\%C3\\%A9mon\\)", group = 1), ".rds"))
	})
}


process_pokemon = function(path = "E:\\html\\", scrape = FALSE){
	if(is_loading()) return()
	if(scrape)scrape_pokemon(path)
	for (pokemon in Sys.glob(glue::glue("{path}*.rds"))) {
		pokemon = "E:\\html\\Zekrom.rds"

		# Parts
		# Zekrom (Pokémon) H1
		# navagation
		# side panel
		# Contents (v)
		# 1 Biology H2
		# 2 Game data H2
		# 2.1 Pokédex entries H3
		# 2.2 Game locations H3
		# 2.2.1 In side games H4
		# 2.2.2 In events H4
		# 2.3 Held items H4
		# 2.4 Stats H3
		# 2.4.1 Base stats H4
		# 2.5 Type effectiveness H3
		# 2.6 Learnset H3
		# 2.6.1 By leveling up H4
		# 2.6.2 By TM H4
		# 2.6.3 By breeding H4
		# 2.7 Side game data H3
		# 2.8 Evolution data H3
		# 2.9 Sprites H3
		# 3 In the anime H2
		# 3.1 Main series H3
		# 3.1.1 Major appearances H4
		# 3.1.2 Minor appearances H4
		# 3.2 Pokémon Generations H3
		# 3.3 GOTCHA! H3
		# 	3.4 Pokémon Evolutions H4
		# 4 In the manga H2
		# 5 In the TCG H2
		# 6 Other appearances H2
		# 7 Trivia H2
		# 7.1 Origin H3
		# 7.1.1 Name origin H4
		# 8 In other languages H2
		# 9 Related articles H2
		# 10 References H2
		# 11 External links (Discard) H2

		# source("R/Util.R")

		# Load HTML
		html = rvest::read_html(read_rds(pokemon))

		# Split the children at the H2 elements
		sections <- rvest::html_element(html, "div.mw-parser-output")|>
			rvest::html_children()|>
			split_each(tags = c("h2", "h3", "h4"))

		x=sections|>
			recursive_xml_map(function(x){
				 rvest::html_text(x)
			})

		x[[2]][[1]] # Biology <h2>
		x[[3]][[1]] # Game data <h2>
		x[[3]][[2]][[1]][[1]] # Pokédex entries <h3>
		x[[3]][[3]][[1]] # Game locations <h3>
	}
}
