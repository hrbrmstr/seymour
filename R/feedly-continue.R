#' Helper function to iterate through a [feedly_stream()] result set
#'
#' The [feedly_stream()] function will return a `continuation` field if
#' there are more results than the max asked for. You can use this function
#' to iterate `max` more times (or less if there are fewer than `n` additional
#' result sets to retrieve).
#'
#' @md
#' @param start the result of a first call to [feedly_stream()]
#' @param max max further `continuation` iterations to follow. If `max` equals
#'        `0` (the default) this function will iterate until there are no more
#'        results.
#' @param progress if `TRUE` then display simple progress as the API calls are
#'        made. Default is `FALSE`.
#' @export
#' @examples
#' r_bloggers_feed_id <- "feed/http://feeds.feedburner.com/RBloggers"
#'
#' feedly_stream(r_bloggers_feed_id, count = 1000L) %>%
#'   feedly_continue(rb_stream, 2) -> rb_stream
feedly_continue <- function(start, max = 0L, .progress = FALSE) {

  # if there were no more entries to begin with
  if (length(start$continuation) == 0) return(start)

  streams <- vector("list")

  streams[1L] <- list(start$items)

  idx <- 2L

  while(length(start$continuation) > 0) {

    if (.progress) cat(".")

    feedly_stream(
      stream_id = start$id,
      count = 1000L, # 1000 is the API max so use it
      continuation = start$continuation
    ) -> start

    streams[idx] <- list(start$items)

    if ((max != 0) && ((idx-1) == max)) break

    idx <- idx + 1L

  }

  if (.progress) cat("\n")

  bind_rows(streams)

}