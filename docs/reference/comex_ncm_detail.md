# Get NCM code details

Returns details for a specific NCM code, including product description
and its HS classification hierarchy.

## Usage

``` r
comex_ncm_detail(ncm_code, verbose = FALSE)
```

## Arguments

- ncm_code:

  NCM code (8 digits, as character, e.g. `"02042200"`).

- verbose:

  Logical. Default: `FALSE`.

## Value

A list with NCM details.

## Examples

``` r
if (FALSE) { # \dontrun{
comex_ncm_detail("02042200")
} # }
```
