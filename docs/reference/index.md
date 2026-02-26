# Package index

## Trade Data Queries

Functions to query export/import statistics. These are the main
workhorse functions that hit the POST endpoints.

- [`comex_query()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_query.md)
  : Query general foreign trade data
- [`comex_export()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_export.md)
  : Query exports
- [`comex_import()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_import.md)
  : Query imports
- [`comex_query_city()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_query_city.md)
  : Query city-level foreign trade data
- [`comex_historical()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_historical.md)
  : Query historical foreign trade data (1989-1996)

## Metadata Discovery

Discover available filters, details, metrics, date ranges, and last
update timestamps for each data type.

- [`comex_last_update()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_last_update.md)
  : Get last data update date
- [`comex_available_years()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_available_years.md)
  : Get available years for queries
- [`comex_filters()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_filters.md)
  : Get available filters
- [`comex_filter_values()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_filter_values.md)
  : Get values for a specific filter
- [`comex_details()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_details.md)
  : Get available detail/grouping fields
- [`comex_metrics()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_metrics.md)
  : Get available metrics

## Geography Tables

Lookup tables for countries, economic blocs, states, cities, transport
modes, and customs units.

- [`comex_countries()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_countries.md)
  : Get countries table
- [`comex_country_detail()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_country_detail.md)
  : Get country details
- [`comex_blocs()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_blocs.md)
  : Get economic blocs table
- [`comex_states()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_states.md)
  : Get Brazilian states (UF) table
- [`comex_state_detail()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_state_detail.md)
  : Get state details
- [`comex_cities()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_cities.md)
  : Get Brazilian cities table
- [`comex_city_detail()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_city_detail.md)
  : Get city details
- [`comex_transport_modes()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_transport_modes.md)
  : Get transport modes table
- [`comex_transport_mode_detail()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_transport_mode_detail.md)
  : Get transport mode details
- [`comex_customs_units()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_customs_units.md)
  : Get customs units (URF) table
- [`comex_customs_unit_detail()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_customs_unit_detail.md)
  : Get customs unit details

## Product Tables

Nomenclature tables: NCM (Mercosur), NBM (historical), and Harmonized
System (HS).

- [`comex_ncm()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_ncm.md)
  : Get NCM (Mercosur Common Nomenclature) table
- [`comex_ncm_detail()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_ncm_detail.md)
  : Get NCM code details
- [`comex_nbm()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_nbm.md)
  : Get NBM (Brazilian Nomenclature of Goods) table
- [`comex_nbm_detail()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_nbm_detail.md)
  : Get NBM code details
- [`comex_hs()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_hs.md)
  : Get Harmonized System (HS) tables

## Classification Tables

Economic classification tables: CGCE (BEC), SITC (CUCI), and ISIC codes.

- [`comex_cgce()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_cgce.md)
  : Get CGCE (Classification by Broad Economic Categories) table
- [`comex_sitc()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_sitc.md)
  : Get SITC/CUCI (Standard International Trade Classification) table
- [`comex_isic()`](https://monitoramento.sepe.pe.gov.br/comex/reference/comex_isic.md)
  : Get ISIC (International Standard Industrial Classification) table
