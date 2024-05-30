# Create a ggplot2 fill scale for Pokémon types (`ggtypes`)

This function creates a ggplot2 fill scale for Pokémon types using a specified color palette.

## Paramaters
 - `types` A named vector representing a color palette for Pokémon types. The names of the vector are the Pokémon types, and the values are the corresponding colors.
 - `aesthetics` The aesthetic mapping to use for the fill scale. Default is "color".
 - `return` A ggplot2 fill scale.

## Usage
```r
ggtypes(types = type_colors$new, aesthetics = "color")
```

## Examples
```r
# Create a ggplot2 fill scale for Pokémon types
ggtypes(types = type_colors$old)

# Create a ggplot2 fill scale for Pokémon types from scratch
ggtypes(types = c("Fire" = "red", "Water" = "blue"), aesthetics = "fill")
```
