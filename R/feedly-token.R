#' Retrieve the Feedly Developer Token
#'
#' This function looks for the "`FEEDLY_ACCESS_TOKEN`" environment variables and
#' will prompt for them if not found (See `Details` for more information):
#' \cr
#' Feedly developer API tokens can be obtained from
#' the [Feedly Developer Site](https://developer.feedly.com/v3/developer/).
#' \cr
#' NOTE: A Feedly account is required to obtain a Feedly developer access token.
#' and there are no current `seymour` package plans to support OAuth or access token
#' refreshes at this time.
#'
#' @md
#' @references (<https://developer.feedly.com/v3/developer/#what-is-a-developer-access-token>)
#' @export
feedly_access_token <- function() {

  env <- Sys.getenv("FEEDLY_ACCESS_TOKEN")

  if (!identical(env, "")) return(env)

  if (!interactive()) {
    stop(
      "Please set env var FEEDLY_ACCESS_TOKEN to your Feedly Developer Access Token",
      call. = FALSE
    )
  }

  message("Couldn't find env var FEEDLY_ACCESS_TOKEN See ?feedly_access_token for more details.")
  message("Please enter your Feedly Developer Access Token and press enter:")

  pat <- readline(": ")

  if (identical(pat, "")) {
    stop("Feedly Developer Access Token entry failed", call. = FALSE)
  }

  message("Updating FEEDLY_ACCESS_TOKEN env var with input; consider setting this in your ~/.Renviron file.")

  Sys.setenv(FEEDLY_ACCESS_TOKEN = pat)

  pat

}

