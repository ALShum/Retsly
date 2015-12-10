# URL for office information requests
#
# @param dataset Vendor to get the listings from.  See \code{list_datasets} for a list of vendors.
# @param office_id Office ID.
# @return URL for office data request.
#
#
url_offices = function(dataset = "test", office_id = NULL) {
  url = retsly_url(dataset, "offices")
  url = ifelse(is.null(office_id), url, paste(url, office_id, sep = "/"))

  url
}

#' Retrieves the set of real estate offices from one of Retsly's MLS datasets.
#'
#' @param opts Request query parameters, see \code{retsly_query}.
#' @param dataset Vendor to get the listings from.  See \code{list_datasets} for a list of vendors.
#' @param agent_id Office ID.
#' @return data.frame of office information including name, address, officeID and other information.
#'
#' @export
offices = function(opts = retsly_query(), dataset = "test", office_id = NULL) {
  url = url_offices(dataset, office_id)
  resp = query_request(opts, url)
  content = query_parse(resp)

  content
}

#' Retrieves the set of agents from a specific office for one of Retsly's MLS datasets.
#'
#' @param opts Request query parameters, see \code{retsly_query}.
#' @param dataset Vendor to get the listings from.  See \code{list_datasets} for a list of vendors.
#' @param office_id Office ID.
#' @return data.frame of agent information including name, contact info, office ID, and other information.
#'
#' @export
offices_agents = function(opts = retsly_query(), dataset = "test", office_id) {
  url = url_offices(dataset, office_id)
  url = paste(url, "agents", sep = "/")
  resp = query_request(opts, url)
  content = query_parse(resp)

  content$agents
}

#' Retrieves the set of listings from a specific office for one of Retsly's MLS datasets.
#'
#' @param opts Request query parameters, see \code{retsly_query}.
#' @param dataset Vendor to get the listings from.  See \code{list_datasets} for a list of vendors.
#' @param office_id Office ID.
#' @return data.frame of listing information including address, listingID and other information.
#'
#' @export
offices_listings = function(opts = retsly_query(), dataset = "test", office_id) {
  url = url_offices(dataset, office_id)
  url = paste(url, "listings", sep = "/")
  resp = query_request(opts, url)
  content = query_parse(resp)

  content$listings
}