url_applications = function() {
  url = retsly_url("applications")

  url
}

applications = function(opts = retsly_query()) {
  url = url_applications()
  resp = query_request(opts, url)
  content = query_parse(resp)

  content
}