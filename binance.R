#install.packages("testthat")
#remotes::install_github("datawookie/binance")

library(binance)
library(testthat)

test_check("binance")

rlang::last_error()

authenticate(
  key = Sys.getenv("BINANCE_API_KEY"),
  secret = Sys.getenv("BINANCE_API_SECRET")
)
packageVersion("binance")