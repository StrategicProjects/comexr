## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = FALSE
)

## ----install------------------------------------------------------------------
# # From GitHub
# remotes::install_github("StrategicProjects/comexr")

## ----setup--------------------------------------------------------------------
# library(comexr)

## ----exports------------------------------------------------------------------
# exports <- comex_export(
#   start_period = "2024-01",
#   end_period   = "2024-01",
#   details      = "country"
# )
# head(exports)

## ----imports------------------------------------------------------------------
# imports <- comex_import(
#   start_period = "2024-01",
#   end_period   = "2024-12",
#   details      = "country",
#   metric_cif   = TRUE
# )

## ----filtered-----------------------------------------------------------------
# # Exports to China (id=160), grouped by HS4
# china_hs4 <- comex_export(
#   start_period = "2024-01",
#   end_period   = "2024-12",
#   details      = c("country", "hs4"),
#   filters      = list(country = 160)
# )

## ----city---------------------------------------------------------------------
# # Exports from Pernambuco by country
# pe_exports <- comex_query_city(
#   flow         = "export",
#   start_period = "2024-01",
#   end_period   = "2024-12",
#   details      = c("state", "country"),
#   filters      = list(state = 26)
# )
# 
# # By product heading (SH4 equivalent)
# pe_products <- comex_query_city(
#   flow         = "export",
#   start_period = "2024-01",
#   end_period   = "2024-06",
#   details      = c("state", "heading"),
#   filters      = list(state = 26)
# )

## ----historical---------------------------------------------------------------
# hist_data <- comex_historical(
#   flow         = "export",
#   start_period = "1995-01",
#   end_period   = "1996-12",
#   details      = "country"
# )

## ----tables_geo---------------------------------------------------------------
# countries <- comex_countries()
# comex_country_detail(105)   # Brazil
# 
# states <- comex_states()
# comex_state_detail(26)      # Pernambuco
# 
# cities <- comex_cities()
# comex_city_detail(2611606)  # Recife
# 
# blocs <- comex_blocs(language = "en")
# 
# transport <- comex_transport_modes()
# comex_transport_mode_detail("01")  # Maritime
# 
# customs <- comex_customs_units()

## ----tables_products----------------------------------------------------------
# ncm <- comex_ncm(language = "en")
# comex_ncm_detail("12019000")       # Soybeans
# 
# nbm <- comex_nbm()                 # Historical codes
# comex_nbm_detail("2924101100")
# 
# hs <- comex_hs(language = "en")    # Harmonized System

## ----tables_class-------------------------------------------------------------
# cgce <- comex_cgce(language = "en")
# sitc <- comex_sitc(language = "en")
# isic <- comex_isic(language = "en")

## ----filter_values------------------------------------------------------------
# # General: country, economicBlock, state, urf, ncm, section
# comex_filter_values("country")
# comex_filter_values("section")
# 
# # City: country, economicBlock, state, city, heading, chapter, section
# comex_filter_values("heading", type = "city")
# 
# # Historical: country, state
# comex_filter_values("country", type = "historical")

## ----ssl----------------------------------------------------------------------
# options(comex.ssl_verifypeer = FALSE)

## ----complete_example---------------------------------------------------------
# library(comexr)
# 
# # Step 1: Find country code
# countries <- comex_countries()
# countries[grepl("China", countries$text, ignore.case = TRUE), ]
# # id = 160
# 
# # Step 2: Query soybean exports to China
# soy_china <- comex_export(
#   start_period = "2024-01",
#   end_period   = "2024-12",
#   details      = c("country", "hs4"),
#   filters      = list(country = 160),
#   month_detail = TRUE
# )
# 
# # Step 3: Analyze
# head(soy_china)

