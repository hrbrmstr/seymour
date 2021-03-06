% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/feedly-refresh-token.R
\name{feedly_refresh_token}
\alias{feedly_refresh_token}
\title{Generate a Feedly Refresh Token}
\usage{
feedly_refresh_token(feedly_token = feedly_access_token())
}
\arguments{
\item{feedly_token}{Your Feedly Developer Access Token (see \code{\link[=feedly_access_token]{feedly_access_token()}})}
}
\description{
Stick this into \code{FEEDLY_ACCESS_TOKEN} when obtained.
}
\references{
(\url{https://developer.feedly.com/v3/auth/#refreshing-an-access-token})
}
