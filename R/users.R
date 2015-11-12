url_users = function() {
  url = retsly_url("users")

  url
}

users = function(opts = retsly_query()) {
  url = url_users()
  resp = query_request(opts, url)
  content = query_parse(resp)

  content
}