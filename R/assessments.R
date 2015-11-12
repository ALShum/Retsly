url_assessments = function(dataset = "pub") {
  url = retsly_url(dataset, "assessments")
}

assessments = function(opts = retsly_query(), dataset = "pub") {
  url = url_assessments(dataset)
  resp = query_request(opts, url)

  content = query_parse(resp)

  content
}