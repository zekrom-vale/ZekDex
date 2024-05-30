# Compute Effectiveness of an Attack for a Pokémon (`effectivenessPokemon`)

This function computes the effectiveness of an attack against a specific Pokémon.
It uses the type chart to determine the effectiveness of the attack.

## Paramaters
 - `attack` Character string representing the attacking type.
 - `pokemon` Either a character string representing the Pokémon''s name or a data frame containing Pokémon data.
 - `regional` Character string representing the regional form of the Pokémon. Default is NA.
 - `form` Character string representing the form of the Pokémon. Default is NA.
 - `efect` Numeric vector representing the effectiveness list. Default is effectiveness_list$Standard.
 - `stab` Logical value indicating whether the attack is of the same type as the attacker. Default is FALSE.
 - `stab_mult` Numeric value representing the STAB multiplier. Default is stab_multiplyer$Standard.
 - `return` Numeric value representing the effectiveness of the attack.

## Usage
```r
effectivenessPokemon(
  attack,
  pokemon,
  regional = NA_character_,
  form = NA_character_,
  efect = effectiveness_list$Standard,
  stab = FALSE,
  stab_mult = stab_multiplyer$Standard
)
```

## Examples
```r
effectivenessPokemon("Fire", "Zekrom", efect = effectiveness_list$Standard)
```
