#' Scrape Pokémon Data from Bulbapedia
#'
#' This function scrapes Pokémon data from Bulbapedia and saves the HTML content of each Pokémon's page as an RDS file in the specified directory.
#'
#' @param path The directory where the RDS files will be saved. Default is "E:\\html\\".
#' @return None. This function does not return anything but saves the HTML content of each Pokémon's page as an RDS file in the specified directory.
#' @importFrom rvest read_html html_elements html_attr
#' @importFrom purrr map
#' @importFrom stringr str_extract
#' @importFrom readr write_rds
#' @examples
#' scrape_pokemon()
scrape_pokemon = function(path = "E:\\html\\"){
	# Import the required package 'rvest' for web scraping
	if(!requireNamespace("rvest", quietly = TRUE))stop("rvest required.  Use install.packages(\"rvest\")")
	HTML = rvest::read_html("https://bulbapedia.bulbagarden.net/wiki/List_of_Pok%C3%A9mon_by_National_Pok%C3%A9dex_number")

	URLS = rvest::html_elements(HTML, css = 'a[href$="_(Pok%C3%A9mon)"]')|>
		rvest::html_attr("href")|>
		unique()|>
		paste0("https://bulbapedia.bulbagarden.net", b=_)

	map(URLS, function(URL){
		Sys.sleep(sample(1:10, 1))
		HTML = rvest::read_html(URL)
		write_rds(as.character(HTML), paste0(path, str_extract(URL, "wiki/(.*)_\\(Pok\\%C3\\%A9mon\\)", group = 1), ".rds"))
	})
}

process_pokemon = function(path = "E:\\html\\", scrape = FALSE){
	if(scrape)scrape_pokemon(path)
	for (pokemon in Sys.glob(glue::glue("{path}*.rds"))) {

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

		#' Checks if a given xml_node type of tag exists
		#'
		#' @param x The object to search
		#' @param tag What xml_node to search for
		#'
		#' @return TRUE if it exists FALSE otherwise
		#' @export
		#'
		check_h <- function(x, tag) {
			if(inherits(x, "xml_node")) rvest::html_name(x) == tag
			else if (is.list(x)) any(unlist(lapply(x, check_h, tag)))
			else FALSE
		}

		#' Extracts all xml_nodes matching the tag and all other elements that don't
		#'
		#'
		#' @param lst A list or xml_nodeset of xml_nodes to extract from
		#' @param tag The tag to extract form the set
		#'
		#' @return A list of
		#'		matched_elements that have the matching xml_nodes
		#'		other_elements that have the updated list without the matched elements
		#' @export
		#'

		pluck_matched_node = function(lst, tag) {
			# Initialize empty lists for matched_elements and other_elements
			matched_elements <- list()
			other_elements <- list()

			# Iterate over each element in the list
			for (i in seq_along(lst)) {
				# If the element is an xml_node and its name matches the tag, add it to matched_elements
				if (inherits(lst[[i]], "xml_node") && rvest::html_name(lst[[i]]) == tag) {
					matched_elements[[length(matched_elements) + 1]] <- lst[[i]]
				} else if(inherits(lst[[i]], "xml_node")) {
					# Otherwise, add it to other_elements
					other_elements[[length(other_elements) + 1]] <- lst[[i]]
				} else {
					# If the element is a list, recursively pluck the h2 element from it
					both <- pluck_matched_node(lst[[i]], tag)
					# Accumulate to respective lists
					matched_elements[[length(matched_elements) + 1]] <- both$matched_elements
					other_elements[[length(other_elements) + 1]] <- both$other_elements
				}
			}

			# Return a list with two elements: matched_elements and other_elements
			list(
				matched_elements = if(length(matched_elements) > 0) matched_elements else NULL,
				other_elements = if(length(other_elements) > 0) other_elements else NULL
			)
		}



		#' Re levels the structure of a list of xml_nodes and xml_nodesets
		#'
		#' @param lst The list to modify
		#' @param level The current level of recursion
		#' @param tags The tags to move down (Note: this is not built to move things up)
		#'
		#' @return The modified list
		#' @export
		#'
		#' @examples
		#' new_node = function(tag, val){
		#' xml2::read_html(glue::glue("<{tag}>{val}</{tag}>"))|>
		#'    xml2::xml_child()|>
		#'    xml2::xml_child()
		#' }
		#'
		#' # example data
		#' t = list(
		#'    list(
		#'        list(
		#'            new_node("h2", "hi"),
		#'            new_node("div", "hi")
		#'        )
		#' 	  )
		#' )
		#' # > [[1]]
		#' # > [[1]][[1]]
		#' # > [[1]][[1]][[1]]
		#' # > {html_node}
		#' # > <h2>
		#' # >
		#' # > 	[[1]][[1]][[2]]
		#' # > {html_node}
		#' # > <div>
		#' v = t|>
		#' 	recursive_xml_map2(relevel_matched_node)
		#' # > [[1]]
		#' # > [[1]][[1]]
		#' # > {html_node}
		#' # > <h2>
		#' # >
		#' # > [[1]][[2]]
		#' # > [[1]][[2]][[1]]
		#' # > {html_node}
		#' # > <div>
		relevel_matched_node <- function(lst, level = 1){
			tags <- c("h2", "h3", "h4")
			# If it's a node return as is
			if (inherits(lst, "xml_node")) return(lst)
			if (level <= length(tags) && any(purrr::map_lgl(lst, function(x) check_h(x, tags[level])))) {
				# Pluck the node
				both <- pluck_matched_node(lst, tags[level])
				# Other elements here
				other_elements <- both$other_elements
				# Matched element here
				matched_elements <- both$matched_elements
				# Recurce, may not be necessary
				return(c(matched_elements, purrr::map(other_elements, relevel_matched_node, level)))
			} else {
				# Check if an element is an xml_node or xml_nodeset before recurcing
				purrr::map(lst, function(x) {
					# If it's a node return as is
					if(inherits(x, "xml_node"))
						return(x)
					# If it's a list or a nodeset recurce
					return(purrr::map(x, relevel_matched_node, level))
				})
			}
		}


		new_node = function(tag, val){
			xml2::read_html(glue::glue("<{tag}>{val}</{tag}>"))|>
				xml2::xml_child()|>
				xml2::xml_child()
		}

		# example data
		t = list(
				list(
					list(
						new_node("h2", "hi"),
						new_node("div", "hi")
					)
				)
			)

		v = t|>
			recursive_xml_map2(relevel_matched_node)



		# Split the children at the H2 elements
		sections <- rvest::html_element(html, "div.mw-parser-output")|>
			rvest::html_children()|>
			split_each(tags = c("h2", "h3", "h4"))|>
			recursive_xml_map2(relevel_matched_node)

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
