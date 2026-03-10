## R CMD check results

0 errors | 0 warnings | 1 note

* This is a resubmission.

## Resubmission

This is a resubmission. Changes since last submission:

1. Fixed SSL certificate handling: the ComexStat API uses the ICP-Brasil
   certificate chain, which is not present in the CA bundle of all systems.
   Added automatic fallback with a one-time warning and a user-configurable
   option (`options(comex.ssl_verifypeer = FALSE)`).
2. Fixed API parameter mapping based on exhaustive testing against the
   live API, which revealed discrepancies with the official documentation:
   - Corrected detail name mapping (`bloc` now correctly maps to
     `economicBlock`; added `heading`, `chapter`, `nbm` mappings).
   - Restricted `comex_historical()` to only FOB and KG metrics, which
     are the only ones accepted by the historical endpoint.
   - Corrected `comex_query_city()` documentation to reflect the actual
     detail names accepted by the city endpoint (`heading`, `chapter`,
     `section` instead of `hs4`, `hs2`).
   - Updated `comex_filter_values()` documentation to list only the
     filters that actually have a values endpoint.
   - Fixed response parsing for fields containing NULL or list values.


# Dear Konstanze,

Thank you for the review. I have addressed all the points:

1. Removed the redundant "R" from both the title and the description.
2. Expanded all acronyms in the description text (NCM, NBM, HS, CGCE, SITC, ISIC, MDIC).
3. Added the API web reference in angle brackets.
