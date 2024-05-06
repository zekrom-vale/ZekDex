#' Generate Pokemon Weight Data
#'
#' @description Function to scrape and generate Pokemon weight data from Bulbapedia.
#' @param write A logical value indicating whether to write the data to a file.
#' @param root The root directory where the file should be saved.
#' @param file The name of the file where the data should be saved.
#' @return A tibble containing the Pokemon weight data.
#' @export
#' @importFrom rvest read_html html_elements html_text
#' @importFrom purrr map
#' @importFrom dplyr mutate if_else bind_rows
#' @importFrom stringr str_trim str_remove str_extract
#' @importFrom tibble tibble
gen_weight = function(write = FALSE, root = "data/", file = "PokemonWeight"){
	URL = "https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_weight"
	HTML = rvest::read_html(URL)
	divs = rvest::html_elements(HTML, css = 'div[style^="clear:both; display: grid; grid-template-columns:"]')

	weight = map(divs, function(div){
		# div = divs[[14]]
		tibble(
			name = div|>
				rvest::html_elements(css = 'div[class="roundy"]>div b')|>
				rvest::html_text(),
			form = div|>
				rvest::html_elements(css = 'div[class="roundy"]>div')|>
				rvest::html_text(),
			lbs = div|>
				rvest::html_elements(css = 'div[class="roundy"]>p>span:nth-of-type(1)')|>
				rvest::html_text(),
			kg = div|>
				rvest::html_elements(css = 'div[class="roundy"]>p>span:nth-of-type(2)')|>
				rvest::html_text()
		)
	})|>
		bind_rows()|>
		mutate(
			form = str_trim(str_remove(form, name)),
			form = if_else(form == "", NA_character_, form),
			lbs = as.numeric(str_extract(lbs, "[\\d.]+")),
			kg = as.numeric(str_extract(kg, "[\\d.]+")),
			lightest = as.integer(row_number()),
			heaveiest = max(lightest) - lightest + 1L
		)
	if(write)save_data("weight", root, file)
	weight
}

#' Generate Pokemon Height Data
#'
#' @description Function to scrape and generate Pokemon height data from Bulbapedia.
#' @param write A logical value indicating whether to write the data to a file.
#' @param root The root directory where the file should be saved.
#' @param file The name of the file where the data should be saved.
#' @return A tibble containing the Pokemon height data.
#' @export
#' @importFrom rvest read_html html_elements html_text
#' @importFrom purrr map
#' @importFrom dplyr mutate if_else bind_rows
#' @importFrom stringr str_trim str_remove str_extract
#' @importFrom tibble tibble
gen_height = function(write = FALSE, root = "data/", file = "PokemonHeight"){
	URL = "https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_height"
	HTML = rvest::read_html(URL)
	# Emulation of parent_of(rvest::html_elements(HTML, css = 'div[style^="clear:both; display: grid; grid-template-columns:"]'))
	divs = rvest::html_elements(HTML, xpath = '//div[starts-with(@style, "clear:both; display: grid; grid-template-columns:")]/..')

	height = map(divs, function(div){
		# div = divs[[1]]
		tibble(
			name = div|>
				rvest::html_elements(css = 'div[class="roundy"]>div b')|>
				rvest::html_text(),
			form = div|>
				rvest::html_elements(css = 'div[class="roundy"]>div')|>
				rvest::html_text(),
			ft = div|>
				rvest::html_elements(css = 'div[style="float:left; font-weight:bold"]')|>
				rvest::html_text(),
			m = div|>
				rvest::html_elements(css = 'div[style="float:right; font-weight:bold"]')|>
				rvest::html_text()
		)
	})|>
		bind_rows()|>
		mutate(
			form = str_trim(str_remove(form, name)),
			form = if_else(form == "", NA_character_, form),
			inch = as.integer(str_extract(ft, "[\\d.]+(?=\")")) + as.integer(str_extract(ft, "[\\d.]+(?=')")) * 12,
			m = as.numeric(str_extract(m, "[\\d.]+")),
			smallest = as.integer(row_number()),
			bigest = max(smallest) - smallest + 1L
		)
	if(write)save_data("height", root, file)
	height
}


gen_physicalAttr = function(write = FALSE, root = "data/", fileHeight = "PokemonHeight", fileWeight = "PokemonWeight"){
	weight = gen_weight(write = write, root = root, file = fileWeight)
	height = gen_height(write = write, root = root, file = fileHeight)
	national = read_data("PokemonNational", root, g="nationalDex")


}