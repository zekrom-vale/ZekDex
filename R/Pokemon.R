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

	pokemonText = list()
	for (pokemon in Sys.glob(glue::glue("{path}*.rds"))) {
		# pokemon = "E:\\html\\Zekrom.rds"
		print(pokemon)

		# Load HTML
		html = rvest::read_html(read_rds(pokemon))

		# Split the children at the H2 elements
		sections = rvest::html_element(html, "div.mw-parser-output")|>
			rvest::html_children()|>
			split_each(tags = c("h2", "h3", "h4"))

		texts = sections|>
			recursive_xml_map(function(x){
				 rvest::html_text(x)
			})

		pokemonText[[URLdecode(str_extract(pokemon, "\\\\([^\\\\]+)\\.rds", 1))]] <- texts

	}
}

random_fact <- function(data) {
	if (inherits(data, "xml_node") || inherits(data, "xml_nodeset")) {
		# If data is an xml node or xml node set, print the text
		rvest::html_text2(data)
	} else if (inherits(data, "list")) {
		# If data is a list, randomly select an element and recurse
		index <- sample(length(data), 1)
		random_fact(data[[index]])
	} else {
		# If data is not a list or xml node/xml node set, print it directly
		data
	}
}
