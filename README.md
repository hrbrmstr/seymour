
![](man/figures/venus-fly-trap.jpg)

# seymour

Tools to Work with the ‘Feedly’ ‘API’

## Description

‘Feedly’ is a news aggregator application for various web browsers and
mobile devices running ‘iOS’ and ‘Android’, also available as a
cloud-based service. It compiles news feeds from a variety of online
sources for the user to customize and share with others. Methods are
provided to retrieve information about and contents of ‘Feedly’
collections and streams.

## What’s Inside The Tin

The following API functions are implemented:

  - `feedly_access_token`: Retrieve the Feedly Developer Token
  - `feedly_collections`: Retrieve Feedly Connections
  - `feedly_feed_meta`: Retrieve Metadata for a Feed
  - `feedly_opml`: Retrieve Your Feedly OPML File
  - `feedly_profile`: Retrieve Your Feedly Profile
  - `feedly_search_contents`: Search content of a stream
  - `feedly_search_title`: Find feeds based on title, url or ‘\#topic’
  - `feedly_stream`: Retrieve contents of a Feedly “stream”
  - `feedly_tags`: Retrieve List of Tags

The following helper functions are åvailable:

  - `render_stream`: Render a Feedly Stream Data Frame to RMarkdown

The following helper references are available:

  - `global_resource_ids`: Global Resource Ids Helper Reference

## Authentication (README)

