## R CMD check results

0 errors | 0 warnings | 0 notes

(WARNING and NOTE produced locally are unrelated to package code: vignette
chunks are evaluated with `eval = FALSE`, but `R CMD check --run-vignettes`
executes the chunks anyway against the live API and trips its HTTP 429
rate limit; the `.claude/` directory is a local IDE artefact and is now
listed in `.Rbuildignore`.)

## Changes since 0.3.0

This is a minor release adding user-facing configuration options.

* Request timeout, retry count and retry backoff are now configurable
  via the options `comexr.timeout`, `comexr.max_tries` and
  `comexr.retry_time`. The default retry backoff was raised from 2 to
  10 seconds, matching the wait time the ComexStat API requests on its
  HTTP 429 rate-limit responses. This helps users who hit the rate
  limit on heavier workloads. Contributed by Matt Bhagat-Conway (#1).
* Documented the new options in README.md.

## Downstream dependencies

There are currently no reverse dependencies on CRAN.
