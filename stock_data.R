library(quantmod)
library(tidyr)
library(dplyr)


# arguments for getSymbols
start_date <- as.Date("2016-01-10")
end_date <- as.Date("2018-01-10")

#  closing prices
ticker <- c("TSLA", "MSFT", "AAPL", "TWTR", "AMZN", "FB", "GOOG")

# load the data into the environment
getSymbols(ticker, src = "yahoo", from = start_date, to = end_date)

stocks <- merge.xts(TSLA, MSFT, AAPL, TWTR, AMZN, FB, GOOG)

stocks_df <- as.data.frame(stocks) %>% 
    rownames_to_column() %>% 
    rename(date = rowname) %>% 
    select(date, ends_with(".Close"))


# tidy the data
stock_tidy <- stocks_df %>% 
    gather(ends_with(".Close"), key = "company", value = "stock_closing")

# export
write.csv(stock_tidy, file = "data/stock_data.csv", row.names = FALSE)
