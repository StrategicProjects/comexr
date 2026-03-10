# Auxiliary Tables and Metadata

# =============================================================================
# METADATA
# =============================================================================

#' Get last data update date
#'
#' @description
#' Returns the date of the last data update in the API.
#'
#' @param type Data type: "general", "city", or "historical"
#' @param verbose Logical. If TRUE, display progress messages. Default: FALSE
#'
#' @return A list with last update information
#'
#' @examples
#' \dontrun{
#' comex_last_update()
#' comex_last_update(type = "city")
#' comex_last_update(type = "historical")
#' }
#'
#' @export
comex_last_update <- function(type = "general", verbose = FALSE) {
  endpoint <- switch(type,
    general = "/general/dates/updated",
    city = "/cities/dates/updated",
    historical = "/historical-data/dates/updated",
    cli::cli_abort("Invalid type: {type}. Use 'general', 'city', or 'historical'")
  )
  data <- execute_get(endpoint, verbose = verbose)
  extract_api_data(data)
}

#' Get available years for queries
#'
#' @description
#' Returns the first and last years available for queries in the API.
#'
#' @param type Data type: "general", "city", or "historical"
#' @param verbose Logical. If TRUE, display progress messages. Default: FALSE
#'
#' @return A list with minimum and maximum available years
#'
#' @examples
#' \dontrun{
#' comex_available_years()
#' comex_available_years(type = "city")
#' comex_available_years(type = "historical")
#' }
#'
#' @export
comex_available_years <- function(type = "general", verbose = FALSE) {
  endpoint <- switch(type,
    general = "/general/dates/years",
    city = "/cities/dates/years",
    historical = "/historical-data/dates/years",
    cli::cli_abort("Invalid type: {type}. Use 'general', 'city', or 'historical'")
  )
  data <- execute_get(endpoint, verbose = verbose)
  extract_api_data(data)
}

#' Get list of available filters
#'
#' @description
#' Returns the list of available filters for API queries.
#'
#' @param type Data type: "general", "city", or "historical"
#' @param language Language: "pt", "en", or "es". Default: "en"
#' @param verbose Logical. If TRUE, display progress messages. Default: FALSE
#'
#' @return A tibble with available filters
#'
#' @examples
#' \dontrun{
#' comex_filters()
#' comex_filters(type = "city")
#' comex_filters(type = "historical")
#' }
#'
#' @export
comex_filters <- function(type = "general", language = "en", verbose = FALSE) {
  endpoint <- switch(type,
    general = paste0("/general/filters?language=", language),
    city = paste0("/cities/filters?language=", language),
    historical = paste0("/historical-data/filters?language=", language),
    cli::cli_abort("Invalid type: {type}. Use 'general', 'city', or 'historical'")
  )
  data <- execute_get(endpoint, verbose = verbose)
  response_to_tibble(data, path = "data")
}

#' Get values for a specific filter
#'
#' @description
#' Returns the possible values for a specific filter. Not all filters listed
#' by [comex_filters()] have a values endpoint.
#'
#' @param filter Filter name. Available filters by type:
#'   \itemize{
#'     \item \strong{general}: "country", "economicBlock", "state", "urf",
#'       "ncm", "section"
#'     \item \strong{city}: "country", "economicBlock", "state", "city",
#'       "heading", "chapter", "section"
#'     \item \strong{historical}: "country", "state"
#'   }
#' @param type Data type: "general", "city", or "historical"
#' @param language Language: "pt", "en", or "es". Default: "en"
#' @param verbose Logical. If TRUE, display progress messages. Default: FALSE
#'
#' @return A tibble with filter values (id, text columns)
#'
#' @examples
#' \dontrun{
#' comex_filter_values("country")
#' comex_filter_values("state", type = "city")
#' comex_filter_values("heading", type = "city")
#' }
#'
#' @export
comex_filter_values <- function(filter, type = "general", language = "en", verbose = FALSE) {
  base_endpoint <- switch(type,
    general = "/general/filters",
    city = "/cities/filters",
    historical = "/historical-data/filters",
    cli::cli_abort("Invalid type: {type}. Use 'general', 'city', or 'historical'")
  )
  endpoint <- paste0(base_endpoint, "/", filter, "?language=", language)
  data <- execute_get(endpoint, verbose = verbose)
  response_to_tibble(data, path = "data")
}

