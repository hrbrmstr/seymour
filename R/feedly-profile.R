#' Retrieve Your Feedly Profile
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

  out

}
