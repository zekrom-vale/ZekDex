# Pokemon Damage Calculation Generation III (`pokemon_damage_III`)

This function calculates the damage inflicted during a Pokemon battle.
It uses the formula from Generation III.

## Paramaters
 - `level` The level of the attacking Pokemon. If the used move is Beat
Up, L is instead the level of the Pokemon performing the strike.
 - `attackStat` The effective Attack stat of the attacking Pokemon if the
used move is a physical move, or the effective Special Attack stat of the
attacking Pokemon if the used move is a special move (for a critical hit,
negative Attack or Special Attack stat stages are ignored). If the used
move is Beat Up, A is instead the base Attack of the Pokemon performing the
strike.
 - `defenseStat` The effective Defense stat of the target if the used
move is a physical move, or the effective Special Defense stat of the
target if the used move is a special move (for a critical hit, positive
Defense or Special Defense stat stages are ignored). If the used move is
Beat Up, D is instead the base Defense of the target.
 - `power` The effective power of the used move.
 - `effectiveness` The product of Type1 and Type2.
 - `stab` Logical. If TRUE, add the same type attack bonus.
 - `burn` Logical. If TRUE, the attacker is burned, its Ability is not
Guts, and the used move is a physical move. Default is FALSE.
 - `screen` Numeric. Screen is 0.5 if the used move is physical and
Reflect is present on the target''s side of the field, or special and Light
Screen is present. For a Double Battle, Screen is instead 2/3, and 1
otherwise or if the used move lands a critical hit. However, if, in a
Double Battle, when the move is executed, the only Pokemon on the target''s
side is the target, Screen remains as 0.5. Default is 1.
 - `targets` Numeric. Targets is 0.5 in Double Battles if the move
targets both foes (unless it targets all other Pokemon, like Earthquake,
and only if there is more than one such target when the move is executed,
regardless of whether the move actually hits or can hit all the targets),
and 1 otherwise. Default is 1.
 - `weather` Numeric. Weather is 1.5 if a Water-type move is being used
during rain or a Fire-type move during harsh sunlight, and 0.5 if a
Water-type move is used during harsh sunlight, any Fire-type move during
rain, or SolarBeam during any non-clear weather besides harsh sunlight, and
1 otherwise or if any Pokemon on the field have the Ability Cloud Nine or
Air Lock. Default is 1.
 - `FF` Logical. If TRUE, the used move is Fire-type, and the attacker''s
Ability is Flash Fire that has been activated by a Fire-type move. Default
is FALSE.
 - `stockpile` Numeric. Stockpile is 1, 2, or 3 if the used move is Spit
Up, depending on how many Stockpiles have been used, or always 1 if the
used move is not Spit Up. Default is 1.
 - `critical` Logical. If TRUE, it''s a critical hit. Default is FALSE.
 - `doubleDmg` Logical. If TRUE, it is 2 if the used move is (and 1 if
the used move is not any of these moves): Gust or Twister and the target is
in the semi-invulnerable turn of Fly or Bounce, Stomp, Needle Arm,
Astonish, or Extrasensory and the target has previously used Minimize, Surf
or Whirlpool and the target is in the semi-invulnerable turn of Dive,
Earthquake or Magnitude and the target is in the semi-invulnerable turn of
Dig, Pursuit and the target is attempting to switch out, Facade and the
user is poisoned, burned, or paralyzed, SmellingSalt and the target is
paralyzed, Revenge and the attacker has been damaged by the target this
turn, Weather Ball, there is non-clear weather, and no Pokemon on the field
have the Ability Cloud Nine or Air Lock. Default is FALSE.
 - `charge` Logical. If TRUE, the move is Electric-type and Charge takes
effect. Default is FALSE.
 - `HH` Logical. If TRUE, the attacker''s ally in a Double Battle has used
Helping Hand on it. Default is FALSE.
 - `random` Character string. If "yes", a random uniformly distributed
integer between 85 and 100 is used. If "minmax", the min and max values are
returned. If anything else, the average is used. Default is "yes".
 - `return` The calculated damage.

## Usage
```r
pokemon_damage_III(
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
)
```