#' Get list of available details
#'
#' @description
#' Returns the list of available detail/grouping fields.
#'
#' @param type Data type: "general", "city", or "historical"
#' @param language Language: "pt", "en", or "es". Default: "en"
#' @param verbose Logical. If TRUE, display progress messages. Default: FALSE
#'
#' @return A tibble with available details
#'
#' @examples
#' \dontrun{
#' comex_details()
#' comex_details(type = "city")
#' comex_details(type = "historical")
#' }
#'
#' @export
comex_details <- function(type = "general", language = "en", verbose = FALSE) {
  endpoint <- switch(type,
    general = paste0("/general/details?language=", language),
    city = paste0("/cities/details?language=", language),
    historical = paste0("/historical-data/details?language=", language),
    cli::cli_abort("Invalid type: {type}. Use 'general', 'city', or 'historical'")
  )
  data <- execute_get(endpoint, verbose = verbose)
  response_to_tibble(data, path = "data")
}

#' Get list of available metrics
#'
#' @description
#' Returns the list of available metrics for API queries.
#'
#' @param type Data type: "general", "city", or "historical"
#' @param language Language: "pt", "en", or "es". Default: "en"
#' @param verbose Logical. If TRUE, display progress messages. Default: FALSE
#'
#' @return A tibble with available metrics
#'
#' @examples
#' \dontrun{
#' comex_metrics()
#' comex_metrics(type = "city")
#' comex_metrics(type = "historical")
#' }
#'
#' @export
comex_metrics <- function(type = "general", language = "en", verbose = FALSE) {
  endpoint <- switch(type,
    general = paste0("/general/metrics?language=", language),
    city = paste0("/cities/metrics?language=", language),
    historical = paste0("/historical-data/metrics?language=", language),
    cli::cli_abort("Invalid type: {type}. Use 'general', 'city', or 'historical'")
  )
  data <- execute_get(endpoint, verbose = verbose)
  response_to_tibble(data, path = "data")
}

# =============================================================================
# AUXILIARY TABLES - GEOGRAPHY
# =============================================================================

#' Get countries table
#'
#' @description
#' Returns the countries table with codes and names.
#'
#' @param language Language: "pt", "en", or "es". Default: "en"
#' @param verbose Logical. If TRUE, display progress messages. Default: FALSE
#'
#' @return A tibble with country codes and names
#'
#' @examples
#' \dontrun{
#' comex_countries()
#' }
#'
#' @export
comex_countries <- function(language = "en", verbose = FALSE) {
  data <- execute_get(paste0("/tables/countries?language=", language), verbose = verbose)
  response_to_tibble(data, path = "data")
}

#' Get country details
#'
#' @description
#' Returns details for a specific country.
#'
#' @param id Country code
#' @param language Language: "pt", "en", or "es". Default: "en"
#' @param verbose Logical. If TRUE, display progress messages. Default: FALSE
#'
#' @return A list with country details
#'
#' @examples
#' \dontrun{
#' comex_country_detail(105)
#' }
#'
#' @export
comex_country_detail <- function(id, language = "en", verbose = FALSE) {
  data <- execute_get(paste0("/tables/countries/", id, "?language=", language), verbose = verbose)
  extract_api_data(data)
}

#' Get economic blocs table
#'
#' @description
#' Returns the economic blocs table with codes and names.
#'
#' @param language Language: "pt", "en", or "es". Default: "en"
#' @param verbose Logical. If TRUE, display progress messages. Default: FALSE
#'
#' @return A tibble with economic bloc codes and names
#'
#' @examples
#' \dontrun{
#' comex_blocs()
#' }
#'
#' @export
comex_blocs <- function(language = "en", verbose = FALSE) {
  data <- execute_get(paste0("/tables/economic-blocks?language=", language), verbose = verbose)
  response_to_tibble(data, path = "data")
}

#' Get Brazilian states table
#'
#' @description
#' Returns the Brazilian states table with codes and names.
#'
#' @param language Language: "pt", "en", or "es". Default: "en"
#' @param verbose Logical. If TRUE, display progress messages. Default: FALSE
#'
#' @return A tibble with state codes and names
#'
#' @examples
#' \dontrun{
#' comex_states()
#' }
#'
#' @export
comex_states <- function(language = "en", verbose = FALSE) {
  data <- execute_get(paste0("/tables/uf?language=", language), verbose = verbose)
  response_to_tibble(data, path = "data")
}

