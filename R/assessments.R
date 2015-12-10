# URL for assessment information requests
#
# @param dataset Vendor to get the listings from.  For assessments, this should be "pub" (public data).
# @return URL for assessment data request.
#
#
url_assessments = function(dataset = "pub") {
  url = retsly_url(dataset, "assessments")
}

#' Retrieves the set of public assessments from one of Retsly's datasets.
#'
#' @param opts Request query parameters, see \code{retsly_query}.
#' @param dataset Vendor to get the listings from.  See \code{list_datasets} for a list of vendors.
#' @return data.frame with id, fips, location, taxID, assessed value and other information.
#'
#' @export
assessments = function(opts = retsly_query(), dataset = "pub") {
  url = url_assessments(dataset)
  resp = query_request(opts, url)

  content = query_parse(resp)

  content
}