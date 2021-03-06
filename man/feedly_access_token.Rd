% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/feedly-token.R
\name{feedly_access_token}
\alias{feedly_access_token}
\title{Retrieve the Feedly Developer Token}
\usage{
feedly_access_token()
}
\description{
This function looks for the "\code{FEEDLY_ACCESS_TOKEN}" environment variables and
will prompt for them if not found (See \code{Details} for more information):
\cr
Feedly developer API tokens can be obtained from
the \href{https://developer.feedly.com/v3/developer/}{Feedly Developer Site}.
\cr
NOTE: A Feedly account is required to obtain a Feedly developer access token.
and there are no current \code{seymour} package plans to support OAuth or access token
refreshes at this time.
}
\references{
(\url{https://developer.feedly.com/v3/developer/#what-is-a-developer-access-token})
}
