# URL for Agent information requests
#
# @param dataset Vendor to get the listings from.  See \code{list_datasets} for a list of vendors.
# @param agent_id Agent ID.
# @return URL for agent data request.
#
#
url_agents = function(dataset = "test", agent_id = NULL) {
  url = retsly_url(dataset, "agents")
  url = ifelse(is.null(agent_id), url, paste(url, agent_id, sep = "/"))

  url
}

#' Retrieves the set of agents from one of Retsly's MLS datasets.
#'
#' @param opts Request query parameters, see \code{retsly_query}.
#' @param dataset Vendor to get the listings from.  See \code{list_datasets} for a list of vendors.
#' @param agent_id Agent ID.
#' @return data.frame of agent information including name, contact info, office ID, and other info.
#'
#' @export
agents = function(opts = retsly_query(), dataset = "test", agent_id = NULL) {
  url = url_agents(dataset, agent_id)
  resp = query_request(opts, url)
  content = query_parse(resp)

  content
}

#' Retrieves the set of listings associated with a specified agent from one of Retsly's MLS datasets.
#'
#' @param opts Request query parameters, see \code{retsly_query}.
#' @param dataset Vendor to get the listings from.  See \code{list_datasets} for a list of vendors.
#' @param agent_id Agent ID.
#' @return data.frame with listings for each agent.
#'
#' @export
agent_listings = function(opts = retsly_query(), dataset = "test", agent_id) {
  url = url_agents(dataset, agent_id)
  url = paste(url, "listings", sep = "/")
  resp = query_request(opts, url)
  content = query_parse(resp)
  content = content$listings

  content
}