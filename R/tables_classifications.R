# Economic Classification Tables

# =============================================================================
# CGCE - CLASSIFICATION BY BROAD ECONOMIC CATEGORIES
# =============================================================================

#' Get CGCE (Classification by Broad Economic Categories) tables
#'
#' @description
#' Returns tables from the Classification by Broad Economic Categories.
#' Use the \code{level} parameter to specify the desired aggregation level.
#'
#' @param level Aggregation level (optional). If NULL, returns all levels.
#'   Options: "n1", "n2", "n3"
#' @param language Language: "pt", "en", or "es". Default: "en"
#' @param verbose Logical. If TRUE, display progress messages. Default: FALSE
#'
#' @return A tibble with CGCE codes and descriptions
#'
#' @details
#' CGCE groups products by use or economic purpose. It is used for
#' foreign trade analysis by economic category.
#'
#' \itemize{
#'   \item \strong{n1}: First level (most aggregated)
#'   \item \strong{n2}: Second level
#'   \item \strong{n3}: Third level (most detailed)
#' }
#'
#' @examples
#' \dontrun{
#' # All CGCE levels
#' comex_cgce()
#'
#' # CGCE level 1
#' comex_cgce(level = "n1")
#'
#' # CGCE level 3 (most detailed)
#' comex_cgce(level = "n3")
#' }
#'
#' @export
comex_cgce <- function(level = NULL, language = "en", verbose = FALSE) {
  if (!is.null(level)) {
    valid_levels <- c("n1", "n2", "n3")

    if (!level %in% valid_levels) {
      cli::cli_abort(c(
        "x" = "Invalid level: {level}",
        "i" = "Valid values: {paste(valid_levels, collapse = ', ')}"
      ))
    }

    # Map level to API type
    api_type <- switch(level,
      n1 = "cgceN1",
      n2 = "cgceN2",
      n3 = "cgceN3"
    )

    endpoint <- paste0("/tables/classifications?type=", api_type, "&language=", language)
  } else {
    endpoint <- paste0("/tables/classifications?language=", language)
  }

  data <- execute_get(endpoint, verbose = verbose)
  response_to_tibble(data, path = "data")
}

# =============================================================================
# SITC - STANDARD INTERNATIONAL TRADE CLASSIFICATION
# =============================================================================

#' Get SITC (Standard International Trade Classification) tables
#'
#' @description
#' Returns SITC tables. Use the \code{level} parameter to
#' specify the desired aggregation level.
#'
#' @param level Aggregation level (optional). If NULL, returns all levels.
#'   Options: "section", "chapter", "position", "subposition", "item"
#' @param language Language: "pt", "en", or "es". Default: "en"
#' @param verbose Logical. If TRUE, display progress messages. Default: FALSE
#'
#' @return A tibble with SITC codes and descriptions
#'
#' @details
#' SITC (Standard International Trade Classification) is a UN
#' classification for international trade statistics.
#'
#' \itemize{
#'   \item \strong{section}: Section - 1 digit (10 sections)
#'   \item \strong{chapter}: Chapter/Division - 2 digits
#'   \item \strong{position}: Group/Position - 3 digits
#'   \item \strong{subposition}: Subgroup - 4 digits
#'   \item \strong{item}: Item - 5 digits (most detailed)
#' }
#'
#' @examples
#' \dontrun{
#' # All SITC levels
#' comex_sitc()
#'
#' # SITC sections
#' comex_sitc(level = "section")
#'
#' # SITC items (most detailed)
#' comex_sitc(level = "item")
#' }
#'
#' @export
comex_sitc <- function(level = NULL, language = "en", verbose = FALSE) {
  if (!is.null(level)) {
    valid_levels <- c("section", "chapter", "position", "subposition", "item")

    if (!level %in% valid_levels) {
      cli::cli_abort(c(
        "x" = "Invalid level: {level}",
        "i" = "Valid values: {paste(valid_levels, collapse = ', ')}"
      ))
    }

    # Map level to API type
    api_type <- switch(level,
      section = "cuciSection",
      chapter = "cuciChapter",
      position = "cuciPosition",
      subposition = "cuciSubposition",
      item = "cuciItem"
    )

    endpoint <- paste0("/tables/product-categories?type=", api_type, "&language=", language)
  } else {
    endpoint <- paste0("/tables/product-categories?language=", language)
  }

  data <- execute_get(endpoint, verbose = verbose)
  response_to_tibble(data, path = "data")
}

# =============================================================================
# ISIC - INTERNATIONAL STANDARD INDUSTRIAL CLASSIFICATION
# =============================================================================

#' Get ISIC (International Standard Industrial Classification) tables
#'
#' @description
#' Returns ISIC tables. Use the \code{level} parameter to
#' specify the desired aggregation level.
#'
#' @param level Aggregation level (optional). If NULL, returns all levels.
#'   Options: "section", "division", "group", "class"
#' @param language Language: "pt", "en", or "es". Default: "en"
#' @param verbose Logical. If TRUE, display progress messages. Default: FALSE
#'
#' @return A tibble with ISIC codes and descriptions
#'
#' @details
#' ISIC is an international classification of economic activities
#' developed by the UN. It is used to classify productive units
#' of goods and services.
#'
#' \itemize{
#'   \item \strong{section}: Section - 1 letter (21 sections: A-U)
#'   \item \strong{division}: Division - 2 digits
#'   \item \strong{group}: Group - 3 digits
#'   \item \strong{class}: Class - 4 digits (most detailed)
#' }
#'
#' @examples
#' \dontrun{
#' # All ISIC levels
#' comex_isic()
#'
#' # ISIC sections
#' comex_isic(level = "section")
#'
#' # ISIC classes (most detailed)
#' comex_isic(level = "class")
#' }
#'
#' @export
comex_isic <- function(level = NULL, language = "en", verbose = FALSE) {
  if (!is.null(level)) {
    valid_levels <- c("section", "division", "group", "class")

    if (!level %in% valid_levels) {
      cli::cli_abort(c(
        "x" = "Invalid level: {level}",
        "i" = "Valid values: {paste(valid_levels, collapse = ', ')}"
      ))
    }

    # Map level to API type
    api_type <- switch(level,
      section = "isicSection",
      division = "isicDivision",
      group = "isicGroup",
      class = "isicClass"
    )

    endpoint <- paste0("/tables/product-categories?type=", api_type, "&language=", language)
  } else {
    # ISIC uses the same product-categories endpoint, filtering by type
    endpoint <- paste0("/tables/product-categories?type=isicSection&language=", language)
  }

  data <- execute_get(endpoint, verbose = verbose)
  response_to_tibble(data, path = "data")
}
