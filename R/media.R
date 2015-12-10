# URL for media information requests
#
# @param dataset Vendor to get the listings from.  See \code{list_datasets} for a list of vendors.
# @param media_id media ID.
# @return URL for media data request.
#
#
url_media = function(dataset = "test", media_id = NULL) {
  url = retsly_url(dataset, "media")
  url = ifelse(is.null(media_id), url, paste(url, media_id, sep = "/"))

  url

}

#' Retrieves the collection of media for a set of listings.
#'
#' @param opts Request query parameters, see \code{retsly_query}.
#' @param dataset Vendor to get the listings from.  See \code{list_datasets} for a list of vendors.
#' @param media_id media ID.
#' @return data.frame of id, url and mimeType.
#'
#' @export
media = function(opts = retsly_query(), dataset = "test", media_id = NULL) {
  url = url_media(dataset, media_id)
  resp = query_request(opts, url)
  content = query_parse(resp)

  content
}