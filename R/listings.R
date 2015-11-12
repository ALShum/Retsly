url_listings = function(dataset = "test", list_id = NULL) {
  url = retsly_url(dataset, "listings")
  url = ifelse(is.null(list_id), url, paste(url, list_id, sep = "/"))

  return(url)
}

listings = function(opts = retsly_query(), dataset = "test", list_id = NULL) {
  url = url_listings(dataset, list_id)
  resp = query_request(opts, url)
  content = query_parse(resp)

  content
}

listings_agent = function(opts = retsly_query(), dataset = "test", list_id) {
  url = url_listings(dataset, list_id)
  url = paste(url, "agent", sep = "/")
  resp = query_request(opts, url)
  content = query_parse(resp)

  content
}

listings_office = function(opts = retsly_query(), dataset = "test", list_id) {
  url = url_listings(dataset, list_id)
  url = paste(url, "office", sep = "/")
  resp = query_request(opts, url)
  content = query_parse(resp)

  content
}