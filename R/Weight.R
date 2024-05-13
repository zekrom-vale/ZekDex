#' Generate Pokemon Weight Data
#'
#' @description Function to scrape and generate Pokemon weight data from Bulbapedia.
#' @param write A logical value indicating whether to write the data to a file.
#' @param root The root directory where the file should be saved.
#' @param file The name of the file where the data should be saved.
#' @return A tibble containing the Pokemon weight data.
#' @export
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
			heaveiest = max(lightest) - lightest + 1L,
			regional = str_extract(name, regionalForm(re=TRUE)),
			regional = if_else(regional == "", NA_character_, regional),
			name = str_trim(str_remove_all(name, regionalForm(re=TRUE))),
			MegaOrPrimal = str_trim(str_extract(name, "Mega|Primal")),
			MegaOrPrimal = if_else(MegaOrPrimal == "", NA_character_, MegaOrPrimal, NA_character_),
			name = str_trim(str_remove(name, "Mega|Primal"))
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
			bigest = max(smallest) - smallest + 1L,
			regional = str_extract(name, regionalForm(re=TRUE)),
			regional = if_else(regional == "", NA_character_, regional),
			name = str_trim(str_remove_all(name, regionalForm(re=TRUE))),
			MegaOrPrimal = str_trim(str_extract(name, "Mega|Primal")),
			MegaOrPrimal = if_else(MegaOrPrimal == "", NA_character_, MegaOrPrimal, NA_character_),
			name = str_trim(str_remove(name, "Mega|Primal"))
		)
	if(write)save_data("height", root, file)
	height
}

#' Generate Physical Attributes of Pokemon
#'
#' This function generates a data frame of physical attributes (weight and height) of Pokemon.
#' It performs two inner joins on the weight and height data frames and combines the results.
#' The function can optionally write the resulting data frame to a file.
#'
#' @importFrom dplyr inner_join filter mutate select distinct bind_rows
#'
#' @param write Logical, whether to write the resulting data frame to a file.
#' @param root Character, the root directory where the data files are located.
#' @param file Character, the name of the file to write the resulting data frame to.
#' @param fileHeight Character, the name of the file containing the height data.
#' @param fileWeight Character, the name of the file containing the weight data.
#' @return A data frame of physical attributes of Pokemon.
#' @export
gen_physicalAttr = function(write = FALSE, root = "data/", file = "PokemonPhysicalAttr", fileHeight = "PokemonHeight", fileWeight = "PokemonWeight"){
	weight = gen_weight(write = write, root = root, file = fileWeight)
	height = gen_height(write = write, root = root, file = fileHeight)

	# Join 'weight' and 'height' data frames on "name", "form", "regional", and "MegaOrPrimal" columns
	# This is an inner join, so only rows with matching values in these columns in both data frames will be included
	attr1 = weight|>
		inner_join(
			height,
			by = c("name", "form", "regional", "MegaOrPrimal")
		)

	# Join 'weight' and 'height' data frames on "name", "regional", and "MegaOrPrimal" columns
	# This is also an inner join, but "form" column is not included in the join
	# 'relationship = "many-to-many"' indicates that there can be multiple matching rows in both data frames for each row in the other data frame
	# This will be dealt with the filter function
	attr2 = weight|>
		inner_join(
			height,
			by = c("name", "regional", "MegaOrPrimal"),
			relationship = "many-to-many"
		)|>
		# Filter out rows where both 'form.x' and 'form.y' are NA or both are not NA
		filter(xor(is.na(form.x), is.na(form.y)))|>
		# Replace NA values in 'form.x' with corresponding values from 'form.y', and remove 'form.y'
		mutate(
			form.x = coalesce(form.x, form.y),
			form.y = NULL
		)|>
		# Rename 'form.x' to 'form'
		rename(form = form.x)

	# Combine 'attr1' and 'attr2' into a single data frame
	physicalAttr = bind_rows(attr1, attr2)

	national = read_data("PokemonNational", root, g="nationalDex")

	physicalAttr = national|>
		select(-form)|>
		distinct()|>
		left_join(
			physicalAttr,
			by = c("name", "regional"),
			relationship = "many-to-many"
		)
	if(write)save_data("physicalAttr", root, file)
	height
}
