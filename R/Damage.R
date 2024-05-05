# In the first four generations, during the calculation, all operations are carried out on integers
# internally—this means that all division operations are truncated integer division
# (i.e. rounding down if the result is not an integer), and the results of multiplication operations
# are rounded down afterwards (truncating any fractional part). From Generation V onward,
# there are three different types of rounding; a flooring (the same as previous generations),
# rounding to the nearest integer while rounding down at 0.5, and rounding to the nearest integer
# while rounding up at 0.5.
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
	damage = (((((2 * level * critical / 5) + 2) * power * attackStat / defenseStat) / 50) + 2) * effectiveness * stab * rand
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
#' @param stab Logical. If TRUE, add the same type attack bonus
#' @param item Logical. If TRUE, the attacker is holding an type-enhancing held item corresponding to the attack type Default is FALSE.
#' @param TK The TK multiplier for Triple Kick. Default is 1.
#' @param weather The weather multiplier. Default is 1.
#' @param badge Logical. If TRUE, the attacking Pokémon is controlled by the player and if the player has obtained the Badge corresponding to the used move's type. Default is FALSE.
#' @param moveMod The move modifier. Default is 1.
#' @param doubleDmg Logical. If TRUE, double the damage of the move. Default is FALSE.
#' @param critical Logical. If TRUE, it's a critical hit. Default is FALSE.
#' @param random Character string. If "yes", a random uniformly distributed integer between 217 and 255 is used. If "minmax", the min and max values are returned. If anything else, the average is used. Default is "yes".
#'
#' @return The calculated damage.
#' @importFrom stats runif
#' @export
#'
pokemon_damage_II <- function(
		level,
		attackStat,
		defenseStat,
		power,
		effectiveness,
		stab = FALSE,
		item = FALSE,
		TK = 1,
		weather = 1,
		badge = FALSE,
		moveMod = 1,
		doubleDmg = FALSE,
		critical = FALSE,
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
	damage = (
		(
			(
				(
					(2 * level / 5) + 2
				) * power * attackStat / defenseStat
			) / 50
		) * item * critical + 2
	) * TK * weather * badge * effectiveness * stab * moveMod * rand * doubleDmg
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
#' @param stab Logical. If TRUE, add the same type attack bonus
#' @param item Logical. If TRUE, the attacker is holding an type-enhancing held item corresponding to the attack type Default is FALSE.
#' @param TK The TK multiplier for Triple Kick. Default is 1.
#' @param weather The weather multiplier. Default is 1.
#' @param badge Logical. If TRUE, the attacking Pokémon is controlled by the player and if the player has obtained the Badge corresponding to the used move's type. Default is FALSE.
#' @param moveMod The move modifier. Default is 1.
#' @param doubleDmg Logical. If TRUE, double the damage of the move. Default is FALSE.
#' @param burn Logical. If TRUE, the attacker is burned, its Ability is not Guts, and the used move is a physical move. Default is FALSE.
#' @param screen The screen multiplier. Default is 1.
#' @param targets The targets multiplier. Default is 1.
#' @param FF Logical. If TRUE, the used move is Fire-type, and the attacker's Ability is Flash Fire that has been activated by a Fire-type move. Default is FALSE.
#' @param stockpile The stockpile multiplier. Default is 1.
#' @param charge Logical. If TRUE, the move is Electric-type and Charge takes effect. Default is FALSE.
#' @param HH Logical. If TRUE, the attacker's ally in a Double Battle has used Helping Hand on it. Default is FALSE.
#' @param critical Logical. If TRUE, it's a critical hit. Default is FALSE.
#' @param random Character string. If "yes", a random uniformly distributed integer between 85 and 100 is used. If "minmax", the min and max values are returned. If anything else, the average is used. Default is "yes".
#' @return The calculated damage.
#' @importFrom stats runif
#' @export
#'
pokemon_damage_III <- function(
		level,
		attackStat,
		defenseStat,
		power,
		effectiveness,
		stab = FALSE,
		item = FALSE,
		TK = 1,
		weather = 1,
		badge = FALSE,
		moveMod = 1,
		doubleDmg = FALSE,
		burn = FALSE,
		screen = 1,
		targets = 1,
		FF = FALSE,
		stockpile = 1,
		charge = FALSE,
		HH = FALSE,
		critical = FALSE,
		random = "yes"
) {
	# If immune return 0
	if(effectiveness == 0)return(0)
	# Logical to set values
	item = ifelse(item, 1.1, 1)
	stab = stab + 1
	critical = critical + 1
	badge = ifelse(badge, 1.125, 1)
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
	damage = (
		(
			(
				(
					(2 * level / 5) + 2
				) * power * attackStat / defenseStat
			) / 50
		) * burn * screen * targets * weather * FF + 2
	) * stockpile * critical * doubleDmg * charge * HH * badge * effectiveness * stab * moveMod * rand
	if(damage == 0) return(1)
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
#' @param stab Logical. If TRUE, add the same type attack bonus
#' @param item Logical. If TRUE, the attacker is holding an type-enhancing held item corresponding to the attack type Default is FALSE.
#' @param TK The TK multiplier for Triple Kick. Default is 1.
#' @param weather The weather multiplier. Default is 1.
#' @param badge Logical. If TRUE, the attacking Pokémon is controlled by the player and if the player has obtained the Badge corresponding to the used move's type. Default is FALSE.
#' @param moveMod The move modifier. Default is 1.
#' @param doubleDmg Logical. If TRUE, double the damage of the move. Default is FALSE.
#' @param burn Logical. If TRUE, the attacker is burned, its Ability is not Guts, and the used move is a physical move. Default is FALSE.
#' @param screen The screen multiplier. Default is 1.
#' @param targets The targets multiplier. Default is 1.
#' @param FF Logical. If TRUE, the used move is Fire-type, and the attacker's Ability is Flash Fire that has been activated by a Fire-type move. Default is FALSE.
#' @param stockpile The stockpile multiplier. Default is 1.
#' @param charge Logical. If TRUE, the move is Electric-type and Charge takes effect. Default is FALSE.
#' @param HH Logical. If TRUE, the attacker's ally in a Double Battle has used Helping Hand on it. Default is FALSE.
#' @param SRF Logical. If TRUE, the used move is super effective, the target's Ability is Solid Rock or Filter, and the attacker's Ability is not Mold Breaker. Default is FALSE.
#' @param EB Logical. If TRUE, the used move is super effective and the attacker is holding an Expert Belt. Default is FALSE.
#' @param TL Logical. If TRUE, the used move is not very effective and the attacker's Ability is Tinted Lens. Default is FALSE.
#' @param Berry Logical. If TRUE, the used move is super effective and the target is holding the Berry that weakens it, or Normal-type and the target is holding a Chilan Berry. Default is FALSE.
#' @param critical Logical. If TRUE, it's a critical hit. Default is FALSE.
#' @param random Character string. If "yes", a random uniformly distributed integer between 85 and 100 is used. If "minmax", the min and max values are returned. If anything else, the average is used. Default is "yes".
#'
#' @return The calculated damage.
#' @importFrom stats runif
#' @export
#'
pokemon_damage_IV = function(
		level,
		attackStat,
		defenseStat,
		power,
		effectiveness,
		stab = FALSE,
		item = FALSE,
		TK = 1,
		weather = 1,
		badge = FALSE,
		moveMod = 1,
		doubleDmg = FALSE,
		burn = FALSE,
		screen = 1,
		targets = 1,
		FF = FALSE,
		stockpile = 1,
		charge = FALSE,
		HH = FALSE,
		SRF = FALSE,
		EB = FALSE,
		TL = FALSE,
		Berry = FALSE,
		critical = FALSE,
		random = "yes"
) {
	# If immune return 0
	if(effectiveness == 0)return(0)
	# Logical to set values
	item = ifelse(item, 1.1, 1)
	stab = stab + 1
	critical = critical + 1
	badge = ifelse(badge, 1.125, 1)
	doubleDmg = doubleDmg + 1
	burn = ifelse(burn, 0.5, 1)
	FF = ifelse(FF, 1.5, 1)
	charge = ifelse(charge, 2, 1)
	HH = ifelse(HH, 1.5, 1)
	SRF = ifelse(SRF, 0.75, 1)
	EB = ifelse(EB, 1.2, 1)
	TL = ifelse(TL, 2, 1)
	Berry = ifelse(Berry, 0.5, 1)

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
	damage = (
		(
			(
				(
					(2 * level / 5) + 2
				) * power * attackStat / defenseStat
			) / 50
		) * burn * screen * targets * weather * FF + 2
	) * critical * item * moveMod * rand * HH * badge * effectiveness * stab * SRF * EB * TL * Berry
	if(damage == 0) return(1)
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
#' @param stab Logical. If TRUE, add the same type attack bonus
#' @param item Logical. If TRUE, the attacker is holding an type-enhancing held item corresponding to the attack type Default is FALSE.
#' @param TK The TK multiplier for Triple Kick. Default is 1.
#' @param weather The weather multiplier. Default is 1.
#' @param badge Logical. If TRUE, the attacking Pokémon is controlled by the player and if the player has obtained the Badge corresponding to the used move's type. Default is FALSE.
#' @param moveMod The move modifier. Default is 1.
#' @param doubleDmg Logical. If TRUE, double the damage of the move. Default is FALSE.
#' @param burn Logical. If TRUE, the attacker is burned, its Ability is not Guts, and the used move is a physical move. Default is FALSE.
#' @param screen The screen multiplier. Default is 1.
#' @param targets The targets multiplier. Default is 1.
#' @param FF Logical. If TRUE, the used move is Fire-type, and the attacker's Ability is Flash Fire that has been activated by a Fire-type move. Default is FALSE.
#' @param stockpile The stockpile multiplier. Default is 1.
#' @param charge Logical. If TRUE, the move is Electric-type and Charge takes effect. Default is FALSE.
#' @param HH Logical. If TRUE, the attacker's ally in a Double Battle has used Helping Hand on it. Default is FALSE.
#' @param SRF Logical. If TRUE, the used move is super effective, the target's Ability is Solid Rock or Filter, and the attacker's Ability is not Mold Breaker. Default is FALSE.
#' @param EB Logical. If TRUE, the used move is super effective and the attacker is holding an Expert Belt. Default is FALSE.
#' @param TL Logical. If TRUE, the used move is not very effective and the attacker's Ability is Tinted Lens. Default is FALSE.
#' @param Berry Logical. If TRUE, the used move is super effective and the target is holding the Berry that weakens it, or Normal-type and the target is holding a Chilan Berry. Default is FALSE.
#' @param other The other multiplier. Default is 1.
#' @param ZMove Logical. If TRUE, the move is a Z-Move or Max Move and the target would be protected from that move (e.g. by Protect). Default is FALSE.
#' @param TeraShield Logical. If TRUE, it is applied in Tera Raid Battles when the Raid boss's shield is active. Default is FALSE.
#' @param critical Logical. If TRUE, it's a critical hit. Default is FALSE.
#' @param random Character string. If "yes", a random uniformly distributed integer between 85 and 100 is used. If "minmax", the min and max values are returned. If anything else, the average is used. Default is "yes".
#'
#' @return The calculated damage.
#' @importFrom stats runif
#' @export
#'
pokemon_damage_V = function(
		level,
		attackStat,
		defenseStat,
		power,
		effectiveness,
		stab = FALSE,
		item = FALSE,
		TK = 1,
		weather = 1,
		badge = FALSE,
		moveMod = 1,
		doubleDmg = FALSE,
		burn = FALSE,
		screen = 1,
		targets = 1,
		FF = FALSE,
		stockpile = 1,
		charge = FALSE,
		HH = FALSE,
		SRF = FALSE,
		EB = FALSE,
		TL = FALSE,
		Berry = FALSE,
		other = 1,
		ZMove = FALSE,
		TeraShield = FALSE,
		critical = FALSE,
		random = "yes"
) {
	# If immune return 0
	if(effectiveness == 0)return(0)
	# Logical to set values
	item = ifelse(item, 1.1, 1)
	stab = stab + 1
	critical = critical + 1
	badge = ifelse(badge, 1.125, 1)
	doubleDmg = doubleDmg + 1
	burn = ifelse(burn, 0.5, 1)
	FF = ifelse(FF, 1.5, 1)
	charge = ifelse(charge, 2, 1)
	HH = ifelse(HH, 1.5, 1)
	SRF = ifelse(SRF, 0.75, 1)
	EB = ifelse(EB, 1.2, 1)
	TL = ifelse(TL, 2, 1)
	Berry = ifelse(Berry, 0.5, 1)
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
	damage = (
		(
			(
				(
					(2 * level / 5) + 2
				) * power * attackStat / defenseStat
			) / 50
		) * burn * screen * targets * weather * FF + 2
	) * critical * item * moveMod * rand * HH * badge * effectiveness * stab * SRF * EB * TL * Berry * other * ZMove * TeraShield
	if(damage == 0 && other >= 1) return(1)
	damage
}
