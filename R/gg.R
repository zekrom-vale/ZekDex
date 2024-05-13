#' Generate a list of color palettes for Pokémon types
#'
#' This function generates a list of color palettes for Pokémon types. The list contains two named vectors: 'new' and 'old', each representing a different color palette.
#'
#' @export
#' @return A list of named vectors representing color palettes for Pokémon types.
type_colors = (function(){
	type_colors_types = c("Grass",   "Fire",    "Water",   "Bug",     "Normal",  "Dark",    "Poison",  "Electric","Ground",  "Ice",     "Fairy",   "Steel",   "Fighting","Psychic", "Rock",    "Ghost",   "Dragon",  "Flying", "Stellar", "???")
	type_colors_old   = c("#78C850", "#F08030", "#6890F0", "#A8B820", "#A8A878", "#705848", "#A040A0", "#F8D030", "#E0C068", "#98D8D8", "#EE99AC", "#B8B8D0", "#C03028", "#F85888", "#B8A038", "#705898", "#7038F8", "#A890F0","#364e71", "#4d7a70")
	type_colors_new   = c("#328121", "#af1415", "#0d55b0", "#748114", "#4e5457", "#4e3e3e", "#6b2a9a", "#c89a00", "#74411a", "#0a85a4", "#840f84", "#3a7083", "#cc6600", "#a10e3d", "#504c33", "#5a345a", "#192795", "#0f4579","#364e71", "#4d7a70")
	list(
		new = setNames(type_colors_new, type_colors_types),
		old = setNames(type_colors_old, type_colors_types)
	)
})()

#' Create a ggplot2 fill scale for Pokémon types
#'
#' This function creates a ggplot2 fill scale for Pokémon types using a specified color palette.
#'
#' @param types A named vector representing a color palette for Pokémon types. The names of the vector are the Pokémon types, and the values are the corresponding colors.
#'
#' @return A ggplot2 fill scale.
#' @export
#' @importFrom ggplot2 scale_fill_manual
ggtypes = function(
		types = type_colors$new
	){
	# Return the scale_fill_manual call with the Pokémon type colors
	scale_fill_manual(values = new)
}
