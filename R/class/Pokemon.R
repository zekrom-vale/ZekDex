#' @importFrom methods setClass new

#' Pokemon Class
#'
#' @description Class for a Pokemon.
#' @slot pokemon A character string representing the name of the Pokemon.
#' @slot reginal A character string representing the regional form of the Pokemon.
#' @slot form A character string representing the form of the Pokemon.
#' @slot level An integer representing the level of the Pokemon.
#' @slot exp An integer representing the current experience points of the Pokemon.
#' @slot expNext An integer representing the experience points needed for the next level.
#' @slot HP An integer representing the HP stat of the Pokemon.
#' @slot status A character string representing the status of the Pokemon.
#' @slot stats An object of class "Stats" representing the stats of the Pokemon.
#' @slot type A character string representing the primary type of the Pokemon.
#' @slot type2 A character string representing the secondary type of the Pokemon.
#' @slot gender A character string representing the gender of the Pokemon.
#' @slot pattern An integer representing the pattern of the Pokemon.
#' @slot height A numeric value representing the height of the Pokemon.
#' @slot wheight A numeric value representing the weight of the Pokemon.
#' @slot item A character string representing the item held by the Pokemon.
#' @slot moves A list representing the moves known by the Pokemon.
#' @slot shiny A logical value indicating whether the Pokemon is shiny.
#' @export
setClass("Pokemon",
		 slots = c(
		 	pokemon = "character",
		 	reginal = "character",
		 	form = "character",
		 	level = "integer",
		 	exp = "integer",
		 	expNext = "integer",

		 	HP = "integer",
		 	status = "character",
		 	stats = "Stats",
		 	type = "character",
		 	type2 = "character",
		 	gender = "character", # Some moves
		 	pattern = "integer", # Graphics only

		 	height = "numeric", # Some moves
		 	wheight = "numeric", # Some moves

		 	#isMega = "logical",
		 	#megaType = "character",
		 	#megaType2 = "character",
		 	#isTera = "logical",
		 	#teraType = "character",
		 	#isMax = "logical",

		 	item = "character",
		 	moves = "list",

		 	shiny = "logical" # Graphics only
		 )
)

#' Create a Pokemon Object
#'
#' @description Function to create a Pokemon object.
#' @param pokemon The name of the Pokemon.
#' @param reginal The regional form of the Pokemon.
#' @param form The form of the Pokemon.
#' @param level The level of the Pokemon.
#' @param stats An object of class "Stats" representing the stats of the Pokemon.
#' @param type The primary type of the Pokemon.
#' @param type2 The secondary type of the Pokemon.
#' @param gender The gender of the Pokemon.
#' @param pattern The pattern of the Pokemon.
#' @param height The height of the Pokemon.
#' @param wheight The weight of the Pokemon.
#' @param item The item held by the Pokemon.
#' @param moves The moves known by the Pokemon.
#' @param shiny Whether the Pokemon is shiny.
#' @return A Pokemon object.
#' @export
Pokemon = function(
		pokemon = "Zekrom",
		reginal = NA_character_,
		form = NA_character_,
		level = 1,
		stats = NULL,
		type = NA_character_,
		type2 = NA_character_,
		gender = "Ungendered",
		pattern = 0,

		height = NA_real_,
		wheight = NA_real_,

		item = NA_character_,
		moves = list(),
		shiny = FALSE
){
	pkm = new("Pokemon",
		pokemon = pokemon,
		reginal = reginal,
		form = form,
		level = level,
		exp = 0,
		expNext = NA_integer_,
		HP = Stats.HP(stats),
		status = NA_character_,
		stats = stats,
		type = type,
		type2 = type2,
		gender = gender,
		pattern = pattern,
		height = height,
		wheight = wheight,
		item = item,
		moves = moves,
		shiny = shiny
	)
	Pokemon.calcNextExp(pkm)
	pkm
}


#' Get Pokemon Type
#'
#' @description Function to get the type of a Pokemon.
#' @param this The Pokemon object.
#' @return The type of the Pokemon. If the Pokemon has two types, a character vector of both types is returned.
#' @export
Pokemon.type = function(this){
	if(is.na(this@type2))return(this@type)
	return(c(this@type, this@type2))
}

