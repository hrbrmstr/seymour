#' Retrieve List of Tags
#'
#' This endpoint is useful for retrieving ids of Feedly Boards which would
#' then enable you to, say, make your own newsletters without upgrading to Teams.
#'
#' @md
#' @param feedly_token Your Feedly Developer Access Token (see [feedly_access_token()])
#' @references (<https://developer.feedly.com/v3/tags/>)
#' @export
#' @return character or `xml_document` depending on `as`
feedly_tags <- function(feedly_token = feedly_access_token()) {

  httr::GET(
    url = "https://cloud.feedly.com/v3/tags",
    httr::add_headers(
      `Authorization` = sprintf("OAuth %s", feedly_token)
    )
  ) -> res

  httr::stop_for_status(res)

  out <- httr::content(res, as="text")

  out <- jsonlite::fromJSON(out)

  out

}
