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
	HTML = scrape_page("https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_weight")
	divs = rvest::html_elements(HTML, css = 'div[style^="clear:both; display: grid; grid-template-columns:"]')

	weight = map(divs, function(div){
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
			across(
				c(lbs, kg),
				as_num
			),
			lightest = as.integer(row_number()),
			heaveiest = max(lightest) - lightest + 1L,
			regional = str_extract(name, regionalForm(re=TRUE)),
			name = str_trim(str_remove_all(name, regionalForm(re=TRUE))),
			MegaOrPrimal = str_trim(str_extract(name, "Mega|Primal")),
			name = str_trim(str_remove(name, "Mega|Primal"))
		)|>
		blank_to_na(form, MegaOrPrimal, regional)|>
		mutate(
			MegaOrPrimal = factor(MegaOrPrimal),
			regional = factor(regional)
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
	HTML = scrape_page("https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_height")
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
			inch = as.integer(str_extract(ft, "[\\d.]+(?=\")")) + as.integer(str_extract(ft, "[\\d.]+(?=')")) * 12,
			m = as_num(m),
			smallest = as.integer(row_number()),
			bigest = max(smallest) - smallest + 1L,
			regional = str_extract(name, regionalForm(re=TRUE)),
			name = str_trim(str_remove_all(name, regionalForm(re=TRUE))),
			MegaOrPrimal = str_trim(str_extract(name, "Mega|Primal")),
			name = str_trim(str_remove(name, "Mega|Primal"))
		)|>
		blank_to_na(MegaOrPrimal, regional, form)|>
		mutate(MegaOrPrimal = factor(MegaOrPrimal))
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
			relationship = "many-to-many",
			suffix = c("", ".y")
		)|>
		# Filter out rows where both 'form' and 'form.y' are NA or both are not NA
		filter(xor(is.na(form), is.na(form.y)))|>
		# Replace NA values in 'form' with corresponding values from 'form.y', and remove 'form.y'
		mutate(
			form = coalesce(form, form.y),
			form.y = NULL
		)|>
		# Join exp types
		left_join(gen_exp_type(), by = c("ndex", "name"))

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

#' @title Scrapes the experience types from Bulbapedia
#' @description This function scrapes the experience types from the Bulbapedia website.
#' @return A vector of experience types.
#' @importFrom rvest read_html html_table
#' @importFrom dplyr filter mutate pull
#' @importFrom stringr str_detect str_remove
#' @export
gen_exp_list = function(){
	HTML = scrape_page("https://bulbapedia.bulbagarden.net/wiki/Experience")
	rvest::html_table(HTML)[[1]]|>
		filter(!str_detect(Description, "unused"))|>
		mutate(Description = str_remove(Description, "Gen.+$"))|>
		pull(Description)
}

#' @title Scrapes the Pokémon by experience type table from Bulbapedia
#' @description This function scrapes the Pokémon by experience type table from the Bulbapedia website.
#' @return A data frame of Pokémon and their experience types.
#' @importFrom rvest read_html html_table
#' @importFrom dplyr select rename mutate
#' @export
gen_exp_type = function(){
	HTML = scrape_page("https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_experience_type")
	rvest::html_table(HTML)[[1]]|>
		select(-MS)|>
		rename(ndex = `#`, expType = `Experience type`)|>
		rename_pokemon()|>
		mutate(expType = factor(expType, levels = gen_exp_list()))
}



#' @title Scrapes the experience total table from Bulbapedia
#' @description This function scrapes the experience total table from the Bulbapedia website.
#' @return A data frame of experience totals by level and experience type.
#' @importFrom rvest read_html html_table
#' @importFrom dplyr rename mutate
#' @importFrom tidyr pivot_longer
#' @export
gen_exp_points = function(){
	HTML = scrape_page("https://bulbapedia.bulbagarden.net/wiki/Experience")
	rvest::html_table(HTML)[[3]]|>
		.name_from_row(sep = "_")|>
		pivot_longer(-Level, names_sep = "_", names_to = c("expType", "to"))|>
		rename(level = Level)|>
		mutate(
			value = as_int(value),
			level = as.integer(level),
			expType = factor(str_remove(expType, "[^\\w ]"), levels = gen_exp_list())
		)
}
