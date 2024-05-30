# Filters rows of a dataframe based on non-unique values in specified columns (`filter_non_unique`)

This function filters rows of a dataframe based on non-unique values in
specified columns. If no columns are specified, all columns are checked.

## Paramaters
 - `df` A dataframe to operate on.
 - `...` Columns to check for non-unique values. If no columns are
specified, all columns are checked.
 - `return` A dataframe with rows containing non-unique values in the specified
columns removed.

## Usage
```r
filter_non_unique(df, ...)
```

## Examples
```r
library(tibble)
filter_non_unique(
  tribble(
    ~a, ~b,
    1, 3,
    2, 4,
    2, 4
  )
)
```
