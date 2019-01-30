#' Subscribe to an RSS feed
#'
#' Authorization is _required_ for this API call.
#'
#' @md
#' @param feed_url a URL to an RSS feed (this will be validated).
#' @param categories if `NULL` then the feed will be assigned to the global (uncategorized) category.
#'        Otherwise pass in a character vector of valid category names (use the
#'        utility function [feedly_categories()] to get a list of category names)
#' @param title if `NULL` the title will be intuited from the contents of `feed_url`
#' @param feedly_token Your Feedly Developer Access Token (see [feedly_access_token()])
#' @return a data frame (invisibly) with metadata about the subcription
#' @references (<https://developer.feedly.com/v3/subscriptions/#subscribe-to-a-feed/>)
#' @export
#' @examples \dontrun{
#' feedly_subscribe("https://journal.r-project.org/rss.atom")
#' feedly_subscribe("http://gh-feed.imsun.net/hrbrmstr/sergeant/issues", "git issues")
#' feedly_subscribe("https://rsshub.app/github/issue/hrbrmstr/sergeant", "git issues")
#' }
feedly_subscribe <- function(feed_url, categories = NULL, title = NULL, feedly_token = feedly_access_token()) {

  feed_url <- feed_url[1]
  feed_url <- feedly_feed_meta(feed_url)

  if (nrow(feed_url) == 0) {
    stop(feed_url, " is not an RSS/Atom feed.", call.=FALSE)
  } else {
    feed_url <- feed_url$id[1]
  }

  if (!is.null(categories)) {

    cats <- feedly_categories(feedly_token = feedly_token)

    hasnt <- categories[categories %nin% cats$label]

    if (length(hasnt) != 0) {
      stop(
        "[", paste0(hasnt, collapse = ", "), "] ",
        "not in feedly categories.", call.=FALSE
      )
    }

    categories <- cats[cats$label == categories,]

  }

  httr::POST(
    url = "https://cloud.feedly.com/v3/subscriptions",
    httr::add_headers(
      `Authorization` = sprintf("OAuth %s", feedly_token)
    ),
    encode = "json",
    body = list(
      id = feed_url,
      title = title,
      categories = I(categories)
    )
  ) -> res

  httr::stop_for_status(res)

  out <- httr::content(res, as="text")

  out <- jsonlite::fromJSON(out)

  invisible(out)

}
