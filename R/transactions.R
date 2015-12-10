# URL for transactions information requests
#
# @param dataset Vendor to get the listings from.  See \code{list_datasets} for a list of vendors.
# @return URL for agent data request.
#
#
url_transactions = function(dataset = "pub") {
  retsly_url(dataset, "transactions")
}

#' Retrieves the set of transactions from one of Retsly's datasets.
#'
#' @param opts Request query parameters, see \code{retsly_query}.
#' @param dataset Vendor to get the listings from.  See \code{list_datasets} for a list of vendors.
#' @return data.frame of transactions including state, documentType, lenderName, parcels and other information.
#'
#' @export
transactions = function(opts = retsly_query(), dataset = "pub") {
  url = url_transactions(dataset)
  resp = query_request(opts, url)
  content = query_parse(resp)

  content
}