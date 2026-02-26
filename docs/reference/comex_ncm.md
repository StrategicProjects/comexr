# Get NCM (Mercosur Common Nomenclature) table

Returns the NCM codes table with descriptions. NCM is the product
classification used by Mercosur countries, based on the Harmonized
System (HS) with 8 digits.

## Usage

``` r
comex_ncm(
  language = "en",
  search = NULL,
  add = NULL,
  page = NULL,
  per_page = NULL,
  verbose = FALSE
)
```

## Arguments

- language:

  Language: `"pt"`, `"en"`, or `"es"`. Default: `"en"`.

- search:

  Optional search term to filter results (e.g. `"animal"`).

- add:

  Optional related table to include in results. Options: `"sh"`,
  `"cuci"`, `"cgce"`.

- page:

  Page number for pagination. Default: `NULL` (all results).

- per_page:

  Number of results per page. Default: `NULL`.

- verbose:

  Logical. Show progress messages. Default: `FALSE`.

## Value

A data.frame with NCM codes and descriptions.

## Examples

``` r
if (FALSE) { # \dontrun{
ncm <- comex_ncm()
comex_ncm(search = "animal", per_page = 10)
comex_ncm(add = "cuci")
} # }
```