#' Pokemon Attack
#'
#' @description Function for a Pokemon to perform an attack.
#' @param atacker The attacking Pokemon.
#' @param attack The attack move.
#' @param defender The defending Pokemon.
#' @param .gen The generation to use for calculating damage.
#' @return TRUE if the attack was successful, FALSE otherwise.
#' @export
Pokemon.attack = function(atacker, attack, defender, .gen = "V"){
	if(!Move.use(attack))return(FALSE)
	atype = Move.type(attack)
	dtypes = Pokemon.type(this)
	damage = pokemon_damage(
		atacker@level,
		Stats.Attack(atacker@stats),
		Stats.Defense(defender@stats),
		Move.power(attack),
		effectiveness(atype, dtypes, atype %in% dtypes),
		.gen = "V"
	)
	Pokemon.damage(defender, damage)
	return(TRUE)
}

#' Pokemon Damage
#'
#' @description Function to apply damage to a Pokemon.
#' @param this The Pokemon object.
#' @param amt The amount of damage to apply.
#' @return TRUE if the Pokemon has fainted as a result of the damage, FALSE otherwise.
#' @export
Pokemon.damage = function(this, amt){
	this@HP = this@HP - amt
	# Is it fainted? TRUE is fainted
	return(Pokemon.isFainted(this))
}

#' Pokemon Heal
#'
#' @description Function to heal a Pokemon.
#' @param this The Pokemon object.
#' @param frac The fraction of max HP to heal.
#' @param pts The number of HP points to heal.
#' @return The current HP of the Pokemon after healing.
#' @export
Pokemon.heal = function(this, frac = 0, pts = 0){
	if(frac > 0){
		max = Stats.HP(this@stats)
		this@HP = max * frac + this@HP
		if(this@HP > max) this@HP = max
		return(this@HP)
	}
	max = Stats.HP(this@stats)
	this@HP = this@HP + pts
	if(this@HP > max) this@HP = max
	return(this@HP)
}

#' Check if Pokemon is Fainted
#'
#' @description Function to check if a Pokemon has fainted.
#' @param this The Pokemon object.
#' @return TRUE if the Pokemon has fainted, FALSE otherwise.
#' @export
Pokemon.isFainted = function(this){
	# Is it fainted? TRUE is fainted
	return(this@HP <= 0)
}

#' Pokemon Gain Experience
#'
#' @description Function for a Pokemon to gain experience.
#' @param this The Pokemon object.
#' @param opponent The defeated Pokemon object.
#' @return Nothing
#' @export
Pokemon.exp = function(this, opponent){
	Pokemon.expRaw(this, Pokemon.expCalc(this, opponent))
}

#' Calculate Experience Points
#'
#' @description Function to calculate the experience points a Pokemon gains after defeating an opponent.
#' @param this The Pokemon object.
#' @param opponent The defeated Pokemon object.
#' @return The calculated experience points.
#' @export
Pokemon.expCalc = function(this, opponent){
	# Base Experience is a constant value specific to the species of the defeated Pokemon.
	# For simplicity, let's assume it's 50 for all Pokemon.
	baseExperience <- 50

	# Level is the level of the defeated Pokemon.
	level <- opponent@level

	# Calculate the experience gained using the formula from Pokemon Black and White.
	expGained <- ((baseExperience * level) / 5) * ((2 * level + 10) / (level + level + 10)) ^ 2.5 / 2

	# Round the experience gained to the nearest whole number.
	expGained <- round(expGained)

	return(expGained)
}



#' Pokemon Gain Experience
#'
#' @description Function for a Pokemon to gain experience.
#' @param this The Pokemon object.
#' @param amt The amount of experience to gain.
#' @export
Pokemon.expRaw = function(this, amt){
	this@exp = this@exp + amt
	while(this@exp >= this@expNext){
		this@exp = this@exp - this@expNext
		Pokemon.calcNextExp(this) # Calculate next
		this@level = this@level + 1
	}
}

#' Pokemon Level Up
#'
#' @description Function for a Pokemon to level up.
#' @param this The Pokemon object.
#' @export
Pokemon.level = function(this){
	this@exp = 0
	this@level = this@level + 1
	Pokemon.calcNextExp(this)
}

#' Calculate Next Experience Threshold
#'
#' @description Function to calculate the next experience threshold for a Pokemon.
#' @param this The Pokemon object.
#' @export
Pokemon.calcNextExp = function(this){
	# Example formula: nextExp = level^2 + level * 100
	this@expNext = this@level^2 + this@level * 100
}
