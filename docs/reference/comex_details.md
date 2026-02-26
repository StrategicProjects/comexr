# Get available detail/grouping fields

Returns the list of detail fields that can be used to group query
results.

## Usage

``` r
comex_details(type = "general", language = "en", verbose = FALSE)
```

## Arguments

- type:

  Data type: `"general"`, `"city"`, or `"historical"`.

- language:

  Language: `"pt"`, `"en"`, or `"es"`. Default: `"en"`.

- verbose:

  Logical. Show progress messages. Default: `FALSE`.

## Value

A data.frame with available details.

## Examples

``` r
if (FALSE) { # \dontrun{
comex_details()
comex_details("city")
comex_details("historical")
} # }
```
