#' Generates regional dex from scratch
#'
#' @param write Write the file to `data/PokemonRegional.csv`?
#'
#' @return A tibble with of regional dexes
#' @export
#'
#' @importFrom rvest read_html html_elements html_attr
#' @importFrom purrr map map2 reduce
#' @importFrom dplyr mutate select rename_with distinct left_join
#' @importFrom readr read_csv write_csv
#' @importFrom utils data
#' @importFrom stringr str_extract str_remove_all
gen_reginal = function(write = FALSE){
	# Check if the 'rvest' package is installed. If not, stop the function and ask the user to install it.
	if(!requireNamespace("rvest", quietly = TRUE))stop("rvest required.  Used install.packages(\"rvest\")")

	# Load the 'PokemonNational' data from the 'ZekDex' package
	nat = data("PokemonNational", package = "ZekDex")
	# If the data is not loaded correctly, read it from the csv file in the package's data directory
	if(nat == "PokemonNational")nat = read_csv(system.file("data/PokemonNational.csv", package = "ZekDex"))

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

	regionDex = map2(HTMLS, dexes, function(HTML, dex){
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
			mutate(type2 = if_else(type == type2, NA_character_, type2))|>
			select(!matches("^(MS|Image|ObsidianFieldlands|CrimsonMirelands|CobaltCoastlands|CoronetHighlands|AlabasterIcelands)$"))|>
			rename(Name = `Pokémon`)|>
			rename_with(!c(Ndex, Name, starts_with("type")), .fn = function(.){
				game = str_remove_all(dex$game, "_")
				dex = str_remove_all(dex$dexes, "_")
				paste(game, dex, ., sep="_")
			})|>
			distinct()
	})|>
		# Combine the regional Pokedex data with the national Pokedex data
		reduce(function(acc, cur){
			# Join by Pokemon than type (Only issue that reginals will be duplicated, may not be an issue though)
			left_join(acc, cur, by = join_by(Ndex, Name, type, type2))
		}, .init = national|>
			rename(Name = English)|>
			distinct()
	)

	# Thses 4 are issues, they have split dexes
	# https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_Kalos_Pok%C3%A9dex_number
	# CeKdex Ndex Pokémon    CoKdex MoKdex game  dex
	# https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_Alola_Pok%C3%A9dex_number_(Sun_and_Moon)
	# Adex  Melemele Akala `Ula'ula` Poni  Ndex  Pokémon    game         dex
	# Adex  Melemele Akala `Ula'ula` Poni  Ndex  Pokémon    game                     dex
	# https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_Hisui_Pok%C3%A9dex_number
	# LAdex ObsidianFieldlands CrimsonMirelands CobaltCoastlands CoronetHighlands AlabasterIcelands Ndex  Pokémon    game  dex > Drop odd dexes

	# Write the regional Pokedex data to a csv file in the package's data directory, if requested
	if(write)write_csv(regionDex, system.file("data/PokemonRegional.csv", package = "ZekDex"))
}
