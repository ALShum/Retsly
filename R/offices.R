url_offices = function(dataset = "test", office_id = NULL) {
  url = retsly_url(dataset, "offices")
  url = ifelse(is.null(office_id), url, paste(url, office_id, sep = "/"))

  url
}

offices = function(opts = retsly_query(), dataset = "test", office_id = NULL) {
  url = url_offices(dataset, office_id)
  resp = query_request(opts, url)
  content = query_parse(resp)

  content
}

offices_agents = function(opts = retsly_query(), dataset = "test", office_id) {
  url = url_offices(dataset, office_id)
  url = paste(url, "agents", sep = "/")
  resp = query_request(opts, url)
  content = query_parse(resp)

  content
}

offices_listings = function(opts = retsly_query(), dataset = "test", office_id) {
  url = url_offices(dataset, office_id)
  url = paste(url, "listings", sep = "/")
  resp = query_request(opts, url)
  content = query_parse(resp)

  content
}