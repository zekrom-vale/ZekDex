# Returns the shortest string before a match (`str_longest_match`)

This function returns the shortest string not matching a test string. It uses a recursive wrap function to match the strings.

## Paramaters
 - `str` The string to resize.
 - `test` The string to test.
 - `...` Additional arguments to be passed to the `regex` function.
 - `.open` The opening character(s) for wrapping in the .recursive_wrap function. Default is "(".
 - `.close` The closing character(s) for wrapping in the .recursive_wrap function. Default is ")?".
 - `return` The shortest string not matching test.

## Usage
```r
str_longest_match(str, test, ..., .open = "(", .close = ")?")
```

## Examples
```r
ZekDex:::str_longest_match("Zekrom", "Zek")
```
