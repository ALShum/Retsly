url_media = function(dataset = "test", media_id = NULL) {
  url = retsly_url(dataset, "media")
  url = ifelse(is.null(media_id), url, paste(url, media_id, sep = "/"))

  url

}

media = function(opts = retsly_query(), dataset = "test", media_id = NULL) {
  url = url_media(dataset, media_id)
  resp = query_request(opts, url)
  content = query_parse(resp)

  content
}