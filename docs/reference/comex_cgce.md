# Get CGCE (Classification by Broad Economic Categories) table

Returns the CGCE classification table from the `/tables/classifications`
endpoint. CGCE groups products by use or economic purpose (e.g. capital
goods, intermediate goods, consumer goods).

## Usage

``` r
comex_cgce(
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

  Page number for pagination. Default: `NULL` (all results).

- per_page:

  Number of results per page. Default: `NULL`.

- verbose:

  Logical. Show progress messages. Default: `FALSE`.

## Value

A data.frame with CGCE codes and descriptions.

## Examples

``` r
if (FALSE) { # \dontrun{
# All CGCE classifications
comex_cgce()

# Search within CGCE
comex_cgce(search = "110")
} # }
```
