#' Generate EV Yield
#'
#' This function scrapes data from Bulbapedia to generate a dataframe of Pokémon effort value yields by generation.
#'
#' @param write A logical value indicating whether to write the output dataframe to a file. Default is FALSE.
#' @param root A character string specifying the root directory where the output file will be saved. Default is "data/".
#' @param file A character string specifying the name of the output file. Default is "PokemonEVYield".
#' @return A dataframe of Pokémon effort value yields by generation.
#' @importFrom pkgload is_loading
#' @importFrom purrr map map2 walk discard
#' @importFrom stringr str_detect str_extract str_remove_all
#' @importFrom tibble as_tibble
#' @importFrom dplyr select rename rename_with mutate bind_rows
#' @importFrom tidyr separate_wider_delim
#' @export
gen_evYield = function(write = FALSE, root = "data/", file = "PokemonEVYield"){
	if(pkgload::is_loading()) return()
	# Import the required package 'rvest' for web scraping
	if(!requireNamespace("rvest", quietly = TRUE))stop("rvest required.  Use install.packages(\"rvest\")")
	URL = "https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_effort_value_yield_(Generation_V-VI)"
	HTML = rvest::read_html(URL)

	URLS = rvest::html_elements(HTML, 'a[title^="List of Pokémon by effort value yield"]')|>
		rvest::html_attr("href")|>
		unique()|>
		discard(~!str_detect(.,"[()]"))|>
		paste0("https://bulbapedia.bulbagarden.net", b=_)|>
		c(URL)

	HTMLS = map(URLS, rvest::read_html)

	evYield = map2(HTMLS, URLS, function(HTML, URL){
		Gen = str_extract(URL, "\\((?:Generation_?)?([^()]+)\\)", group = 1)

		# Find all 'span.explain' elements in the HTML
		spans = HTML|>
			rvest::html_nodes("span.explain")

		# For each 'span.explain' element, extract the 'title' attribute and replace the element's text with the title
		spans|>
			walk(~{
				# Due to pointers this modifies the original HTML source
				title = rvest::html_attr(.x, "title")  # Extract the 'title' attribute
				xml2::xml_text(.x) <- paste0(":!:", title)  # Replace the element's text with the title
			})

		rvest::html_table(HTML)[[2]]|>
			as_tibble(.name_repair = "unique")|>
			rename(ndex = `#`)|>
			select(-`...2`)|>
			rename_with(~"form", matches("Pok\u00e9mon"))|>
			rename_with(~str_remove_all(., "[.\\s]"), everything())|>
			separate_wider_delim(Exp, delim = ":!:", names = c("Exp", "note"), too_few = "align_start")|>
			mutate(Gen = Gen, Exp = as.integer(Exp))
	})|>
		bind_rows()|>
		mutate(Gen = factor(Gen))

	REGIONAL_REGEX = regionalForm(re = TRUE, ext = TRUE)
	REMOVE_REGEX = glue("[\\s,]*{REGIONAL_REGEX}[\\s,]*(Forme?)?[\\s,]*")
	nationalDex = read_data("PokemonNational", root, g="nationalDex")

	evYield = evYield|>
		left_join(nationalDex|>select(ndex, name), by = "ndex", relationship = "many-to-many")|>
		mutate(
			form = str_remove(form, name),
			regional = str_extract(form, REGIONAL_REGEX),
			form = str_trim(str_remove(form, REMOVE_REGEX))
		)|>
		extract(form, into = c("form", "MegaOrPrimal", "Mega"), regex = "^(.*?)(?:(?=(Mega|Primal))(.*))?$")|>
		mutate(
			across(
				c(form, MegaOrPrimal, Mega, regional),
				# Trim any leading/trailing whitespace and replace empty strings with NA
				.fns = ~if_else(str_trim(.) == "", NA_character_, str_trim(.), NA_character_)
			),
			regional = factor(regional),
			MegaOrPrimal = factor(MegaOrPrimal)
		)|>
		select(ndex, name, form, regional, Gen, everything())

	if(write)save_data("evYield", root, file)

	# Return the 'evYield' dataframe
	evYield
}
