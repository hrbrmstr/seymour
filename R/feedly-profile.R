#' Retrieve Your Feedly Profile
#'
#' This function also returns information about current API rate limits
#' associated with your account.
#'
#' @md
#' @param feedly_token Your Feedly Developer Access Token (see [feedly_access_token()])
#' @references (<https://developer.feedly.com/v3/opml/>)
#' @export
feedly_profile <- function(feedly_token = feedly_access_token()) {

  httr::GET(
    url = "https://cloud.feedly.com/v3/profile",
    httr::add_headers(
      `Authorization` = sprintf("OAuth %s", feedly_token)
    )
  ) -> res

  httr::stop_for_status(res)

  out <- httr::content(res, as="text")

  out <- jsonlite::fromJSON(out)

  ln <- names(out)

  if ("productExpiration" %in% ln)
    out$productExpiration <- as.POSIXct(out$productExpiration/1000, origin = "1970-01-01")
  if ("subscriptionRenewalDate" %in% ln)
    out$subscriptionRenewalDate <- as.POSIXct(out$subscriptionRenewalDate/1000, origin = "1970-01-01")
  if ("upgradeDate" %in% ln)
    out$upgradeDate <- as.POSIXct(out$upgradeDate/1000, origin = "1970-01-01")

  out$x_rate_limit_limit <- unlist(res$headers["x-ratelimit-limit"], use.names = FALSE)
  out$x_rate_limit_count <- unlist(res$headers["x-ratelimit-count"], use.names = FALSE)
  out$x_rate_limit_reset <- unlist(res$headers["x-ratelimit-reset"], use.names = FALSE)

  out

}
