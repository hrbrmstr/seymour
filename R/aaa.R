.seymour_ua <- httr::user_agent(sprintf(
  "seymour R package %s; (<https://github.com/hrbrmstr/seymour>)",
  utils::packageVersion("seymour")
))