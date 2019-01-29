#' Show Feedly Categories
#'
#' Utility function to just return category names and ids from your
#' Feedly collections. Authentication is _required_.
#'
#' @param feedly_token Your Feedly Developer Access Token (see [feedly_access_token()])
#' @export
feedly_categories <- function(feedly_token = feedly_access_token()) {
  col <- feedly_collections(feedly_token = feedly_token)
  col <- unique(col[grepl("/category/", col$id), c("label", "id")])
  col <- col[order(tolower(col$label)), ]
  class(col) <- c("tbl_df", "tbl", "data.frame")
  col
}