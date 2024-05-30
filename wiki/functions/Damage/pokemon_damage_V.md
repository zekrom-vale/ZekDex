# Pokemon Damage Calculation Generation V and onward (`pokemon_damage_V`)

This function calculates the damage inflicted during a Pokemon battle.
It uses the formula from Generation V and onward. This formula takes into
account various factors such as the level of the attacking Pokemon, its
attack stat, the defense stat of the target Pokemon, the power of the move
used, and more.

## Paramaters
 - `level` The level of the attacking Pokemon. This is an integer value
representing the current level of the Pokemon performing the attack.
 - `attackStat` The effective Attack stat of the attacking Pokemon. This
is a numeric value representing the attacking Pokemon''s Attack or Special
Attack stat, depending on whether the move being used is a physical or
special move.
 - `defenseStat` The effective Defense stat of the target Pokemon. This
is a numeric value representing the target Pokemon''s Defense or Special
Defense stat, depending on whether the move being used is a physical or
special move.
 - `power` The power of the used move. This is a numeric value
representing the base power of the move being used by the attacking Pokemon.
 - `effectiveness` The product of Type1 and Type2. This is a numeric
value representing the combined type effectiveness of the move against the
target Pokemon. This takes into account the type of the move and the
type(s) of the target Pokemon.
 - `stab` Logical. If TRUE, add the same type attack bonus. This is a
boolean value indicating whether the move being used is of the same type as
the attacking Pokemon. If TRUE, a Same Type Attack Bonus (STAB) is applied,
increasing the damage dealt.
 - `PB` Logical. If TRUE, the move is the second strike of Parental Bond.
Default is FALSE. This is a boolean value indicating whether the move is
the second strike of a move affected by the Parental Bond Ability. If TRUE,
the damage of the move is adjusted accordingly.
 - `weather` Numeric. Weather is 1.5 if a Water-type move is being used
during rain or a Fire-type move or Hydro Steam during harsh sunlight, and
0.5 if a Water-type move (besides Hydro Steam) is used during harsh
sunlight or a Fire-type move during rain, or SolarBeam during any non-clear
weather besides harsh sunlight, and 1 otherwise or if any Pokemon on the
field have the Ability Cloud Nine or Air Lock. Default is 1. This is a
numeric value representing the effect of the current weather conditions on
the move. Certain weather conditions can increase or decrease the damage of
certain types of moves.
 - `GlaiveRush` Logical. If TRUE, the target used the move Glaive Rush in
the previous turn. Default is FALSE. This is a boolean value indicating
whether the target Pokemon used the move Glaive Rush in the previous turn.
If TRUE, the damage of the move is adjusted accordingly.
 - `critical` Logical. If TRUE, it''s a critical hit. Default is FALSE.
This is a boolean value indicating whether the move landed a critical hit.
If TRUE, the damage of the move is increased.
 - `burn` Logical. If TRUE, the attacker is burned, its Ability is not
Guts, and the used move is a physical move. Default is FALSE. This is a
boolean value indicating whether the attacking Pokemon is burned. If TRUE
and the attacking Pokemon''s Ability is not Guts and the move is a physical
move, the damage of the move is reduced.
 - `other` Numeric. Other is 1 in most cases, and a different multiplier
when specific interactions of moves, Abilities, or items take effect.
Default is 1. This is a numeric value representing other potential
modifiers to the damage calculation. These can include things like held
items, Abilities, and other effects.
 - `ZMove` Logical. If TRUE, the move is a Z-Move or Max Move and the
target would be protected from that move (e.g. by Protect). Default is
FALSE. This is a boolean value indicating whether the move is a Z-Move or
Max Move. If TRUE and the target would be protected from the move (e.g. by
the move Protect), the damage of the move is adjusted accordingly.
 - `TeraShield` Logical. If TRUE, it is applied in Tera Raid Battles when
the Raid boss''s shield is active. Default is FALSE. This is a boolean value
indicating whether a TeraShield is active in a Tera Raid Battle. If TRUE,
the damage of the move is adjusted accordingly.
 - `targets` Numeric. Targets is 0.75 (0.5 in Battle Royals) if the move
has more than one target when the move is executed, and 1 otherwise.
Default is 1. This is a numeric value representing the number of targets of
the move. If the move targets multiple Pokemon, the damage of the move is
adjusted accordingly.
 - `random` Character string. If "yes", a random uniformly distributed
integer between 85 and 100 is used. If "minmax", the min and max values are
returned. If anything else, the average is used. Default is "yes". This is
a character string indicating how to handle randomness in the damage
calculation. If set to "yes", a random integer between 85 and 100 is used.
If set to "minmax", the minimum and maximum possible values are returned.
If set to anything else, the average value is used.
 - `.criticalVal` Numeric. The critical hit multiplier. Default is 1.5
(2 in Generation V). This is a numeric value representing the multiplier
applied to the damage when a critical hit lands. The default value is 1.5,
but it was 2 in Generation V.
 - `.PBVal` Numeric. The Parental Bond multiplier. Default is 0.25 (0.5
in Generation VI). This is a numeric value representing the multiplier
applied to the damage when the move is the second strike of a move affected
by the Parental Bond Ability. The default value is 0.25, but it was 0.5 in
Generation VI.
 - `return` The calculated damage. This function returns a numeric value
representing the calculated damage dealt by the attacking Pokemon to the
target Pokemon, based on the provided parameters and the Generation V
damage formula.

## Usage
```r
pokemon_damage_V(
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
  .criticalVal = 1.5,
  .PBVal = 0.25
)
```

## Examples
```r
# From https://bulbapedia.bulbagarden.net/wiki/Damage#Example
pokemon_damage_V(
    75, 123, 163, 65,
    stab = TRUE, effectiveness = 4, random = "minmax"
)
pokemon_damage_V(
    75, 123, 163, 71,
    stab = TRUE, effectiveness = 4, critical = TRUE, random = "minmax"
)
```
