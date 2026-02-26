# Get Harmonized System (HS) tables

Returns Harmonized System classification tables. The HS is an
international product nomenclature developed by the World Customs
Organization (WCO).

## Usage

``` r
comex_hs(
  language = "en",
  add = NULL,
  page = NULL,
  per_page = NULL,
  verbose = FALSE
)
```

## Arguments

- language:

  Language: `"pt"`, `"en"`, or `"es"`. Default: `"en"`.

- add:

  Optional related table to include (e.g. `"ncm"`).

- page:

  Page number for pagination. Default: `NULL`.

- per_page:

  Number of results per page. Default: `NULL`.

- verbose:

  Logical. Default: `FALSE`.

## Value

A data.frame with HS codes and descriptions.

## Details

The Harmonized System is organized hierarchically:

- **Section**: 21 sections (broadest grouping)

- **Chapter (HS2)**: ~97 chapters (2 digits)

- **Heading (HS4)**: 4 digits

- **Subheading (HS6)**: 6 digits (most detailed)

The NCM adds 2 more digits to the HS6 code.

## Examples

``` r
if (FALSE) { # \dontrun{
# All HS classifications
comex_hs()

# With related NCM codes
comex_hs(add = "ncm", per_page = 10)
} # }
```
