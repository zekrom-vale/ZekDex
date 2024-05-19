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
#' @param random Character string. If "yes", a random uniformly distributed
#' integer between 217 and 255 is used. If "minmax", the min and max values are
#' returned. If anything else, the average is used. Default is "yes".
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
	# Logical to set values
	critical = critical + 1
	stab = ifelse(stab, 1.5, 1)

	rand = damage_random(random, .min = 217, .max = 255)

	# Calculate damage
	base = damage_base(level, power, attackStat, defenseStat, .round = round)
	floor_mult = function(x,y) floor(x*y)

	damage = (base + 2)|>
		floor_mult(stab)|>
		floor_mult(effectiveness)

	map(rand, function(x){
		d=damage|>
			floor_mult(rand)
		ifelse(d == 0 & other >= 1, 1, d)
	})

}

#' Pokemon Damage Calculation Generation II
#'
#' This function calculates the damage inflicted during a Pokemon battle.
#' It uses the formula from Generation II.
#'
#' @note
#' this function does not handle the specific conditions mentioned (like Reflect,
#' Light Screen, Explosion, Selfdestruct, etc.). You would need to handle these
#' conditions before passing the values to this function.
#'
#' @param level The level of the attacking Pokemon.
#' @param attackStat The effective Attack stat of the attacking Pokemon.
#' @param defenseStat The effective Defense stat of the target Pokemon.
#' @param power The power of the used move.
#' @param effectiveness The product of Type, and Type2.
#' @param stab Logical. If TRUE, add the same type attack bonus.
#' @param item Logical. If TRUE, the attacker is holding an type-enhancing held
#' item corresponding to the attack type. Default is FALSE.
#' @param critical Logical. If TRUE, it's a critical hit. Default is FALSE.
#' @param TK Numeric. It is 1, 2, or 3 for each successive hit of Triple Kick,
#' or always 1 if the used move is not Triple Kick.
#' @param weather Numeric. It is 1.5 if a Water-type move is being used during
#' rain or a Fire-type move during harsh sunlight, and 0.5 if a Water-type move
#' is used during harsh sunlight or SolarBeam or any Fire-type move during rain,
#' and 1 otherwise.
#' @param badge Logical. If TRUE, the attacking Pokémon is controlled by the
#' player and if the player has obtained the Badge corresponding to the used
#' move's type. Default is FALSE.
#' @param moveMod Numeric. It can be (and if the used move is not any of these,
#' MoveMod is 1): If Rollout is used, 2 * (n + d), where n is the amount of
#' successful and consecutive hits of the move, up to 4 (for the fifth hit),
#' and d is 1 if Defense Curl was used beforehand and 0 otherwise. If Fury
#' Cutter is used, 2^n, where n is the number of successful and consecutive
#' uses of the move, up to 4. If Rage is used, an integer value corresponding
#' to the Rage counter, i.e. the number of times the user of Rage has been
#' damaged by an attack while using Rage.
#' @param doubleDmg Logical. If TRUE, it is 2 if the used move is Pursuit and the
#' target is attempting to switch out, Stomp and the target has previously used
#' Minimize, Gust or Twister and the target is in the semi-invulnerable turn of Fly,
#' or Earthquake or Magnitude and the target is in the semi-invulnerable turn of Dig,
#' and 1 otherwise.
#' @param random Character string. If "yes", a random uniformly distributed integer
#' between 217 and 255 is used. If "minmax", the min and max values are returned.
#' If anything else, the average is used. Default is "yes".
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
	# Logical to set values
	item = ifelse(item, 1.1, 1)
	critical = critical + 1
	stab = stab + 1
	badge = ifelse(badge, 1.125, 1)
	doubleDmg = doubleDmg + 1

	rand = damage_random(random, .min = 217, .max = 255)

	# Calculate damage
	base = damage_base(level, power, attackStat, defenseStat, .round = round)
	floor_mult = function(x,y) floor(x*y)

	inner = base|>
		floor_mult(item)|>
		floor_mult(critical)

	damage = (inner + 2)|>
		floor_mult(TK)|>
		floor_mult(weather)|>
		floor_mult(badge)|>
		floor_mult(stab)|>
		floor_mult(effectiveness)|>
		floor_mult(moveMod)

	map(rand, function(x){
		d=damage|>
			floor_mult(rand)|>
			floor_mult(doubleDmg)
		ifelse(d == 0 & other >= 1, 1, d)
	})
}

