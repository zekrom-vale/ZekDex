# Pokemon Damage Calculation Random (`damage_random`)

This function calculates the random factor in Pokemon damage calculation.
Gen I-II uses `.min = 217, .max = 255`, while Gen III+ uses `.min = 85, .max = 100`

## Paramaters
 - `random` How to generate the random number.
 - `.min` The min random number to generate to be divided by `.max`.
 - `.max` The max random number to generate to be divided by `.max`.
 - `return` The random factor.

## Usage
```r
damage_random(random, .min = 85, .max = 100)
```