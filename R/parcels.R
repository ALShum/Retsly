# URL for parcel information requests
#
# @param dataset Vendor to get the listings from.  See \code{list_datasets} for a list of vendors.
# @return URL for agent data request.
#
#
url_parcels = function(dataset = "pub") {
  retsly_url(dataset, "parcels")
}

#' Retrieves the set of parcels from Retsly's datasets.
#'
#' @param opts Request query parameters, see \code{retsly_query}.
#' @param dataset Vendor to get the listings from.  See \code{list_datasets} for a list of vendors.
#' @return data.frame of parcel information including id, land use description, acres and other information.
#'
#' @export
parcels = function(opts = retsly_query(), dataset = "pub") {
  url = url_parcels(dataset)
  resp = query_request(opts, url)
  content = query_parse(resp)

  content
}