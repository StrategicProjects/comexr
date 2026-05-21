## R CMD check results

0 errors | 0 warnings | 0 notes

(WARNING and NOTE produced locally are unrelated to package code: vignette
chunks are evaluated with `eval = FALSE`, but `R CMD check --run-vignettes`
executes the chunks anyway against the live API and trips its HTTP 429
rate limit; the `.claude/` directory is a local IDE artefact and is now
listed in `.Rbuildignore`.)

## Changes since 0.2.1

This release fixes a critical compatibility issue. After exhaustive
testing against the live ComexStat API, several user-friendly
detail/filter aliases were found to map to identifiers the API now
rejects with HTTP 400 ("Invalid detail item"). This made `comex_query()`,
`comex_export()`, `comex_import()` and `comex_query_city()` fail for
several common groupings. The release corrects the mapping and the
accompanying documentation.

### Breaking changes

* `.details_map` (internal) updated to match the names returned by
  `/general/details`, `/general/filters`, `/cities/filters` and
  `/historical-data/filters`:
    - `"transport_mode"` now maps to `via` (was `transportMode`).
    - `"hs6"` / `"sh6"` → `subHeading` (was `sh6`).
    - `"hs4"` / `"sh4"` → `heading` (was `sh4`).
    - `"hs2"` / `"sh2"` → `chapter` (was `sh2`).
    - `"cgce_n1"` / `"cgce_n2"` / `"cgce_n3"` → `BECLevel1` / `BECLevel2`
      / `BECLevel3` (was `cgceN1` / `cgceN2` / `cgceN3`).
    - `"sitc_*"` / `"cuci_*"` → `SITCSection` / `SITCDivision` /
      `SITCGroup` / `SITCSubGroup` / `SITCBasicHeading` (was
      `cuciSection` / `cuciChapter` / etc.).
    - `"isic_*"` → `ISICSection` / `ISICDivision` / `ISICGroup` /
      `ISICClass` (was lowercase `isicSection` etc.).
* `comex_query_city()`: removed the `metric_statistic` parameter; the
  city endpoint only supports `metricFOB` and `metricKG`.
* `comex_isic()`: rewritten to call `/general/filters/ISIC*`, the only
  place the API exposes ISIC values. The function now takes a `level`
  argument (`"section"`, `"division"`, `"group"`, `"class"`).

### Documentation

* Detail-list documentation in `comex_query()`, `comex_query_city()`
  and `comex_historical()` rewritten to show both the user-friendly
  alias and the actual API name.
* `comex_query_city()`: corrected — HS6 is **not** available for the
  city endpoint; product detail goes only down to HS4 (heading).
* `comex_filter_values()`: clarified that the `filter` argument is
  case-sensitive and must match `comex_filters()` output verbatim.
* New vignette `city-profile.Rmd` showing how to reproduce the
  public ComexStat municipality page using `comex_query_city()`.

### Misc

* Bumped `Date` to 2026-05-21.
* Added `.claude/` to `.Rbuildignore`.

## Downstream dependencies

There are currently no reverse dependencies on CRAN.
