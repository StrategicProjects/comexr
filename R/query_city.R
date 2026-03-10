#' Query foreign trade data by city
#'
#' @description
#' Query the city endpoint of the ComexStat API. City-level data has
#' more limited detail options than general data.
#'
#' @param flow Trade flow type: "export" or "import"
#' @param start_period Start period in "YYYY-MM" format (e.g., "2023-01")
#' @param end_period End period in "YYYY-MM" format (e.g., "2023-12")
#' @param details Character vector with desired detail levels. Options for city data:
#'   \itemize{
#'     \item Geographic: "country", "economic_block", "state", "city"
#'     \item Products: "heading" (SH4), "chapter" (SH2), "section"
#'   }
#' @param filters Named list with filters.
#' @param month_detail Logical. If TRUE, detail by month. Default: TRUE
#' @param metric_fob Logical. If TRUE, include FOB value (US$). Default: TRUE
#' @param metric_kg Logical. If TRUE, include net weight in kg. Default: TRUE
#' @param metric_statistic Logical. If TRUE, include statistical quantity. Default: FALSE
#' @param verbose Logical. If TRUE, display progress messages. Default: TRUE
#'
#' @return A tibble with query results
#'
#' @details
#' City-level data has important differences from general data:
#' \itemize{
#'   \item Product details use different names: "heading" (≈SH4),
#'     "chapter" (≈SH2), "section" — NOT "hs6"/"hs4"/"hs2"/"ncm"
#'   \item "economic_block" (or "economicBlock") is available
#'   \item Classifications (CGCE, SITC, ISIC) are NOT available
#'   \item Only FOB, KG, and statistical quantity metrics are available
#' }
#'
#' @examples
#' \dontrun{
#' # Exports from Pernambuco in 2023 by country
#' comex_query_city(
#'   flow = "export",
#'   start_period = "2023-01",
#'   end_period = "2023-12",
#'   details = c("state", "country"),
#'   filters = list(state = 26)
#' )
#' }
#'
#' @export
comex_query_city <- function(flow = "export",
                             start_period,
                             end_period,
                             details = NULL,
                             filters = NULL,
                             month_detail = TRUE,
                             metric_fob = TRUE,
                             metric_kg = TRUE,
                             metric_statistic = FALSE,
                             verbose = TRUE) {

  # Validations
  validate_period(start_period, end_period)
  flow_api <- convert_flow(flow)

  if (verbose) {
    cli::cli_alert_info(
      "Querying city-level {if(flow_api == 'export') 'exports' else 'imports'} from {start_period} to {end_period}"
    )
  }

  # Build details in API format
  details_api <- build_details(details, type = "city")

  # Build filters in API format
  filters_api <- build_filters(filters, type = "city")

  # Build metrics (city endpoint has fewer metrics)
  metrics <- c()
  if (metric_fob) metrics <- c(metrics, "metricFOB")
  if (metric_kg) metrics <- c(metrics, "metricKG")
  if (metric_statistic) metrics <- c(metrics, "metricStatistic")

  if (length(metrics) == 0) {
    cli::cli_abort("At least one metric must be selected")
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
    metrics = metrics
  )

  # Execute query
  data <- execute_post("/cities", body, verbose = verbose)

  # Convert to tibble
  result <- response_to_tibble(data)

  if (nrow(result) > 0 && verbose) {
    cli::cli_alert_success("{nrow(result)} records found")
  }

  result
}
