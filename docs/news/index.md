# Changelog

## comexr 0.2.0

CRAN release: 2026-03-10

### Breaking Changes

- [`comex_historical()`](https://strategicprojects.github.io/comexr/reference/comex_historical.md)
  no longer accepts `metric_statistic`, `metric_freight`,
  `metric_insurance`, or `metric_cif` parameters. The historical API
  endpoint only supports FOB and KG metrics.
- `month_detail` default changed from `FALSE` to `TRUE` in all query
  functions.

### Bug Fixes

- Fixed `bloc` detail mapping: now correctly maps to `economicBlock`
  (API name).
- Added missing detail mappings: `heading`, `chapter` (city endpoint),
  `nbm` (historical endpoint), `economic_block` (alias).
- Fixed `comex_metrics("general")` returning 0 rows when the `depends`
  field contained NULL values.
- Fixed
  [`comex_ncm_detail()`](https://strategicprojects.github.io/comexr/reference/comex_ncm_detail.md),
  [`comex_nbm_detail()`](https://strategicprojects.github.io/comexr/reference/comex_nbm_detail.md),
  and other detail functions returning empty lists instead of named
  lists.
- Fixed
  [`comex_historical()`](https://strategicprojects.github.io/comexr/reference/comex_historical.md)
  endpoint path (added required trailing slash).
- Fixed `response_to_tibble()` failing on responses containing NULL or
  nested list values in row fields.

### New Features

- SSL auto-fallback: the package now detects SSL certificate failures
  (common with the ICP-Brasil chain) and automatically retries without
  verification, issuing a one-time warning. Set
  `options(comex.ssl_verifypeer = FALSE)` to suppress.

### Documentation

- Corrected
  [`comex_query_city()`](https://strategicprojects.github.io/comexr/reference/comex_query_city.md)
  documentation: city endpoint uses `heading`, `chapter`, `section` —
  not `hs4`, `hs2`, `hs6`.
- Corrected
  [`comex_historical()`](https://strategicprojects.github.io/comexr/reference/comex_historical.md)
  documentation: only `country`, `state`, and `nbm` details are
  available (not `ncm` or `section`).
- Updated
  [`comex_filter_values()`](https://strategicprojects.github.io/comexr/reference/comex_filter_values.md)
  documentation with the actual filters that have value endpoints (6 for
  general, 7 for city, 2 for historical).
- Renamed package from `comex` to `comexr`.

## comexr 0.1.0

### Initial Release

- 30 exported functions covering all ComexStat API endpoints.
- General trade queries:
  [`comex_query()`](https://strategicprojects.github.io/comexr/reference/comex_query.md),
  [`comex_export()`](https://strategicprojects.github.io/comexr/reference/comex_export.md),
  [`comex_import()`](https://strategicprojects.github.io/comexr/reference/comex_import.md).
- City-level queries:
  [`comex_query_city()`](https://strategicprojects.github.io/comexr/reference/comex_query_city.md).
- Historical queries (1989-1996):
  [`comex_historical()`](https://strategicprojects.github.io/comexr/reference/comex_historical.md).
- Metadata:
  [`comex_last_update()`](https://strategicprojects.github.io/comexr/reference/comex_last_update.md),
  [`comex_available_years()`](https://strategicprojects.github.io/comexr/reference/comex_available_years.md),
  [`comex_filters()`](https://strategicprojects.github.io/comexr/reference/comex_filters.md),
  [`comex_filter_values()`](https://strategicprojects.github.io/comexr/reference/comex_filter_values.md),
  [`comex_details()`](https://strategicprojects.github.io/comexr/reference/comex_details.md),
  [`comex_metrics()`](https://strategicprojects.github.io/comexr/reference/comex_metrics.md).
- Auxiliary tables for geography, products, and classifications.
