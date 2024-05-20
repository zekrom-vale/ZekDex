#' Create Directories and Links for Pokemon Data
#'
#' This function creates directories for each letter of the alphabet and for each Pokemon.
#' It also creates links for each Pokemon's type.
#'
#' @param dir A string specifying the base directory. Default is "Pokemon".
#' @param link Boolean create typing links
#'
#' @importFrom purrr map pmap
#' @importFrom stringr str_to_upper str_remove str_detect
#' @importFrom glue glue
#' @importFrom base dir.create
#'
#' @return None. The function is called for its side effects of creating directories and links.
#' @examples
#' create_pokemon_dirs_links(dir = "Pokemon")
#' @export
function(dir = "Pokemon", link = TRUE){
	# Letters
	purrr::map(LETTERS, function(x){
		dir.create(glue::glue("{dir}\\Letters\\{x}"), recursive = TRUE)
	})

	pokemon = nationalDex|>
		mutate(
			name = removeA(name),
			name = str_remove(name, "[:*<>\\/\\[\\]]"),
			L = str_to_upper(substr(name, start = 1, stop = 1)),
			folder = glue::glue("E:\\lambada-dest\\Pokemon\\Letters\\{L}\\{name}"),
			L = NULL,
			type = str_to_lower(type),
			type2 = str_to_lower(type2)
		)

	# Pokemon sub folders
	pokemon|>
		pull(folder)|>
		purrr::map(
			dir.create
		)
	if(requireNamespace("rvest", quietly = TRUE)&&link){
		# Create typing links
		# This takes a while
		pokemon|>
			group_by(name, folder, type, type2)|>
			dplyr::group_map(function(x){
				name = x$name[[1]]
				folder = x$folder[[1]]
				type = x$type[[1]]
				type2 = x$type2[[1]]
				R.utils::createLink(link = glue::glue("{dir}\\{str_to_title(type)}\\{name}"), target = folder, skip = TRUE)
				if(!is.na(type2) && type != type2){
					R.utils::createLink(link = glue::glue("{dir}\\{str_to_title(type2)}\\{name}"), target = folder, skip = TRUE)
				}
			})
	}
	else warning("Skipping type links, Use install.packages(\"R.utils\")")
}
