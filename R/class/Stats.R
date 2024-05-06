#' @importFrom methods setClass new

#' Stats Class
#'
#' @description Class for Pokemon Stats that includes EV and IV objects.
#' @slot EV An object of class "EV".
#' @slot IV An object of class "IV".
#' @export
setClass("Stats",
		 slots = c(
		 	EV = "EV",
		 	IV = "IV"
		 )
)

#' Create a Stats Object
#'
#' @description Function to create a Stats object.
#' @param EV An object of class "EV".
#' @param IV An object of class "IV".
#' @return A Stats object.
#' @export
Stats = function(EV, IV){
	new("Stats", EV = EV, IV = IV)
}

#' @importFrom methods @

#' Get the HP Stat
#'
#' @description Function to get the HP stat.
#' @param this The Stats object.
#' @return The HP stat.
#' @export
Stats.HP = function(this){
	IV.HP(this@IV) + EV.HP(this@EV)
}

#' Get the Attack Stat
#'
#' @description Function to get the Attack stat.
#' @param this The Stats object.
#' @return The Attack stat.
#' @export
Stats.Attack = function(this){
	IV.Attack(this@IV) + EV.Attack(this@EV)
}

#' Get the Defense Stat
#'
#' @description Function to get the Defense stat.
#' @param this The Stats object.
#' @return The Defense stat.
#' @export
Stats.Defense = function(this){
	IV.Defense(this@IV) + EV.Defense(this@EV)
}

#' Get the Speed Stat
#'
#' @description Function to get the Speed stat.
#' @param this The Stats object.
#' @return The Speed stat.
#' @export
Stats.Speed = function(this){
	IV.Speed(this@IV) + EV.Speed(this@EV)
}

#' Get the Special Attack Stat
#'
#' @description Function to get the Special Attack stat.
#' @param this The Stats object.
#' @return The Special Attack stat.
#' @export
Stats.SpAttack = function(this){
	IV.SpAttack(this@IV) + EV.SpAttack(this@EV)
}

#' Get the Special Defense Stat
#'
#' @description Function to get the Special Defense stat.
#' @param this The Stats object.
#' @return The Special Defense stat.
#' @export
Stats.SpDefense = function(this){
	IV.SpDefense(this@IV) + EV.SpDefense(this@EV)
}
