#' Retrieve Feedly Subscriptions
#'
#' This call _requires_ authentication.
#'
#' @md
#' @param feedly_token Your Feedly Developer Access Token (see [feedly_access_token()])
#' @references (<https://developer.feedly.com/v3/subscriptions/>)
#' @export
#' @return a data frame of feed subscriptions
feedly_subscriptions <- function(feedly_token = feedly_access_token()) {

  httr::GET(
    url = "https://cloud.feedly.com/v3/subscriptions",
    .seymour_ua,
    httr::add_headers(
      `Authorization` = sprintf("OAuth %s", feedly_token)
    )
  ) -> res

  httr::stop_for_status(res)

  res <- httr::content(res, as="text")
  out <- jsonlite::fromJSON(res)

  class(out) <- c("tbl_df", "tbl", "data.frame")

  out

}
