# Load the tidyverse package
library(tidyverse)

#' Pokemon Damage Calculation Generation I
#'
#' This function calculates the damage inflicted during a Pokemon battle.
#' It uses the formula from Generation I.
#'
#' @param level The level of the attacking Pokemon.
#' @param attackStat The effective Attack stat of the attacking Pokemon.
#' @param defenseStat The effective Defense stat of the target Pokemon.
#' @param power The power of the used move.
#' @param effectiveness The product of Type, and Type2.
#' @param stab Logical. If TRUE, add the same type attack bonus
#' @param critical Logical. If TRUE, it's a critical hit. Default is FALSE.
#' @param random Character string. If "yes", a random uniformly distributed integer between 217 and 255 is used. If "minmax", the min and max values are returned. If anything else, the average is used. Default is "yes".
#'
#' @return The calculated damage.
#' @importFrom stats runif
#' @export
#'
pokemon_damage_I = function(
		level,
		attackStat,
		defenseStat,
		power,
		effectiveness,
		stab = FALSE,
		critical = FALSE,
		random = "yes"
	) {
	# If immune return 0
	if(effectiveness == 0)return(0)
	# Logical to set values
	critical = critical + 1
	stab = stab + 1

	# Check if attackStat or defenseStat are greater than 255
	if (attackStat > 255 | defenseStat > 255) {
		attackStat = attackStat / 4
		defenseStat = defenseStat / 4
	}

	# Calculate random uniformly distributed integer between 217 and 255 if random is yes
	if(random == "yes") rand = runif(1, 217, 255) / 255
	# If random is passed minmax give the min and max
	else if(random == "minmax") rand = c(217, 255) / 255
	# Else give the average
	else rand = (217 + 255) / 255 / 2

	# Calculate damage
	base = floor(
		floor(
			(
				floor(2 * level / 5) + 2
			) * power * floor(attackStat / defenseStat)
		) / 50
	)
	floor_mult = function(x,y) floor(x*y)

	damage = (base + 2)|>
		floor_mult(stab)|>
		floor_mult(effectiveness)|>
		floor_mult(rand)

	if(damage == 0) return(1)
	damage

}

#' Pokemon Damage Calculation Generation II
#'
#' This function calculates the damage inflicted during a Pokemon battle.
#' It uses the formula from Generation II.
#'
#' @note
#' this function does not handle the specific conditions mentioned (like Reflect, Light Screen, Explosion, Selfdestruct, etc.).
#' You would need to handle these conditions before passing the values to this function
#'
#' @param level The level of the attacking Pokemon.
#' @param attackStat The effective Attack stat of the attacking Pokemon.
#' @param defenseStat The effective Defense stat of the target Pokemon.
#' @param power The power of the used move.
#' @param effectiveness The product of Type, and Type2.
#' @param stab Logical. If TRUE, add the same type attack bonus.
#' @param item Logical. If TRUE, the attacker is holding an type-enhancing held item corresponding to the attack type. Default is FALSE.
#' @param critical Logical. If TRUE, it's a critical hit. Default is FALSE.
#' @param random Character string. If "yes", a random uniformly distributed integer between 217 and 255 is used. If "minmax", the min and max values are returned. If anything else, the average is used. Default is "yes".
#'
#' @return The calculated damage.
#' @importFrom stats runif
#' @export
pokemon_damage_II <- function(
		level,
		attackStat,
		defenseStat,
		power,
		effectiveness,

		item = FALSE,
		critical = FALSE,
		TK = 1,
		weather = 1,
		badge = FALSE,
		stab = FALSE,
		moveMod = 1,
		doubleDmg = FALSE,
		random = "yes"
	) {
	# If immune return 0
	if(effectiveness == 0)return(0)
	# Logical to set values
	item = ifelse(item, 1.1, 1)
	critical = critical + 1
	stab = stab + 1
	badge = ifelse(badge, 1.125, 1)
	doubleDmg = doubleDmg + 1

	# Check if attackStat or defenseStat are greater than 255
	if (attackStat > 255 | defenseStat > 255) {
		attackStat = attackStat / 4
		defenseStat = defenseStat / 4
	}

	# Calculate random uniformly distributed integer between 217 and 255 if random is yes
	if(random == "yes") rand = runif(1, 217, 255) / 255
	# If random is passed minmax give the min and max
	else if(random == "minmax") rand = c(217, 255) / 255
	# Else give the average
	else rand = (217 + 255) / 255 / 2

	# Calculate damage
	base = floor(
		floor(
			(
				floor(2 * level / 5) + 2
			) * power * floor(attackStat / defenseStat)
		) / 50
	)
	floor_mult = function(x,y) floor(x*y)

	inner = base|>
		floor_mult(item)|>
		floor_mult(critical)|>

	damage = (inner + 2)|>
		floor_mult(TK)|>
		floor_mult(weather)|>
		floor_mult(badge)|>
		floor_mult(stab)|>
		floor_mult(effectiveness)|>
		floor_mult(moveMod)|>
		floor_mult(rand)|>
		floor_mult(doubleDmg)

	if(damage == 0) return(1)
	damage
}

