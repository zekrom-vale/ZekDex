# Pokemon Damage Calculation Base (`damage_base`)

This function calculates the base damage inflicted during a Pokemon battle.
Gen I-IV uses `.round = floor`, while Gen V+ uses `.round = round`

## Paramaters
 - `level` The level of the attacking Pokemon.
 - `power` The power of the used move.
 - `attackStat` The effective Attack stat of the attacking Pokemon.
 - `defenseStat` The effective Defense stat of the target Pokemon.
 - `.round` The rounding function to use. Gen I-IV uses `floor()`
and Gen V+ uses `round()` (.5 and under is truncated, above is rounded up).
 - `return` The base damage.

## Usage
```r
damage_base(level, power, attackStat, defenseStat, .round = floor)
```