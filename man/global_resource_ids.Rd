% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/feedly-global-resource-ids.R
\name{global_resource_ids}
\alias{global_resource_ids}
\title{Global Resource Ids}
\description{
The following is a list of built-in categories and tags applications can take advantage of. These ids are not returned by the APIs directly, they must be constructed in code.
}
\section{Id List}{

\itemize{
\item \verb{user/:userId/category/global.all}
All articles from all the feeds the user subscribes to (example: \verb{user/c805fcbf-3acf-4302-a97e-d82f9d7c897f/category/global.all})
\item \verb{user/:userId/category/global.uncategorized}
All the articles from all the sources the user subscribes to and are not in a category (example: \verb{user/c805fcbf-3acf-4302-a97e-d82f9d7c897f/category/global.uncategorized})
\item \verb{user/:userId/category/global.must}
Users can promote sources they really love to read to must have (example: \verb{user/c805fcbf-3acf-4302-a97e-d82f9d7c897f/category/global.must})
\item \verb{user/:userId/tag/global.read’ List of entries the user has recently read - limited to the feeds the users subscribes to (example: }user/c805fcbf-3acf-4302-a97e-d82f9d7c897f/tag/global.read`)
\item \verb{user/:userId/tag/global.saved}
Users can save articles for later. Equivalent of starring articles in Google Reader (example: \verb{user/c805fcbf-3acf-4302-a97e-d82f9d7c897f/tag/global.saved})
\item \verb{user/:userId/tag/global.all}
All articles from all personal tags, including global.saved (example: \verb{user/c805fcbf-3acf-4302-a97e-d82f9d7c897f/tag/global.all})
\item \verb{enterprise/:enterpriseName/category/global.all}
All articles from all team feeds (example: \code{enterprise/acmeinc/category/global.all})
\item \verb{enterprise/:enterpriseName/tags/global.all}
All articles from all team tags (example: \code{enterprise/acmeinc/tags/global.all})
\item \verb{user/:userId/category/global.enterprise}
All articles from all the team categories a user is following (example: \verb{user/c805fcbf-3acf-4302-a97e-d82f9d7c897f/category/global.enterprise})
\item \verb{user/:userId/tag/global.enterprise}
All articles from all the team tags a user is subscribed to (example: \verb{user/c805fcbf-3acf-4302-a97e-d82f9d7c897f/tag/global.enterprise})
}
}

\references{
(\url{https://developer.feedly.com/cloud/})
}