#' Pokemon Damage Calculation Generation III
#'
#' This function calculates the damage inflicted during a Pokemon battle.
#' It uses the formula from Generation III.
#'
#' @note
#' this function does not handle the specific conditions mentioned (like
#' Reflect, Light Screen, Explosion, Selfdestruct, etc.). You would need to
#' handle these conditions before passing the values to this function.
#'
#' @param level The level of the attacking Pokemon. If the used move is Beat
#' Up, L is instead the level of the Pokemon performing the strike.
#' @param attackStat The effective Attack stat of the attacking Pokemon if the
#' used move is a physical move, or the effective Special Attack stat of the
#' attacking Pokemon if the used move is a special move (for a critical hit,
#' negative Attack or Special Attack stat stages are ignored). If the used
#' move is Beat Up, A is instead the base Attack of the Pokemon performing the
#' strike.
#' @param defenseStat The effective Defense stat of the target if the used
#' move is a physical move, or the effective Special Defense stat of the
#' target if the used move is a special move (for a critical hit, positive
#' Defense or Special Defense stat stages are ignored). If the used move is
#' Beat Up, D is instead the base Defense of the target.
#' @param power The effective power of the used move.
#' @param effectiveness The product of Type1 and Type2.
#' @param stab Logical. If TRUE, add the same type attack bonus.
#' @param burn Logical. If TRUE, the attacker is burned, its Ability is not
#' Guts, and the used move is a physical move. Default is FALSE.
#' @param screen Numeric. Screen is 0.5 if the used move is physical and
#' Reflect is present on the target's side of the field, or special and Light
#' Screen is present. For a Double Battle, Screen is instead 2/3, and 1
#' otherwise or if the used move lands a critical hit. However, if, in a
#' Double Battle, when the move is executed, the only Pokemon on the target's
#' side is the target, Screen remains as 0.5. Default is 1.
#' @param targets Numeric. Targets is 0.5 in Double Battles if the move
#' targets both foes (unless it targets all other Pokemon, like Earthquake,
#' and only if there is more than one such target when the move is executed,
#' regardless of whether the move actually hits or can hit all the targets),
#' and 1 otherwise. Default is 1.
#' @param weather Numeric. Weather is 1.5 if a Water-type move is being used
#' during rain or a Fire-type move during harsh sunlight, and 0.5 if a
#' Water-type move is used during harsh sunlight, any Fire-type move during
#' rain, or SolarBeam during any non-clear weather besides harsh sunlight, and
#' 1 otherwise or if any Pokemon on the field have the Ability Cloud Nine or
#' Air Lock. Default is 1.
#' @param FF Logical. If TRUE, the used move is Fire-type, and the attacker's
#' Ability is Flash Fire that has been activated by a Fire-type move. Default
#' is FALSE.
#' @param stockpile Numeric. Stockpile is 1, 2, or 3 if the used move is Spit
#' Up, depending on how many Stockpiles have been used, or always 1 if the
#' used move is not Spit Up. Default is 1.
#' @param critical Logical. If TRUE, it's a critical hit. Default is FALSE.
#' @param doubleDmg Logical. If TRUE, it is 2 if the used move is (and 1 if
#' the used move is not any of these moves): Gust or Twister and the target is
#' in the semi-invulnerable turn of Fly or Bounce, Stomp, Needle Arm,
#' Astonish, or Extrasensory and the target has previously used Minimize, Surf
#' or Whirlpool and the target is in the semi-invulnerable turn of Dive,
#' Earthquake or Magnitude and the target is in the semi-invulnerable turn of
#' Dig, Pursuit and the target is attempting to switch out, Facade and the
#' user is poisoned, burned, or paralyzed, SmellingSalt and the target is
#' paralyzed, Revenge and the attacker has been damaged by the target this
#' turn, Weather Ball, there is non-clear weather, and no Pokemon on the field
#' have the Ability Cloud Nine or Air Lock. Default is FALSE.
#' @param charge Logical. If TRUE, the move is Electric-type and Charge takes
#' effect. Default is FALSE.
#' @param HH Logical. If TRUE, the attacker's ally in a Double Battle has used
#' Helping Hand on it. Default is FALSE.
#' @param random Character string. If "yes", a random uniformly distributed
#' integer between 85 and 100 is used. If "minmax", the min and max values are
#' returned. If anything else, the average is used. Default is "yes".
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
	# Logical to set values
	stab = ifelse(stab, 1.5, 1)
	critical = critical + 1
	doubleDmg = doubleDmg + 1
	burn = ifelse(burn, 0.5, 1)
	FF = ifelse(FF, 1.5, 1)
	charge = ifelse(charge, 2, 1)
	HH = ifelse(HH, 1.5, 1)

	rand = damage_random(random)

	# Calculate damage
	base = damage_base(level, power, attackStat, defenseStat, .round = round)

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
		floor_mult(effectiveness)

	map(rand, function(x){
		d=damage|>
			floor_mult(rand)
		ifelse(d == 0 & other >= 1, 1, d)
	})
}

