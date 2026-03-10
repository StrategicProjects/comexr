# Query historical foreign trade data (1989-1996)

Query the historical data endpoint of the ComexStat API to retrieve
Brazilian export and import data from 1989 to 1996, before the SISCOMEX
system was implemented. Historical data uses the NBM (Brazilian
Nomenclature of Goods) classification.

## Usage

``` r
comex_historical(
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

  Start period in `"YYYY-MM"` format (e.g. `"1990-01"`).

- end_period:

  End period in `"YYYY-MM"` format (e.g. `"1996-12"`).

- details:

  Character vector of detail/grouping fields. Options: `"country"`,
  `"state"`, `"nbm"`.

- filters:

  Named list of filters.

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

Historical data differs from general data:

- Available period: **1989 to 1996** only

- Limited details: `"country"`, `"state"`, `"nbm"`

- Product classification is **NBM** (not NCM)

- Only **FOB and KG** metrics are available (no statistic, freight,
  insurance, or CIF)

## Examples

``` r
if (FALSE) { # \dontrun{
# Historical exports 1995-1996 by country
comex_historical(
  flow = "export",
  start_period = "1995-01",
  end_period = "1996-12",
  details = "country"
)
} # }
```
