# URL for user information requests
#
# @return URL for user data request.
#
#
url_users = function() {
  url = retsly_url("users")

  url
}

#' Retrieve a user associated with a user token.
#'
#' @param opts Request query parameters, see \code{retsly_query}.
#' @return data.frame 
#'
#' @export
users = function(opts = retsly_query()) {
  url = url_users()
  resp = query_request(opts, url)
  content = query_parse(resp)

  content
}