#' Pokemon Damage Calculation Generation IV
#'
#' This function calculates the damage inflicted during a Pokemon battle. It
#' uses the formula from Generation IV.
#'
#' @note
#' this function does not handle the specific conditions mentioned (like
#' Reflect, Light Screen, Explosion, Selfdestruct, etc.). You would need to
#' handle these conditions before passing the values to this function.
#'
#' @param level The level of the attacking Pokemon. If the used move is Beat
#' Up, L is instead the level of the Pokemon performing the strike.
#' @param attackStat The effective Attack stat of the attacking Pokemon if the
#' used move is a physical move, or the effective Special Attack stat of the
#' attacking Pokemon if the used move is a special move (for a critical hit,
#' negative Attack or Special Attack stat stages are ignored). If the used
#' move is Beat Up, A is instead the base Attack of the Pokemon performing the
#' strike.
#' @param defenseStat The effective Defense stat of the target if the used
#' move is a physical move, or the effective Special Defense stat of the
#' target if the used move is a special move (for a critical hit, positive
#' Defense or Special Defense stat stages are ignored). If the used move is
#' Beat Up, D is instead the base Defense of the target.
#' @param power The effective power of the used move.
#' @param effectiveness The product of Type1 and Type2.
#' @param stab Logical. If TRUE, add the same type attack bonus.
#' @param burn Logical. If TRUE, the attacker is burned, its Ability is not
#' Guts, and the used move is a physical move. Default is FALSE.
#' @param screen Numeric. Screen is 0.5 if the used move is physical and
#' Reflect is present on the target's side of the field, or special and Light
#' Screen is present. For a Double Battle, Screen is instead 2/3; however, if
#' in a Double Battle when the move is executed, the only Pokemon on the
#' target's side of the field is the target (for moves with only one target),
#' or there is only one target when the move is executed (for moves with more
#' than one target), Screen remains as 0.5. Screen is 1 otherwise or if the
#' used move lands a critical hit. Default is 1.
#' @param targets Numeric. Targets is 0.75 in Double Battles if the used move
#' has more than one target (provided there is more than one such target when
#' the move is executed, regardless of whether the move actually hits or can
#' hit all the targets), and 1 otherwise. Default is 1.
#' @param weather Numeric. Weather is 1.5 if a Water-type move is being used
#' during rain or a Fire-type move during harsh sunlight, and 0.5 if a
#' Water-type move is used during harsh sunlight or a Fire-type move during
#' rain, or SolarBeam during any non-clear weather besides harsh sunlight, and
#' 1 otherwise or if any Pokemon on the field have the Ability Cloud Nine or
#' Air Lock. Default is 1.
#' @param FF Logical. If TRUE, the used move is Fire-type, and the attacker's
#' Ability is Flash Fire that has been activated by a Fire-type move. Default
#' is FALSE.
#' @param critical Logical. If TRUE, it's a critical hit. Default is FALSE.
#' @param item Logical. If TRUE, the attacker is holding an type-enhancing
#' held item corresponding to the attack type. Default is FALSE.
#' @param first Logical. If TRUE, the used move was stolen with Me First.
#' Default is FALSE.
#' @param SRF Logical. If TRUE, the used move is super effective, the target's
#' Ability is Solid Rock or Filter, and the attacker's Ability is not Mold
#' Breaker. Default is FALSE.
#' @param EB Logical. If TRUE, the used move is super effective and the
#' attacker is holding an Expert Belt. Default is FALSE.
#' @param TL Logical. If TRUE, the used move is not very effective and the
#' attacker's Ability is Tinted Lens. Default is FALSE.
#' @param Berry Logical. If TRUE, the used move is super effective and the
#' target is holding the Berry that weakens it, or Normal-type and the target
#' is holding a Chilan Berry. Default is FALSE.
#' @param random Character string. If "yes", a random uniformly distributed
#' integer between 85 and 100 is used. If "minmax", the min and max values are
#' returned. If anything else, the average is used. Default is "yes".
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
	# Logical to set values
	item = ifelse(item, 1.1, 1)
	stab = ifelse(stab, 1.5, 1)
	critical = critical + 1
	burn = ifelse(burn, 0.5, 1)
	FF = ifelse(FF, 1.5, 1)
	SRF = ifelse(SRF, 0.75, 1)
	EB = ifelse(EB, 1.2, 1)
	TL = ifelse(TL, 2, 1)
	Berry = ifelse(Berry, 0.5, 1)
	first = ifelse(first, 1.5, 1)

	rand = damage_random(random)

	# Calculate damage
	base = damage_base(level, power, attackStat, defenseStat)

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
		floor_mult(first)

	map(rand, function(x){
		d=damage|>
			floor_mult(x)|>
			floor_mult(stab)|>
			floor_mult(effectiveness)|>
			floor_mult(SRF)|>
			floor_mult(EB)|>
			floor_mult(TL)|>
			floor_mult(Berry)
		ifelse(d == 0 & other >= 1, 1, d)
	})
}

