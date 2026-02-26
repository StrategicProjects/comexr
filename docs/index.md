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
remotes::install_github("StrategicProjects/comex")
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
| **Queries** | [`comex_query()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_query.md), [`comex_export()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_export.md), [`comex_import()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_import.md), [`comex_query_city()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_query_city.md), [`comex_historical()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_historical.md) |
| **Metadata** | [`comex_last_update()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_last_update.md), [`comex_available_years()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_available_years.md), [`comex_filters()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_filters.md), [`comex_filter_values()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_filter_values.md), [`comex_details()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_details.md), [`comex_metrics()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_metrics.md) |
| **Geography** | [`comex_countries()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_countries.md), [`comex_country_detail()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_country_detail.md), [`comex_blocs()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_blocs.md), [`comex_states()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_states.md), [`comex_state_detail()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_state_detail.md), [`comex_cities()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_cities.md), [`comex_city_detail()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_city_detail.md), [`comex_transport_modes()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_transport_modes.md), [`comex_transport_mode_detail()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_transport_mode_detail.md), [`comex_customs_units()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_customs_units.md), [`comex_customs_unit_detail()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_customs_unit_detail.md) |
| **Products** | [`comex_ncm()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_ncm.md), [`comex_ncm_detail()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_ncm_detail.md), [`comex_nbm()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_nbm.md), [`comex_nbm_detail()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_nbm_detail.md), [`comex_hs()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_hs.md) |
| **Classifications** | [`comex_cgce()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_cgce.md), [`comex_sitc()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_sitc.md), [`comex_isic()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_isic.md) |

## Documentation

- [`vignette("getting-started")`](https://monitoramento.sepe.pe.gov.br/comex/articles/getting-started.md)
  — overview and first steps
- [`vignette("querying-trade-data")`](https://monitoramento.sepe.pe.gov.br/comex/articles/querying-trade-data.md)
  — advanced query patterns
- [`vignette("auxiliary-tables")`](https://monitoramento.sepe.pe.gov.br/comex/articles/auxiliary-tables.md)
  — browsing product codes and classifications

## API Reference

This package wraps the official ComexStat API documented at
<https://api-comexstat.mdic.gov.br/docs>.

## License

MIT
