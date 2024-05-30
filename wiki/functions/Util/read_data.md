# Read Data from CSV or RDA (`read_data`)

This function reads data from a CSV or RDA file, or from a package namespace.

## Paramaters
 - `data` The name of the data to load.
 - `root` The root directory where the file is located.
 - `ns` The namespace from which to load the data.
 - `one` Logical, if `TRUE`, returns the first item in the RDA file. Default is `TRUE`.
 - `g` The name of the data to load from the namespace `ns`. If `NULL`, the function will try to load data named `data` from `ns`.
 - `return` The loaded data.

## Usage
```r
read_data(data, root, ns = asNamespace("ZekDex"), one = TRUE, g = NULL)
```