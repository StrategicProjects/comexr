# Get ISIC (International Standard Industrial Classification) table

Queries the `/tables/product-categories` endpoint to retrieve ISIC
classification data. ISIC is an international classification of economic
activities developed by the United Nations.

## Usage

``` r
comex_isic(
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

A data.frame with classification codes and descriptions.

## Note

The OpenAPI specification does not define a dedicated ISIC table
endpoint. ISIC codes are available as detail/grouping fields in trade
queries (e.g. `"isic_section"`, `"isic_division"`). This convenience
function queries `/tables/product-categories`, which may return ISIC
data alongside CUCI/SITC classifications. You can also look up ISIC
values using
[`comex_filter_values()`](https://strategicprojects.github.io/comexr/reference/comex_filter_values.md)
with filter names like `"isicSection"`.

## Examples

``` r
if (FALSE) { # \dontrun{
# Browse product categories (includes ISIC)
comex_isic()

# Alternatively, look up ISIC values via filters:
comex_filter_values("isicSection")
} # }
```
