# Internal Utility Functions

# =============================================================================
# SESSION MANAGEMENT USING RVEST
# =============================================================================

# Global environment for session
.comex_env <- new.env(parent = emptyenv())
.comex_env$session <- NULL
.comex_env$chrome <- NULL
.comex_env$ready <- FALSE

#' Initialize session for API calls
#' 
#' @description
#' Starts a browser session using rvest's read_html_live() and solves 
#' the Cloudflare challenge. All API calls will be made via this session.
#' 
#' @param force If TRUE, close existing session and create new one. Default: FALSE
#' @return Invisibly returns TRUE on success
#' 
#' @details
#' This function uses \code{rvest::read_html_live()} which internally uses
#' chromote to create a headless Chrome session. The session navigates to
#' the API domain to solve Cloudflare's JavaScript challenge.
#' 
#' The session stays open and is reused for all subsequent API calls.
#' Call \code{comex_close()} when done to free resources.
#' 
#' @note
#' Requires the \code{rvest} package (>= 1.0.0) and Chrome/Chromium browser.
#' 
#' @examples
#' \dontrun{
#' # Initialize session (called automatically on first API call)
#' comex_init()
#' 
#' # Make API calls
#' years <- comex_available_years()
#' 
#' # Close when done
#' comex_close()
#' }
#' 
#' @export
comex_init <- function(force = FALSE) {
  
  # Check if already initialized
  if (!force && .comex_env$ready) {
    cli::cli_alert_info("Session already active")
    return(invisible(TRUE))
  }
  
  # Close existing session if forcing
  if (force) {
    comex_close()
  }
  
  # Check for rvest
  if (!requireNamespace("rvest", quietly = TRUE)) {
    cli::cli_abort(c(
      "x" = "Package 'rvest' is required",
      "i" = "Install with: install.packages('rvest')"
    ))
  }
  
  cli::cli_alert_info("Initializing session...")
  cli::cli_alert_info("Solving Cloudflare challenge (may take 10-15s)...")
  
  tryCatch({
    # Use read_html_live to create session on API domain
    .comex_env$session <- rvest::read_html_live(
      "https://api-comexstat.mdic.gov.br/general/dates/years?language=pt"
    )
    
    # Access the internal ChromoteSession
    .comex_env$chrome <- .comex_env$session$session
    
    # Check if it worked by looking at page content
    content <- .comex_env$session |> 
      rvest::html_elements("body") |> 
      rvest::html_text() |>
      paste(collapse = "")  # Ensure single string
    
    if (grepl("minYear|min|success", content)) {
      .comex_env$ready <- TRUE
      cli::cli_alert_success("Session ready!")
      invisible(TRUE)
    } else {
      cli::cli_abort(c(
        "x" = "Failed to pass Cloudflare challenge",
        "i" = "Content: {substr(content, 1, 200)}"
      ))
    }
    
  }, error = function(e) {
    .comex_env$session <- NULL
    .comex_env$chrome <- NULL
    .comex_env$ready <- FALSE
    cli::cli_abort(c(
      "x" = "Failed to initialize session",
      "i" = "Error: {e$message}",
      "i" = "Make sure Chrome/Chromium is installed"
    ))
  })
}

#' Close browser session
#' 
#' @description
#' Closes the browser session and frees resources.
#' 
#' @return Invisibly returns TRUE
#' 
#' @examples
#' \dontrun{
#' comex_close()
#' }
#' 
#' @export
comex_close <- function() {
  .comex_env$session <- NULL
  .comex_env$chrome <- NULL
  .comex_env$ready <- FALSE
  cli::cli_alert_info("Session closed")
  invisible(TRUE)
}

#' Check if session is ready
#' @keywords internal
ensure_session <- function() {
  if (!.comex_env$ready || is.null(.comex_env$chrome)) {
    comex_init()
  }
}

