# Extract data from double-wrapped browser response

Browser wrapper returns nested lists with API envelope inside. This
helper extracts the inner data field, handling several patterns:

- Named data (e.g. country detail): return as-is

- Unnamed single-element list (e.g. NCM detail): unwrap first element

- NULL → return NULL

## Usage

``` r
extract_api_data(response)
```
