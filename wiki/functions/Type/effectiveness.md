# Compute Effectiveness of an Attack (`effectiveness`)

This function computes the effectiveness of an attack against a defender.
It uses the type chart to determine the effectiveness of the attack.

## Paramaters
 - `attack` Character string representing the attacking type.
 - `defender` Character vector representing the defending types.
 - `efect` Numeric vector representing the effectiveness list. Default is effectiveness_list$Standard.
 - `stab` Logical value indicating whether the attack is of the same type as the attacker. Default is FALSE.
 - `stab_mult` Numeric value representing the STAB multiplier. Default is stab_multiplyer$Standard.
 - `return` Numeric value representing the effectiveness of the attack.

## Usage
```r
effectiveness(
  attack,
  defender,
  stab = FALSE,
  stab_mult = stab_multiplyer$Standard,
  efect = effectiveness_list$Standard
)
```

## Examples
```r
effectiveness("Fire", c("Grass", "Bug"), effectiveness_list$Standard)
```
