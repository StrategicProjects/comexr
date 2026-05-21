# Get ISIC (International Standard Industrial Classification) values

Retrieves ISIC classification values at a chosen hierarchical level by
calling the corresponding `/general/filters/{filter}` endpoint, which is
the only place the ComexStat API exposes ISIC codes (there is no
`/tables/isic` endpoint).

## Usage

``` r
comex_isic(
  level = c("section", "division", "group", "class"),
  language = "en",
  verbose = FALSE
)
```

## Arguments

- level:

  Hierarchical level. One of `"section"`, `"division"`, `"group"`, or
  `"class"`. Default: `"section"`.

- language:

  Language: `"pt"`, `"en"`, or `"es"`. Default: `"en"`.

- verbose:

  Logical. Show progress messages. Default: `FALSE`.

## Value

A data.frame with ISIC codes and descriptions for the given level.

## Details

ISIC is the international classification of economic activities
maintained by the United Nations.

## Examples

``` r
if (FALSE) { # \dontrun{
comex_isic("section")
comex_isic("division", language = "pt")
} # }
```
