# URL for Agent information requests
#
# @return URL for applications data request.
#
#
url_applications = function() {
  url = retsly_url("applications")

  url
}

#' Retrieves the set of applications associated with a user id token.
#'
#' @param opts Request query parameters, see \code{retsly_query}.
#' @return list of information including approved vendors (available datasets)
#'
#' @export
applications = function(opts = retsly_query()) {
  url = url_applications()
  resp = query_request(opts, url)
  content = query_parse(resp)

  content
}