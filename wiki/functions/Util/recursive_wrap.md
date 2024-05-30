# Vectorized version of the .recursive_wrap function (`recursive_wrap`)

This function is a vectorized version of the .recursive_wrap function. It applies the .recursive_wrap function to each element of a vector of strings.

## Paramaters
 - `str` A vector of strings to be wrapped.
 - `return` A vector of strings that are recursively wrapped with the specified opening and closing characters.

## Usage
```r
recursive_wrap(str, .open = "(", .close = ")?")
```

## Examples
```r
ZekDex:::recursive_wrap(c("Zekrom", "Reshiram"))
```
