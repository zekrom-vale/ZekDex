#' Generate Catch Rate Pokémon Data
#'
#' This function scrapes data from Bulbapedia's "List of Pokémon by catch rate" page and returns a tibble of the data.
#' It also has the option to write the data to a file.
#'
#' @param write Logical. If TRUE, the function will write the data to a file. Default is FALSE.
#' @param root Character. The root directory where the file will be saved. Default is "data/".
#' @param file Character. The name of the file where the data will be saved. Default is "PokemonCatch".
#' @return A tibble of the scraped Pokémon data.
#' @export
#' @importFrom purrr map walk
#' @importFrom dplyr as_tibble select_if rename any_of rename_with mutate coalesce bind_rows
#' @importFrom tidyr separate
#' @importFrom stringr str_extract
gen_catch = function(write = FALSE, root = "data/", file = "PokemonCatch"){
	check_rvest()

	# Read and parse the HTML from the URL
	HTML = scrape_page("https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_catch_rate")

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

	# Extract the specified tables from the HTML
	table = rvest::html_table(HTML)[c(2,4)]

	# Use the purrr package's map function to apply a function to each element of 'table'
	catchRate = table |>
		map(function(t){
			t|>
				# Convert 't' to a tibble and ensure column names are unique
				as_tibble(.name_repair = "unique")|>
				# Select only the columns that are not logical
				select_if(~!is.logical(.))|>
				# Rename the specified columns if they exist
				rename(
					any_of(c(catchRate = "Catch rate", Ndex = "#"))
				)|>
				rename(ndex = Ndex)|>
				# Rename the columns that match the specified patterns to "name"
				rename_pokemon()|>
				# Mutate the 'ndex' column by attempting to extract integer values from it,
				# and if that fails (returns NA), use the original 'ndex' values
				mutate(
					ndex = as_int(ndex)
				)
		})|>
		# Bind all the tibbles in the list together into a single tibble
		bind_rows()|>
		# Split catch rate on :!: as defined above
		separate(catchRate, into = c("catchRate", "note"), sep = ":!:", fill="right")|>
		mutate(
			catchRate = as.integer(catchRate),
			Hdex = as_int(Hdex)
		)|>
		rename(hdex = Hdex)

	if(write)save_data("catchRate", root, file)
	catchRate
}
