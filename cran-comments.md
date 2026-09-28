## R CMD check results

0 errors | 0 warnings | 0 notes

All examples and vignette chunks that call the live ComexStat API are
wrapped in `\dontrun{}` / `eval = FALSE`, because the API rate-limits
aggressively (HTTP 429). The test suite runs fully offline.

## Changes since 0.3.0 (current CRAN version)

* Fixes a failure on R < 4.4.0: the internal error handler used `%||%`,
  which base R only provides from 4.4.0. The package now defines it.
* Fixes `comex_historical()`, which failed with HTTP 403 because the
  API now blocks its old endpoint URL (trailing slash).
* SSL verification is no longer disabled automatically or written to a
  global option; users opt out explicitly via
  `options(comexr.ssl_verifypeer = FALSE)`.
* Query results are now typed (numeric metrics, integer year/month).
* Faster response parsing, stricter argument validation, and a new
  offline testthat suite.
* Request timeout, retry count and backoff are configurable via options
  (contributed by Matt Bhagat-Conway).

## Downstream dependencies

There are currently no reverse dependencies on CRAN.
