# Returns the string before a match (`str_before_match`)

This function returns the string before a match. It uses the `str_longest_match` function to find the match and then returns the string before it.

## Paramaters

 - `return` The string before the match.

## Usage
```r
str_before_match(str, test, ..., .open = "(", .close = ")?")
```

## Examples
```r
ZekDex:::str_before_match("Zekrom", "Zek")
```
