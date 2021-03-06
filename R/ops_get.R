#' @title Obtain a set of urls from ops_publications
#' @description Used in conjunction with ops_iterate. Given a set of urls convert to a get request to retrieve the data from OPS. When the response is received extract the content to create a list.
#' @param url . A single url or vector of urls
#' @param key Alphanumeric provided by OPS (quoted).
#' @param secret Alphanumeric secret provided by OPS (quoted).
#' @return A list.
#' @importFrom httr GET
#' @importFrom httr content_type
#' @importFrom httr accept
#' @importFrom httr content
#' @export
#' @examples \dontrun{lapply(three_urls, ops_get)}
ops_get <- function(url, key, secret){
  # Generate access token and create header
  access_token <- ops_auth(key = key, secret = secret)
  head_post <- c(paste("Bearer", access_token ),"application/json", "text/plain")
  names(head_post) <- c("Authorization", "Accept", "Content-Type" )
  myquery <- httr::GET(paste0(url), httr::add_headers(head_post))
  content <- httr::content(myquery) #required or raw return
  # results <- content$`ops:world-patent-data`$`ops:biblio-search`$`ops:search-result`$`ops:publication-reference`

  #testing to access list at right level
  #will need expanding to inherit the service from the parent function.
  # if(length(url) > 1){
  #   content <- lapply(myquery, httr::content)
  #   return(content)
    #results <- unlist(content, recursive = FALSE) # need to access the content at the level above first to use in melt
  # }
  }


