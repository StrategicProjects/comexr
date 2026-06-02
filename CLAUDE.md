# comexr — Claude context

R client for the Brazilian ComexStat foreign-trade API
(`https://api-comexstat.mdic.gov.br`). Single-author package
(StrategicProjects/comexr on GitHub). Two runtime deps: `httr2` + `cli`.

## Verifying the live API

The OpenAPI docs at `/docs`, `/docs/doc.yaml`, `/openapi.json`, etc.
are **Cloudflare-blocked** (HTTP 403) from CLI clients. The actual
API endpoints respond fine. When you need to confirm behaviour or
parameter names, probe the live endpoints directly — they are the
source of truth, not the unreachable spec.

Authoritative sources for filter/detail/metric names:
* `GET /general/filters`, `/general/details`, `/general/metrics`
* `GET /cities/filters`, `/cities/details`, `/cities/metrics`
* `GET /historical-data/filters`, `/historical-data/details`,
  `/historical-data/metrics`

Use `/usr/bin/curl` (the system curl). The shell alias in this env
points to something that errors out.

The API rate-limits aggressively: HTTP 429 with body `"Você excedeu
o limite de solicitações. Por favor, tente novamente em 10
segundos."` Since 0.3.1 the package's own retry/timeout behaviour is
user-configurable via options (`R/utils.R`, both `comex_get` and
`comex_post`):

* `comexr.timeout`    — `req_timeout` (default 60 for GET, 120 for POST)
* `comexr.max_tries`  — `req_retry(max_tries=)` (default 3)
* `comexr.retry_time` — `req_retry(backoff=)` in seconds (default 10,
  matching the API's 429 wait; was 2 before 0.3.1)

For ad-hoc CLI probing use a retry loop:

```bash
while /usr/bin/curl -sS "$URL" -o /tmp/r.json && grep -q "429" /tmp/r.json; do
  sleep 15
done
```

Same caveat applies inside vignette chunks — they are all set
`eval = FALSE` because `R CMD check --run-vignettes` ignores that
and trips the rate limit, producing a spurious WARNING.

## The `.details_map` invariant

`R/utils.R` keeps a translation table from user-friendly aliases
(`hs4`, `transport_mode`, `cgce_n1`, …) to the API's internal names
(`heading`, `via`, `BECLevel1`, …). The mapping has been wrong
historically (0.2.x mapped `transport_mode` → `transportMode`, which
the API rejects with HTTP 400). Before changing or adding to the
map, verify each destination is valid by POSTing to `/general` (or
`/cities`, `/historical-data/`) with `details: ["<name>"]` and
checking for a 200 with data vs. `"Invalid detail item (...)"`.

The map also maps every API name to itself, so users who already
know the API name can pass it verbatim.

## Local dev requirements

`roxygen2` and `pkgdown` aren't pre-installed in this environment.
Install on demand:

```r
install.packages(c("roxygen2", "pkgdown"), repos = "https://cloud.r-project.org/")
```

Standard refresh cycle after editing `R/`:
1. `Rscript -e 'roxygen2::roxygenise()'`
2. `Rscript -e 'pkgdown::build_site(override = list(eval_articles = FALSE), preview = FALSE)'`
3. `cd .. && R CMD build comexr && _R_CHECK_FORCE_SUGGESTS_=false R CMD check --no-manual --no-build-vignettes comexr_*.tar.gz`

## Release checklist (for future bumps)

* `DESCRIPTION` — bump `Version` and `Date`
* `NEWS.md` — new top-level section
* `cran-comments.md` — rewrite for the new submission
* `roxygen2::roxygenise()` for `man/*.Rd`
* `pkgdown::build_site(...)` to refresh `docs/`
* `R CMD check` clean (modulo the live-API vignette WARNING)
* Commit, push, then submit tarball to CRAN
