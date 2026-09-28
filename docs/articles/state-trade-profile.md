# Full state trade profile (Pernambuco example)

This vignette reproduces a complete state-level trade extract similar to
the one offered by the ComexStat web app, with the following combination
requested in the “By Municipality” panel:

- **Flow** — exports **and** imports
- **Period** — 2026 (January to current month), with monthly detail
- **Filter** — state of the declarant = **Pernambuco**
- **Detail** — state, city, HS4 (heading), section, HS2 (chapter),
  country
- **Metrics** — FOB (US\$) and net weight (kg)

> **City-level data refers to the declarant’s tax residence**, not the
> place where the goods were produced or purchased. The city endpoint
> only goes down to HS4 (heading) — full NCM and HS6 (subHeading) are
> not available for this view.

\
[`library`](https://rdrr.io/r/base/library.html)`(`[`comexr`](https://strategicprojects.github.io/comexr/)`)`

## 1. Look up the state code

Brazilian state codes follow the IBGE convention (`26` = Pernambuco). If
you don’t remember the code, query the table:

\
`states`` ``<-`` `[`comex_states`](https://strategicprojects.github.io/comexr/reference/comex_states.md)`(``)`\
`states``[``states``$``uf`` ``==`` ``"PE"``, ``]`\
`#>      text id uf`\
`#>  Pernambuco 26 PE`

## 2. Build the query parameters

\
`state_code`` ``<-`` ``26``                       ``# Pernambuco`\
`period_from`` ``<-`` ``"2026-01"`\
`period_to``   ``<-`` ``"2026-12"``               ``# API returns up to the latest update`\
\
`# These names are user-friendly aliases. The package translates each`\
`` # to the underlying API name (see `getting-started` vignette for the ``\
`# full mapping table):`\
`#   hs4     -> heading`\
`#   hs2     -> chapter`\
`detalhes`` ``<-`` `[`c`](https://rdrr.io/r/base/c.html)`(``"state"``, ``"city"``, ``"hs4"``, ``"section"``, ``"hs2"``, ``"country"``)`\
\
`filtros`` ``<-`` `[`list`](https://rdrr.io/r/base/list.html)`(``state ``=`` ``state_code``)`

## 3. Fetch exports and imports

The API serves one flow per request, so we make two calls and combine
the results:

\
`exp_pe`` ``<-`` `[`comex_query_city`](https://strategicprojects.github.io/comexr/reference/comex_query_city.md)`(`\
`  flow         ``=`` ``"export"``,`\
`  start_period ``=`` ``period_from``,`\
`  end_period   ``=`` ``period_to``,`\
`  details      ``=`` ``detalhes``,`\
`  filters      ``=`` ``filtros``,`\
`  month_detail ``=`` ``TRUE``,`\
`  metric_fob   ``=`` ``TRUE``,`\
`  metric_kg    ``=`` ``TRUE`\
`)`\
`exp_pe``$``flow`` ``<-`` ``"export"`\
\
`imp_pe`` ``<-`` `[`comex_query_city`](https://strategicprojects.github.io/comexr/reference/comex_query_city.md)`(`\
`  flow         ``=`` ``"import"``,`\
`  start_period ``=`` ``period_from``,`\
`  end_period   ``=`` ``period_to``,`\
`  details      ``=`` ``detalhes``,`\
`  filters      ``=`` ``filtros``,`\
`  month_detail ``=`` ``TRUE``,`\
`  metric_fob   ``=`` ``TRUE``,`\
`  metric_kg    ``=`` ``TRUE`\
`)`\
`imp_pe``$``flow`` ``<-`` ``"import"`\
\
`pe`` ``<-`` `[`rbind`](https://rdrr.io/r/base/cbind.html)`(``exp_pe``, ``imp_pe``)`

The resulting data frame has one row per **month × city × HS4 × country
× flow** combination:

\
[`str`](https://rdrr.io/r/utils/str.html)`(``pe``)`\
[`head`](https://rdrr.io/r/utils/head.html)`(``pe``)`

## 4. Cast metrics and add a date column

Metric columns already come back as numeric and `year`/`monthNumber` as
integer. Build a proper `Date` column for time-series analysis:

\
`pe``$``date`` ``<-`` `[`as.Date`](https://rdrr.io/r/base/as.Date.html)`(`[`sprintf`](https://rdrr.io/r/base/sprintf.html)`(``"%d-%02d-01"``, ``pe``$``year``, ``pe``$``monthNumber``)``)`

## 5. Monthly trade balance

\
`monthly`` ``<-`` `[`aggregate`](https://rdrr.io/r/stats/aggregate.html)`(``metricFOB`` ``~`` ``date`` ``+`` ``flow``, data ``=`` ``pe``, FUN ``=`` ``sum``)`\
`monthly_wide`` ``<-`` `[`reshape`](https://rdrr.io/r/stats/reshape.html)`(``monthly``, idvar ``=`` ``"date"``, timevar ``=`` ``"flow"``,`\
`                        direction ``=`` ``"wide"``)`\
[`names`](https://rdrr.io/r/base/names.html)`(``monthly_wide``)`` ``<-`` `[`c`](https://rdrr.io/r/base/c.html)`(``"date"``, ``"exports"``, ``"imports"``)`\
`monthly_wide``$``balance`` ``<-`` ``monthly_wide``$``exports`` ``-`` ``monthly_wide``$``imports`\
`monthly_wide`\
\
`# Base-R plot`\
[`with`](https://rdrr.io/r/base/with.html)`(``monthly_wide``, ``{`\
`  `[`plot`](https://rdrr.io/r/graphics/plot.default.html)`(``date``, ``exports`` ``/`` ``1e6``, type ``=`` ``"b"``, pch ``=`` ``19``, col ``=`` ``"steelblue"``,`\
`       ylim ``=`` `[`range`](https://rdrr.io/r/base/range.html)`(`[`c`](https://rdrr.io/r/base/c.html)`(``exports``, ``imports``)``, na.rm ``=`` ``TRUE``)`` ``/`` ``1e6``,`\
`       xlab ``=`` ``"Month"``, ylab ``=`` ``"US$ millions"``,`\
`       main ``=`` ``"Pernambuco: exports vs imports, 2026"``)`\
`  `[`lines`](https://rdrr.io/r/graphics/lines.html)`(``date``, ``imports`` ``/`` ``1e6``, type ``=`` ``"b"``, pch ``=`` ``17``, col ``=`` ``"tomato"``)`\
`  `[`legend`](https://rdrr.io/r/graphics/legend.html)`(``"topleft"``, legend ``=`` `[`c`](https://rdrr.io/r/base/c.html)`(``"Exports"``, ``"Imports"``)``,`\
`         col ``=`` `[`c`](https://rdrr.io/r/base/c.html)`(``"steelblue"``, ``"tomato"``)``, pch ``=`` `[`c`](https://rdrr.io/r/base/c.html)`(``19``, ``17``)``, bty ``=`` ``"n"``)`\
`}``)`

## 6. Top municipalities by flow

The package returns the city as `noMunMinsgUf` (e.g. “Goiana - PE”):

\
`exports_by_city`` ``<-`` `[`aggregate`](https://rdrr.io/r/stats/aggregate.html)`(``metricFOB`` ``~`` ``noMunMinsgUf``,`\
`                             data ``=`` `[`subset`](https://rdrr.io/r/base/subset.html)`(``pe``, ``flow`` ``==`` ``"export"``)``,`\
`                             FUN ``=`` ``sum``)`\
[`head`](https://rdrr.io/r/utils/head.html)`(``exports_by_city``[`[`order`](https://rdrr.io/r/base/order.html)`(``-``exports_by_city``$``metricFOB``)``, ``]``, ``10``)`\
\
`imports_by_city`` ``<-`` `[`aggregate`](https://rdrr.io/r/stats/aggregate.html)`(``metricFOB`` ``~`` ``noMunMinsgUf``,`\
`                             data ``=`` `[`subset`](https://rdrr.io/r/base/subset.html)`(``pe``, ``flow`` ``==`` ``"import"``)``,`\
`                             FUN ``=`` ``sum``)`\
[`head`](https://rdrr.io/r/utils/head.html)`(``imports_by_city``[`[`order`](https://rdrr.io/r/base/order.html)`(``-``imports_by_city``$``metricFOB``)``, ``]``, ``10``)`

## 7. Top products (HS4)

\
`exp_hs4`` ``<-`` `[`aggregate`](https://rdrr.io/r/stats/aggregate.html)`(`\
`  ``metricFOB`` ``~`` ``headingCode`` ``+`` ``heading``,`\
`  data ``=`` `[`subset`](https://rdrr.io/r/base/subset.html)`(``pe``, ``flow`` ``==`` ``"export"``)``,`\
`  FUN  ``=`` ``sum`\
`)`\
[`head`](https://rdrr.io/r/utils/head.html)`(``exp_hs4``[`[`order`](https://rdrr.io/r/base/order.html)`(``-``exp_hs4``$``metricFOB``)``, ``]``, ``10``)`\
\
`imp_hs4`` ``<-`` `[`aggregate`](https://rdrr.io/r/stats/aggregate.html)`(`\
`  ``metricFOB`` ``~`` ``headingCode`` ``+`` ``heading``,`\
`  data ``=`` `[`subset`](https://rdrr.io/r/base/subset.html)`(``pe``, ``flow`` ``==`` ``"import"``)``,`\
`  FUN  ``=`` ``sum`\
`)`\
[`head`](https://rdrr.io/r/utils/head.html)`(``imp_hs4``[`[`order`](https://rdrr.io/r/base/order.html)`(``-``imp_hs4``$``metricFOB``)``, ``]``, ``10``)`

## 8. Top trading partners (countries)

\
`exp_country`` ``<-`` `[`aggregate`](https://rdrr.io/r/stats/aggregate.html)`(``metricFOB`` ``~`` ``country``,`\
`                         data ``=`` `[`subset`](https://rdrr.io/r/base/subset.html)`(``pe``, ``flow`` ``==`` ``"export"``)``,`\
`                         FUN  ``=`` ``sum``)`\
[`head`](https://rdrr.io/r/utils/head.html)`(``exp_country``[`[`order`](https://rdrr.io/r/base/order.html)`(``-``exp_country``$``metricFOB``)``, ``]``, ``10``)`\
\
`imp_country`` ``<-`` `[`aggregate`](https://rdrr.io/r/stats/aggregate.html)`(``metricFOB`` ``~`` ``country``,`\
`                         data ``=`` `[`subset`](https://rdrr.io/r/base/subset.html)`(``pe``, ``flow`` ``==`` ``"import"``)``,`\
`                         FUN  ``=`` ``sum``)`\
[`head`](https://rdrr.io/r/utils/head.html)`(``imp_country``[`[`order`](https://rdrr.io/r/base/order.html)`(``-``imp_country``$``metricFOB``)``, ``]``, ``10``)`

## 9. Cross-cuts (country × product, city × product)

Because `pe` already contains the full set of details, any deeper cut is
just a matter of
[`aggregate()`](https://rdrr.io/r/stats/aggregate.html):

\
`# Top product for each top destination`\
`exp_country_hs4`` ``<-`` `[`aggregate`](https://rdrr.io/r/stats/aggregate.html)`(`\
`  ``metricFOB`` ``~`` ``country`` ``+`` ``heading``,`\
`  data ``=`` `[`subset`](https://rdrr.io/r/base/subset.html)`(``pe``, ``flow`` ``==`` ``"export"``)``,`\
`  FUN  ``=`` ``sum`\
`)`\
`exp_country_hs4`` ``<-`` ``exp_country_hs4``[`\
`  `[`order`](https://rdrr.io/r/base/order.html)`(``exp_country_hs4``$``country``, ``-``exp_country_hs4``$``metricFOB``)``,`\
`]`\
[`do.call`](https://rdrr.io/r/base/do.call.html)`(``rbind``, `[`lapply`](https://rdrr.io/r/base/lapply.html)`(`\
`  `[`split`](https://rdrr.io/r/base/split.html)`(``exp_country_hs4``, ``exp_country_hs4``$``country``)``,`\
`  ``function``(``x``)`` `[`head`](https://rdrr.io/r/utils/head.html)`(``x``, ``1``)`\
`)``)`\
\
`# Top destination for each Pernambuco municipality`\
`exp_city_country`` ``<-`` `[`aggregate`](https://rdrr.io/r/stats/aggregate.html)`(`\
`  ``metricFOB`` ``~`` ``noMunMinsgUf`` ``+`` ``country``,`\
`  data ``=`` `[`subset`](https://rdrr.io/r/base/subset.html)`(``pe``, ``flow`` ``==`` ``"export"``)``,`\
`  FUN  ``=`` ``sum`\
`)`\
`exp_city_country`` ``<-`` ``exp_city_country``[`\
`  `[`order`](https://rdrr.io/r/base/order.html)`(``exp_city_country``$``noMunMinsgUf``, ``-``exp_city_country``$``metricFOB``)``,`\
`]`\
[`do.call`](https://rdrr.io/r/base/do.call.html)`(``rbind``, `[`lapply`](https://rdrr.io/r/base/lapply.html)`(`\
`  `[`split`](https://rdrr.io/r/base/split.html)`(``exp_city_country``, ``exp_city_country``$``noMunMinsgUf``)``,`\
`  ``function``(``x``)`` `[`head`](https://rdrr.io/r/utils/head.html)`(``x``, ``1``)`\
`)``)`

## 10. Year-over-year comparison

To compare with previous years, just widen the date range and drop
`month_detail`:

\
`yearly_exp`` ``<-`` `[`comex_query_city`](https://strategicprojects.github.io/comexr/reference/comex_query_city.md)`(`\
`  flow         ``=`` ``"export"``,`\
`  start_period ``=`` ``"2019-01"``,`\
`  end_period   ``=`` ``"2026-12"``,`\
`  details      ``=`` ``"state"``,`\
`  filters      ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``state ``=`` ``state_code``)``,`\
`  month_detail ``=`` ``FALSE`\
`)`\
`yearly_imp`` ``<-`` `[`comex_query_city`](https://strategicprojects.github.io/comexr/reference/comex_query_city.md)`(`\
`  flow         ``=`` ``"import"``,`\
`  start_period ``=`` ``"2019-01"``,`\
`  end_period   ``=`` ``"2026-12"``,`\
`  details      ``=`` ``"state"``,`\
`  filters      ``=`` `[`list`](https://rdrr.io/r/base/list.html)`(``state ``=`` ``state_code``)``,`\
`  month_detail ``=`` ``FALSE`\
`)`\
`yearly_exp``$``flow`` ``<-`` ``"export"``; ``yearly_imp``$``flow`` ``<-`` ``"import"`\
`yearly`` ``<-`` `[`rbind`](https://rdrr.io/r/base/cbind.html)`(``yearly_exp``, ``yearly_imp``)`\
`yearly``  ``# one row per year × flow`

## 11. Adapt to any state

The same code works for any Brazilian state — change only `state_code`
and the date range. To get the code interactively:

\
[`comex_filter_values`](https://strategicprojects.github.io/comexr/reference/comex_filter_values.md)`(``"state"``, type ``=`` ``"city"``)`

For analyses that require finer product detail (NCM, HS6) or other
classifications (CGCE, SITC, ISIC), use
\[[`comex_query()`](https://strategicprojects.github.io/comexr/reference/comex_query.md)\]
/
\[[`comex_export()`](https://strategicprojects.github.io/comexr/reference/comex_export.md)\]
/
\[[`comex_import()`](https://strategicprojects.github.io/comexr/reference/comex_import.md)\]
on the general endpoint — but those do **not** accept a city filter.
