#' @keywords internal
#' @aliases comexr-package
"_PACKAGE"

#' @section Package Options:
#' \describe{
#'   \item{`comex.ssl_verifypeer`}{Logical. Whether to verify the API server's
#'     SSL certificate. Defaults to `TRUE`. Set to `FALSE` if you encounter
#'     certificate errors on systems that lack the ICP-Brasil CA chain:
#'     \code{options(comex.ssl_verifypeer = FALSE)}.
#'     The package will also auto-detect SSL failures and retry without
#'     verification, issuing a one-time warning.}
#' }

## API base URL (internal)
.base_url <- "https://api-comexstat.mdic.gov.br"
