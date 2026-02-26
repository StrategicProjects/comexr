# Get last data update date

Returns the date of the last data update in the API.

## Usage

``` r
comex_last_update(type = "general", verbose = FALSE)
```

## Arguments

- type:

  Data type: `"general"`, `"city"`, or `"historical"`. Default:
  `"general"`.

- verbose:

  Logical. Show progress messages. Default: `FALSE`.

## Value

A list with last update information.

## Examples

``` r
if (FALSE) { # \dontrun{
comex_last_update()
comex_last_update("city")
comex_last_update("historical")
} # }
```