#' Pokemon Damage Calculation Generation V and onward
#'
#' This function calculates the damage inflicted during a Pokemon battle.
#' It uses the formula from Generation V and onward. This formula takes into
#' account various factors such as the level of the attacking Pokemon, its
#' attack stat, the defense stat of the target Pokemon, the power of the move
#' used, and more.
#'
#' @note
#' this function does not handle the specific conditions mentioned (like
#' Reflect, Light Screen, Explosion, Selfdestruct, etc.). You would need to
#' handle these conditions before passing the values to this function. This
#' means that if any of these conditions are present in the battle scenario,
#' they should be accounted for before using this function.
#'
#' @param level The level of the attacking Pokemon. This is an integer value
#' representing the current level of the Pokemon performing the attack.
#' @param attackStat The effective Attack stat of the attacking Pokemon. This
#' is a numeric value representing the attacking Pokemon's Attack or Special
#' Attack stat, depending on whether the move being used is a physical or
#' special move.
#' @param defenseStat The effective Defense stat of the target Pokemon. This
#' is a numeric value representing the target Pokemon's Defense or Special
#' Defense stat, depending on whether the move being used is a physical or
#' special move.
#' @param power The power of the used move. This is a numeric value
#' representing the base power of the move being used by the attacking Pokemon.
#' @param effectiveness The product of Type1 and Type2. This is a numeric
#' value representing the combined type effectiveness of the move against the
#' target Pokemon. This takes into account the type of the move and the
#' type(s) of the target Pokemon.
#' @param stab Logical. If TRUE, add the same type attack bonus. This is a
#' boolean value indicating whether the move being used is of the same type as
#' the attacking Pokemon. If TRUE, a Same Type Attack Bonus (STAB) is applied,
#' increasing the damage dealt.
#' @param PB Logical. If TRUE, the move is the second strike of Parental Bond.
#' Default is FALSE. This is a boolean value indicating whether the move is
#' the second strike of a move affected by the Parental Bond Ability. If TRUE,
#' the damage of the move is adjusted accordingly.
#' @param weather Numeric. Weather is 1.5 if a Water-type move is being used
#' during rain or a Fire-type move or Hydro Steam during harsh sunlight, and
#' 0.5 if a Water-type move (besides Hydro Steam) is used during harsh
#' sunlight or a Fire-type move during rain, or SolarBeam during any non-clear
#' weather besides harsh sunlight, and 1 otherwise or if any Pokemon on the
#' field have the Ability Cloud Nine or Air Lock. Default is 1. This is a
#' numeric value representing the effect of the current weather conditions on
#' the move. Certain weather conditions can increase or decrease the damage of
#' certain types of moves.
#' @param GlaiveRush Logical. If TRUE, the target used the move Glaive Rush in
#' the previous turn. Default is FALSE. This is a boolean value indicating
#' whether the target Pokemon used the move Glaive Rush in the previous turn.
#' If TRUE, the damage of the move is adjusted accordingly.
#' @param critical Logical. If TRUE, it's a critical hit. Default is FALSE.
#' This is a boolean value indicating whether the move landed a critical hit.
#' If TRUE, the damage of the move is increased.
#' @param burn Logical. If TRUE, the attacker is burned, its Ability is not
#' Guts, and the used move is a physical move. Default is FALSE. This is a
#' boolean value indicating whether the attacking Pokemon is burned. If TRUE
#' and the attacking Pokemon's Ability is not Guts and the move is a physical
#' move, the damage of the move is reduced.
#' @param other Numeric. Other is 1 in most cases, and a different multiplier
#' when specific interactions of moves, Abilities, or items take effect.
#' Default is 1. This is a numeric value representing other potential
#' modifiers to the damage calculation. These can include things like held
#' items, Abilities, and other effects.
#' @param ZMove Logical. If TRUE, the move is a Z-Move or Max Move and the
#' target would be protected from that move (e.g. by Protect). Default is
#' FALSE. This is a boolean value indicating whether the move is a Z-Move or
#' Max Move. If TRUE and the target would be protected from the move (e.g. by
#' the move Protect), the damage of the move is adjusted accordingly.
#' @param TeraShield Logical. If TRUE, it is applied in Tera Raid Battles when
#' the Raid boss's shield is active. Default is FALSE. This is a boolean value
#' indicating whether a TeraShield is active in a Tera Raid Battle. If TRUE,
#' the damage of the move is adjusted accordingly.
#' @param targets Numeric. Targets is 0.75 (0.5 in Battle Royals) if the move
#' has more than one target when the move is executed, and 1 otherwise.
#' Default is 1. This is a numeric value representing the number of targets of
#' the move. If the move targets multiple Pokemon, the damage of the move is
#' adjusted accordingly.
#' @param random Character string. If "yes", a random uniformly distributed
#' integer between 85 and 100 is used. If "minmax", the min and max values are
#' returned. If anything else, the average is used. Default is "yes". This is
#' a character string indicating how to handle randomness in the damage
#' calculation. If set to "yes", a random integer between 85 and 100 is used.
#' If set to "minmax", the minimum and maximum possible values are returned.
#' If set to anything else, the average value is used.
#' @param .criticalVal Numeric. The critical hit multiplier. Default is 1.5
#' (2 in Generation V). This is a numeric value representing the multiplier
#' applied to the damage when a critical hit lands. The default value is 1.5,
#' but it was 2 in Generation V.
#' @param .PBVal Numeric. The Parental Bond multiplier. Default is 0.25 (0.5
#' in Generation VI). This is a numeric value representing the multiplier
#' applied to the damage when the move is the second strike of a move affected
#' by the Parental Bond Ability. The default value is 0.25, but it was 0.5 in
#' Generation VI.
#'
#' @return The calculated damage. This function returns a numeric value
#' representing the calculated damage dealt by the attacking Pokemon to the
#' target Pokemon, based on the provided parameters and the Generation V
#' damage formula.
#' @importFrom stats runif
#' @export
#'
#' @examples
#' # From https://bulbapedia.bulbagarden.net/wiki/Damage#Example
#' pokemon_damage_V(
#'     75, 123, 163, 65,
#'     stab = TRUE, effectiveness = 4, random = "minmax"
#' )
#' pokemon_damage_V(
#'     75, 123, 163, 71,
#'     stab = TRUE, effectiveness = 4, critical = TRUE, random = "minmax"
#' )
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
	# Logical to set values
	stab = ifelse(stab, 1.5, 1)
	critical = ifelse(critical, .criticalVal, 1)
	burn = ifelse(burn, 0.5, 1)
	PB = ifelse(PB, .PBVal, 1)
	ZMove = ifelse(ZMove, 0.25, 1)
	TeraShield = ifelse(TeraShield, 0.2, 1)
	GlaiveRush = GlaiveRush + 1

	rand = damage_random(random)

	# Calculate damage
	base = damage_base(level, power, attackStat, defenseStat, .round = round)

	# base * burn * screen * targets * weather * FF
	floor_mult = function(x,y) floor(x*y)

	# (inner + 2) * critical * item * moveMod * rand * HH * badge *
	# effectiveness * stab * SRF * EB * TL * Berry * other * ZMove * TeraShield
	damage = (base + 2)|>
		floor_mult(targets)|>
		floor_mult(PB)|>
		floor_mult(weather)|>
		floor_mult(GlaiveRush)|>
		floor_mult(critical)

	map(rand, function(x){
		d=damage|>
			floor_mult(x)|>
			floor_mult(stab)|>
			floor_mult(effectiveness)|>
			floor_mult(burn)|>
			floor_mult(other)|>
			floor_mult(ZMove)|>
			floor_mult(TeraShield)
		ifelse(d == 0 & other >= 1, 1, d)
	})
}

