#' Search content of a stream
#'
#' @md
#' @param query a full or partial title string, URL, or `#topic`
#' @param stream_id the id of the stream; a feed id, category id, tag id or a
#'        system collection/category ids can be used as
#'        stream ids. If `NULL` (the default) the server will use the
#'        “`global.all`” (see [global_resource_ids]) collection/category.
#' @param fields if not "`all`" then a character vector of fields to use for
#'        matching. SUpported fields are "`title`", "`author`", and "`keywords`".
#' @param embedded if not `NULL` then one of "`audio`", "`video`", "`doc`" or "`any`".
#'        Using this parameter will limit results to also include this media type.
#'        “`any`” means the article _must_ contain at least one embed.
#'        Default behavior (i.e. `NULL`) is to not filter by embedded.
#' @param engagement if not `NULL` then either "`medium`" or "`high`".
#'        Using this parameter will limit results to articles that have the
#'        specified engagement. Default behavior (i.e. `NULL`) is to not
#'        filter by engagement.
#' @param count number of items to return (max 20 for "pro" users)
#' @param locale if not `NULL` then a Feedly-recognized locale string (see
#'        `References`) to provide a hint to the search engine to return feeds
#'        in that locale.
#' @param feedly_token Your Feedly Developer Access Token (see [feedly_access_token()])
#' @references (<https://developer.feedly.com/v3/search/>) & [Search Tutorial](https://feedly.uservoice.com/knowledgebase/articles/441699-power-search-tutorial)
#' @seealso feedly_search_title
#' @return list with a data frame element of `results`
#' @export
#' @examples
#' feedly_search_contents("data science")
feedly_search_contents <- function(query,
                                   stream_id = NULL,
                                   fields = "all",
                                   embedded = NULL,
                                   engagement = NULL,
                                   count = 20L,
                                   locale = NULL,
                                   feedly_token = feedly_access_token()) {

  ct <- as.integer(count[1])
  if (ct < 1) ct <- 20L
  if (ct > 20) ct <- 20L

  query <- query[1]

  if (length(fields) == 1) {
    fields <- match.arg(fields, c("all", "title", "author", "keywords"))
  } else {
    fields <- match.arg(fields, c("title", "author", "keywords"), several.ok = TRUE)
    fields <- paste0(fields, collapse=",")
  }

  if (!is.null(embedded)) {
    embedded <- match.arg(embedded, c("audio", "video", "doc", "any"))
  }

  if (!is.null(engagement)) {
    engagement <- match.arg(engagement, c("medium", "high"))
  }

  httr::GET(
    url = "https://cloud.feedly.com/v3/search/feeds",
    .seymour_ua,
    if (!is.null(feedly_token)) {
      httr::add_headers(
        `Authorization` = sprintf("OAuth %s", feedly_token)
      )
    },
    query = list(
      stream_id = stream_id,
      query = query,
      fields = fields,
      embedded = embedded,
      engagement = engagement,
      count = ct,
      locale = locale
    )
  ) -> res

  httr::stop_for_status(res)

  out <- httr::content(res, as="text")

  out <- jsonlite::fromJSON(out)

  if (length(out$results) > 0) {
    if (nrow(out$results) > 0) {
      class(out$results) <- c("tbl_df", "tbl", "data.frame")
    }
  }

  out

}
