#' Retrieve Metadata for a Feed
#'
#' @md
#' @note This endpoint will do a real-time fetch of the feed if the submitted feed is not yet part of the feedly cloud.
#' @param feed an RSS feed URL. `feed/` will be prepended if not present.
#' @param feedly_token Your Feedly Developer Access Token (see [feedly_access_token()])
#' @references (<https://developer.feedly.com/v3/feeds/>)
#' @return data frame (tibble) with the following fields:
#' - `id`:
#' string the unique, immutable id of this feed.
#' - `feedId`:
#'   string same as id; for backward compatibility
#' - `subscribers`:
#'   integer number of feedly cloud subscribers who have this feed in their subscription list.
#' - `title`:
#'   string the feed name.
#' - `description`:
#'   Optional string the feed description.
#' - `language`:
#'   Optional string this field is a combination of the language reported by the RSS feed, and the language automatically detected from the feed’s content. It might not be accurate, as many feeds misreport it.
#' - `velocity`:
#'   Optional float the average number of articles published weekly. This number is updated every few days.
#' - `website`:
#'   Optional **url ** the website for this feed.
#' - `topics`:
#'   Optional string array an array of topics this feed covers. This list can be used in searches and mixes to build a list of related feeds and articles. E.g. if the list contains “productivity”, querying “productivity” in feed search will produce a list of related feeds.
#' - `status`:
#'   Optional string only returned if the feed cannot be polled. Values include “dead” (cannot be polled), “dead.flooded” (if the feed produces too many articles per day) and “dead.dropped” if the feed has been removed.
#' @export
#' @examples
#' feedly_feed_meta("https://feeds.feedburner.com/rweeklylive")
feedly_feed_meta <- function(feed, feedly_token = feedly_access_token()) {

  feed <- curl::curl_escape(sprintf("feed/%s", sub("^feed/", "", feed)))

  httr::GET(
    url = sprintf("https://cloud.feedly.com/v3/feeds/%s", feed),
    httr::add_headers(
      `Authorization` = sprintf("OAuth %s", feedly_token)
    )
  ) -> res

  httr::stop_for_status(res)

  out <- httr::content(res, as="text")

  out <- jsonlite::fromJSON(out)

  for (i in which(lengths(out) > 1)) {
    out[[i]] <- I(list(out[[i]]))
  }

  out <- as.data.frame(out, stringsAsFactors=FALSE)

  class(out) <- c("tbl_df", "tbl", "data.frame")

  out

}
