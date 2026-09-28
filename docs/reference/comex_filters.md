# Get available filters

Returns the list of filter types available for API queries.

## Usage

``` r
comex_filters(
  type = c("general", "city", "historical"),
  language = "en",
  verbose = FALSE
)
```

## Arguments

- type:

  Data type: `"general"` (default), `"city"`, or `"historical"`.

- language:

  Language: `"pt"`, `"en"`, or `"es"`. Default: `"en"`.

- verbose:

  Logical. Show progress messages. Default: `FALSE`.

## Value

A data.frame with available filters.

## Examples

``` r
if (FALSE) { # \dontrun{
comex_filters()
comex_filters("city")
comex_filters("historical")
} # }
```
