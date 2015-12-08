# URL for assessment information requests
#
# @param dataset Vendor to get the listings from.  For assessments, this should be "pub" (public data).
# @return URL for assessment data request.
#
#
url_assessments = function(dataset = "pub") {
  url = retsly_url(dataset, "assessments")
}

#' Public assessment data
#'
#' @export
assessments = function(opts = retsly_query(), dataset = "pub") {
  url = url_assessments(dataset)
  resp = query_request(opts, url)

  content = query_parse(resp)

  content
}