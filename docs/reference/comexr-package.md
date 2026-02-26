# comexr: R Client for the ComexStat API

The `comexr` package provides a complete R interface to the ComexStat
API from the Brazilian Ministry of Development, Industry, Trade and
Services (MDIC).

The API provides Brazilian foreign trade data from 1997 (general data)
and from 1989 (historical data), along with auxiliary tables for product
nomenclatures, countries, economic classifications, and more.

## Query functions (POST)

These functions query aggregated export and import data with
configurable filters, details, and metrics:

- [`comex_query()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_query.md):
  Query general foreign trade data

- [`comex_export()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_export.md):
  Shortcut for export queries

- [`comex_import()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_import.md):
  Shortcut for import queries

- [`comex_query_city()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_query_city.md):
  Query city-level data

- [`comex_historical()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_historical.md):
  Query historical data (1989-1996)

## API metadata (GET)

Functions to retrieve information about the API itself:

- [`comex_last_update()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_last_update.md):
  Date of last data update

- [`comex_available_years()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_available_years.md):
  Available years for queries

- [`comex_filters()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_filters.md):
  Available filters

- [`comex_filter_values()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_filter_values.md):
  Possible values for a filter

- [`comex_details()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_details.md):
  Available detail/grouping fields

- [`comex_metrics()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_metrics.md):
  Available metrics

## Auxiliary tables - Geography (GET)

- [`comex_countries()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_countries.md),
  [`comex_country_detail()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_country_detail.md)

- [`comex_blocs()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_blocs.md)

- [`comex_states()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_states.md),
  [`comex_state_detail()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_state_detail.md)

- [`comex_cities()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_cities.md),
  [`comex_city_detail()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_city_detail.md)

- [`comex_transport_modes()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_transport_modes.md),
  [`comex_transport_mode_detail()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_transport_mode_detail.md)

- [`comex_customs_units()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_customs_units.md),
  [`comex_customs_unit_detail()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_customs_unit_detail.md)

## Auxiliary tables - Products (GET)

- [`comex_ncm()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_ncm.md),
  [`comex_ncm_detail()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_ncm_detail.md)

- [`comex_nbm()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_nbm.md),
  [`comex_nbm_detail()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_nbm_detail.md)

- [`comex_hs()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_hs.md)

## Auxiliary tables - Classifications (GET)

- [`comex_cgce()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_cgce.md)

- [`comex_sitc()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_sitc.md)

- [`comex_isic()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_isic.md)

## Dependencies

The package uses **only two dependencies**:

- `httr2` for all HTTP requests (no headless browser needed)

- `cli` for formatted console messages

## See also

Useful links:

- <https://github.com/StrategicProjects/comexr>

- Report bugs at <https://github.com/StrategicProjects/comexr/issues>

## Author

**Maintainer**: Andre Leite <leite@castlab.org>

Authors:

- Marcos Wasilew <marcos.wasilew@gmail.com>

- Hugo Vasconcelos <hugo.vasconcelos@ufpe.br>

- Carlos Amorin <carlos.agaf@ufpe.br>

- Diogo Bezerra <diogo.bezerra@ufpe.br>
