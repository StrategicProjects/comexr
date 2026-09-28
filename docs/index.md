# comexr

The **comexr** package provides a complete R interface to the [ComexStat
API](https://api-comexstat.mdic.gov.br/docs#/) from the Brazilian
Ministry of Development, Industry, Trade and Services (MDIC). It allows
programmatic access to detailed Brazilian export and import data.

## Features

- **30 functions** covering all API endpoints
- **General trade data** (1997–present), **city-level** data, and
  **historical** records (1989–1996)
- **Auxiliary tables**: countries, economic blocs, NCM/NBM/HS product
  codes, CGCE/SITC/ISIC classifications, states, cities, transport
  modes, customs units
- **Only 2 dependencies**: `httr2` + `cli`
- **Multilingual**: Portuguese, English, Spanish
- **Typed results**: metrics come back numeric, `year`/`monthNumber`
  integer

## Installation

\
`# Install from GitHub`\
`# install.packages("remotes")`\
`remotes``::`[`install_github`](https://remotes.r-lib.org/reference/install_github.html)`(``"StrategicProjects/comexr"``)`

## Quick Start

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`comexr`](https://strategicprojects.github.io/comexr/)`)`\
\
`# Exports by country in January 2024 (monthly detail by default)`\
`exports`` ``<-`` `[`comex_export`](https://strategicprojects.github.io/comexr/reference/comex_export.md)`(`\
`  start_period ``=`` ``"2024-01"``,`\
`  end_period ``=`` ``"2024-01"``,`\
`  details ``=`` ``"country"`\
`)`\
\
`# Imports with CIF value`\
`imports`` ``<-`` `[`comex_import`](https://strategicprojects.github.io/comexr/reference/comex_import.md)`(`\
`  start_period ``=`` ``"2024-01"``,`\
`  end_period ``=`` ``"2024-12"``,`\
`  details ``=`` ``"country"``,`\
`  metric_cif ``=`` ``TRUE`\
`)`\
\
`# Filter: exports to China (160), grouped by HS4`\
`` # (the package translates "hs4" to the API's `heading`) ``\
`soy`` ``<-`` `[`comex_export`](https://strategicprojects.github.io/comexr/reference/comex_export.md)`(`\
`  start_period ``=`` ``"2024-01"``,`\
`  end_period ``=`` ``"2024-12"``,`\
`  details ``=`` `[`c`](https://rdrr.io/r/base/c.html)`(``"country"``, ``"hs4"``)``,`\
`  filters ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``country ``=`` ``160``)`\
`)`

It is fairly common for the ComexStat API to return rate limit errors
(“Você excedeu o limite de solicitações. Por favor, tente novamente em
10 segundos.”) or to report timeouts. There are three package options
you can adjust to work around these errors:

- `comexr.retry_time` - the number of seconds to wait after a failed
  request before trying again (default 10, increase if you get errors
  about exceeding request limits)
- `comexr.max_tries` - maximum number of times to repeat the same failed
  request before giving up (default 3, adjusting `comexr.retry_time` is
  generally a better approach to avoid errors without overloading
  ComexStat servers)
- `comexr.timeout` - maximum number of seconds to wait for the ComexStat
  servers to respond (default 60 for simple requests and 120 for complex
  requests; increase if you get errors about timeouts)

You can set any of these using the `options` function:
e.g. `options("comexr.retry_time" = 30)` to set the retry time to 30
seconds.

## Discover available options

\
`# What grouping fields are available?`\
[`comex_details`](https://strategicprojects.github.io/comexr/reference/comex_details.md)`(``"general"``)`\
\
`# What filters can I use?`\
[`comex_filters`](https://strategicprojects.github.io/comexr/reference/comex_filters.md)`(``"general"``)`\
\
`# Look up country codes`\
`countries`` ``<-`` `[`comex_countries`](https://strategicprojects.github.io/comexr/reference/comex_countries.md)`(``)`\
`countries``[`[`grepl`](https://rdrr.io/r/base/grep.html)`(``"China"``, ``countries``$``text``, ignore.case ``=`` ``TRUE``)``, ``]`\
\
`# Economic blocs in Portuguese`\
[`comex_blocs`](https://strategicprojects.github.io/comexr/reference/comex_blocs.md)`(``language ``=`` ``"pt"``)`

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
recognized, and requests fail with an SSL error. SSL verification is
never disabled automatically; if you trust your network, opt out
explicitly:

\
[`options`](https://rdrr.io/r/base/options.html)`(``comexr.ssl_verifypeer ``=`` ``FALSE``)`

## References

- [ComexStat](https://comexstat.mdic.gov.br/en/home) — Brazilian foreign
  trade statistics
- [ComexStat API Docs](https://api-comexstat.mdic.gov.br/docs) —
  Official API documentation
- [MDIC](https://www.gov.br/mdic/pt-br) — Ministry of Development,
  Industry, Trade and Services

## License

MIT © comexr authors
