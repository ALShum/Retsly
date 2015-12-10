# URL for vendor information requests
#
# @param vendor_id vendor ID.
# @return URL for vendor data request.
#
#
url_vendors = function(vendor_id = NULL) {
  url = retsly_url("vendors")
  url = ifelse(is.null(vendor_id), url, paste(url, vendor_id, sep = "/"))

  url
}

#' Retrieves the set of all vendors available.
#'
#' @param opts Request query parameters, see \code{retsly_query}.
#' @param vendor_id Specific vendor ID.
#' @return data.frame of all vendors including name, id, number of listings and other information.
#'
#' @export
vendors = function(opts = retsly_query(), vendor_id = NULL) {
  url = url_vendors(vendor_id)
  resp = query_request(opts, url)
  content = query_parse(resp)

  content
}

#' Retrieves the set of vendors approved for a user.
#'
#' @param opts Request query parameters, see \code{retsly_query}.
#' @return data.frame of approved vendors including name, id, number of listings and other information.
#'
#' @export
vendors_approved = function(opts = retsly_query()) {
  url = retsly_url("vendors", "approved")
  resp = query_request(opts, url)
  content = query_parse(resp)

  content
}