#' Pokemon Damage Calculation Generation III
#'
#' This function calculates the damage inflicted during a Pokemon battle.
#' It uses the formula from Generation III.
#'
#' @note
#' this function does not handle the specific conditions mentioned (like Reflect, Light Screen, Explosion, Selfdestruct, etc.).
#' You would need to handle these conditions before passing the values to this function
#'
#' @param level The level of the attacking Pokemon.
#' @param attackStat The effective Attack stat of the attacking Pokemon.
#' @param defenseStat The effective Defense stat of the target Pokemon.
#' @param power The power of the used move.
#' @param effectiveness The product of Type, and Type2.
#' @param stab Logical. If TRUE, add the same type attack bonus.
#' @param burn Logical. If TRUE, the attacker is burned, its Ability is not Guts, and the used move is a physical move. Default is FALSE.
#' @param screen The screen multiplier. Default is 1.
#' @param targets The targets multiplier. Default is 1.
#' @param weather The weather multiplier. Default is 1.
#' @param FF Logical. If TRUE, the used move is Fire-type, and the attacker's Ability is Flash Fire that has been activated by a Fire-type move. Default is FALSE.
#' @param stockpile The stockpile multiplier. Default is 1.
#' @param critical Logical. If TRUE, it's a critical hit. Default is FALSE.
#' @param doubleDmg Logical. If TRUE, double the damage of the move. Default is FALSE.
#' @param charge Logical. If TRUE, the move is Electric-type and Charge takes effect. Default is FALSE.
#' @param HH Logical. If TRUE, the attacker's ally in a Double Battle has used Helping Hand on it. Default is FALSE.
#' @param random Character string. If "yes", a random uniformly distributed integer between 85 and 100 is used. If "minmax", the min and max values are returned. If anything else, the average is used. Default is "yes".
#'
#' @return The calculated damage.
#' @importFrom stats runif
#' @export
pokemon_damage_III = function(
		level,
		attackStat,
		defenseStat,
		power,
		effectiveness,

		burn = FALSE,
		screen = 1,
		targets = 1,
		weather = 1,
		FF = FALSE,
		stockpile = 1,
		critical = FALSE,
		doubleDmg = FALSE,
		charge = FALSE,
		HH = FALSE,
		stab = FALSE,
		random = "yes"
) {
	# If immune return 0
	if(effectiveness == 0)return(0)
	# Logical to set values
	stab = stab + 1
	critical = critical + 1
	doubleDmg = doubleDmg + 1
	burn = ifelse(burn, 0.5, 1)
	FF = ifelse(FF, 1.5, 1)
	charge = ifelse(charge, 2, 1)
	HH = ifelse(HH, 1.5, 1)

	# Check if attackStat or defenseStat are greater than 255
	if (attackStat > 255 | defenseStat > 255) {
		attackStat = attackStat / 4
		defenseStat = defenseStat / 4
	}

	# Calculate random uniformly distributed integer between 85 and 100 if random is yes
	if(random == "yes") rand = runif(1, 85, 100) / 100
	# If random is passed minmax give the min and max
	else if(random == "minmax") rand = c(85, 100) / 100
	# Else give the average
	else rand = (85 + 100) / 100 / 2

	# Calculate damage
	base = floor(
		floor(
			(
				(floor(2 * level / 5)) + 2
			) * power * floor(attackStat / defenseStat)
		) / 50
	)

	floor_mult = function(x,y) floor(x*y)
	inner = base|>
		floor_mult(burn)|>
		floor_mult(screen)|>
		floor_mult(targets)|>
		floor_mult(weather)|>
		floor_mult(FF)

	damage = (inner + 2)|>
		floor_mult(stockpile)|>
		floor_mult(critical)|>
		floor_mult(doubleDmg)|>
		floor_mult(charge)|>
		floor_mult(HH)|>
		floor_mult(stab)|>
		floor_mult(effectiveness)|>
		floor_mult(rand)
	if(damage == 0 && other >= 1) return(1)
	damage
}

