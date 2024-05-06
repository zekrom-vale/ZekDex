#' @importFrom methods setClass new

#' IV Class
#'
#' @description Class for Individual Values (IV) of a Pokemon.
#' @slot HP An integer representing the HP stat.
#' @slot Attack An integer representing the Attack stat.
#' @slot Defense An integer representing the Defense stat.
#' @slot Speed An integer representing the Speed stat.
#' @slot SpAttack An integer representing the Special Attack stat.
#' @slot SpDefense An integer representing the Special Defense stat.
#' @export
setClass("IV",
		 slots = c(
		 	HP = "integer",
		 	Attack = "integer",
		 	Defense = "integer",
		 	Speed = "integer",
		 	SpAttack = "integer",
		 	SpDefense = "integer"
		 )
)

#' Create an IV Object
#'
#' @description Function to create an IV object.
#' @param HP The HP stat.
#' @param Attack The Attack stat.
#' @param Defense The Defense stat.
#' @param Speed The Speed stat.
#' @param SpAttack The Special Attack stat.
#' @param SpDefense The Special Defense stat.
#' @param pkm The Pokemon name.
#' @param f The form of the Pokemon.
#' @param g The generation of the Pokemon.
#' @return An IV object.
#' @export
IV = function(
		HP = 0,
		Attack = 0,
		Defense = 0,
		Speed = 0,
		SpAttack = 0,
		SpDefense = 0,
		pkm = NULL,
		f = NA_character_,
		g = "IX"
){
	if(!is.null(pkm)){
		dex = stats|>
			filter(name == pkm, Gen == g)
		if(is.na(f))dex = dex|>
				filter(is.na(form))
		else dex = dex|>
				filter(form == f)


		return(new("IV",
				   HP = dex$HP[1],
				   Attack = dex$Attack[1],
				   Defense = dex$Defense[1],
				   Speed = dex$Speed[1],
				   SpAttack = dex$SpAttack[1],
				   SpDefense = dex$SpDefense[1]
		))
	}

	new("IV",
		HP = HP,
		Attack = Attack,
		Defense = Defense,
		Speed = Speed,
		Special = Special,
		SpAttack = SpAttack,
		SpDefense = SpDefense
	)
}

#' @importFrom methods @

#' Get the HP IV
#'
#' @description Function to get the HP IV.
#' @param this The IV object.
#' @return The HP IV.
#' @export
IV.HP = function(this){
	this@HP
}
#' Get the Attack IV
#'
#' @description Function to get the Attack IV.
#' @param this The IV object.
#' @return The Attack IV.
#' @export
IV.Attack = function(this){
	this@Attack
}

#' Get the Defense IV
#'
#' @description Function to get the Defense IV.
#' @param this The IV object.
#' @return The Defense IV.
#' @export
IV.Defense = function(this){
	this@Defense
}

#' Get the Speed IV
#'
#' @description Function to get the Speed IV.
#' @param this The IV object.
#' @return The Speed IV.
#' @export
IV.Speed = function(this){
	this@Speed
}

#' Get the Special Attack IV
#'
#' @description Function to get the Special Attack IV.
#' @param this The IV object.
#' @return The Special Attack IV.
#' @export
IV.SpAttack = function(this){
	this@SpAttack
}

#' Get the Special Defense IV
#'
#' @description Function to get the Special Defense IV.
#' @param this The IV object.
#' @return The Special Defense IV.
#' @export
IV.SpDefense = function(this){
	this@SpDefense
}
