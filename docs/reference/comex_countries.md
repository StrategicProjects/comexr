# Get countries table

Returns the countries table with codes and names.

## Usage

``` r
comex_countries(search = NULL, verbose = FALSE)
```

## Arguments

- search:

  Optional search term to filter results (e.g. `"br"`).

- verbose:

  Logical. Show progress messages. Default: `FALSE`.

## Value

A data.frame with country codes and names.

## Examples

``` r
if (FALSE) { # \dontrun{
comex_countries()
comex_countries(search = "bra")
} # }
```
