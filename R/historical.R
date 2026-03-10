#' Query historical foreign trade data
#'
#' @description
#' Query the historical data endpoint of the ComexStat API to retrieve
#' Brazilian export and import data from 1989 to 1996, before the SISCOMEX system.
#'
#' @param flow Trade flow type: "export" or "import"
#' @param start_period Start period in "YYYY-MM" format (e.g., "1995-01")
#' @param end_period End period in "YYYY-MM" format (e.g., "1996-12")
#' @param details Character vector with desired detail levels. Options for historical data:
#'   \itemize{
#'     \item "country"
#'     \item "state"
#'     \item "nbm"
#'   }
#' @param filters Named list with filters.
#' @param month_detail Logical. If TRUE, detail by month. Default: TRUE
#' @param metric_fob Logical. If TRUE, include FOB value (US$). Default: TRUE
#' @param metric_kg Logical. If TRUE, include net weight in kg. Default: TRUE
#' @param verbose Logical. If TRUE, display progress messages. Default: TRUE
#'
#' @return A tibble with historical query results
#'
#' @details
#' Historical data has important differences from general data:
#' \itemize{
#'   \item Available period: 1989 to 1996
#'   \item Limited details: only "country", "state", and "nbm"
#'   \item Only FOB and KG metrics are available (no statistic, freight,
#'     insurance, or CIF)
#'   \item "section" is NOT a valid detail for historical queries
#' }
#'
#' @examples
#' \dontrun{
#' # Historical exports 1995-1996 by country
#' comex_historical(
#'   flow = "export",
#'   start_period = "1995-01",
#'   end_period = "1996-12",
#'   details = c("country")
#' )
#'
#' # Historical imports with multiple metrics
#' comex_historical(
#'   flow = "import",
#'   start_period = "1990-01",
#'   end_period = "1992-12",
#'   details = c("ncm", "country"),
#'   metric_cif = TRUE
#' )
#' }
#'
#' @export
comex_historical <- function(flow = "export",
                             start_period,
                             end_period,
                             details = NULL,
                             filters = NULL,
                             month_detail = TRUE,
                             metric_fob = TRUE,
                             metric_kg = TRUE,
                             verbose = TRUE) {

  # Validations
  validate_period(start_period, end_period)
  flow_api <- convert_flow(flow)

  # Validate year range for historical data
  start_year <- as.integer(substr(start_period, 1, 4))
  end_year <- as.integer(substr(end_period, 1, 4))

  if (start_year < 1989 || end_year > 1996) {
    cli::cli_warn(c(
      "!" = "Historical data is available from 1989 to 1996",
      "i" = "Requested period: {start_period} to {end_period}"
    ))
  }

  if (verbose) {
    cli::cli_alert_info(
      "Querying historical {if(flow_api == 'export') 'exports' else 'imports'} from {start_period} to {end_period}"
    )
  }

  # Build details in API format
  details_api <- build_details(details, type = "historical")

  # Build filters in API format
  filters_api <- build_filters(filters, type = "historical")

  # Historical only supports FOB and KG
  metrics <- character()
  if (metric_fob) metrics <- c(metrics, "metricFOB")
  if (metric_kg)  metrics <- c(metrics, "metricKG")
  if (length(metrics) == 0) {
    cli::cli_abort("At least one metric must be selected (metric_fob or metric_kg)")
  }

  # Request body
  body <- list(
    flow = flow_api,
    monthDetail = month_detail,
    period = list(
      from = start_period,
      to = end_period
    ),
    filters = filters_api,
    details = details_api,
    metrics = as.list(metrics)
  )

  # Execute query
  data <- execute_post("/historical-data/", body, verbose = verbose)

  # Convert to tibble
  result <- response_to_tibble(data)

  if (nrow(result) > 0 && verbose) {
    cli::cli_alert_success("{nrow(result)} records found")
  }

  result
}