#' Execute GET request via browser
#' @keywords internal
execute_get <- function(endpoint, verbose = TRUE) {
  ensure_session()
  
  if (verbose) {
    cli::cli_progress_step("Querying API...")
  }
  
  js_code <- sprintf('
    (async () => {
      try {
        const response = await fetch("%s", {
          method: "GET",
          headers: { "Accept": "application/json" }
        });
        if (!response.ok) {
          return JSON.stringify({success: false, status: response.status, error: "HTTP " + response.status});
        }
        const data = await response.json();
        return JSON.stringify({success: true, status: response.status, data: data});
      } catch (error) {
        return JSON.stringify({success: false, error: error.message});
      }
    })()
  ', endpoint)
  
  result <- .comex_env$chrome$Runtime$evaluate(
    expression = js_code,
    awaitPromise = TRUE
  )
  
  parsed <- jsonlite::fromJSON(result$result$value, simplifyVector = FALSE)
  
  # Retry on rate limit (HTTP 429)
  if (!parsed$success && identical(parsed$status, 429L)) {
    for (attempt in 1:3) {
      wait_secs <- attempt * 5
      if (verbose) {
        cli::cli_alert_warning(
          "Rate limited (429). Waiting {wait_secs}s before retry {attempt}/3..."
        )
      }
      Sys.sleep(wait_secs)
      result <- .comex_env$chrome$Runtime$evaluate(
        expression = js_code, awaitPromise = TRUE
      )
      parsed <- jsonlite::fromJSON(result$result$value, simplifyVector = FALSE)
      if (parsed$success || !identical(parsed$status, 429L)) break
    }
  }
  
  if (!parsed$success) {
    cli::cli_abort(c(
      "x" = "API request failed",
      "i" = "Error: {parsed$error}"
    ))
  }
  
  if (verbose) {
    cli::cli_alert_success("Query completed")
  }
  
  parsed
}

#' Execute POST request via browser
#' @keywords internal
execute_post <- function(endpoint, body, verbose = TRUE) {
  ensure_session()
  
  body_json <- jsonlite::toJSON(body, auto_unbox = TRUE)
  
  if (verbose) {
    cli::cli_progress_step("Sending query to API...")
  }
  
  # Escape backticks in JSON
  body_json_escaped <- gsub("`", "\\\\`", body_json)
  
  js_code <- sprintf('
    (async () => {
      try {
        const response = await fetch("%s", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: `%s`
        });
        if (!response.ok) {
          const text = await response.text();
          return JSON.stringify({success: false, status: response.status, error: text || ("HTTP " + response.status)});
        }
        const data = await response.json();
        return JSON.stringify({success: true, status: response.status, data: data});
      } catch (error) {
        return JSON.stringify({success: false, error: error.message});
      }
    })()
  ', endpoint, body_json_escaped)
  
  # Retry loop for rate limiting (HTTP 429)
  max_retries <- 3
  for (attempt in seq_len(max_retries + 1)) {
    result <- .comex_env$chrome$Runtime$evaluate(
      expression = js_code,
      awaitPromise = TRUE
    )
    
    parsed <- jsonlite::fromJSON(result$result$value, simplifyVector = FALSE)
    
    # If rate limited, wait and retry
    if (!parsed$success && identical(parsed$status, 429L) && attempt <= max_retries) {
      wait_secs <- attempt * 5  # 5s, 10s, 15s
      if (verbose) {
        cli::cli_alert_warning(
          "Rate limited (429). Waiting {wait_secs}s before retry {attempt}/{max_retries}..."
        )
      }
      Sys.sleep(wait_secs)
      next
    }
    
    break
  }
  
  if (!parsed$success) {
    cli::cli_abort(c(
      "x" = "API request failed",
      "i" = "Status: {parsed$status}",
      "i" = "Error: {parsed$error}"
    ))
  }
  
  if (verbose) {
    cli::cli_alert_success("Query completed")
  }
  
  parsed
}

#' Extract data from double-wrapped browser response
#'
#' Browser wrapper returns nested lists with API envelope inside.
#' This helper extracts the inner data field, handling several patterns:
#' - Named data (e.g. country detail): return as-is
#' - Unnamed single-element list (e.g. NCM detail): unwrap first element
#' - NULL → return NULL
#' @keywords internal
extract_api_data <- function(response) {
  # Level 1: browser wrapper → API envelope
  envelope <- response$data
  if (is.null(envelope)) return(NULL)

  # Level 2: API envelope → actual data
  if (is.list(envelope) && "data" %in% names(envelope)) {
    inner <- envelope$data
  } else {
    inner <- envelope
  }

  if (is.null(inner)) return(NULL)

  # Unwrap single-element unnamed list: [{id, text}] → {id, text}
  if (is.list(inner) && length(inner) == 1) {
    nm <- names(inner)
    is_unnamed <- is.null(nm) || length(nm) == 0 || all(nm == "")
    if (is_unnamed && is.list(inner[[1]]) && !is.null(names(inner[[1]]))) {
      return(inner[[1]])
    }
  }

  # If it's a named list with typical detail fields → return as-is
  if (is.list(inner) && !is.null(names(inner)) && length(names(inner)) > 0) {
    return(inner)
  }

  inner
}

# =============================================================================
# DETAIL/FILTER MAPPINGS
# =============================================================================

.details_map <- c(
  # Geography
  country = "country",
  bloc = "economicBlock",
  economic_block = "economicBlock",
  state = "state",
  city = "city",
  transport_mode = "transportMode",
  customs_unit = "urf",
  # Products (general)
  ncm = "ncm",
  hs6 = "sh6",
  hs4 = "sh4",
  hs2 = "sh2",
  section = "section",
  # Products (city-specific names)
  heading = "heading",
  chapter = "chapter",
  # Products (historical)
  nbm = "nbm",
  # CGCE
  cgce_n1 = "cgceN1",
  cgce_n2 = "cgceN2",
  cgce_n3 = "cgceN3",
  # SITC
  sitc_section = "cuciSection",
  sitc_chapter = "cuciChapter",
  sitc_position = "cuciPosition",
  sitc_subposition = "cuciSubposition",
  sitc_item = "cuciItem",
  # ISIC
  isic_section = "isicSection",
  isic_division = "isicDivision",
  isic_group = "isicGroup",
  isic_class = "isicClass",
  # Other
  company_size = "companySize"
)

#' Validate period format
#' @keywords internal
validate_period <- function(start_period, end_period) {
  pattern <- "^\\d{4}-\\d{2}$"
  
  if (!grepl(pattern, start_period)) {
    cli::cli_abort(c(
      "x" = "Invalid start period: {start_period}",
      "i" = "Use format 'YYYY-MM' (e.g., '2023-01')"
    ))
  }
  
  if (!grepl(pattern, end_period)) {
    cli::cli_abort(c(
      "x" = "Invalid end period: {end_period}",
      "i" = "Use format 'YYYY-MM' (e.g., '2023-12')"
    ))
  }
  
  if (start_period > end_period) {
    cli::cli_abort("Start period must be before or equal to end period")
  }
  
  invisible(TRUE)
}

#' Convert flow to API format
#' @keywords internal
convert_flow <- function(flow) {
  flow_lower <- tolower(flow)
  
  if (flow_lower %in% c("exp", "export", "exports")) {
    return("export")
  } else if (flow_lower %in% c("imp", "import", "imports")) {
    return("import")
  } else {
    cli::cli_abort("Invalid flow: {flow}. Use 'export' or 'import'")
  }
}

#' Get API name for detail/filter
#' @keywords internal
get_api_name <- function(name, type = "general") {
  if (name %in% names(.details_map)) {
    return(.details_map[[name]])
  }
  if (name %in% .details_map) {
    return(name)
  }
  cli::cli_warn("Unknown detail/filter: {name}")
  name
}

#' Build filters array for API
#' @keywords internal
build_filters <- function(filters, type = "general") {
  if (is.null(filters) || length(filters) == 0) {
    return(list())
  }
  
  lapply(names(filters), function(filter_name) {
    api_name <- get_api_name(filter_name, type)
    values <- as.character(filters[[filter_name]])
    list(filter = api_name, values = as.list(values))
  })
}

#' Build details array for API
#' @keywords internal
build_details <- function(details, type = "general") {
  if (is.null(details) || length(details) == 0) {
    return(list())
  }
  as.list(sapply(details, function(d) get_api_name(d, type), USE.NAMES = FALSE))
}

#' Build metrics array for API
#' @keywords internal
build_metrics <- function(metric_fob = TRUE,
                          metric_kg = TRUE,
                          metric_statistic = FALSE,
                          metric_freight = FALSE,
                          metric_insurance = FALSE,
                          metric_cif = FALSE) {
  metrics <- c()
  
  if (metric_fob) metrics <- c(metrics, "metricFOB")
  if (metric_kg) metrics <- c(metrics, "metricKG")
  if (metric_statistic) metrics <- c(metrics, "metricStatistic")
  if (metric_freight) metrics <- c(metrics, "metricFreight")
  if (metric_insurance) metrics <- c(metrics, "metricInsurance")
  if (metric_cif) metrics <- c(metrics, "metricCIF")
  
  if (length(metrics) == 0) {
    cli::cli_abort("At least one metric must be selected")
  }
  
  as.list(metrics)
}

#' Convert API response to tibble
#' @keywords internal
response_to_tibble <- function(response, path = "data") {
  # Step 1: Extract from browser wrapper {success, status, data: <api_response>}
  if (!is.null(path) && path %in% names(response)) {
    data <- response[[path]]
  } else {
    data <- response
  }

  if (is.null(data) || length(data) == 0) {
    return(tibble::tibble())
  }

  # Step 2: Unwrap API envelope {data: <rows>, success, message, ...}
  if (is.list(data) && "data" %in% names(data)) {
    data <- data[["data"]]
  }

  if (is.null(data) || length(data) == 0) {
    return(tibble::tibble())
  }

  if (is.data.frame(data)) {
    return(tibble::as_tibble(data))
  }

  # Step 3: Handle Pattern 1 — {list: [...], count: N}
  has_nm <- !is.null(names(data)) && length(names(data)) > 0 && !all(names(data) == "")
  if (has_nm && "list" %in% names(data)) {
    data <- data[["list"]]
    if (is.null(data) || length(data) == 0) {
      return(tibble::tibble())
    }
  }

  # Step 4: Unwrap single-element unnamed wrapper (Pattern 3: [[rows]])
  while (is.list(data) && length(data) == 1) {
    inner_nm <- names(data)
    is_unnamed <- is.null(inner_nm) || length(inner_nm) == 0 || all(inner_nm == "")
    if (is_unnamed && is.list(data[[1]])) {
      data <- data[[1]]
    } else {
      break
    }
  }

  if (is.null(data) || length(data) == 0) {
    return(tibble::tibble())
  }

  # Step 5: Convert list of row-lists to data.frame
  if (is.list(data) && length(data) > 0) {
    first <- data[[1]]
    if (is.list(first) && !is.null(names(first))) {
      # Each element is a named list (row)
      tryCatch({
        df <- do.call(rbind, lapply(data, function(row) {
          # NULL → NA, list values → collapsed string
          row <- lapply(row, function(val) {
            if (is.null(val)) return(NA_character_)
            if (is.list(val)) return(paste(unlist(val), collapse = ", "))
            val
          })
          as.data.frame(row, stringsAsFactors = FALSE)
        }))
        return(tibble::as_tibble(df))
      }, error = function(e) {
        return(tibble::tibble())
      })
    }
  }

  tibble::tibble()
}
