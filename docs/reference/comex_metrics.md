# Get available metrics

Returns the list of metrics (values) available for API queries.

## Usage

``` r
comex_metrics(type = "general", language = "en", verbose = FALSE)
```

## Arguments

- type:

  Data type: `"general"`, `"city"`, or `"historical"`.

- language:

  Language: `"pt"`, `"en"`, or `"es"`. Default: `"en"`.

- verbose:

  Logical. Show progress messages. Default: `FALSE`.

## Value

A data.frame with available metrics and their descriptions.

## Examples

``` r
if (FALSE) { # \dontrun{
comex_metrics()
comex_metrics("city")
comex_metrics("historical")
} # }
```
