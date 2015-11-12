url_vendors = function(vendor_id = NULL) {
  url = retsly_url("vendors")
  url = ifelse(is.null(vendor_id), url, paste(url, vendor_id, sep = "/"))

  url
}

vendors = function(opts = retsly_query(), vendor_id = NULL) {
  url = url_vendors(vendor_id)
  resp = query_request(opts, url)
  content = query_parse(resp)

  content
}

vendors_approved = function(opts = retsly_query()) {
  url = retsly_url("vendors", "approved")
  resp = query_request(opts, url)
  content = query_parse(resp)

  content
}