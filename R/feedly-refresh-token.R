#' Generate a Feedly Refresh Token
#'
#' Stick this into `FEEDLY_ACCESS_TOKEN` when obtained.
#'
#' @md
#' @param feedly_token Your Feedly Developer Access Token (see [feedly_access_token()])
#' @references (<https://developer.feedly.com/v3/auth/#refreshing-an-access-token>)
#' @export
feedly_refresh_token <- function(feedly_token = feedly_access_token()) {

  httr::POST(
    seymour:::.seymour_ua,
    url = "https://cloud.feedly.com/v3/auth/token",
    httr::add_headers(
      `Authorization` = sprintf("OAuth %s", seymour::feedly_access_token())
    ),
    body = list(
      refresh_token = Sys.getenv("FEEDLY_REFRESH_TOKEN"),
      client_id = "feedlydev",
      client_secret = "feedlydev",
      grant_type = "refresh_token"
    )
  ) -> res

  httr::stop_for_status(res)

  httr::content(res)

}