#' Check OPS Authentication and Throttle Status
#'
#' Search query to test status of response. Look for 200. If other rerun
#' authentication or use ops_throttle for detailed status. If 403 check fair
#' usage in headers. Throttle data indicates the status of a particular service at a particular time. If a query fails it may be because a service is under heavy load.
#' @param x unquoted character x to run the function.
#' @return two strings indicating the per hour used and per week used MB. Furthermore, it returns the level of throttling and the status code
#' @export
#' @examples ops_status(key = "your key here", secret = "your secret key here")
#' @importFrom magrittr %>%
ops_status <- function(key, secret){

  log <- capture.output({
    access_token <- invisible(ops_auth(key = key, secret = secret))
  })
  head_post <- c(paste("Bearer", access_token ),"application/json", "text/plain")
  names(head_post) <- c("Authorization", "Accept", "Content-Type" )
  r_get <- httr::GET("http://ops.epo.org/3.2/rest-services/published-data/search?q=ti%3Dpizza", httr::add_headers(head_post))
  print(paste0("Per hour used: ",as.numeric(r_get$headers$`x-individualquotaperhour-used`)*1e-6))
  print(paste0("Per week used: ",as.numeric(r_get$headers$`x-registeredquotaperweek-used`)*1e-6))
  print(paste0("Throttling: ",r_get$headers$`x-throttling-control`))
  print(paste0("Status code: ",r_get$status_code))
}



