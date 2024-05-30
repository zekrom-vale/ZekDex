# Pokemon Damage Calculation Generation I (`pokemon_damage_I`)

This function calculates the damage inflicted during a Pokemon battle.
It uses the formula from Generation I.

## Paramaters
 - `level` The level of the attacking Pokemon.
 - `attackStat` The effective Attack stat of the attacking Pokemon.
 - `defenseStat` The effective Defense stat of the target Pokemon.
 - `power` The power of the used move.
 - `effectiveness` The product of Type, and Type2.
 - `stab` Logical. If TRUE, add the same type attack bonus
 - `critical` Logical. If TRUE, it''s a critical hit. Default is FALSE.
 - `random` Character string. If "yes", a random uniformly distributed
integer between 217 and 255 is used. If "minmax", the min and max values are
returned. If anything else, the average is used. Default is "yes".
 - `return` The calculated damage.

## Usage
```r
pokemon_damage_I(
  level,
  attackStat,
  defenseStat,
  power,
  effectiveness,
  stab = FALSE,
  critical = FALSE,
  random = "yes"
)
```