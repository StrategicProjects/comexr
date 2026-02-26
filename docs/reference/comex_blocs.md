# Get economic blocs table

Returns the economic blocs table with codes and names. Economic blocs
represent trade agreements between countries and regions.

## Usage

``` r
comex_blocs(language = "en", search = NULL, add = NULL, verbose = FALSE)
```

## Arguments

- language:

  Language: `"pt"`, `"en"`, or `"es"`. Default: `"en"`.

- search:

  Optional search term to filter results.

- add:

  Optional related table to include (e.g. `"country"`).

- verbose:

  Logical. Default: `FALSE`.

## Value

A data.frame with economic bloc codes and names.

## Examples

``` r
if (FALSE) { # \dontrun{
comex_blocs()
comex_blocs(search = "mercosul")
comex_blocs(add = "country")
} # }
```
