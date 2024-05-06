#' @importFrom methods setClass new

#' Move Class
#'
#' @description Class for a Pokemon Move.
#' @slot name A character string representing the name of the move.
#' @slot PP An integer representing the current Power Points (PP) of the move.
#' @slot PP.max An integer representing the maximum Power Points (PP) of the move.
#' @slot power An integer representing the power of the move.
#' @slot type A character string representing the type of the move.
#' @slot special A logical value indicating whether the move is special.
#' @slot support A logical value indicating whether the move is a support move.
#' @export
setClass("Move",
		 slots = c(
		 	name = "character",
		 	PP = "integer",
		 	PP.max = "integer",
		 	power = "integer",
		 	type = "character",
		 	special = "logical",
		 	support = "logical"
		 ),
		 prototype = list(
		 	name = NA_character_,
		 	PP = NA_integer_,
		 	PP.max = NA_integer_,
		 	power = NA_integer_,
		 	type = NA_character_,
		 	special = FALSE,
		 	support = FALSE
		 )
)

#' Create a Move Object
#'
#' @description Function to create a Move object.
#' @param name The name of the move.
#' @param PP The current Power Points (PP) of the move.
#' @param power The power of the move.
#' @param type The type of the move.
#' @param special Whether the move is special.
#' @param support Whether the move is a support move.
#' @return A Move object.
#' @export
Move = function(name, PP, power, type, special = FALSE, support = FALSE){
	new("Move",
		name = name,
		PP = PP,
		PP.max = PP,
		power = power,
		type = type,
		special = special,
		support = support
	)
}

#' @importFrom methods @

#' Use a Move
#'
#' @description Function to use a move. If the move has no PP left, it cannot be used.
#' @param this The Move object.
#' @return TRUE if the move was used successfully, FALSE otherwise.
#' @export
Move.use = function(this){
	if(this@PP==0)return(FALSE)
	this@PP = this@PP - 1
	return(TRUE)
}
#' Restore Move PP
#'
#' @description Function to restore the Power Points (PP) of a move to its maximum.
#' @param this The Move object.
#' @return None.
#' @export
Move.restore = function(this){
	this@PP = this@PP.max
}

#' Increase Move PP
#'
#' @description Function to increase the Power Points (PP) of a move by a certain amount.
#' @param this The Move object.
#' @param amt The amount to increase the PP by.
#' @return None.
#' @export
Move.PPUp = function(this, amt){
	# Note, this is allowed to be done infinity
	this@PP = this@PP + amt
	this@PP.max = this@PP.max + amt
}

#' Get Move Power
#'
#' @description Function to get the power of a move.
#' @param this The Move object.
#' @return The power of the move.
#' @export
Move.power = function(this){
	this@power
}

#' Get Move Type
#'
#' @description Function to get the type of a move.
#' @param this The Move object.
#' @return The type of the move.
#' @export
Move.type = function(this){
	this@type
}
