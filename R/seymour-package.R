#' Tools to Work with the 'Feedly' 'API'
#'
#' \if{html}{
#' \figure{venus-fly-trap.jpg}{options: alt="Figure: venus-fly-trap.jpg"}
#' }
#'
#' \if{latex}{
#' \figure{venus-fly-trap.jpg}
#' }
#'
#' 'Feedly' is a news aggregator application for various web browsers and
#' mobile devices running 'iOS' and 'Android', also available as a cloud-based
#' service. It compiles news feeds from a variety of online sources for the
#' user to customize and share with others. Methods are provided to retrieve
#' information about and contents of 'Feedly' collections and streams.
#'
#' @note Neither [feedly_search()] nor [feedly_stream()] require authentication
#'      (i.e. you do not need a developer token) to retrieve the contents of the
#'      API call. For `feedly_stream()` You _do_ need to know the
#'      Feedly-structured feed id which is (generally) `feed/FEED_URL`
#'      (e.g. `feed/http://feeds.feedburner.com/RBloggers`).
#'
#'
#' - URL: <https://gitlab.com/hrbrmstr/seymour>
#' - BugReports: <https://gitlab.com/hrbrmstr/seymour/issues>
#'
#' @md
#' @name seymour
#' @docType package
#' @author Bob Rudis (bob@@rud.is)
#' @import httr
#' @importFrom xml2 read_html xml_find_first xml_find_all xml_text xml_attr
#' @importFrom jsonlite fromJSON
#' @importFrom utils packageVersion
NULL
