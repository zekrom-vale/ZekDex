# Compute Effectiveness Function (`efect_fun`)

This function computes the effectiveness of an attack based on the effectiveness value and the effectiveness list.
It uses a logarithmic mapping to determine the effectiveness.

## Paramaters
 - `eft` Numeric value representing the effectiveness of an attack.
 - `efect` Numeric vector representing the effectiveness list. Default is effectiveness_list$Standard.
 - `stab` Logical value indicating whether the attack is of the same type as the attacker. Default is FALSE.
 - `stab_multiplyer` Numeric value representing the STAB multiplier. Default is stab_multiplyer$Standard.
 - `return` Numeric value representing the computed effectiveness.

## Usage
```r
efect_fun(
  eft,
  efect = effectiveness_list$Standard,
  stab = FALSE,
  stab_multiplyer = stab_multiplyer$Standard
)
```

## Examples
```r
efect_fun(2, effectiveness_list$Standard)
```
