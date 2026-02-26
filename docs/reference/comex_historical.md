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
  month_detail = FALSE,
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

- flow:

  Trade flow: `"export"` or `"import"`.

- start_period:

  Start period in `"YYYY-MM"` format (e.g. `"1990-01"`).

- end_period:

  End period in `"YYYY-MM"` format (e.g. `"1996-12"`).

- details:

  Character vector of detail/grouping fields. Options: `"country"`,
  `"state"`, `"ncm"` (actually NBM for this period).

- filters:

  Named list of filters.

- month_detail:

  Logical. If `TRUE`, break down by month. Default: `FALSE`.

- metric_fob:

  Logical. Include FOB value (US\$). Default: `TRUE`.

- metric_kg:

  Logical. Include net weight (kg). Default: `TRUE`.

- metric_statistic:

  Logical. Include statistical quantity. Default: `FALSE`.

- metric_freight:

  Logical. Include freight value (US\$). Default: `FALSE`.

- metric_insurance:

  Logical. Include insurance value (US\$). Default: `FALSE`.

- metric_cif:

  Logical. Include CIF value (US\$). Default: `FALSE`.

- language:

  Response language: `"pt"`, `"en"`, or `"es"`. Default: `"en"`.

- verbose:

  Logical. Show progress messages. Default: `TRUE`.

## Value

A data.frame (or tibble) with query results.

## Details

Historical data differs from general data:

- Available period: **1989 to 1996** only

- Limited details: `"country"`, `"state"`, `"ncm"`

- Product classification is **NBM** (not NCM)

- All six metrics are available (FOB, KG, Statistic, Freight, Insurance,
  CIF)

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

# Historical imports with CIF value
comex_historical(
  flow = "import",
  start_period = "1990-01",
  end_period = "1992-12",
  details = c("ncm", "country"),
  metric_cif = TRUE
)
} # }
```
