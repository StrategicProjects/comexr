# Query city-level foreign trade data

Query the city endpoint of the ComexStat API. City-level data is more
aggregated than general data, with fewer available details and metrics.

City information is based on the declarant of exports/imports, not the
producer or buyer.

## Usage

``` r
comex_query_city(
  flow = "export",
  start_period,
  end_period,
  details = NULL,
  filters = NULL,
  month_detail = TRUE,
  metric_fob = TRUE,
  metric_kg = TRUE,
  language = "en",
  verbose = TRUE
)
```

## Arguments

- flow:

  Trade flow: `"export"` or `"import"`.

- start_period:

  Start period in `"YYYY-MM"` format.

- end_period:

  End period in `"YYYY-MM"` format.

- details:

  Character vector of detail/grouping fields. The city endpoint accepts
  only a subset of the general-endpoint fields:

  **Geographic:** `"country"`, `"bloc"` (`"economic_block"`), `"state"`,
  `"city"`

  **Products:** `"hs4"` / `"sh4"` (API: `heading`), `"hs2"` / `"sh2"`
  (API: `chapter`), `"section"`

- filters:

  Named list of filters. Accepts the same names as `details`. Example:
  `list(city = "3550308", state = "26")`

- month_detail:

  Logical. If `TRUE`, break down by month. Default: `TRUE`.

- metric_fob:

  Logical. Include FOB value (US\$). Default: `TRUE`.

- metric_kg:

  Logical. Include net weight (kg). Default: `TRUE`.

- language:

  Response language: `"pt"`, `"en"`, or `"es"`. Default: `"en"`.

- verbose:

  Logical. Show progress messages. Default: `TRUE`.

## Value

A data.frame (or tibble) with query results.

## Details

City-level data differs from general data:

- Full NCM is **not** available; product detail goes only down to HS4
  (heading). HS6 (subheading) is also **not** available.

- Classifications like CGCE, SITC, and ISIC are **not** available

- Transport mode (`via`) and customs unit (`urf`) are **not** available

- Only **FOB** and **KG** metrics are supported; statistical quantity,
  freight, insurance, and CIF metrics are **not** available

## Examples

``` r
if (FALSE) { # \dontrun{
# Exports from Pernambuco in 2023
comex_query_city(
  flow = "export",
  start_period = "2023-01",
  end_period = "2023-12",
  details = c("country", "state"),
  filters = list(state = 26)
)
} # }
```
