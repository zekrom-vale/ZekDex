# Pokemon Damage Calculation Generation IV (`pokemon_damage_IV`)

This function calculates the damage inflicted during a Pokemon battle. It
uses the formula from Generation IV.

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
Screen is present. For a Double Battle, Screen is instead 2/3; however, if
in a Double Battle when the move is executed, the only Pokemon on the
target''s side of the field is the target (for moves with only one target),
or there is only one target when the move is executed (for moves with more
than one target), Screen remains as 0.5. Screen is 1 otherwise or if the
used move lands a critical hit. Default is 1.
 - `targets` Numeric. Targets is 0.75 in Double Battles if the used move
has more than one target (provided there is more than one such target when
the move is executed, regardless of whether the move actually hits or can
hit all the targets), and 1 otherwise. Default is 1.
 - `weather` Numeric. Weather is 1.5 if a Water-type move is being used
during rain or a Fire-type move during harsh sunlight, and 0.5 if a
Water-type move is used during harsh sunlight or a Fire-type move during
rain, or SolarBeam during any non-clear weather besides harsh sunlight, and
1 otherwise or if any Pokemon on the field have the Ability Cloud Nine or
Air Lock. Default is 1.
 - `FF` Logical. If TRUE, the used move is Fire-type, and the attacker''s
Ability is Flash Fire that has been activated by a Fire-type move. Default
is FALSE.
 - `critical` Logical. If TRUE, it''s a critical hit. Default is FALSE.
 - `item` Logical. If TRUE, the attacker is holding an type-enhancing
held item corresponding to the attack type. Default is FALSE.
 - `first` Logical. If TRUE, the used move was stolen with Me First.
Default is FALSE.
 - `SRF` Logical. If TRUE, the used move is super effective, the target''s
Ability is Solid Rock or Filter, and the attacker''s Ability is not Mold
Breaker. Default is FALSE.
 - `EB` Logical. If TRUE, the used move is super effective and the
attacker is holding an Expert Belt. Default is FALSE.
 - `TL` Logical. If TRUE, the used move is not very effective and the
attacker''s Ability is Tinted Lens. Default is FALSE.
 - `Berry` Logical. If TRUE, the used move is super effective and the
target is holding the Berry that weakens it, or Normal-type and the target
is holding a Chilan Berry. Default is FALSE.
 - `random` Character string. If "yes", a random uniformly distributed
integer between 85 and 100 is used. If "minmax", the min and max values are
returned. If anything else, the average is used. Default is "yes".
 - `return` The calculated damage.

## Usage
```r
pokemon_damage_IV(
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
)
```