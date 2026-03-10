#' Query general foreign trade data
#'
#' @description
#' Query the main ComexStat API endpoint to retrieve Brazilian export and
#' import data. Allows filtering and detailing by various classifications
#' such as NCM, Harmonized System, countries, states, etc.
#'
#' @param flow Trade flow type: "export" or "import"
#' @param start_period Start period in "YYYY-MM" format (e.g., "2023-01")
#' @param end_period End period in "YYYY-MM" format (e.g., "2023-12")
#' @param details Character vector with desired detail levels. Options:
#'   \itemize{
#'     \item Geographic: "country", "bloc", "state", "city", "transport_mode", "customs_unit"
#'     \item Products: "ncm", "hs6", "hs4", "hs2", "section"
#'     \item CGCE: "cgce_n1", "cgce_n2", "cgce_n3"
#'     \item SITC: "sitc_section", "sitc_chapter", "sitc_position", "sitc_subposition", "sitc_item"
#'     \item ISIC: "isic_section", "isic_division", "isic_group", "isic_class"
#'     \item Other: "company_size" (imports only)
#'   }
#' @param filters Named list with filters. Use the same names as details.
#'   Example: \code{list(country = c("160", "249"), state = c("SP", "RJ"))}
#' @param month_detail Logical. If TRUE, detail by month. Default: TRUE
#' @param metric_fob Logical. If TRUE, include FOB value (US$). Default: TRUE
#' @param metric_kg Logical. If TRUE, include net weight in kg. Default: TRUE
#' @param metric_statistic Logical. If TRUE, include statistical quantity. Default: FALSE
#' @param metric_freight Logical. If TRUE, include freight value (US$). Default: FALSE
#' @param metric_insurance Logical. If TRUE, include insurance value (US$). Default: FALSE
#' @param metric_cif Logical. If TRUE, include CIF value (US$). Default: FALSE
#' @param verbose Logical. If TRUE, display progress messages. Default: TRUE
#'
#' @return A tibble with query results
#'
#' @examples
#' \dontrun{
#' # Brazilian exports in 2023 by country (monthly by default)
#' comex_query(
#'   flow = "export",
#'   start_period = "2023-01",
#'   end_period = "2023-12",
#'   details = c("country")
#' )
#'
#' # Imports 2022-2023 by NCM, filtered by country
#' comex_query(
#'   flow = "import",
#'   start_period = "2022-01",
#'   end_period = "2023-12",
#'   details = c("ncm", "country"),
#'   filters = list(country = c("160", "249")),
#'   metric_cif = TRUE
#' )
#' }
#'
#' @export
comex_query <- function(flow = "export",
                        start_period,
                        end_period,
                        details = NULL,
                        filters = NULL,
                        month_detail = TRUE,
                        metric_fob = TRUE,
                        metric_kg = TRUE,
                        metric_statistic = FALSE,
                        metric_freight = FALSE,
                        metric_insurance = FALSE,
                        metric_cif = FALSE,
                        verbose = TRUE) {

  # Validations
  validate_period(start_period, end_period)
  flow_api <- convert_flow(flow)

  if (verbose) {
    cli::cli_alert_info(
      "Querying {if(flow_api == 'export') 'exports' else 'imports'} from {start_period} to {end_period}"
    )
  }

  # Build details in API format
  details_api <- build_details(details, type = "general")

  # Build filters in API format
  filters_api <- build_filters(filters, type = "general")

  # Build metrics in API format
  metrics_api <- build_metrics(
    metric_fob = metric_fob,
    metric_kg = metric_kg,
    metric_statistic = metric_statistic,
    metric_freight = metric_freight,
    metric_insurance = metric_insurance,
    metric_cif = metric_cif
  )

  # Request body in correct API format
  body <- list(
    flow = flow_api,
    monthDetail = month_detail,
    period = list(
      from = start_period,
      to = end_period
    ),
    filters = filters_api,
    details = details_api,
    metrics = metrics_api
  )

  # Execute query
  data <- execute_post("/general", body, verbose = verbose)

  # Convert to tibble
  result <- response_to_tibble(data)

  if (nrow(result) > 0 && verbose) {
    cli::cli_alert_success("{nrow(result)} records found")
  }

  result
}

#' Query exports
#'
#' @description
#' Shortcut for \code{comex_query()} with \code{flow = "export"}.
#'
#' @inheritParams comex_query
#'
#' @return A tibble with export data
#'
#' @examples
#' \dontrun{
#' # Exports in 2023 by country
#' comex_export(
#'   start_period = "2023-01",
#'   end_period = "2023-12",
#'   details = c("country")
#' )
#' }
#'
#' @export
comex_export <- function(start_period,
                         end_period,
                         details = NULL,
                         filters = NULL,
                         month_detail = TRUE,
                         metric_fob = TRUE,
                         metric_kg = TRUE,
                         metric_statistic = FALSE,
                         metric_freight = FALSE,
                         metric_insurance = FALSE,
                         metric_cif = FALSE,
                         verbose = TRUE) {

  comex_query(
    flow = "export",
    start_period = start_period,
    end_period = end_period,
    details = details,
    filters = filters,
    month_detail = month_detail,
    metric_fob = metric_fob,
    metric_kg = metric_kg,
    metric_statistic = metric_statistic,
    metric_freight = metric_freight,
    metric_insurance = metric_insurance,
    metric_cif = metric_cif,
    verbose = verbose
  )
}

#' Query imports
#'
#' @description
#' Shortcut for \code{comex_query()} with \code{flow = "import"}.
#'
#' @inheritParams comex_query
#'
#' @return A tibble with import data
#'
#' @examples
#' \dontrun{
#' # Imports in 2023 by country with CIF value
#' comex_import(
#'   start_period = "2023-01",
#'   end_period = "2023-12",
#'   details = c("country"),
#'   metric_cif = TRUE
#' )
#' }
#'
#' @export
comex_import <- function(start_period,
                         end_period,
                         details = NULL,
                         filters = NULL,
                         month_detail = TRUE,
                         metric_fob = TRUE,
                         metric_kg = TRUE,
                         metric_statistic = FALSE,
                         metric_freight = FALSE,
                         metric_insurance = FALSE,
                         metric_cif = FALSE,
                         verbose = TRUE) {

  comex_query(
    flow = "import",
    start_period = start_period,
    end_period = end_period,
    details = details,
    filters = filters,
    month_detail = month_detail,
    metric_fob = metric_fob,
    metric_kg = metric_kg,
    metric_statistic = metric_statistic,
    metric_freight = metric_freight,
    metric_insurance = metric_insurance,
    metric_cif = metric_cif,
    verbose = verbose
  )
}
