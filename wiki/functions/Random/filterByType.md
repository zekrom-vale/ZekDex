# Returns a tibble with filtered Pokemon (`filterByType`)



## Paramaters
 - `type` Filter on type
 - `type2` Filter on type2
 - `swap` Allow type to match type2 and vicea-versa
 - `data` Override the data (Must have type and type2 (If type 2 is not ANY or swap is TRUE))


## Usage
```r
filterByType(type = "ANY", type2 = "ANY", swap = FALSE, data = nationalDex)
```