# Get available years for queries

Returns the first and last years available for queries in the API.

## Usage

``` r
comex_available_years(
  type = c("general", "city", "historical"),
  verbose = FALSE
)
```

## Arguments

- type:

  Data type: `"general"` (default), `"city"`, or `"historical"`.
  Default: `"general"`.

- verbose:

  Logical. Show progress messages. Default: `FALSE`.

## Value

A list with `min` and `max` year values.

## Examples

``` r
if (FALSE) { # \dontrun{
comex_available_years()
comex_available_years("city")
comex_available_years("historical")
} # }
```