You need a developer token to access most of the API endpoints. You can
do that via links provdied by (<https://developer.feedly.com/v3/auth/>).
There are no plans to support OAuth or token refreshing unless there is
sufficient demand via Git\[la|hu\]b issues & issue votes.

### NOT ALL ENDPOINTS REQUIRE AUTHENTICATION

Neither `feedly_search_title()` nor `feedly_stream()` require
authentication (i.e. you do not need a developer token) to retrieve the
contents of the API call. For `feedly_stream()` You *do* need to know
the Feedly-structured feed id which is (generally) `feed/FEED_URL` (e.g.
`feed/http://feeds.feedburner.com/RBloggers`).

## Installation

``` r
devtools::install_github("hrbrmstr/seymour")
```

## Usage

``` r
library(seymour)
library(tidyverse) # mostly for printing

# current verison
packageVersion("seymour")
```

    ## [1] '0.1.0'

### Collections

``` r
coll <- feedly_collections()

filter(coll, title == "R-bloggers") %>% 
  glimpse()
```

    ## Observations: 1
    ## Variables: 33
    ## $ id                <chr> "user/c45e5b02-5a96-464c-bf77-4eea75409c3d/category/big data viz"
    ## $ feedId            <chr> "feed/http://feeds.feedburner.com/RBloggers"
    ## $ title             <chr> "R-bloggers"
    ## $ subscribers       <int> 24514
    ## $ updated           <dbl> 1.546129e+12
    ## $ velocity          <dbl> 44.9
    ## $ website           <chr> "https://www.r-bloggers.com"
    ## $ topics            <list> [<"data science", "data", "tech", "programming">]
    ## $ partial           <lgl> FALSE
    ## $ iconUrl           <chr> "https://storage.googleapis.com/test-site-assets/XGq6cYRY3hH9_vdZr0WOJiPdAe0u6dQ2ddUFEsTq...
    ## $ visualUrl         <chr> "https://storage.googleapis.com/test-site-assets/XGq6cYRY3hH9_vdZr0WOJiPdAe0u6dQ2ddUFEsTq...
    ## $ contentType       <chr> "longform"
    ## $ language          <chr> "en"
    ## $ description       <chr> "R (#rstats), data science, statistics, visualization"
    ## $ customizable      <lgl> TRUE
    ## $ enterprise        <lgl> FALSE
    ## $ label             <chr> "big data viz"
    ## $ created           <dbl> NA
    ## $ coverUrl          <chr> NA
    ## $ coverColor        <chr> NA
    ## $ mustRead          <lgl> NA
    ## $ twitterScreenName <chr> NA
    ## $ twitterFollowers  <int> NA
    ## $ state             <chr> NA
    ## $ valid             <lgl> NA
    ## $ analyticsEngine   <chr> NA
    ## $ analyticsId       <chr> NA
    ## $ logo              <chr> NA
    ## $ relatedLayout     <chr> NA
    ## $ relatedTarget     <chr> NA
    ## $ accentColor       <chr> NA
    ## $ promotion         <list> [NA]
    ## $ wordmark          <chr> NA

### Streams

``` r
feedly_stream(
  stream_id = "feed/http://feeds.feedburner.com/RBloggers",
) -> rbloggers

glimpse(rbloggers$items)
```

    ## Observations: 1,000
    ## Variables: 20
    ## $ id             <chr> "XGq6cYRY3hH9/vdZr0WOJiPdAe0u6dQ2ddUFEsTqP10=_167fc7294e4:49b96a:56b782f7", "XGq6cYRY3hH9/vd...
    ## $ keywords       <list> ["R bloggers", "R bloggers", "R bloggers", "R bloggers", "R bloggers", "R bloggers", "R blo...
    ## $ originId       <chr> "http://www.brodrigues.co/blog/2018-12-30-reticulate/", "https://datascienceplus.com/?p=1948...
    ## $ fingerprint    <chr> "2e6f8adb", "3d7edcd1", "69b6d432", "edd91496", "f7a0066a", "3b0604a5", "69a21e91", "1fc5fb9...
    ## $ title          <chr> "R or Python? Why not both? Using Anaconda Python within R with {reticulate}", "Leaf Plant C...
    ## $ crawled        <dttm> 2018-12-29 19:10:26, 2018-12-29 18:40:05, 2018-12-29 04:59:18, 2018-12-28 19:50:35, 2018-12...
    ## $ published      <dttm> 2018-12-29 19:00:00, 2018-12-29 12:06:13, 2018-12-29 04:26:16, 2018-12-27 19:00:00, 2018-12...
    ## $ canonical      <list> [<https://www.r-bloggers.com/r-or-python-why-not-both-using-anaconda-python-within-r-with-r...
    ## $ author         <chr> "Econometrics and Free Software", "Giorgio Garziano", "chris2016", "r-tastic", "Posts on Maë...
    ## $ alternate      <list> [<http://feedproxy.google.com/~r/RBloggers/~3/3czsWXNA2WI/, text/html>, <http://feedproxy.g...
    ## $ unread         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, F...
    ## $ categories     <list> [<user/c45e5b02-5a96-464c-bf77-4eea75409c3d/category/big data viz, big data viz, R (#rstats...
    ## $ entities       <list> [<c("nlp/f/entity/en/w/Republican Party (United States)", "nlp/f/entity/en/w/Python (progra...
    ## $ engagement     <int> 391, 103, 29, 12, 13, 37, 50, 29, 27, 339, 47, 25, 17, 8, 32, 87, 57, 356, 120, 89, 57, 145,...
    ## $ engagementRate <dbl> 9.77, 2.51, 0.58, 0.22, 0.24, 0.67, 0.89, 0.51, 0.47, 5.84, 0.81, 0.43, 0.29, 0.14, 0.54, 1....
    ## $ enclosure      <list> [NULL, NULL, <c("https://0.gravatar.com/avatar/0d1d3b371182823519a7320ac9f58c4f?s=96&d=iden...
    ## $ tags           <list> [NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, <c("user/c45e5b02-5a96-464c-bf77-4ee...
    ## $ recrawled      <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ...
    ## $ updateCount    <int> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, ...
    ## $ Dropbox        <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, "Clustering the Bible [R-bloggers].html", NA, NA, NA, NA...

``` r
rbloggers$items
```

    ## # A tibble: 1,000 x 20
    ##    id    keywords originId fingerprint title crawled             published           canonical author alternate unread
    ##  * <chr> <list>   <chr>    <chr>       <chr> <dttm>              <dttm>              <list>    <chr>  <list>    <lgl> 
    ##  1 XGq6… <chr [1… http://… 2e6f8adb    R or… 2018-12-29 19:10:26 2018-12-29 19:00:00 <data.fr… Econo… <data.fr… FALSE 
    ##  2 XGq6… <chr [1… https:/… 3d7edcd1    Leaf… 2018-12-29 18:40:05 2018-12-29 12:06:13 <data.fr… Giorg… <data.fr… FALSE 
    ##  3 XGq6… <chr [1… http://… 69b6d432    Part… 2018-12-29 04:59:18 2018-12-29 04:26:16 <data.fr… chris… <data.fr… FALSE 
    ##  4 XGq6… <chr [1… https:/… edd91496    My R… 2018-12-28 19:50:35 2018-12-27 19:00:00 <data.fr… r-tas… <data.fr… FALSE 
    ##  5 XGq6… <chr [1… https:/… f7a0066a    My #… 2018-12-28 14:20:54 2018-12-27 19:00:00 <data.fr… Posts… <data.fr… FALSE 
    ##  6 XGq6… <chr [1… http://… 3b0604a5    Part… 2018-12-28 11:10:43 2018-12-28 03:39:35 <data.fr… chris… <data.fr… FALSE 
    ##  7 XGq6… <chr [1… http://… 69a21e91    Usin… 2018-12-28 07:53:55 2018-12-28 00:48:27 <data.fr… kjytay <data.fr… FALSE 
    ##  8 XGq6… <chr [1… http://… 1fc5fb9b    Some… 2018-12-27 22:22:47 2018-12-26 19:00:00 <data.fr… Econo… <data.fr… FALSE 
    ##  9 XGq6… <chr [1… https:/… e5ba8852    Shou… 2018-12-27 18:55:33 2018-12-26 19:00:00 <data.fr… An Ac… <data.fr… FALSE 
    ## 10 XGq6… <chr [1… http://… 7be23492    Clus… 2018-12-27 12:43:25 2018-12-27 04:00:10 <data.fr… Learn… <data.fr… FALSE 
    ## # ... with 990 more rows, and 9 more variables: categories <list>, entities <list>, engagement <int>,
    ## #   engagementRate <dbl>, enclosure <list>, tags <list>, recrawled <dbl>, updateCount <int>, Dropbox <chr>

### Feed Metadata

``` r
feedly_feed_meta("https://feeds.feedburner.com/rweeklylive") %>% 
  glimpse()
```

    ## Observations: 1
    ## Variables: 9
    ## $ feedId      <chr> "feed/https://feeds.feedburner.com/rweeklylive"
    ## $ id          <chr> "feed/https://feeds.feedburner.com/rweeklylive"
    ## $ title       <chr> "R Weekly Live: R Focus"
    ## $ subscribers <int> 1
    ## $ updated     <dbl> 1.5461e+12
    ## $ velocity    <dbl> 14.9
    ## $ website     <chr> "https://rweekly.org/live"
    ## $ language    <chr> "en"
    ## $ description <chr> "Live Updates from R Weekly"

### OPML Retrieval

``` r
feedly_opml(as = "parsed")
```

    ## {xml_document}
    ## <opml version="1.0">
    ## [1] <head>\n  <title>boB subscriptions in feedly Cloud</title>\n</head>
    ## [2] <body>\n  <outline text="politics" title="politics">\n    <outline type="rss" text="SCOTUSblog" title="SCOTUSblog ...

### Title Search

``` r
rst <- feedly_search_title("data science")
glimpse(rst$results)
```

    ## Observations: 20
    ## Variables: 24
    ## $ deliciousTags       <list> [<"tech", "data science", "big data", "data">, <"statistics", "data science", "data", ...
    ## $ feedId              <chr> "feed/http://feeds.feedburner.com/oreilly/radar/atom", "feed/http://www.stat.columbia.e...
    ## $ title               <chr> "All - O'Reilly Media", "Statistical Modeling, Causal Inference, and Social Science", "...
    ## $ subscribers         <int> 40451, 27254, 24514, 22620, 21982, 17702, 16374, 16230, 16743, 12575, 12276, 11385, 139...
    ## $ lastUpdated         <dbl> 1.546004e+12, 1.546096e+12, 1.546129e+12, 1.545235e+12, 1.545249e+12, 1.545257e+12, 1.5...
    ## $ velocity            <dbl> 7.0, 7.9, 44.9, 0.5, 0.7, 0.2, 28.9, 1.4, 0.2, 2.7, 1.1, 3.2, 0.7, 101.2, 7.9, 0.9, 0.2...
    ## $ website             <chr> "https://www.oreilly.com", "https://andrewgelman.com", "https://www.r-bloggers.com", "h...
    ## $ score               <dbl> 769774.00, 537467.00, 490480.50, 450160.63, 441607.09, 337690.63, 331959.53, 317340.03,...
    ## $ coverage            <dbl> 0.28, 0.22, 0.15, 1.00, 0.81, 1.00, 0.17, 0.82, 1.00, 0.00, 0.00, 0.36, 0.77, 0.00, 0.3...
    ## $ coverageScore       <dbl> 6.53, 9.50, 7.30, 34.95, 9.70, 12.46, 3.97, 8.50, 20.95, 0.00, 0.00, 3.05, 16.80, 0.00,...
    ## $ estimatedEngagement <int> 18, 40, 60, 5, 37, 122, 42, 357, 193, 94, 26, 16, NA, NA, 6, NA, 5, 2, 36, 14
    ## $ hint                <chr> "data science", "data science", "data science", "data science", "data science", "data s...
    ## $ contentType         <chr> "article", "article", "longform", "longform", "article", "article", "article", "article...
    ## $ scheme              <chr> "txt:b:o", "txt:b:o", "txt:b:o", "txt:b:o", "txt:b:o", "txt:b:o", "txt:b:o", "txt:b:o",...
    ## $ language            <chr> "en", "en", "en", "en", "en", "en", "en", "en", "en", "en", "en", "en", "en", "en", "en...
    ## $ description         <chr> "Gain technology and business knowledge and hone your skills with learning resources cr...
    ## $ coverUrl            <chr> "https://storage.googleapis.com/site-assets/qMirhz1mjco2EvJpk-iNKJxH9_amBCnwZm3c9iInyQc...
    ## $ iconUrl             <chr> "https://storage.googleapis.com/site-assets/qMirhz1mjco2EvJpk-iNKJxH9_amBCnwZm3c9iInyQc...
    ## $ partial             <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE...
    ## $ visualUrl           <chr> "https://storage.googleapis.com/site-assets/qMirhz1mjco2EvJpk-iNKJxH9_amBCnwZm3c9iInyQc...
    ## $ coverColor          <chr> "FFFFFF", NA, NA, "C0DEED", "DDDCDC", NA, "0099B9", "FFFFFF", NA, NA, "FFFFFF", NA, NA,...
    ## $ art                 <dbl> 23.68, 43.39, 50.30, 34.95, 11.90, 12.46, 23.08, 10.42, 20.95, 0.00, 0.00, 8.55, 21.87,...
    ## $ twitterScreenName   <chr> NA, NA, NA, NA, "kaggle", NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "b0rk", NA, NA, NA, "...
    ## $ twitterFollowers    <int> NA, NA, NA, NA, 133956, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 104691, NA, NA, NA, 15252

### Contents Search

``` r
rsc <- feedly_search_contents("data science")
glimpse(rsc$results)
```

    ## Observations: 20
    ## Variables: 24
    ## $ deliciousTags       <list> [<"tech", "data science", "big data", "data">, <"statistics", "data science", "data", ...
    ## $ feedId              <chr> "feed/http://feeds.feedburner.com/oreilly/radar/atom", "feed/http://www.stat.columbia.e...
    ## $ title               <chr> "All - O'Reilly Media", "Statistical Modeling, Causal Inference, and Social Science", "...
    ## $ subscribers         <int> 40451, 27254, 24514, 22620, 21982, 17702, 16374, 16230, 16743, 12575, 12276, 11385, 139...
    ## $ lastUpdated         <dbl> 1.546004e+12, 1.546096e+12, 1.546129e+12, 1.545235e+12, 1.545249e+12, 1.545257e+12, 1.5...
    ## $ velocity            <dbl> 7.0, 7.9, 44.9, 0.5, 0.7, 0.2, 28.9, 1.4, 0.2, 2.7, 1.1, 3.2, 0.7, 101.2, 7.9, 0.9, 0.2...
    ## $ website             <chr> "https://www.oreilly.com", "https://andrewgelman.com", "https://www.r-bloggers.com", "h...
    ## $ score               <dbl> 769774.00, 537467.00, 490480.50, 450160.63, 441607.09, 337690.63, 331959.53, 317340.03,...
    ## $ coverage            <dbl> 0.28, 0.22, 0.15, 1.00, 0.81, 1.00, 0.17, 0.82, 1.00, 0.00, 0.00, 0.36, 0.77, 0.00, 0.3...
    ## $ coverageScore       <dbl> 6.53, 9.50, 7.30, 34.95, 9.70, 12.46, 3.97, 8.50, 20.95, 0.00, 0.00, 3.05, 16.80, 0.00,...
    ## $ estimatedEngagement <int> 18, 40, 60, 5, 37, 122, 42, 357, 193, 94, 26, 16, NA, NA, 6, NA, 5, 2, 36, 14
    ## $ hint                <chr> "data science", "data science", "data science", "data science", "data science", "data s...
    ## $ scheme              <chr> "txt:b:o", "txt:b:o", "txt:b:o", "txt:b:o", "txt:b:o", "txt:b:o", "txt:b:o", "txt:b:o",...
    ## $ language            <chr> "en", "en", "en", "en", "en", "en", "en", "en", "en", "en", "en", "en", "en", "en", "en...
    ## $ contentType         <chr> "article", "article", "longform", "longform", "article", "article", "article", "article...
    ## $ description         <chr> "Gain technology and business knowledge and hone your skills with learning resources cr...
    ## $ coverUrl            <chr> "https://storage.googleapis.com/site-assets/qMirhz1mjco2EvJpk-iNKJxH9_amBCnwZm3c9iInyQc...
    ## $ iconUrl             <chr> "https://storage.googleapis.com/site-assets/qMirhz1mjco2EvJpk-iNKJxH9_amBCnwZm3c9iInyQc...
    ## $ partial             <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE...
    ## $ visualUrl           <chr> "https://storage.googleapis.com/site-assets/qMirhz1mjco2EvJpk-iNKJxH9_amBCnwZm3c9iInyQc...
    ## $ coverColor          <chr> "FFFFFF", NA, NA, "C0DEED", "DDDCDC", NA, "0099B9", "FFFFFF", NA, NA, "FFFFFF", NA, NA,...
    ## $ art                 <dbl> 23.68, 43.39, 50.30, 34.95, 11.90, 12.46, 23.08, 10.42, 20.95, 0.00, 0.00, 8.55, 21.87,...
    ## $ twitterScreenName   <chr> NA, NA, NA, NA, "kaggle", NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, "b0rk", NA, NA, NA, "...
    ## $ twitterFollowers    <int> NA, NA, NA, NA, 133956, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, 104691, NA, NA, NA, 15252

### API Usage Rate Limit Info

``` r
fp <- feedly_profile()
fp[grepl("rate_limit", names(fp))]
```

    ## $x_rate_limit_limit
    ## [1] "500"
    ## 
    ## $x_rate_limit_count
    ## [1] "53"
    ## 
    ## $x_rate_limit_reset
    ## [1] "38413"

### Sample Stream Report

``` r
fp <- feedly_profile() # get profile to get my id

# use the id to get my "security" category feed
fs <- feedly_stream(sprintf("user/%s/category/security", fp$id))

# get the top 10 items with engagement >= third quartile of all posts
# and don't include duplicates in the report
mutate(fs$items, published = as.Date(published)) %>% 
  filter(published >= as.Date("2018-12-01")) %>%
  filter(engagement > fivenum(engagement)[4]) %>% 
  filter(!is.na(summary_content)) %>% 
  mutate(alt_url = map_chr(alternate, ~.x[[1]])) %>% 
  distinct(alt_url, .keep_all = TRUE) %>% 
  slice(1:10) -> for_report

# render the report
render_stream(
  feedly_stream = for_report, 
  title = "Cybersecurity News", 
  include_visual = TRUE,
  browse = TRUE
)
```

Click on the following to see the complete
render:

<center>

<a href="sample-report.jpg"><img src="report-thumb.png"/></a>

</center>

## Package Code Metrics

``` r
cloc::cloc_pkg_md()
```

| Lang | \# Files |  (%) | LoC | (%) | Blank lines |  (%) | \# Lines |  (%) |
| :--- | -------: | ---: | --: | --: | ----------: | ---: | -------: | ---: |
| R    |       16 | 0.94 | 356 | 0.9 |         138 | 0.73 |      331 | 0.81 |
| Rmd  |        1 | 0.06 |  40 | 0.1 |          50 | 0.27 |       76 | 0.19 |

## Image Credit

<!-- HTML Credit Code for Can Stock Photo -->

<a href="https://www.canstockphoto.com">(c) Can Stock Photo /
lineartestpilot</a>
