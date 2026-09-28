# Building a city trade profile (replicating the ComexStat municipality page)

The public ComexStat website has a page per municipality at
`https://comexstat.mdic.gov.br/en/municipio/{code}` showing the city’s
foreign trade profile. This vignette reproduces those panels — totals,
top trading partners, top economic blocs, top products and a monthly
time series — using only the `comexr` package.

We use **Recife - PE (IBGE 2611606)** as the example. The same pattern
works for any Brazilian municipality; just swap the IBGE code.

> **Note on city codes.** The ComexStat web URLs may use a legacy
> internal code (`co_mun_geo`). The API accepts only the standard
> 7-digit IBGE code (`coMunGeo`). Use
> \[[`comex_cities()`](https://strategicprojects.github.io/comexr/reference/comex_cities.md)\]
> or
> \[[`comex_city_detail()`](https://strategicprojects.github.io/comexr/reference/comex_city_detail.md)\]
> to look up the right code.

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`comexr`](https://strategicprojects.github.io/comexr/)`)`\
\
`city_code`` ``<-`` ``"2611606"``  ``# Recife - PE (IBGE)`\
`year_from`` ``<-`` ``"2024-01"`\
`year_to``   ``<-`` ``"2024-12"`

## What the city endpoint exposes

City-level data is more limited than the general endpoint. Always
inspect the available options before building a query:

\
[`comex_filters`](https://strategicprojects.github.io/comexr/reference/comex_filters.md)`(``"city"``)``    ``# 7 filters`\
[`comex_details`](https://strategicprojects.github.io/comexr/reference/comex_details.md)`(``"city"``)``    ``# 7 details (same names as filters)`\
[`comex_metrics`](https://strategicprojects.github.io/comexr/reference/comex_metrics.md)`(``"city"``)``    ``# only FOB and KG`

| Available for cities | Not available for cities                         |
|----------------------|--------------------------------------------------|
| `country`            | `via` (transport mode)                           |
| `economicBlock`      | `urf` (customs unit)                             |
| `state`              | `ncm` (full 8-digit NCM)                         |
| `city`               | `subHeading` (HS6)                               |
| `heading` (HS4)      | CGCE / SITC / ISIC classifications               |
| `chapter` (HS2)      | `metricStatistic`, `metricFreight`, `metricCIF`, |
| `section`            | `metricInsurance`                                |

User-friendly aliases — `bloc` / `economic_block`, `hs4` / `sh4`, `hs2`
/ `sh2` — are translated automatically by the package.

## 1. Headline totals (FOB and net weight)

Aggregate exports and imports for the period, with no detail grouping
beyond the year:

\
`exports_total`` ``<-`` `[`comex_query_city`](https://strategicprojects.github.io/comexr/reference/comex_query_city.md)`(`\
`  flow         ``=`` ``"export"``,`\
`  start_period ``=`` ``year_from``,`\
`  end_period   ``=`` ``year_to``,`\
`  filters      ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``city ``=`` ``city_code``)``,`\
`  month_detail ``=`` ``FALSE`\
`)`\
\
`imports_total`` ``<-`` `[`comex_query_city`](https://strategicprojects.github.io/comexr/reference/comex_query_city.md)`(`\
`  flow         ``=`` ``"import"``,`\
`  start_period ``=`` ``year_from``,`\
`  end_period   ``=`` ``year_to``,`\
`  filters      ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``city ``=`` ``city_code``)``,`\
`  month_detail ``=`` ``FALSE`\
`)`\
\
`exports_total`\
`imports_total`

The trade balance is just `metricFOB(export) - metricFOB(import)`:

\
`balance`` ``<-`` ``exports_total``$``metricFOB`` ``-`\
`           ``imports_total``$``metricFOB`

## 2. Top trading partners

The “Top countries” panel on the municipality page is a `country` group:

\
`top_export_countries`` ``<-`` `[`comex_query_city`](https://strategicprojects.github.io/comexr/reference/comex_query_city.md)`(`\
`  flow         ``=`` ``"export"``,`\
`  start_period ``=`` ``year_from``,`\
`  end_period   ``=`` ``year_to``,`\
`  details      ``=`` ``"country"``,`\
`  filters      ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``city ``=`` ``city_code``)``,`\
`  month_detail ``=`` ``FALSE`\
`)`\
\
`top_export_countries`` ``<-`` ``top_export_countries``[`\
`  `[`order`](https://rdrr.io/r/base/order.html)`(``-``top_export_countries``$``metricFOB``)``,`\
`]`\
[`head`](https://rdrr.io/r/utils/head.html)`(``top_export_countries``, ``10``)`\
\
`top_import_countries`` ``<-`` `[`comex_query_city`](https://strategicprojects.github.io/comexr/reference/comex_query_city.md)`(`\
`  flow         ``=`` ``"import"``,`\
`  start_period ``=`` ``year_from``,`\
`  end_period   ``=`` ``year_to``,`\
`  details      ``=`` ``"country"``,`\
`  filters      ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``city ``=`` ``city_code``)``,`\
`  month_detail ``=`` ``FALSE`\
`)`\
`top_import_countries`` ``<-`` ``top_import_countries``[`\
`  `[`order`](https://rdrr.io/r/base/order.html)`(``-``top_import_countries``$``metricFOB``)``,`\
`]`\
[`head`](https://rdrr.io/r/utils/head.html)`(``top_import_countries``, ``10``)`

## 3. Top economic blocs

The “Top blocs” panel groups by `economicBlock` (alias: `bloc`):

\
`exports_by_bloc`` ``<-`` `[`comex_query_city`](https://strategicprojects.github.io/comexr/reference/comex_query_city.md)`(`\
`  flow         ``=`` ``"export"``,`\
`  start_period ``=`` ``year_from``,`\
`  end_period   ``=`` ``year_to``,`\
`  details      ``=`` ``"bloc"``,`\
`  filters      ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``city ``=`` ``city_code``)``,`\
`  month_detail ``=`` ``FALSE`\
`)`\
\
`exports_by_bloc`` ``<-`` ``exports_by_bloc``[`\
`  `[`order`](https://rdrr.io/r/base/order.html)`(``-``exports_by_bloc``$``metricFOB``)``,`\
`]`\
`exports_by_bloc`

## 4. Top products (HS4 / heading)

Product detail goes down to HS4 (`heading`) for cities — HS6
(`subHeading`) is **not** available at this endpoint, and neither is the
full 8-digit NCM:

\
`top_export_products`` ``<-`` `[`comex_query_city`](https://strategicprojects.github.io/comexr/reference/comex_query_city.md)`(`\
`  flow         ``=`` ``"export"``,`\
`  start_period ``=`` ``year_from``,`\
`  end_period   ``=`` ``year_to``,`\
`  details      ``=`` ``"hs4"``,   ``# → heading`\
`  filters      ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``city ``=`` ``city_code``)``,`\
`  month_detail ``=`` ``FALSE`\
`)`\
\
`top_export_products`` ``<-`` ``top_export_products``[`\
`  `[`order`](https://rdrr.io/r/base/order.html)`(``-``top_export_products``$``metricFOB``)``,`\
`]`\
[`head`](https://rdrr.io/r/utils/head.html)`(``top_export_products``, ``10``)`

For a coarser cut, use `"hs2"` (chapter) or `"section"`:

\
`exports_by_section`` ``<-`` `[`comex_query_city`](https://strategicprojects.github.io/comexr/reference/comex_query_city.md)`(`\
`  flow         ``=`` ``"export"``,`\
`  start_period ``=`` ``year_from``,`\
`  end_period   ``=`` ``year_to``,`\
`  details      ``=`` ``"section"``,`\
`  filters      ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``city ``=`` ``city_code``)``,`\
`  month_detail ``=`` ``FALSE`\
`)`\
`exports_by_section`

## 5. Monthly time series

Set `month_detail = TRUE` (the default) to reproduce the time-series
chart on the page:

\
`exports_monthly`` ``<-`` `[`comex_query_city`](https://strategicprojects.github.io/comexr/reference/comex_query_city.md)`(`\
`  flow         ``=`` ``"export"``,`\
`  start_period ``=`` ``year_from``,`\
`  end_period   ``=`` ``year_to``,`\
`  filters      ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``city ``=`` ``city_code``)``,`\
`  month_detail ``=`` ``TRUE`\
`)`\
`exports_monthly``  ``# year, monthNumber, metricFOB, metricKG`

Plot it with whichever graphics package you prefer:

\
`# Example with base R`\
`exports_monthly``$``date`` ``<-`` `[`as.Date`](https://rdrr.io/r/base/as.Date.html)`(`\
`  `[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"%d-%02d-01"``, ``exports_monthly``$``year``, ``exports_monthly``$``monthNumber``)`\
`)`\
`exports_monthly``$``fob_musd`` ``<-`` ``exports_monthly``$``metricFOB`` ``/`` ``1e6`\
\
[`plot`](https://rdrr.io/r/graphics/plot.default.html)`(`\
`  ``exports_monthly``$``date``, ``exports_monthly``$``fob_musd``,`\
`  type ``=`` ``"b"``, pch ``=`` ``19``,`\
`  xlab ``=`` ``"Month"``, ylab ``=`` ``"Exports (US$ millions)"``,`\
`  main ``=`` `[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"Recife - PE exports, %s to %s"``, ``year_from``, ``year_to``)`\
`)`

## 6. Year-over-year comparison

To compare with prior years (the page typically shows a YoY change),
extend the period and group by year only:

\
`exports_yearly`` ``<-`` `[`comex_query_city`](https://strategicprojects.github.io/comexr/reference/comex_query_city.md)`(`\
`  flow         ``=`` ``"export"``,`\
`  start_period ``=`` ``"2019-01"``,`\
`  end_period   ``=`` ``"2024-12"``,`\
`  filters      ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``city ``=`` ``city_code``)``,`\
`  month_detail ``=`` ``FALSE`\
`)`\
`exports_yearly``  ``# one row per year`

## 7. Cross-cutting query: top destinations by product

You can combine details to drill in further — e.g. top destinations for
the city’s leading product:

\
`# 1. Find the top HS4`\
`top_hs4`` ``<-`` `[`head`](https://rdrr.io/r/utils/head.html)`(``top_export_products``, ``1``)``$``headingCode`\
\
`# 2. Break that product down by destination`\
`top_destinations_for_product`` ``<-`` `[`comex_query_city`](https://strategicprojects.github.io/comexr/reference/comex_query_city.md)`(`\
`  flow         ``=`` ``"export"``,`\
`  start_period ``=`` ``year_from``,`\
`  end_period   ``=`` ``year_to``,`\
`  details      ``=`` `[`c`](https://rdrr.io/r/base/c.html)`(``"country"``, ``"hs4"``)``,`\
`  filters      ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``city ``=`` ``city_code``, hs4 ``=`` ``top_hs4``)``,`\
`  month_detail ``=`` ``FALSE`\
`)`\
`top_destinations_for_product`

## Looking up the city code from a name

If you only have the city’s name, search the cities table:

\
`recife`` ``<-`` `[`comex_cities`](https://strategicprojects.github.io/comexr/reference/comex_cities.md)`(``)`\
`recife``[`[`grepl`](https://rdrr.io/r/base/grep.html)`(``"Recife"``, ``recife``$``text``, ignore.case ``=`` ``TRUE``)``, ``]`\
`` # Use the `id` column (IBGE coMunGeo) in subsequent filters. ``

For an authoritative single-city lookup (with state), use
\[[`comex_city_detail()`](https://strategicprojects.github.io/comexr/reference/comex_city_detail.md)\]:

\
[`comex_city_detail`](https://strategicprojects.github.io/comexr/reference/comex_city_detail.md)`(``2611606``)`\
`#> $coMunGeo  "2611606"`\
`#> $noMun     "RECIFE"`\
`#> $noMunMin  "Recife"`\
`#> $sgUf      "PE"`

## Tips

- City-level data follows the **declarant**’s municipality (where the
  exporter / importer is registered), not the origin or destination of
  the goods. A producer city and the declarant city can differ.
- The API caps responses to roughly 150,000 rows. If a query times out,
  add filters or shorten the date range.
- For deeper product detail (NCM, HS6) or for transport / customs-unit
  breakdowns, use
  \[[`comex_query()`](https://strategicprojects.github.io/comexr/reference/comex_query.md)\]
  /
  \[[`comex_export()`](https://strategicprojects.github.io/comexr/reference/comex_export.md)\]
  /
  \[[`comex_import()`](https://strategicprojects.github.io/comexr/reference/comex_import.md)\]
  on the general endpoint instead — but those do not accept a `city`
  filter.
