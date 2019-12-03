#' Retrieve Your Feedly Enterprise Profile
#'
#' @md
#' @param feedly_token Your Feedly Developer Access Token (see [feedly_access_token()])
#' @references (<https://developer.feedly.com/v3/opml/>)
#' @export
feedly_enterprise_profile <- function(feedly_token = feedly_access_token()) {

  httr::GET(
    .seymour_ua,
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
  if ("lastChargeDate" %in% ln)
    out$lastChargeDate <- as.POSIXct(out$lastChargeDate/1000, origin = "1970-01-01")
  if ("nextChargeDate" %in% ln)
    out$nextChargeDate <- as.POSIXct(out$nextChargeDate/1000, origin = "1970-01-01")

  out

}
