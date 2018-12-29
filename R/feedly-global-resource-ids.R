#' Global Resource Ids
#'
#' @name global_resource_ids
#' @rdname global_resource_ids
#' @description The following is a list of built-in categories and tags applications can take advantage of. These ids are not returned by the APIs directly, they must be constructed in code.
#' @references (<https://developer.feedly.com/cloud/>)
#' @md
#' @section Id List:
#'
#' - `user/:userId/category/global.all`
#'     All articles from all the feeds the user subscribes to (example: `user/c805fcbf-3acf-4302-a97e-d82f9d7c897f/category/global.all`)
#' - `user/:userId/category/global.uncategorized`
#'     All the articles from all the sources the user subscribes to and are not in a category (example: `user/c805fcbf-3acf-4302-a97e-d82f9d7c897f/category/global.uncategorized`)
#' - `user/:userId/category/global.must`
#'     Users can promote sources they really love to read to must have (example: `user/c805fcbf-3acf-4302-a97e-d82f9d7c897f/category/global.must`)
#' - `user/:userId/tag/global.read’
#'     List of entries the user has recently read - limited to the feeds the users subscribes to (example: `user/c805fcbf-3acf-4302-a97e-d82f9d7c897f/tag/global.read`)
#' - `user/:userId/tag/global.saved`
#'     Users can save articles for later. Equivalent of starring articles in Google Reader (example: `user/c805fcbf-3acf-4302-a97e-d82f9d7c897f/tag/global.saved`)
#' - `user/:userId/tag/global.all`
#'     All articles from all personal tags, including global.saved (example: `user/c805fcbf-3acf-4302-a97e-d82f9d7c897f/tag/global.all`)
#' - `enterprise/:enterpriseName/category/global.all`
#'     All articles from all team feeds (example: `enterprise/acmeinc/category/global.all`)
#' - `enterprise/:enterpriseName/tags/global.all`
#'     All articles from all team tags (example: `enterprise/acmeinc/tags/global.all`)
#' - `user/:userId/category/global.enterprise`
#'     All articles from all the team categories a user is following (example: `user/c805fcbf-3acf-4302-a97e-d82f9d7c897f/category/global.enterprise`)
#' - `user/:userId/tag/global.enterprise`
#'     All articles from all the team tags a user is subscribed to (example: `user/c805fcbf-3acf-4302-a97e-d82f9d7c897f/tag/global.enterprise`)
NULL