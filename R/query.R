retsly_url = function(...) {
  base_url = "https://rets.io/api/v1"
  args = paste(..., sep = "/")

  paste(base_url, args, sep = "/")
}

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

query_request = function(opts = retsly_query(), url) {
  resp = httr::GET(
    url = url,
    query = opts
  )

  resp
}

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

translate_symbol = list(
  "=" = "",
  "!=" = ".ne",
  ">" = ".gt",
  "<" = ".lt",
  ">=" = ".gte.",
  "<=" = ".lte"
)

valid_symbol = function(sym) {
  sym %in% names(translate_symbol)
}

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