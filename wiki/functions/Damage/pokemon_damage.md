# Pokemon Damage Function (`pokemon_damage`)

This function calculates the damage for a Pokemon based on the generation.

## Paramaters
 - `...` Additional arguments to be passed to the generation-specific
damage function.
 - `.gen` The generation to use for calculating damage. Default is "V".
 - `return` The calculated damage.

## Usage
```r
pokemon_damage(..., .gen = "V")
```