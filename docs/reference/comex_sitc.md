# Get SITC/CUCI (Standard International Trade Classification) table

Returns the CUCI (Classificacao Uniforme para o Comercio Internacional)
table from the `/tables/product-categories` endpoint. CUCI is the
Portuguese name for SITC (Standard International Trade Classification).

## Usage

``` r
comex_sitc(
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

  Logical. Show progress messages. Default: `FALSE`.

## Value

A data.frame with CUCI/SITC codes and descriptions.

## Examples

``` r
if (FALSE) { # \dontrun{
# All CUCI/SITC classifications
comex_sitc()

# Search for products
comex_sitc(search = "carne")
} # }
```
