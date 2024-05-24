#' Generate Regional Pokedex
#'
#' This function generates a tibble of the regional Pokedex by scraping data from Bulbapedia. It extracts the URLs of the regional Pokedex pages from the HTML, reads the HTML of each regional Pokedex page, and combines the regional Pokedex data with the national Pokedex data.
#'
#' @param write Logical, if `TRUE`, writes the tibble to a csv file. Default is `FALSE`.
#' @param root The root directory where the csv file will be written if `write = TRUE`. Default is "data/".
#' @param file The name of the csv file to be written if `write = TRUE`. Default is "PokemonRegional".
#' @return A tibble of regional dexes.
#' @importFrom purrr map map2 reduce discard transpose
#' @importFrom dplyr mutate select distinct left_join join_by bind_rows rename rename_with starts_with
#' @importFrom readr read_csv write_csv
#' @importFrom utils data
#' @importFrom stringr str_extract str_remove_all
#' @importFrom tidyr drop_na
#' @importFrom magrittr "%>%"
#' @importFrom pkgload is_loading
#' @export
gen_reginal = function(write = FALSE, root = "data/", file = "PokemonRegional"){
	if(is_loading()) return()
	check_rvest()

	national = read_data("PokemonNational", root, g="nationalDex")

	# Read the HTML of the webpage containing the list of Pokemon by National Pokedex number
	HTML = rvest::read_html("https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_National_Pok%C3%A9dex_number")

	# Extract the URLs of the regional Pokedex pages from the HTML
	URLS = rvest::html_elements(HTML, css = 'table tbody tbody tbody [href^="/wiki/List_of_Pok%C3%A9mon_by_"][href*="Pok%C3%A9dex_number"]')|>
		rvest::html_attr("href")|>
		paste0("https://bulbapedia.bulbagarden.net", b=_)

	# Remove the URLs of the Diamond/Pearl/Battle Pokedex and the New Pokedex, as they cause issues for binding
	URLS = URLS[!str_detect(URLS, "_Pearl_Battle_|_by_New_Pok")]

	# Extract the names of the dexes and the games from the URLs
	dexes = list(
		dexes = str_extract(URLS, "by_(.*)_Pok", group = 1),
		game = str_extract(URLS, "\\(([^()]+)\\)", group = 1)
	)|>
		transpose()

	# Read the HTML of each regional Pokedex page
	HTMLS = URLS|>
		map(rvest::read_html)

	regionalDex = map2(HTMLS, dexes, function(HTML, dex){
		# HTML = HTMLS[[11]]; dex = dexes[[11]]
		# Read the tables from the HTML
		table = HTML|>
			rvest::html_table()

		# Discard the changes from Ultra Sun and Ultra Moon
		if(is.na(dex$game)) table = table[1:(length(table)-3)]
		else if(dex$game == "Ultra_Sun_and_Ultra_Moon")table = table[1:(length(table)-4)]
		else table = table[1:(length(table)-3)]

		# Bind the rows of the tables, rename the type columns, and clean up the data
		table = table|>
			discard(~dim(.)[2]<6 || dim(.)[2]>13)|>
			bind_rows()|>
			rename_with(starts_with("Type"), .fn = ~c("type", "type2"))

		# Further clean up the data and rename the columns
		table|>
			rename(ndex=Ndex)|>
			mutate(
				# Remove duplicate types
				type2 = factor_type(if_else(type == type2, NA_character_, type2)),
				type = factor_type(type),
				# Fix ndex to int
				ndex = as_int(ndex)
			)|>
			select(!matches("^(MS|Image|ObsidianFieldlands|CrimsonMirelands|CobaltCoastlands|CoronetHighlands|AlabasterIcelands)$"))|>
			rename_pokemon()|>
			rename_with(!c(ndex, name, starts_with("type")), .fn = function(.){
				game = str_remove_all(dex$game, "_")
				dex = str_remove_all(dex$dexes, "_")
				paste(game, dex, ., sep="_")
			})|>
			distinct()
	})|>
		# Combine the regional Pokedex data with the national Pokedex data
		reduce(function(acc, cur){
			# Join by Pokemon than type (Only issue that reginals will be duplicated, may not be an issue though)
			left_join(acc, cur, by = join_by(ndex, name, type, type2))
		}, .init = national|>
			distinct()
	)|>
		# Fix the dexes into ints
		mutate(
			across(
				-names(national),
				as_int
			),
			across(c(regional, family, size), factor),
			generation = as.integer(generation)
		)|>
		# Remove speaces
		# Fix the redundant names
		rename_with(
			.fn = function(.){
				removeA(.)|>
					str_replace_all("\\s+", "_")|>
					str_remove_all("'")
			},
			.cols = matches("^[A-Z]")
		)

	if(write)save_data("regionalDex", root, file)
	regionalDex
}