#' Pokemon Damage Calculation Generation IV
#'
#' This function calculates the damage inflicted during a Pokemon battle.
#' It uses the formula from Generation IV.
#'
#' @note
#' this function does not handle the specific conditions mentioned (like Reflect, Light Screen, Explosion, Selfdestruct, etc.).
#' You would need to handle these conditions before passing the values to this function
#'
#' @param level The level of the attacking Pokemon.
#' @param attackStat The effective Attack stat of the attacking Pokemon.
#' @param defenseStat The effective Defense stat of the target Pokemon.
#' @param power The power of the used move.
#' @param effectiveness The product of Type, and Type2.
#' @param stab Logical. If TRUE, add the same type attack bonus.
#' @param burn Logical. If TRUE, the attacker is burned, its Ability is not Guts, and the used move is a physical move. Default is FALSE.
#' @param screen The screen multiplier. Default is 1.
#' @param targets The targets multiplier. Default is 1.
#' @param weather The weather multiplier. Default is 1.
#' @param FF Logical. If TRUE, the used move is Fire-type, and the attacker's Ability is Flash Fire that has been activated by a Fire-type move. Default is FALSE.
#' @param critical Logical. If TRUE, it's a critical hit. Default is FALSE.
#' @param item Logical. If TRUE, the attacker is holding an type-enhancing held item corresponding to the attack type. Default is FALSE.
#' @param first Logical. If TRUE, the used move was stolen with Me First. Default is FALSE.
#' @param SRF Logical. If TRUE, the used move is super effective, the target's Ability is Solid Rock or Filter, and the attacker's Ability is not Mold Breaker. Default is FALSE.
#' @param EB Logical. If TRUE, the used move is super effective and the attacker is holding an Expert Belt. Default is FALSE.
#' @param TL Logical. If TRUE, the used move is not very effective and the attacker's Ability is Tinted Lens. Default is FALSE.
#' @param Berry Logical. If TRUE, the used move is super effective and the target is holding the Berry that weakens it, or Normal-type and the target is holding a Chilan Berry. Default is FALSE.
#' @param random Character string. If "yes", a random uniformly distributed integer between 85 and 100 is used. If "minmax", the min and max values are returned. If anything else, the average is used. Default is "yes".
#'
#' @return The calculated damage.
#' @importFrom stats runif
#' @export
pokemon_damage_IV = function(
		level,
		attackStat,
		defenseStat,
		power,
		effectiveness,

		burn = FALSE,
		screen = 1,
		targets = 1,
		weather = 1,
		FF = FALSE,
		critical = FALSE,
		item = FALSE,
		first = FALSE,
		stab = FALSE,
		SRF = FALSE,
		EB = FALSE,
		TL = FALSE,
		Berry = FALSE,
		random = "yes"
) {
	# If immune return 0
	if(effectiveness == 0)return(0)
	# Logical to set values
	item = ifelse(item, 1.1, 1)
	stab = stab + 1
	critical = critical + 1
	burn = ifelse(burn, 0.5, 1)
	FF = ifelse(FF, 1.5, 1)
	SRF = ifelse(SRF, 0.75, 1)
	EB = ifelse(EB, 1.2, 1)
	TL = ifelse(TL, 2, 1)
	Berry = ifelse(Berry, 0.5, 1)
	first = ifelse(first, 1.5, 1)

	# Check if attackStat or defenseStat are greater than 255
	if (attackStat > 255 | defenseStat > 255) {
		attackStat = attackStat / 4
		defenseStat = defenseStat / 4
	}

	# Calculate random uniformly distributed integer between 85 and 100 if random is yes
	if(random == "yes") rand = runif(1, 85, 100) / 100
	# If random is passed minmax give the min and max
	else if(random == "minmax") rand = c(85, 100) / 100
	# Else give the average
	else rand = (85 + 100) / 100 / 2

	# Calculate damage
	base = floor(
		floor(
			(
				(floor(2 * level / 5)) + 2
			) * power * floor(attackStat / defenseStat)
		) / 50
	)

	floor_mult = function(x,y) floor(x*y)
	inner = base|>
		floor_mult(burn)|>
		floor_mult(screen)|>
		floor_mult(targets)|>
		floor_mult(weather)|>
		floor_mult(FF)

	damage = (inner + 2)|>
		floor_mult(critical)|>
		floor_mult(item)|>
		floor_mult(first)|>
		floor_mult(rand)|>
		floor_mult(stab)|>
		floor_mult(effectiveness)|>
		floor_mult(SRF)|>
		floor_mult(EB)|>
		floor_mult(TL)|>
		floor_mult(Berry)
	if(damage == 0 && other >= 1) return(1)
	damage
}

