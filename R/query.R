# Base URL for retsly requests
#
# @param ... Additional URL path elements.
# @return URL for retsly request
#
#
retsly_url = function(...) {
  base_url = "https://rets.io/api/v1"
  args = paste(..., sep = "/")

  paste(base_url, args, sep = "/")
}

#' A listing of all the available datasets available on Retsly
#'
#' @return a vector of valid dataset names
#' 
#' @export
list_datasets = function() {
  c(
    "test", 
    "test_sf", 
    "test_sd",
    "omreb",
    "retsly",
    "pub",
    "abor",
    "hiinfo",
    "armls"
  )
}

# Parses a httr::content response from Retsly API
#
# @param resp httr::content response object
# @return parsed JSON object from Retsly API
# 
# 
query_parse = function(resp) {
  content = httr::content(resp, as = "text")
  json = jsonlite::fromJSON(content)

  if(!json$success) {
    stop(
      paste0(
        "Error in request: ",
        json$status,
        ". ",
        json$bundle$message
      )
    )
  }

  json$bundle
}

# Retsly API GET request
#
# @param opts GET request query parameters
# @param url Retsly API query parameters
# @return httr::content response object from Retsly API
#
#
query_request = function(opts = retsly_query(), url) {
  resp = httr::GET(
    url = url,
    query = opts
  )

  resp
}

#' Retsly API query parameters
#' 
#' @param access_token Retsly API access token.
#' @param vendor Vendor to get the listings from.  See \code{list_datasets} for a list of vendors.
#' @param offset Skips the number of results.
#' @param limit Limits the size of the result set.
#' @param sortBy Response field to sort by.
#' @param order Order by "asc" or "desc".
#' @param near Coord or location either "lat,long" or "San Diego".
#' @param radius Search radius.  For example "10mi", "10km" or degrees (if no units).
#' @param ... Additional query parameters, see \code{valid_query}
#' @return Named list of API query parameters.
#' 
#' @export
retsly_query = function(
  access_token = "",
  vendor = NULL,
  offset = NULL,
  limit = 100,
  sortBy = NULL,
  order = NULL,
  near = NULL,
  radius = NULL,
  total = NULL,
  ...
) {
  params = as.list(environment())
  dots = substitute(...())

  if(!is.null(dots)) {
    checkParams = sapply(names(dots), valid_query)

    if(!all(checkParams)) {
      invalid = names(dots)[!checkParams]
      stop(
        paste0(
          "Invalid Parameters: ",
          paste(invalid, collapse = ", ")
        )
      )
    }

    for(i in 1:length(dots)) {
      custom_query = eval(dots[[i]])
      if(length(custom_query) > 1) {
        if(!valid_symbol(custom_query[1])) {
          stop("Symbol must be one of: '!=', '>', '<', '>=', '<='")
        } 

        value = custom_query[2]
        symbol = translate_symbol[[custom_query[1]]]
        param = names(dots)[i]
        names(dots)[i] = paste0(param, symbol)
        dots[[i]] = value
      }
    }

    params = c(params, dots)
  }

  params
}

# Maps Retsly API custom query operators
# See https://rets.ly/docs/platform.html#Querying-the-API
# 
#
translate_symbol = list(
  "=" = "",
  "!=" = ".ne",
  ">" = ".gt",
  "<" = ".lt",
  ">=" = ".gte.",
  "<=" = ".lte"
)

# Is the symbol a valid Retsly API custom query operator?
#
# @param sym query operator
# @return TRUE if valid operator otherwise FALSE
#
#
valid_symbol = function(sym) {
  sym %in% names(translate_symbol)
}

#' Is the parameter a valid query parameter for the Retsly API?
#'
#' @param Retsly query
#' @return TRUE if valid operator otherwise FALSE
#'
#' @export
valid_query = function(query) {
  valid = c(
    "aboveGradeFinishedArea", "accessibilityFeatures", "acres",
    "address", "agent", "appliances",
    "baths", "bedrooms", "belowGradeFinishedArea",
    "carportSpaces", "city", "closePrice",
    "constructionMaterials", "contingency", "cooling",
    "coordinates", "country", "county",
    "daysOnMarket", "disclosures", "exteriorFeatures",
    "financialDataSource", "fireplaceFeatures", "fireplaces",
    "flooring", "foundationDetails", "frontageLength",
    "garageSpaces", "gas", "halfBaths",
    "heating", "id", "laundry",
    "livingArea", "media", "mlsAgentID",
    "mlsListingID", "mlsOfficeID", "occupantType",
    "office", "originalPrice", "ownership",
    "parcelNumber", "poolFeatures", "possession",
    "previousPrice", "price", "privateRemarks",
    "publicRemarks", "roadSurface", "roof",
    "roomsTotal", "sewer", "squareFootage",
    "state", "status", "stories",
    "storiesTotal", "streetName", "streetNumber",
    "subdivision", "subtype", "taxAnnual",
    "taxAssessedValue", "taxStatus", "taxYear",
    "telephoneService", "termsOfSale", "type",
    "unitNumber", "unitsInBuilding", "url",
    "view", "waterSource", "yearBuilt",
    "yearBuiltDetails", "zipCode", "zoning",
    "zoningDescription"
  )

  query %in% valid
}