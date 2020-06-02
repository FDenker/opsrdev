#' @title Retrieve bibliographic information using patent numbers
#' @description Use this function to fetch patent front pages 'biblios' from OPS
#'   by posting a list of publication numbers using httr::POST.
#' @param x a character vector containing patent numbers produced by
#'   ops_numbers(), epodoc column preferred.
#' @details epodoc format appears to capture more data than docdb but
#'   experimentation may be needed.
#' @return a JSON format response
#' @export
#' @importFrom httr content_type
#' @importFrom httr accept
#' @importFrom httr accept
#' @importFrom httr POST
#' @examples \dontrun{x <- more_pizza$epodoc}
#' @examples \dontrun{biblios <- ops_post(x)}
ops_post <- function(x, key, secret){
  access_token <- ops_auth(key = key, secret = secret)
  head_post <- c(paste("Bearer", access_token ),"application/json", "text/plain")
  names(head_post) <- c("Authorization", "Accept", "Content-Type" )
  POST("http://ops.epo.org/3.2/rest-services/published-data/publication/epodoc/biblio", add_headers(head_post), body = x)

}

