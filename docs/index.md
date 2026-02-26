# comexr ![comex logo](reference/figures/logo.svg)

R client for the [ComexStat API](https://comexstat.mdic.gov.br/) —
Brazilian foreign trade statistics from the Ministry of Development,
Industry, Trade and Services (MDIC).

## Features

- **30 functions** covering all 38 API endpoints
- **General trade data** (1997–present), **city-level** data, and
  **historical** records (1989–1996)
- **Auxiliary tables**: countries, economic blocs, NCM/NBM/HS product
  codes, CGCE/SITC/ISIC classifications, states, cities, transport
  modes, customs units
- **Multilingual**: Portuguese, English, Spanish
- User-friendly parameter names mapped automatically to API names

## Installation

``` r

# From GitHub
remotes::install_github("StrategicProjects/comexr")
```

## Quick start

``` r

library(comexr)

# Top export destinations in January 2024
exports <- comex_export(
  start_period = "2024-01",
  end_period   = "2024-01",
  details      = "country"
)
exports
#> # A tibble: 219 × 4
#>    year  country          metricFOB    metricKG
#>    <chr> <chr>                <dbl>       <dbl>
#>  1 2024  China           7812623070 19868234567
#>  2 2024  United States   3254810234  2547891234
#>  ...

# Imports with CIF value
imports <- comex_import(
  start_period = "2024-01",
  end_period   = "2024-01",
  details      = "country",
  metric_cif   = TRUE
)

# Filter: exports to China (160), grouped by HS4
soy <- comex_export(
  start_period = "2024-01",
  end_period   = "2024-12",
  details      = c("country", "hs4"),
  filters      = list(country = 160),
  month_detail = TRUE
)
```

## Discover available options

``` r

# What grouping fields are available?
comex_details("general")

# What filters can I use?
comex_filters("general")

# Look up country codes
comex_countries(search = "China")

# Economic blocs in Portuguese
comex_blocs(language = "pt")
```

## Function overview

| Category | Functions |
|----|----|
| **Queries** | [`comex_query()`](https://strategicprojects.github.io/comexr/reference/comex_query.md), [`comex_export()`](https://strategicprojects.github.io/comexr/reference/comex_export.md), [`comex_import()`](https://strategicprojects.github.io/comexr/reference/comex_import.md), [`comex_query_city()`](https://strategicprojects.github.io/comexr/reference/comex_query_city.md), [`comex_historical()`](https://strategicprojects.github.io/comexr/reference/comex_historical.md) |
| **Metadata** | [`comex_last_update()`](https://strategicprojects.github.io/comexr/reference/comex_last_update.md), [`comex_available_years()`](https://strategicprojects.github.io/comexr/reference/comex_available_years.md), [`comex_filters()`](https://strategicprojects.github.io/comexr/reference/comex_filters.md), [`comex_filter_values()`](https://strategicprojects.github.io/comexr/reference/comex_filter_values.md), [`comex_details()`](https://strategicprojects.github.io/comexr/reference/comex_details.md), [`comex_metrics()`](https://strategicprojects.github.io/comexr/reference/comex_metrics.md) |
| **Geography** | [`comex_countries()`](https://strategicprojects.github.io/comexr/reference/comex_countries.md), [`comex_country_detail()`](https://strategicprojects.github.io/comexr/reference/comex_country_detail.md), [`comex_blocs()`](https://strategicprojects.github.io/comexr/reference/comex_blocs.md), [`comex_states()`](https://strategicprojects.github.io/comexr/reference/comex_states.md), [`comex_state_detail()`](https://strategicprojects.github.io/comexr/reference/comex_state_detail.md), [`comex_cities()`](https://strategicprojects.github.io/comexr/reference/comex_cities.md), [`comex_city_detail()`](https://strategicprojects.github.io/comexr/reference/comex_city_detail.md), [`comex_transport_modes()`](https://strategicprojects.github.io/comexr/reference/comex_transport_modes.md), [`comex_transport_mode_detail()`](https://strategicprojects.github.io/comexr/reference/comex_transport_mode_detail.md), [`comex_customs_units()`](https://strategicprojects.github.io/comexr/reference/comex_customs_units.md), [`comex_customs_unit_detail()`](https://strategicprojects.github.io/comexr/reference/comex_customs_unit_detail.md) |
| **Products** | [`comex_ncm()`](https://strategicprojects.github.io/comexr/reference/comex_ncm.md), [`comex_ncm_detail()`](https://strategicprojects.github.io/comexr/reference/comex_ncm_detail.md), [`comex_nbm()`](https://strategicprojects.github.io/comexr/reference/comex_nbm.md), [`comex_nbm_detail()`](https://strategicprojects.github.io/comexr/reference/comex_nbm_detail.md), [`comex_hs()`](https://strategicprojects.github.io/comexr/reference/comex_hs.md) |
| **Classifications** | [`comex_cgce()`](https://strategicprojects.github.io/comexr/reference/comex_cgce.md), [`comex_sitc()`](https://strategicprojects.github.io/comexr/reference/comex_sitc.md), [`comex_isic()`](https://strategicprojects.github.io/comexr/reference/comex_isic.md) |

## Documentation

- [`vignette("getting-started")`](https://strategicprojects.github.io/comexr/articles/getting-started.md)
  — overview and first steps
- [`vignette("querying-trade-data")`](https://strategicprojects.github.io/comexr/articles/querying-trade-data.md)
  — advanced query patterns
- [`vignette("auxiliary-tables")`](https://strategicprojects.github.io/comexr/articles/auxiliary-tables.md)
  — browsing product codes and classifications

## API Reference

This package wraps the official ComexStat API documented at
<https://api-comexstat.mdic.gov.br/docs>.

## License

MIT
