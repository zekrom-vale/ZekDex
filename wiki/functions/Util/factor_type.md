# Convert Pokémon Types to Factor (`factor_type`)

This function converts a vector of Pokémon types to a factor with levels defined by the unique Pokémon types.

## Paramaters
 - `x` A character vector of Pokémon types.
 - `return` A factor with levels defined by the unique Pokémon types.

## Usage
```r
factor_type(x)
```

## Examples
```r
# Assume ''types'' is a dataframe with a column ''types'' containing unique Pokémon types
pokemon_types <- c("Fire", "Water", "Grass", "Electric")
factor_types <- factor_type(pokemon_types)

```