#' Get state details
#'
#' @description
#' Returns details for a specific Brazilian state.
#'
#' @param state_id State code or abbreviation
#' @param language Language: "pt", "en", or "es". Default: "en"
#' @param verbose Logical. If TRUE, display progress messages. Default: FALSE
#'
#' @return A list with state details
#'
#' @examples
#' \dontrun{
#' comex_state_detail("SP")
#' }
#'
#' @export
comex_state_detail <- function(state_id, language = "en", verbose = FALSE) {
  data <- execute_get(paste0("/tables/uf/", state_id, "?language=", language), verbose = verbose)
  extract_api_data(data)
}

#' Get Brazilian cities table
#'
#' @description
#' Returns the Brazilian cities table with codes and names.
#'
#' @param language Language: "pt", "en", or "es". Default: "en"
#' @param verbose Logical. If TRUE, display progress messages. Default: FALSE
#'
#' @return A tibble with city codes and names
#'
#' @examples
#' \dontrun{
#' comex_cities()
#' }
#'
#' @export
comex_cities <- function(language = "en", verbose = FALSE) {
  data <- execute_get(paste0("/tables/cities?language=", language), verbose = verbose)
  response_to_tibble(data, path = "data")
}

#' Get city details
#'
#' @description
#' Returns details for a specific Brazilian city.
#'
#' @param city_id IBGE city code
#' @param language Language: "pt", "en", or "es". Default: "en"
#' @param verbose Logical. If TRUE, display progress messages. Default: FALSE
#'
#' @return A list with city details
#'
#' @examples
#' \dontrun{
#' comex_city_detail(3550308)  # Sao Paulo
#' }
#'
#' @export
comex_city_detail <- function(city_id, language = "en", verbose = FALSE) {
  data <- execute_get(paste0("/tables/cities/", city_id, "?language=", language), verbose = verbose)
  extract_api_data(data)
}

#' Get transport modes table
#'
#' @description
#' Returns the transport modes table with codes and names.
#'
#' @param language Language: "pt", "en", or "es". Default: "en"
#' @param verbose Logical. If TRUE, display progress messages. Default: FALSE
#'
#' @return A tibble with transport mode codes and names
#'
#' @examples
#' \dontrun{
#' comex_transport_modes()
#' }
#'
#' @export
comex_transport_modes <- function(language = "en", verbose = FALSE) {
  data <- execute_get(paste0("/tables/ways?language=", language), verbose = verbose)
  response_to_tibble(data, path = "data")
}

#' Get transport mode details
#'
#' @description
#' Returns details for a specific transport mode.
#'
#' @param mode_id Transport mode code
#' @param language Language: "pt", "en", or "es". Default: "en"
#' @param verbose Logical. If TRUE, display progress messages. Default: FALSE
#'
#' @return A list with transport mode details
#'
#' @examples
#' \dontrun{
#' comex_transport_mode_detail(1)  # Maritime
#' }
#'
#' @export
comex_transport_mode_detail <- function(mode_id, language = "en", verbose = FALSE) {
  data <- execute_get(paste0("/tables/ways/", mode_id, "?language=", language), verbose = verbose)
  extract_api_data(data)
}

#' Get customs units (URF) table
#'
#' @description
#' Returns the customs units table with codes and names.
#'
#' @param language Language: "pt", "en", or "es". Default: "en"
#' @param verbose Logical. If TRUE, display progress messages. Default: FALSE
#'
#' @return A tibble with customs unit codes and names
#'
#' @examples
#' \dontrun{
#' comex_customs_units()
#' }
#'
#' @export
comex_customs_units <- function(language = "en", verbose = FALSE) {
  data <- execute_get(paste0("/tables/urf?language=", language), verbose = verbose)
  response_to_tibble(data, path = "data")
}

#' Get customs unit details
#'
#' @description
#' Returns details for a specific customs unit.
#'
#' @param urf_id Customs unit code
#' @param language Language: "pt", "en", or "es". Default: "en"
#' @param verbose Logical. If TRUE, display progress messages. Default: FALSE
#'
#' @return A list with customs unit details
#'
#' @examples
#' \dontrun{
#' comex_customs_unit_detail(817600)
#' }
#'
#' @export
comex_customs_unit_detail <- function(urf_id, language = "en", verbose = FALSE) {
  data <- execute_get(paste0("/tables/urf/", urf_id, "?language=", language), verbose = verbose)
  extract_api_data(data)
}
