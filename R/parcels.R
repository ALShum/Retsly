url_parcels = function(dataset = "pub") {
  retsly_url(dataset, "parcels")
}

parcels = function(opts = retsly_query(), dataset = "pub") {
  url = url_parcels(dataset)
  resp = query_request(opts, url)
  content = query_parse(resp)

  content
}