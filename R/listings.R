# URL for listing information requests
#
# @param dataset Vendor to get the listings from.  See \code{list_datasets} for a list of vendors.
# @param list_id Listing ID.
# @return URL for listing data request.
#
#
url_listings = function(dataset = "test", list_id = NULL) {
  url = retsly_url(dataset, "listings")
  url = ifelse(is.null(list_id), url, paste(url, list_id, sep = "/"))

  return(url)
}

#' Retrieves the set of real estate listings from one of Retsly's MLS datasets.
#'
#' @param opts Request query parameters, see \code{retsly_query}.
#' @param dataset Vendor to get the listings from.  See \code{list_datasets} for a list of vendors.
#' @param list_id Listing ID for a specific listing.
#' @return data.frame of listing information address, price, agent and other information.
#'
#' @export
listings = function(opts = retsly_query(), dataset = "test", list_id = NULL) {
  url = url_listings(dataset, list_id)
  resp = query_request(opts, url)
  content = query_parse(resp)

  content
}

#' Retrieves the listing agent associated with a specific real estate listing.
#'
#' @param opts Request query parameters, see \code{retsly_query}.
#' @param dataset Vendor to get the listings from.  See \code{list_datasets} for a list of vendors.
#' @param list_id Listing ID for a specific listing.
#' @return List of information including agentID, name, address and other information.
#'
#' @export
listings_agent = function(opts = retsly_query(), dataset = "test", list_id) {
  url = url_listings(dataset, list_id)
  url = paste(url, "agent", sep = "/")
  resp = query_request(opts, url)
  content = query_parse(resp)

  content
}

#' Retrieves the office associated with a specific real estate listing.
#'
#' @param opts Request query parameters, see \code{retsly_query}.
#' @param dataset Vendor to get the listings from.  See \code{list_datasets} for a list of vendors.
#' @param list_id Listing ID for a specific listing.
#' @return List of information including officeID, name, address and other information.
#'
#' @export
listings_office = function(opts = retsly_query(), dataset = "test", list_id) {
  url = url_listings(dataset, list_id)
  url = paste(url, "office", sep = "/")
  resp = query_request(opts, url)
  content = query_parse(resp)

  content
}