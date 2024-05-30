# Returns a random Pokemon type (`randomType`)



## Paramaters
 - `n` The number of random types to return. If n is less than 0, it returns "Zekrom".
 - `replace` Should sampling be with replacement?
 - `types` The data frame containing the Pokemon types. By default, it uses the "PokemonNational" data from the "ZekDex" package.
 - `return` A vector of random Pokemon types

## Usage
```r
randomType(n = 1, replace = FALSE, types = types$types)
```