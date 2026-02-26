# Get NBM (Brazilian Nomenclature of Goods) table

Returns the NBM codes table with descriptions. NBM was the nomenclature
used in Brazil before NCM adoption and is used only for historical data
(1989-1996).

## Usage

``` r
comex_nbm(
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

  Optional search term to filter results.

- add:

  Optional related table to include (e.g. `"ncm"`).

- page:

  Page number for pagination. Default: `NULL`.

- per_page:

  Number of results per page. Default: `NULL`.

- verbose:

  Logical. Default: `FALSE`.

## Value

A data.frame with NBM codes and descriptions.

## Examples

``` r
if (FALSE) { # \dontrun{
comex_nbm()
comex_nbm(search = "encomendas", per_page = 5)
comex_nbm(add = "ncm")
} # }
```
