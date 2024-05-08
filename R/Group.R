#' Generate a tibble of legendary/mythical groups of Pokemon
#'
#' This function scrapes data from Bulbapedia to create a tibble of legendary/mythical groups of Pokemon.
#' @param write Logical, if TRUE the data is saved to a file, default is FALSE.
#' @param root Character, the root directory where the data file will be saved, default is "data/".
#' @param file Character, the name of the file where the data will be saved, default is "PokemonGroups".
#' @return A tibble of legendary/mythical groups of Pokemon.
#' @importFrom purrr map
#' @importFrom dplyr rename_with mutate filter bind_rows
#' @importFrom tidyr fill pivot_longer
#' @importFrom stringr str_split
#' @importFrom pkgload is_loading
#' @export
gen_groups = function(write = FALSE, root = "data/", file = "PokemonGroups"){
	if(pkgload::is_loading()) return()
	# Import the required package 'rvest' for web scraping
	if(!requireNamespace("rvest", quietly = TRUE))stop("rvest required.  Use install.packages(\"rvest\")")
	# Check if the 'janitor' package is installed. If not, stop the function and ask the user to install it.
	if(!requireNamespace("janitor", quietly = TRUE))stop("janitor required.  Use install.packages(\"janitor\")")
	HTML = rvest::read_html("https://bulbapedia.bulbagarden.net/wiki/Groups_of_Legendary_and_Mythical_Pok%C3%A9mon")
	table = rvest::html_table(HTML)[1:4]
	groups = table|>
		map(function(x){
			# x = table[[2]]
			s = str_split(names(x)[1], " ")[[1]][2]

			x|>
				janitor::clean_names()|>
				rename_with(.fn = ~ paste0("x", 1:length(.)))|>
				mutate(
					family = if_else(x1 == x2, x1, NA_character_)
				)|>
				fill(family, .direction = "up")|>
				filter(x1!=x2)|>
				pivot_longer(cols = starts_with("x"), values_to = "name", names_to = NULL)|>
				mutate(size = s)
		})|>
		bind_rows()
	if(write)save_data("groups", root, file)
	groups
}
