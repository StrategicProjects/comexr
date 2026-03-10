# comexr

The **comexr** package provides a complete R interface to the [ComexStat
API](https://comexstat.mdic.gov.br/) from the Brazilian Ministry of
Development, Industry, Trade and Services (MDIC). It allows programmatic
access to detailed Brazilian export and import data.

## Features

- **30 functions** covering all API endpoints
- **General trade data** (1997–present), **city-level** data, and
  **historical** records (1989–1996)
- **Auxiliary tables**: countries, economic blocs, NCM/NBM/HS product
  codes, CGCE/SITC/ISIC classifications, states, cities, transport
  modes, customs units
- **Only 2 dependencies**: `httr2` + `cli`
- **Multilingual**: Portuguese, English, Spanish
- **SSL auto-fallback**: handles ICP-Brasil certificate issues
  transparently

## Installation

``` r

# Install from GitHub
# install.packages("remotes")
remotes::install_github("StrategicProjects/comexr")
```

## Quick Start

``` r

library(comexr)

# Exports by country in January 2024 (monthly detail by default)
exports <- comex_export(
  start_period = "2024-01",
  end_period = "2024-01",
  details = "country"
)

# Imports with CIF value
imports <- comex_import(
  start_period = "2024-01",
  end_period = "2024-12",
  details = "country",
  metric_cif = TRUE
)

# Filter: exports to China (160), grouped by HS4
soy <- comex_export(
  start_period = "2024-01",
  end_period = "2024-12",
  details = c("country", "hs4"),
  filters = list(country = 160)
)
```

## Discover available options

``` r

# What grouping fields are available?
comex_details("general")

# What filters can I use?
comex_filters("general")

# Look up country codes
countries <- comex_countries()
countries[grepl("China", countries$text, ignore.case = TRUE), ]

# Economic blocs in Portuguese
comex_blocs(language = "pt")
```

## API Coverage

### Query Functions

| Function | Description |
|----|----|
| [`comex_query()`](https://strategicprojects.github.io/comexr/reference/comex_query.md) | General foreign trade query |
| [`comex_export()`](https://strategicprojects.github.io/comexr/reference/comex_export.md) | Shortcut for export queries |
| [`comex_import()`](https://strategicprojects.github.io/comexr/reference/comex_import.md) | Shortcut for import queries |
| [`comex_query_city()`](https://strategicprojects.github.io/comexr/reference/comex_query_city.md) | City-level data query |
| [`comex_historical()`](https://strategicprojects.github.io/comexr/reference/comex_historical.md) | Historical data (1989-1996) |

### Metadata Functions

| Function | Description |
|----|----|
| [`comex_last_update()`](https://strategicprojects.github.io/comexr/reference/comex_last_update.md) | Last data update date |
| [`comex_available_years()`](https://strategicprojects.github.io/comexr/reference/comex_available_years.md) | Available years for queries |
| [`comex_filters()`](https://strategicprojects.github.io/comexr/reference/comex_filters.md) | Available filters |
| [`comex_filter_values()`](https://strategicprojects.github.io/comexr/reference/comex_filter_values.md) | Values for a specific filter |
| [`comex_details()`](https://strategicprojects.github.io/comexr/reference/comex_details.md) | Available detail/grouping fields |
| [`comex_metrics()`](https://strategicprojects.github.io/comexr/reference/comex_metrics.md) | Available metrics |

### Auxiliary Tables

| Function | Description |
|----|----|
| [`comex_countries()`](https://strategicprojects.github.io/comexr/reference/comex_countries.md) / [`comex_country_detail()`](https://strategicprojects.github.io/comexr/reference/comex_country_detail.md) | Countries |
| [`comex_blocs()`](https://strategicprojects.github.io/comexr/reference/comex_blocs.md) | Economic blocs |
| [`comex_states()`](https://strategicprojects.github.io/comexr/reference/comex_states.md) / [`comex_state_detail()`](https://strategicprojects.github.io/comexr/reference/comex_state_detail.md) | Brazilian states |
| [`comex_cities()`](https://strategicprojects.github.io/comexr/reference/comex_cities.md) / [`comex_city_detail()`](https://strategicprojects.github.io/comexr/reference/comex_city_detail.md) | Brazilian cities |
| [`comex_transport_modes()`](https://strategicprojects.github.io/comexr/reference/comex_transport_modes.md) / [`comex_transport_mode_detail()`](https://strategicprojects.github.io/comexr/reference/comex_transport_mode_detail.md) | Transport modes |
| [`comex_customs_units()`](https://strategicprojects.github.io/comexr/reference/comex_customs_units.md) / [`comex_customs_unit_detail()`](https://strategicprojects.github.io/comexr/reference/comex_customs_unit_detail.md) | Customs units |
| [`comex_ncm()`](https://strategicprojects.github.io/comexr/reference/comex_ncm.md) / [`comex_ncm_detail()`](https://strategicprojects.github.io/comexr/reference/comex_ncm_detail.md) | NCM codes |
| [`comex_nbm()`](https://strategicprojects.github.io/comexr/reference/comex_nbm.md) / [`comex_nbm_detail()`](https://strategicprojects.github.io/comexr/reference/comex_nbm_detail.md) | NBM codes (historical) |
| [`comex_hs()`](https://strategicprojects.github.io/comexr/reference/comex_hs.md) | Harmonized System |
| [`comex_cgce()`](https://strategicprojects.github.io/comexr/reference/comex_cgce.md) | CGCE (BEC) classification |
| [`comex_sitc()`](https://strategicprojects.github.io/comexr/reference/comex_sitc.md) | SITC classification |
| [`comex_isic()`](https://strategicprojects.github.io/comexr/reference/comex_isic.md) | ISIC classification |

## SSL Certificate Issues

On some systems the API’s ICP-Brasil certificate chain is not
recognized. The package handles this automatically — on the first
failure it retries without SSL verification and issues a warning. To
suppress:

``` r

options(comex.ssl_verifypeer = FALSE)
```

## References

- [ComexStat](https://comexstat.mdic.gov.br/) — Brazilian foreign trade
  statistics
- [ComexStat API Docs](https://api-comexstat.mdic.gov.br/docs) —
  Official API documentation
- [MDIC](https://www.gov.br/mdic/) — Ministry of Development, Industry,
  Trade and Services

## License

MIT © comexr authors
