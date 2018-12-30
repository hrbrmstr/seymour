tmpl <- "

### {title}

**URL**: [{prt_url}]({alt_url})  \n**Published**: {published}  \n

{vis}

{summary_content}

<a class='lnk' href='{alt_url}'></a>

<center><span style='font-size:32pt; padding-bottom:12pt;'>&Cconint;</span><br/></center>
"


#' Render a Feedly Stream Data Frame to RMarkdown
#'
#' This function takes a minimalist approach to formatting an R Markdown
#' document from the contents of a Feedly stream. It uses the feed item
#' title, URL (first `alternate` one), published data and summary content to make
#' each entry.
#'
#' @md
#' @param feedly_stream output from [feedly_stream()]. Ideally, you'll filter
#'        this so it has a minimal number of elements (unless you like scrolling
#'        through large HTML documents)
#' @param title A title for your "report"
#' @param include_visual if `TRUE` then any `visual_url` image content will
#'        be rendered with the summary text. Default is `FALSE`.
#' @param browse if `TRUE` open the HTML document for viewing. Default is `FALSE`
#' @param quiet passed on to [rmarkdown::render()]. Default is `TRUE`.
#' @note This function requires that `htmltools`, `rmarkdown` and `glue` are installed
#'       on your system.
#' @return a list with the contents of the R Markdown document and the
#'         rendered HTML file (so you can save/tweak before publishing).
#' @export
render_stream <- function(feedly_stream,
                          title = "Feedly Stream Summary",
                          include_visual = FALSE,
                          browse = FALSE,
                          quiet = TRUE) {

  if (!requireNamespace("htmltools", quietly = TRUE)) {
    stop("htmltools must be installed to use this function", call. = FALSE)
  }

  if (!requireNamespace("rmarkdown", quietly = TRUE)) {
    stop("rmarkdown must be installed to use this function", call. = FALSE)
  }

  if (!requireNamespace("glue", quietly = TRUE)) {
    stop("glue must be installed to use this function", call. = FALSE)
  }

  tf <- tempfile(fileext = ".Rmd")

  feedly_stream$vis <- ""

  feedly_stream$alt_url <- sapply(feedly_stream$alternate, function(.x) .x[[1]])

  ifelse(
    test = nchar(feedly_stream$alt_url) > 75,
    yes = sprintf("%s&hellip;", substr(feedly_stream$alt_url, 1, 75)),
    no = feedly_stream$alt_url
  ) -> feedly_stream$prt_url

  if (include_visual) {

    ifelse(
      test = (grepl("image", feedly_stream$visual_contenttype) &
                ((!is.na(feedly_stream$visual_url)) |
                   (feedly_stream$visual_url != ""))),
      yes = sprintf("![](%s)", feedly_stream$visual_url),
      no = ""
    ) -> feedly_stream$vis

  }

  bs <- "\\"

  cat(glue::glue(
    "---
title: {title}
output:
  html_document:
    self_contained: false
---

```{{css, echo=FALSE}}
html, body, div {{
  font-family: 'Lato', 'Helvetica', 'sans-serif'
}}

a:link, a:visited, a:hover, a:active {{
  text-decoration: none;
  color: #6a3d9a;
}}

a.lnk::before {{
  content: '{bs}01F517';
}}
```

"), file = tf)

  cat(
    glue::glue_data(feedly_stream, tmpl),
    file = tf, append = TRUE, sep = ""
  )

  of <- rmarkdown::render(tf, quiet=quiet)

  on.exit(unlink(tf), add=TRUE)
  on.exit(unlink(of), add=TRUE)

  list(
    rmd = rawToChar(readBin(tf, "raw", n = file.size(tf))),
    html = rawToChar(readBin(of, "raw", n = file.size(of)))
  ) -> out

  if (browse) htmltools::html_print(htmltools::HTML(out$html))

  invisible(out)

}

