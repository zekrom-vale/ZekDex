# Regional Form Function (`regionalForm`)

This function provides a list or a regex pattern of Pokémon regional forms.

## Paramaters
 - `re` A logical value. If TRUE, the function returns a regex pattern.
If FALSE, it returns a list. Default is FALSE.
 - `ext` A logical value. If TRUE, the function includes extended regional
forms in the output. Default is FALSE.
 - `return` If re is TRUE, a character string representing a regex pattern of
Pokémon regional forms. If re is FALSE, a character vector of Pokémon
regional forms.

## Usage
```r
regionalForm(re = FALSE, ext = FALSE, wrap = TRUE)
```

## Examples
```r
regionalForm(re = TRUE, ext = TRUE)
regionalForm(re = FALSE, ext = FALSE)

```
