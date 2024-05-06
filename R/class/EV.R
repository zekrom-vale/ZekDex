#' @importFrom methods setClass new

#' EV Class
#'
#' @description Class for Effort Values (EV) of a Pokemon.
#' @slot HP An integer representing the HP stat.
#' @slot Attack An integer representing the Attack stat.
#' @slot Defense An integer representing the Defense stat.
#' @slot Speed An integer representing the Speed stat.
#' @slot SpAttack An integer representing the Special Attack stat.
#' @slot SpDefense An integer representing the Special Defense stat.
#' @export
setClass("EV",
		 slots = c(
		 	HP = "integer",
		 	Attack = "integer",
		 	Defense = "integer",
		 	Speed = "integer",
		 	SpAttack = "integer",
		 	SpDefense = "integer"
		 ),
		 prototype = list(
		 	HP = 0,
		 	Attack = 0,
		 	Defense = 0,
		 	Speed = 0,
		 	SpAttack = 0,
		 	SpDefense = 0
		 )
)

#' Create an EV Object
#'
#' @description Function to create an EV object.
#' @param HP The HP stat.
#' @param Attack The Attack stat.
#' @param Defense The Defense stat.
#' @param Speed The Speed stat.
#' @param SpAttack The Special Attack stat.
#' @param SpDefense The Special Defense stat.
#' @return An EV object.
#' @export
EV = function(
		HP = 0,
		Attack = 0,
		Defense = 0,
		Speed = 0,
		SpAttack = 0,
		SpDefense = 0
){
	new("EV",
		HP = HP,
		Attack = Attack,
		Defense = Defense,
		Speed = Speed,
		SpAttack = SpAttack,
		SpDefense = SpDefense
	)
}

#' @importFrom methods @

#' Get the HP EV
#'
#' @description Function to get the HP EV.
#' @param this The EV object.
#' @return The HP EV.
#' @export
EV.HP = function(this){
	this@HP
}
#' Get the Attack EV
#'
#' @description Function to get the Attack EV.
#' @param this The EV object.
#' @return The Attack EV.
#' @export
EV.Attack = function(this){
	this@Attack
}

#' Get the Defense EV
#'
#' @description Function to get the Defense EV.
#' @param this The EV object.
#' @return The Defense EV.
#' @export
EV.Defense = function(this){
	this@Defense
}

#' Get the Speed EV
#'
#' @description Function to get the Speed EV.
#' @param this The EV object.
#' @return The Speed EV.
#' @export
EV.Speed = function(this){
	this@Speed
}

#' Get the Special Attack EV
#'
#' @description Function to get the Special Attack EV.
#' @param this The EV object.
#' @return The Special Attack EV.
#' @export
EV.SpAttack = function(this){
	this@SpAttack
}

#' Get the Special Defense EV
#'
#' @description Function to get the Special Defense EV.
#' @param this The EV object.
#' @return The Special Defense EV.
#' @export
EV.SpDefense = function(this){
	this@SpDefense
}
