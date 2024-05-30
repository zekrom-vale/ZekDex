# Compute STAB Multiplier for an Attack (`stab`)

This function computes the Same Type Attack Bonus (STAB) multiplier for an attack.
It is to be used with the `effectiveness` and `effectivenessPokemon` functions instead of passing a parameter.

## Paramaters
 - `effectiveness` Numeric value representing the effectiveness of an attack.
 - `stab_mult` Numeric value representing the STAB multiplier. Default is stab_multiplyer$Standard.
 - `return` Numeric value representing the effectiveness of the attack with the STAB multiplier applied.

## Usage
```r
stab(effectiveness, stab_mult = stab_multiplyer$Standard)
```

## Examples
```r
effectivenessPokemon("Fire", "Zekrom")|>
  stab()
```
