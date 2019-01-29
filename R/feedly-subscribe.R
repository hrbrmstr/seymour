# Subscribe to an RSS feed
#
# Authorization is _required_ for this API call.
#
# @md
# @param feed_url a URL to an RSS feed (this will be validated).
# @param categories if `NULL` then the feed will be assigned to the global (uncategorized) category.
#        Otherwise pass in a character vector of valid category names (use the
#        utility function [feedly_categories()] to get a list of category names)
# @param feedly_token Your Feedly Developer Access Token (see [feedly_access_token()])
# @references (<https://developer.feedly.com/v3/subscriptions/#subscribe-to-a-feed/>)
# @export
# @examples
# feedly_subscribe("https://journal.r-project.org/rss.atom")
# feedly_subscribe <- function(feed_url, categories = NULL, feedly_token = feedly_access_token()) {
#
#   feed_url <- feed_url[1]
#
#   httr::GET(
#     url = feed_url
#   ) -> res0
#
#   httr::GET(
#     url = "https://cloud.feedly.com/v3/search/feeds",
#     if (!is.null(feedly_token)) {
#       httr::add_headers(
#         `Authorization` = sprintf("OAuth %s", feedly_token)
#       )
#     },
#     query = list(
#       query = query,
#       count = ct,
#       locale = locale
#     )
#   ) -> res
#
#   httr::stop_for_status(res)
#
#   out <- httr::content(res, as="text")
#
#   out <- jsonlite::fromJSON(out)
#
#   if (length(out$results) > 0) {
#     if (nrow(out$results) > 0) {
#       class(out$results) <- c("tbl_df", "tbl", "data.frame")
#     }
#   }
#
#   out
#
# }
