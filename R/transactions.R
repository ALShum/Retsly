url_transactions = function(dataset = "pub") {
  retsly_url(dataset, "transactions")
}

transactions = function(opts = retsly_query(), dataset = "pub") {
  url = url_transactions(dataset)
  resp = query_request(opts, url)
  content = query_parse(resp)

  content
}