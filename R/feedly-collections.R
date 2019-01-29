#' Retrieve Feedly Connections
#'
#' @md
#' @param with_stats if `TRUE`, return reading and tag stats for the past 31 days (default: `FALSE`)
#' @param feedly_token Your Feedly Developer Access Token (see [feedly_access_token()])
#' @references (<https://developer.feedly.com/v3/collections//>)
#' @export
#' @return a data frame of all non-empty collections
feedly_collections <- function(with_stats=FALSE,
                               feedly_token = feedly_access_token()) {

  httr::GET(
    url = "https://cloud.feedly.com/v3/collections",
    .seymour_ua,
    httr::add_headers(
      `Authorization` = sprintf("OAuth %s", feedly_token)
    ),
    query = list(
      withStats = if (with_stats) "true" else "false"
    )
  ) -> res

  httr::stop_for_status(res)

  res <- httr::content(res, as="text")
  coll <- jsonlite::fromJSON(res)

  for (i in 1:length(coll$customizable)) {

    if (nrow(coll$feeds[[i]]) > 0) {
      coll$feeds[[i]]$customizable <- coll$customizable[i]
      coll$feeds[[i]]$enterprise <- coll$enterprise[i]
      coll$feeds[[i]]$customizable <- coll$customizable[i]
      coll$feeds[[i]]$label <- coll$label[i]
      coll$feeds[[i]]$id <- coll$id[i]
      coll$feeds[[i]]$created <- coll$created[i]
      coll$feeds[[i]]$description <- coll$description[i]
    }

  }

  out <- bind_rows(coll$feeds[which(sapply(coll$feeds, nrow) > 0)])

  class(out) <- c("tbl_df", "tbl", "data.frame")

  out

}