#' Pokemon Damage Calculation Base
#'
#' This function calculates the base damage inflicted during a Pokemon battle.
#' Gen I-IV uses `.round = floor`, while Gen V+ uses `.round = round`
#'
#' @param level The level of the attacking Pokemon.
#' @param power The power of the used move.
#' @param attackStat The effective Attack stat of the attacking Pokemon.
#' @param defenseStat The effective Defense stat of the target Pokemon.
#' @param .round The rounding function to use. Gen I-IV uses `floor()`
#' and Gen V+ uses `round()` (.5 and under is truncated, above is rounded up).
#'
#' @return The base damage.
#' @export
damage_base = function(level, power, attackStat, defenseStat, .round = floor){
	# Check if attackStat or defenseStat are greater than 255
	if (attackStat > 255 | defenseStat > 255) {
		attackStat = attackStat / 4
		defenseStat = defenseStat / 4
	}
	.round(
		.round(
			(
				(.round(2 * level / 5)) + 2
			) * power * attackStat / defenseStat
		) / 50
	)
}

#' Pokemon Damage Calculation Random
#'
#' This function calculates the random factor in Pokemon damage calculation.
#' Gen I-II uses `.min = 217, .max = 255`, while Gen III+ uses `.min = 85, .max = 100`
#'
#' @param random How to generate the random number.
#' @param .min The min random number to generate to be divided by `.max`.
#' @param .max The max random number to generate to be divided by `.max`.
#'
#' @return The random factor.
#' @importFrom stats runif
#' @export
damage_random = function(random, .min = 85, .max = 100){
	# Calculate random uniformly distributed integer between 85 and 100 if random is yes
	if(random == "yes") return(runif(1, .min, .max) / .max)
	# If random is passed minmax give the min and max
	else if(random == "minmax")return(list(.min / .max, .max / .max))
	# Else give the average
	else return((.min + .max) / .max / 2)
}


#' Pokemon Damage Function
#'
#' This function calculates the damage for a Pokemon based on the generation.
#'
#' @param ... Additional arguments to be passed to the generation-specific
#' damage function.
#' @param .gen The generation to use for calculating damage. Default is "V".
#' @return The calculated damage.
#' @seealso \code{\link{pokemon_damage_V}}, \code{\link{pokemon_damage_IV}},
#' \code{\link{pokemon_damage_III}}, \code{\link{pokemon_damage_II}},
#' \code{\link{pokemon_damage_I}} for the generation specific damage functions.
#' @export
pokemon_damage = function(..., .gen = "V"){
	switch (.gen,
			"V" = pokemon_damage_V(...),
			"IV" = pokemon_damage_IV(...),
			"III" = pokemon_damage_III(...),
			"II" = pokemon_damage_II(...),
			"I" = pokemon_damage_I(...)
	)
}
