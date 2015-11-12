url_agents = function(dataset = "test", agent_id = NULL) {
  url = retsly_url(dataset, "agents")
  url = ifelse(is.null(agent_id), url, paste(url, agent_id, sep = "/"))

  url
}

agents = function(opts = retsly_query(), dataset = "test", agent_id = NULL) {
  url = url_agents(dataset, agent_id)
  resp = query_request(opts, url)
  content = query_parse(resp)

  content
}

agent_listings = function(opts = retsly_query(), dataset = "test", agent_id) {
  url = url_agents(dataset, agent_id)
  url = paste(url, "listings", sep = "/")
  resp = query_request(opts, url)
  content = query_parse(resp)

  content
}