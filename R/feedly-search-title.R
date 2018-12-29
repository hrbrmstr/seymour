#' Find feeds based on title, url or `#topic`
#'
#' Authorization is _optional_ for this API call. Pass in `NULL` to `feedly_token`
#' to make unauthenticated calls to this API endpoint.
#'
#' @md
#' @param query a full or partial title string, URL, or `#topic`
#' @param count number of items to return (API default is 20)
#' @param locale if not `NULL` then a Feedly-recognized locale string (see
#'        `References`) to provide a hint to the search engine to return feeds
#'        in that locale.
#' @param feedly_token Your Feedly Developer Access Token (see [feedly_access_token()])
#' @references (<https://developer.feedly.com/v3/search/>) & [Search Tutorial](https://feedly.uservoice.com/knowledgebase/articles/441699-power-search-tutorial)
#' @return list similar to [feedly_stream()]
#' @export
#' @examples
#' feedly_search_title("data science")
feedly_search_title <- function(query, count=20L, locale=NULL, feedly_token = feedly_access_token()) {

  ct <- as.integer(count)

  query <- query[1]

  httr::GET(
    url = "https://cloud.feedly.com/v3/search/feeds",
    if (!is.null(feedly_token)) {
      httr::add_headers(
        `Authorization` = sprintf("OAuth %s", feedly_token)
      )
    },
    query = list(
      query = query,
      count = ct,
      locale = locale
    )
  ) -> res

  httr::stop_for_status(res)

  out <- httr::content(res, as="text")

  out <- jsonlite::fromJSON(out)

  out

}

# @seealso feedly_search_contents
