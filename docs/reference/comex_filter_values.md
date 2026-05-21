# Get values for a specific filter

Returns the possible values for a given filter name. The `filter`
argument is passed verbatim to the API and is case-sensitive — use the
exact name returned by
[`comex_filters()`](https://strategicprojects.github.io/comexr/reference/comex_filters.md)
(for example `"economicBlock"`, `"BECLevel1"`, `"SITCSection"`,
`"ISICSection"`, `"subHeading"`, `"heading"`, `"chapter"`).

## Usage

``` r
comex_filter_values(filter, type = "general", language = "en", verbose = FALSE)
```

## Arguments

- filter:

  Filter name as returned by
  [`comex_filters()`](https://strategicprojects.github.io/comexr/reference/comex_filters.md)
  (e.g. `"country"`, `"state"`, `"ncm"`, `"economicBlock"`,
  `"BECLevel1"`, `"SITCSection"`, `"ISICSection"`).

- type:

  Data type: `"general"`, `"city"`, or `"historical"`.

- language:

  Language: `"pt"`, `"en"`, or `"es"`. Default: `"en"`.

- verbose:

  Logical. Show progress messages. Default: `FALSE`.

## Value

A data.frame with filter values.

## Examples

``` r
if (FALSE) { # \dontrun{
comex_filter_values("country")
comex_filter_values("state", type = "city")
comex_filter_values("economicBlock")
comex_filter_values("BECLevel1")
comex_filter_values("ISICSection")
} # }
```
