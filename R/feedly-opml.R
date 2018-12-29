#' Retrieve Your Feedly OPML File
#'
#' OPML (Outline Processor Markup Language) files are XML documents holding
#' "outlines". Specifically (for the context of Feedly) OPML files fully
#' describe the set of collections of RSS feeds, providing all the necessary
#' metadata to transfer between feed readers.
#'
#' @md
#' @param as one of "`text`" (plain character XML) or "`parsed`" (which will return
#'        an `xml2::xml_document`)
#' @param feedly_token Your Feedly Developer Access Token (see [feedly_access_token()])
#' @references (<https://developer.feedly.com/v3/opml/>)
#' @export
#' @return character or `xml_document` depending on `as`
feedly_opml <- function(as = c("text", "parsed"), feedly_token = feedly_access_token()) {

  as <- match.arg(as[1], c("text", "parsed"))

  httr::GET(
    url = "https://cloud.feedly.com/v3/opml",
    httr::add_headers(
      `Authorization` = sprintf("OAuth %s", feedly_token)
    )
  ) -> res

  httr::stop_for_status(res)

  httr::content(res, as=as)

}
