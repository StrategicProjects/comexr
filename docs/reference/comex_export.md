# Query exports

Shortcut for
[`comex_query()`](https://strategicprojects.github.io/comexr/reference/comex_query.md)
with `flow = "export"`.

## Usage

``` r
comex_export(
  start_period,
  end_period,
  details = NULL,
  filters = NULL,
  month_detail = TRUE,
  metric_fob = TRUE,
  metric_kg = TRUE,
  metric_statistic = FALSE,
  metric_freight = FALSE,
  metric_insurance = FALSE,
  metric_cif = FALSE,
  language = "en",
  verbose = TRUE
)
```

## Arguments

- start_period:

  Start period in `"YYYY-MM"` format (e.g. `"2023-01"`).

- end_period:

  End period in `"YYYY-MM"` format (e.g. `"2023-12"`).

- details:

  Character vector of detail/grouping fields. The names below are
  user-friendly aliases; the package translates each to the underlying
  API name. The API names returned by `comex_details("general")` are
  also accepted verbatim. Available options:

  **Geographic:** `"country"`, `"bloc"` (`"economic_block"`), `"state"`,
  `"transport_mode"` (API: `via`), `"customs_unit"` (API: `urf`)

  **Products:** `"ncm"`, `"hs6"` / `"sh6"` (API: `subHeading`), `"hs4"`
  / `"sh4"` (API: `heading`), `"hs2"` / `"sh2"` (API: `chapter`),
  `"section"`

  **CGCE (BEC):** `"cgce_n1"`, `"cgce_n2"`, `"cgce_n3"` (API:
  `BECLevel1`, `BECLevel2`, `BECLevel3`)

  **SITC/CUCI:** `"sitc_section"`, `"sitc_division"`, `"sitc_group"`,
  `"sitc_subgroup"`, `"sitc_basic_heading"` (API: `SITCSection`,
  `SITCDivision`, `SITCGroup`, `SITCSubGroup`, `SITCBasicHeading`)

  **ISIC:** `"isic_section"`, `"isic_division"`, `"isic_group"`,
  `"isic_class"` (API: `ISICSection`, `ISICDivision`, `ISICGroup`,
  `ISICClass`)

- filters:

  Named list of filters. Names should match detail field names. Example:
  `list(country = c(160, 249), state = c(26, 13))`

- month_detail:

  Logical. If `TRUE`, break down results by month. Default: `FALSE`.

- metric_fob:

  Logical. Include FOB value (US\$). Default: `TRUE`.

- metric_kg:

  Logical. Include net weight (kg). Default: `TRUE`.

- metric_statistic:

  Logical. Include statistical quantity. Default: `FALSE`.

- metric_freight:

  Logical. Include freight value (US\$, imports only). Default: `FALSE`.

- metric_insurance:

  Logical. Include insurance value (US\$, imports only). Default:
  `FALSE`.

- metric_cif:

  Logical. Include CIF value (US\$, imports only). Default: `FALSE`.

- language:

  Response language: `"pt"`, `"en"`, or `"es"`. Default: `"en"`.

- verbose:

  Logical. Show progress messages. Default: `TRUE`.

## Value

A data.frame (or tibble) with export data.

## Examples

``` r
if (FALSE) { # \dontrun{
comex_export(
  start_period = "2023-01",
  end_period = "2023-12",
  details = "country"
)
} # }
```
