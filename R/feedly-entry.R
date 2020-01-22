#' Get the content of an entry
#'
#' An entry is the atomic unit of content in the feedly cloud.
#'
#' @md
#' @param entry_id the unique, immutable ID for this particular article.
#' @param feedly_token Your Feedly Developer Access Token (see [feedly_access_token()])
#' @references (<https://developer.feedly.com/v3/entries/>)
#' @export
feedly_entry <- function(entry_id, feedly_token = feedly_access_token()) {

  httr::GET(
    .seymour_ua,
    url = sprintf("https://cloud.feedly.com/v3/entries/%s", entry_id[1]),
    httr::add_headers(
      `Authorization` = sprintf("OAuth %s", feedly_token)
    )
  ) -> res

  httr::stop_for_status(res)

  out <- httr::content(res, as="text")

  out <- jsonlite::fromJSON(out)

  if (inherits(out, "data.frame")) {
    if (nrow(out) > 0) {

      cn <- colnames(out)

      if ("recrawled" %in% cn) out$updated <- as.POSIXct(out$recrawled/1000, origin = "1970-01-01")
      if ("updated" %in% cn) out$updated <- as.POSIXct(out$updated/1000, origin = "1970-01-01")
      if ("crawled" %in% cn) out$crawled <- as.POSIXct(out$crawled/1000, origin = "1970-01-01")
      if ("published" %in% cn) out$published <- as.POSIXct(out$published/1000, origin = "1970-01-01")
      if ("actionTimestamp" %in% cn) out$actionTimestamp <- as.POSIXct(out$actionTimestamp/1000, origin = "1970-01-01")

      class(out) <- c("tbl_df", "tbl", "data.frame")

    }
  }

  out

}
