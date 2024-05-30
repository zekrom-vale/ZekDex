# Pokemon Damage Calculation Generation II (`pokemon_damage_II`)

This function calculates the damage inflicted during a Pokemon battle.
It uses the formula from Generation II.

## Paramaters
 - `level` The level of the attacking Pokemon.
 - `attackStat` The effective Attack stat of the attacking Pokemon.
 - `defenseStat` The effective Defense stat of the target Pokemon.
 - `power` The power of the used move.
 - `effectiveness` The product of Type, and Type2.
 - `stab` Logical. If TRUE, add the same type attack bonus.
 - `item` Logical. If TRUE, the attacker is holding an type-enhancing held
item corresponding to the attack type. Default is FALSE.
 - `critical` Logical. If TRUE, it''s a critical hit. Default is FALSE.
 - `TK` Numeric. It is 1, 2, or 3 for each successive hit of Triple Kick,
or always 1 if the used move is not Triple Kick.
 - `weather` Numeric. It is 1.5 if a Water-type move is being used during
rain or a Fire-type move during harsh sunlight, and 0.5 if a Water-type move
is used during harsh sunlight or SolarBeam or any Fire-type move during rain,
and 1 otherwise.
 - `badge` Logical. If TRUE, the attacking Pokémon is controlled by the
player and if the player has obtained the Badge corresponding to the used
move''s type. Default is FALSE.
 - `moveMod` Numeric. It can be (and if the used move is not any of these,
MoveMod is 1): If Rollout is used, 2 * (n + d), where n is the amount of
successful and consecutive hits of the move, up to 4 (for the fifth hit),
and d is 1 if Defense Curl was used beforehand and 0 otherwise. If Fury
Cutter is used, 2^n, where n is the number of successful and consecutive
uses of the move, up to 4. If Rage is used, an integer value corresponding
to the Rage counter, i.e. the number of times the user of Rage has been
damaged by an attack while using Rage.
 - `doubleDmg` Logical. If TRUE, it is 2 if the used move is Pursuit and the
target is attempting to switch out, Stomp and the target has previously used
Minimize, Gust or Twister and the target is in the semi-invulnerable turn of Fly,
or Earthquake or Magnitude and the target is in the semi-invulnerable turn of Dig,
and 1 otherwise.
 - `random` Character string. If "yes", a random uniformly distributed integer
between 217 and 255 is used. If "minmax", the min and max values are returned.
If anything else, the average is used. Default is "yes".
 - `return` The calculated damage.

## Usage
```r
pokemon_damage_II(
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
)
```