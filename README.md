
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

The following functions are implemented:

  - `feedly_access_token`: Retrieve the Feedly Developer Token
  - `feedly_connections`: Retrieve Feedly Connections
  - `feedly_stream`: Retrieve contents of a Feedly “stream”

## Authentication (README)

You need a developer token to access most of the API endpoints. You can
do that via links provdied by (<https://developer.feedly.com/v3/auth/>).
There are no plans to support OAuth or token refreshing unless there is
sufficient demand via Git\[la|hu\]b issues & issue votes.

### NOT ALL ENDPOINTS REQUIRE AUTHENTICATION

If you pass in a Feedly-structured feed id to `feedly_stream()` you do
**not** need to authenticate (i.e. you do not need a developer token) to
retrieve the contents. You *do* need to know the Feedly-structured feed
id which is (generally) `feed/FEED_URL` (e.g.
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

### Basic Usage

``` r
coll <- feedly_connections()

filter(coll, title == "R-bloggers") %>% 
  glimpse()
```

    ## Observations: 1
    ## Variables: 33
    ## $ id                <chr> "user/c45e5b02-5a96-464c-bf77-4eea75409c3d/category/big data viz"
    ## $ feedId            <chr> "feed/http://feeds.feedburner.com/RBloggers"
    ## $ title             <chr> "R-bloggers"
    ## $ subscribers       <int> 24499
    ## $ updated           <dbl> 1.546002e+12
    ## $ velocity          <dbl> 47.6
    ## $ website           <chr> "https://www.r-bloggers.com"
    ## $ topics            <list> [<"data science", "data", "tech", "programming">]
    ## $ partial           <lgl> FALSE
    ## $ iconUrl           <chr> "https://storage.googleapis.com/test-site-assets/XGq6cYRY3hH9_vdZr0WOJiPdAe0u6dQ2ddUFEsTq...
    ## $ visualUrl         <chr> "https://storage.googleapis.com/test-site-assets/XGq6cYRY3hH9_vdZr0WOJiPdAe0u6dQ2ddUFEsTq...
    ## $ language          <chr> "en"
    ## $ contentType       <chr> "longform"
    ## $ description       <chr> "R (#rstats), data science, statistics, visualization"
    ## $ customizable      <lgl> TRUE
    ## $ enterprise        <lgl> FALSE
    ## $ label             <chr> "big data viz"
    ## $ created           <dbl> NA
    ## $ coverUrl          <chr> NA
    ## $ coverColor        <chr> NA
    ## $ twitterScreenName <chr> NA
    ## $ twitterFollowers  <int> NA
    ## $ mustRead          <lgl> NA
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

``` r
feedly_stream(
  stream_id = "feed/http://feeds.feedburner.com/RBloggers",
) -> items

str(items, 2)
```

    ## List of 7
    ##  $ id          : chr "feed/http://feeds.feedburner.com/RBloggers"
    ##  $ title       : chr "R-bloggers"
    ##  $ direction   : chr "ltr"
    ##  $ updated     : num 1.55e+12
    ##  $ alternate   :'data.frame':    1 obs. of  2 variables:
    ##   ..$ href: chr "https://www.r-bloggers.com"
    ##   ..$ type: chr "text/html"
    ##  $ continuation: chr "164f3604c54:6d51e6:b0312b22"
    ##  $ items       :'data.frame':    1000 obs. of  21 variables:
    ##   ..$ id            : chr [1:1000] "XGq6cYRY3hH9/vdZr0WOJiPdAe0u6dQ2ddUFEsTqP10=_167f4e0d7b3:803437:5f10326c" "XGq6cYRY3hH9/vdZr0WOJiPdAe0u6dQ2ddUFEsTqP10=_167f2d5f3ce:4815a:875042c9" "XGq6cYRY3hH9/vdZr0WOJiPdAe0u6dQ2ddUFEsTqP10=_167f21839a7:527b94:b77f238b" "XGq6cYRY3hH9/vdZr0WOJiPdAe0u6dQ2ddUFEsTqP10=_167f0c38a0a:393593:5f10326c" ...
    ##   ..$ keywords      :List of 1000
    ##   ..$ originId      : chr [1:1000] "http://statisticaloddsandends.wordpress.com/?p=804" "http://www.brodrigues.co/blog/2018-12-27-fun_gganimate/" "https://joachim-gassen.github.io/2018/12/should-old-acquaintance-be-forgot-tidying-up-mac-mail/" "http://blog.ephorie.de/?p=225" ...
    ##   ..$ fingerprint   : chr [1:1000] "69a21e91" "1fc5fb9b" "e5ba8852" "7be23492" ...
    ##   ..$ content       :'data.frame':   1000 obs. of  2 variables:
    ##   ..$ title         : chr [1:1000] "Using emojis as scatterplot points" "Some fun with {gganimate}" "Should Old Acquaintance be Forgot: Tidying up Mac Mail" "Clustering the Bible" ...
    ##   ..$ crawled       : num [1:1000] 1.55e+12 1.55e+12 1.55e+12 1.55e+12 1.55e+12 ...
    ##   ..$ published     : num [1:1000] 1.55e+12 1.55e+12 1.55e+12 1.55e+12 1.55e+12 ...
    ##   ..$ canonical     :List of 1000
    ##   ..$ summary       :'data.frame':   1000 obs. of  2 variables:
    ##   ..$ origin        :'data.frame':   1000 obs. of  3 variables:
    ##   ..$ author        : chr [1:1000] "kjytay" "Econometrics and Free Software" "An Accounting and Data Science Nerd's Corner" "Learning Machines" ...
    ##   ..$ enclosure     :List of 1000
    ##   ..$ alternate     :List of 1000
    ##   ..$ visual        :'data.frame':   1000 obs. of  5 variables:
    ##   ..$ unread        : logi [1:1000] TRUE TRUE TRUE TRUE TRUE TRUE ...
    ##   ..$ engagement    : int [1:1000] 13 21 25 272 41 21 16 8 28 87 ...
    ##   ..$ engagementRate: num [1:1000] 0.68 0.57 0.61 5.79 0.85 0.44 0.32 0.15 0.53 1.61 ...
    ##   ..$ webfeeds      :'data.frame':   1000 obs. of  1 variable:
    ##   ..$ recrawled     : num [1:1000] NA NA NA NA NA NA NA NA NA NA ...
    ##   ..$ updateCount   : int [1:1000] NA NA NA NA NA NA NA NA NA NA ...

## Package Code Metrics

``` r
cloc::cloc_pkg_md()
```

| Lang | \# Files |  (%) | LoC | (%) | Blank lines |  (%) | \# Lines |  (%) |
| :--- | -------: | ---: | --: | --: | ----------: | ---: | -------: | ---: |
| R    |        8 | 0.89 | 120 | 0.9 |          45 | 0.62 |      155 | 0.81 |
| Rmd  |        1 | 0.11 |  13 | 0.1 |          27 | 0.38 |       36 | 0.19 |

## Image Credit

<!-- HTML Credit Code for Can Stock Photo -->

<a href="https://www.canstockphoto.com">(c) Can Stock Photo /
lineartestpilot</a>
