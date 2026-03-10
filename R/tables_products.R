# Product Classification Tables

# =============================================================================
# NCM - MERCOSUR COMMON NOMENCLATURE
# =============================================================================

#' Get NCM (Mercosur Common Nomenclature) table
#'
#' @description
#' Returns the NCM codes table with descriptions. NCM is the product
#' classification used by Mercosur countries, based on the Harmonized
#' System (HS).
#'
#' @param language Language: "pt", "en", or "es". Default: "en"
#' @param verbose Logical. If TRUE, display progress messages. Default: FALSE
#'
#' @return A tibble with NCM codes and descriptions
#'
#' @examples
#' \dontrun{
#' comex_ncm()
#' }
#'
#' @export
comex_ncm <- function(language = "en", verbose = FALSE) {
  data <- execute_get(paste0("/tables/ncm?language=", language), verbose = verbose)
  response_to_tibble(data, path = "data")
}

#' Get NCM code details
#'
#' @description
#' Returns details for a specific NCM code.
#'
#' @param ncm_code NCM code (8 digits)
#' @param language Language: "pt", "en", or "es". Default: "en"
#' @param verbose Logical. If TRUE, display progress messages. Default: FALSE
#'
#' @return A list with NCM details
#'
#' @examples
#' \dontrun{
#' comex_ncm_detail("02023000")  # Boneless frozen beef
#' }
#'
#' @export
comex_ncm_detail <- function(ncm_code, language = "en", verbose = FALSE) {
  data <- execute_get(paste0("/tables/ncm/", ncm_code, "?language=", language), verbose = verbose)
  extract_api_data(data)
}

# =============================================================================
# NBM - BRAZILIAN NOMENCLATURE OF GOODS (HISTORICAL)
# =============================================================================

#' Get NBM (Brazilian Nomenclature of Goods) table
#'
#' @description
#' Returns the NBM codes table with descriptions. NBM was the nomenclature
#' used in Brazil before NCM adoption and is used only for historical
#' data (1989-1996).
#'
#' @param language Language: "pt", "en", or "es". Default: "en"
#' @param verbose Logical. If TRUE, display progress messages. Default: FALSE
#'
#' @return A tibble with NBM codes and descriptions
#'
#' @examples
#' \dontrun{
#' comex_nbm()
#' }
#'
#' @export
comex_nbm <- function(language = "en", verbose = FALSE) {
  data <- execute_get(paste0("/tables/nbm?language=", language), verbose = verbose)
  response_to_tibble(data, path = "data")
}

#' Get NBM code details
#'
#' @description
#' Returns details for a specific NBM code.
#'
#' @param nbm_code NBM code
#' @param language Language: "pt", "en", or "es". Default: "en"
#' @param verbose Logical. If TRUE, display progress messages. Default: FALSE
#'
#' @return A list with NBM details
#'
#' @examples
#' \dontrun{
#' comex_nbm_detail("00100101")
#' }
#'
#' @export
comex_nbm_detail <- function(nbm_code, language = "en", verbose = FALSE) {
  data <- execute_get(paste0("/tables/nbm/", nbm_code, "?language=", language), verbose = verbose)
  extract_api_data(data)
}

# =============================================================================
# HS - HARMONIZED SYSTEM
# =============================================================================

#' Get Harmonized System (HS) tables
#'
#' @description
#' Returns Harmonized System tables. Use the \code{level} parameter to
#' specify the desired aggregation level.
#'
#' @param level Aggregation level (optional). If NULL, returns all levels.
#'   Options: "section", "chapter" (HS2), "heading" (HS4), "subheading" (HS6)
#' @param language Language: "pt", "en", or "es". Default: "en"
#' @param verbose Logical. If TRUE, display progress messages. Default: FALSE
#'
#' @return A tibble with Harmonized System codes and descriptions
#'
#' @details
#' The Harmonized System (HS) is an international product nomenclature
#' developed by the World Customs Organization (WCO). It is organized
#' into sections, chapters, headings, and subheadings.
#'
#' \itemize{
#'   \item \strong{section}: Section - Broadest grouping (21 sections)
#'   \item \strong{chapter}: Chapter (HS2) - 2 digits, ~97 chapters
#'   \item \strong{heading}: Heading (HS4) - 4 digits
#'   \item \strong{subheading}: Subheading (HS6) - 6 digits
#' }
#'
#' @examples
#' \dontrun{
#' # All HS levels
#' comex_hs()
#'
#' # Sections only
#' comex_hs(level = "section")
#'
#' # Chapters (HS2)
#' comex_hs(level = "chapter")
#'
#' # Headings (HS4)
#' comex_hs(level = "heading")
#'
#' # Subheadings (HS6)
#' comex_hs(level = "subheading")
#' }
#'
#' @export
comex_hs <- function(level = NULL, language = "en", verbose = FALSE) {
  if (!is.null(level)) {
    valid_levels <- c("section", "chapter", "heading", "subheading")

    if (!level %in% valid_levels) {
      cli::cli_abort(c(
        "x" = "Invalid level: {level}",
        "i" = "Valid values: {paste(valid_levels, collapse = ', ')}"
      ))
    }

    endpoint <- paste0("/tables/hs?type=", level, "&language=", language)
  } else {
    endpoint <- paste0("/tables/hs?language=", language)
  }

  data <- execute_get(endpoint, verbose = verbose)
  response_to_tibble(data, path = "data")
}