#' Pokemon Damage Calculation Generation V and onward
#'
#' This function calculates the damage inflicted during a Pokemon battle.
#' It uses the formula from Generation V and onward.
#'
#' @note
#' this function does not handle the specific conditions mentioned (like Reflect, Light Screen, Explosion, Selfdestruct, etc.).
#' You would need to handle these conditions before passing the values to this function
#'
#' @param level The level of the attacking Pokemon.
#' @param attackStat The effective Attack stat of the attacking Pokemon.
#' @param defenseStat The effective Defense stat of the target Pokemon.
#' @param power The power of the used move.
#' @param effectiveness The product of Type, and Type2.
#' @param stab Logical. If TRUE, add the same type attack bonus.
#' @param PB Logical. If TRUE, the move is the second strike of Parental Bond. Default is FALSE.
#' @param weather The weather multiplier. Default is 1.
#' @param GlaiveRush Logical. If TRUE, the target used the move Glaive Rush in the previous turn. Default is FALSE.
#' @param critical Logical. If TRUE, it's a critical hit. Default is FALSE.
#' @param burn Logical. If TRUE, the attacker is burned, its Ability is not Guts, and the used move is a physical move. Default is FALSE.
#' @param other The other multiplier. Default is 1.
#' @param ZMove Logical. If TRUE, the move is a Z-Move or Max Move and the target would be protected from that move (e.g. by Protect). Default is FALSE.
#' @param TeraShield Logical. If TRUE, it is applied in Tera Raid Battles when the Raid boss's shield is active. Default is FALSE.
#' @param targets The targets multiplier. Default is 1.
#' @param random Character string. If "yes", a random uniformly distributed integer between 85 and 100 is used. If "minmax", the min and max values are returned. If anything else, the average is used. Default is "yes".
#' @param .criticalVal The critical hit multiplier. Default is 1.5 (2 in Generation V).
#' @param .PBVal The Parental Bond multiplier. Default is 0.25 (0.5 in Generation VI).
#'
#' @return The calculated damage.
#' @importFrom stats runif
#' @export
pokemon_damage_V = function(
		level,
		attackStat,
		defenseStat,
		power,
		effectiveness,

		PB = FALSE,
		weather = 1,
		GlaiveRush = FALSE,
		critical = FALSE,
		stab = FALSE,
		burn = FALSE,
		other = 1,
		ZMove = FALSE,
		TeraShield = FALSE,
		targets = 1,
		random = "yes",
		.criticalVal = 1.5, # 1.5 (2 in Generation V)
		.PBVal = 0.25 # 0.25 (0.5 in Generation VI)
) {
	# If immune return 0
	if(effectiveness == 0)return(0)
	# Logical to set values
	stab = stab + 1
	critical = ifelse(critical, .criticalVal, 1)
	burn = ifelse(burn, 0.5, 1)
	PB = ifelse(PB, 1, .PBVal)
	ZMove = ifelse(ZMove, 0.25, 1)
	TeraShield = ifelse(TeraShield, 0.2, 1)

	# Check if attackStat or defenseStat are greater than 255
	if (attackStat > 255 | defenseStat > 255) {
		attackStat = attackStat / 4
		defenseStat = defenseStat / 4
	}

	# Calculate random uniformly distributed integer between 85 and 100 if random is yes
	if(random == "yes") rand = runif(1, 85, 100) / 100
	# If random is passed minmax give the min and max
	else if(random == "minmax") rand = c(85, 100) / 100
	# Else give the average
	else rand = (85 + 100) / 100 / 2

	# Calculate damage
	base = round(
		round(
			(
				(round(2 * level / 5)) + 2
			) * power * round(attackStat / defenseStat)
		) / 50
	)

	# base * burn * screen * targets * weather * FF
	floor_mult = function(x,y) floor(x*y)

	# (inner + 2) * critical * item * moveMod * rand * HH * badge * effectiveness * stab * SRF * EB * TL * Berry * other * ZMove * TeraShield
	damage = (base + 2)|>
		floor_mult(targets)|>
		floor_mult(PB)|>
		floor_mult(weather)|>
		floor_mult(GlaiveRush)|>
		floor_mult(critical)|>
		floor_mult(rand)|>
		floor_mult(stab)|>
		floor_mult(effectiveness)|>
		floor_mult(burn)|>
		floor_mult(other)|>
		floor_mult(ZMove)|>
		floor_mult(TeraShield)
	if(damage == 0 && other >= 1) return(1)
	damage
}
