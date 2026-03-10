# Initialize session for API calls

Starts a browser session using rvest's read_html_live() and solves the
Cloudflare challenge. All API calls will be made via this session.

## Usage

``` r
comex_init(force = FALSE)
```

## Arguments

- force:

  If TRUE, close existing session and create new one. Default: FALSE

## Value

Invisibly returns TRUE on success

## Details

This function uses
[`rvest::read_html_live()`](https://rvest.tidyverse.org/reference/read_html_live.html)
which internally uses chromote to create a headless Chrome session. The
session navigates to the API domain to solve Cloudflare's JavaScript
challenge.

The session stays open and is reused for all subsequent API calls. Call
[`comex_close()`](https://strategicprojects.github.io/comexr/reference/comex_close.md)
when done to free resources.

## Note

Requires the `rvest` package (\>= 1.0.0) and Chrome/Chromium browser.

## Examples

``` r
if (FALSE) { # \dontrun{
# Initialize session (called automatically on first API call)
comex_init()

# Make API calls
years <- comex_available_years()

# Close when done
comex_close()
} # }
```
