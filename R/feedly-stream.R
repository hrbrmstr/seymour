#' Retrieve contents of a Feedly "stream"
#'
#' Authorization is _optional_ for this API call **unless** you are fetching
#' _category_ or _tag_ streams (i.e. a stream for an RSS feed requires no
#' authentication). Pass in `NULL` to `feedly_token` to make unauthenticated calls
#' to this API endpoint.
#'
#' @return
#' This endpoint returns a `list` with the following entries:
#'- `id`:
#'  string the stream id, repeated.
#'- `updated`:
#'  Optional timestamp the timestamp, in ms, of the most recent entry for this stream (regardless of continuation, newerThan, etc).
#'- `continuation`:
#'  Optional string the continuation id to pass to the next stream call, for pagination. This id guarantees that no entry will be duplicated in a stream (meaning, there is no need to de-duplicate entries returned by this call). If this value is not returned, it means the end of the stream has been reached.
#'- `title`:
#'  Optional string for single feeds only, the feed title.
#'- `direction`:
#'  Optional string for single feeds only, the feed direction ("ltr" or "rtl").
#'- `alternate`:
#'  Optional link object for single feeds only, the feed website URL and type.
#'- `items`:
#'  entry array See the entries API for a description of the fields.
#'
#' The `items` component is a data frame Entries roughly follow the
#' Atom format. Here is a list of fields you can expect to receive:
#'
#' - `id`:
#'   string the unique, immutable ID for this particular article.
#' - `title`:
#'   Optional string the article’s title. This string does not contain any HTML markup.
#' - `content`:
#'   Optional content object the article content. This object typically has two values: “content” for the content itself, and “direction” (“ltr” for left-to-right, “rtl” for right-to-left). The content itself contains sanitized HTML markup.
#' - `summary`:
#'   Optional content object the article summary. See the content object above.
#' - `author`:
#'   Optional string the author’s name
#' - `crawled`:
#'   timestamp the immutable timestamp, in ms, when this article was processed by the feedly Cloud servers.
#' - `recrawled`:
#'   Optional timestamp the timestamp, in ms, when this article was re-processed and updated by the feedly Cloud servers.
#' - `published`:
#'   timestamp the timestamp, in ms, when this article was published, as reported by the RSS feed (often inaccurate).
#' - `updated`:
#'   Optional timestamp the timestamp, in ms, when this article was updated, as reported by the RSS feed
#' - `alternate`:
#'   Optional link object array a list of alternate links for this article. Each link object contains a media type and a URL. Typically, a single object is present, with a link to the original web page.
#' - `origin`:
#'   Optional origin object the feed from which this article was crawled. If present, “streamId” will contain the feed id, “title” will contain the feed title, and “htmlUrl” will contain the feed’s website.
#' - `keywords`:
#'   Optional string array a list of keyword strings extracted from the RSS entry.
#' - `visual`:
#'   Optional visual object an image URL for this entry. If present, “url” will contain the image URL, “width” and “height” its dimension, and “contentType” its MIME type.
#' - `unread`:
#'   boolean was this entry read by the user? If an Authorization header is not provided, this will always return false. If an Authorization header is provided, it will reflect if the user has read this entry or not.
#' - `tags`:
#'   Optional tag object array a list of tag objects (“id” and “label”) that the user added to this entry. This value is only returned if an Authorization header is provided, and at least one tag has been added. If the entry has been explicitly marked as read (not the feed itself), the “global.read” tag will be present.
#' - `categories`:
#'   category object array a list of category objects (“id” and “label”) that the user associated with the feed of this entry. This value is only returned if an Authorization header is provided.
#' - `engagement`:
#'   Optional integer an indicator of how popular this entry is. The higher the number, the more readers have read, saved or shared this particular entry.
#' - `actionTimestamp`:
#'   Optional timestamp for tagged articles, contains the timestamp when the article was tagged by the user. This will only be returned when the entry is returned through the streams API.
#' - `enclosure`:
#'   Optional link object array a list of media links (videos, images, sound etc) provided by the feed. Some entries do not have a summary or content, only a collection of media links.
#' - `fingerprint`:
#'   string the article fingerprint. This value might change if the article is updated.
#' - `originId`:
#'   string the unique id of this post in the RSS feed (not necessarily a URL!)
#' - `sid`:
#'   Optional string an internal search id.
#'
#' @md
#' @param stream_id the id of the stream
#' @param ranked one of "`newest`" or "`oldest`" (date order sort return). Default is "`newest`".
#' @param unread_only if `TRUE` will only return unread itemm (default is `FALSE`)
#' @param count numnber of items to retrieve (API will only return a max of 1,000
#'        items for a single response and populate `continuation`
#'        with a value that should be passed to subsequent calls
#'        to page through the results; `count` will be reset to 1,000
#'        internally if this is the case)
#' @param continuation pagination parameter (retrieved from previous API call)
#' @param feedly_token Your Feedly Developer Access Token (see [feedly_access_token()])
#' @note Feed ids, category ids, tag ids or a system category id can be used as stream ids.
#' @references (<https://developer.feedly.com/v3/streams/>)
#' @export
feedly_stream <- function(stream_id,
                          ranked = c("newest", "oldest"),
                          unread_only = FALSE,
                          # newer_than = NULL,
                          count = 1000L,
                          continuation = NULL,
                          feedly_token = feedly_access_token()) {

  ct <- as.integer(count)

  if (!is.null(continuation)) ct <- 1000L

  if (ct > 1000L) ct <- 1000L
  if (ct < 1L) ct <- 1000L

  ranked <- match.arg(ranked[1], c("newest", "oldest"))

  # if (!is.null(newer_than)) {
  #   newer_than <- as.numeric(as.POSIXct(newer_than))*1000
  # }

  httr::GET(
    url = "https://cloud.feedly.com/v3/streams/contents",
    if (!is.null(feedly_token)) {
      httr::add_headers(
        `Authorization` = sprintf("OAuth %s", feedly_token)
      )
    },
    query = list(
      streamId = stream_id,
      ranked = ranked,
      unreadOnly = if (unread_only) "true" else "false",
      # newerThan = newer_than,
      count = ct,
      continuation = continuation
    )
  ) -> res

  httr::stop_for_status(res)

  res <- httr::content(res, as="text")
  res <- jsonlite::fromJSON(res)

  res

}

# @param newer_than Return posts newer than this value. `POSIXct` timestamp or ISO string
#        convertable to a `POSIXct` object. Default is `NULL` and specifying
#        this value is optional (will be ignored if left `NULL`)
