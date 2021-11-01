library(knitr)
library(tidyverse)
library(httr)
library(jsonlite)
library(plotly)
library(patchwork)
library(cowplot)
library(network)
library(ggraph)
library(networkDynamic)
library(ndtv)
library(tsna)

#install.packages("patchwork", "cowplot", "network", "ggraph", "networkDynamic", "ndtv", "tsna")


# EtherScan requires a token, have a look at their website. This is my token but please use your own!
EtherScanAPIToken <- "UJP16VCE9D29XFAA86RWADATJ5K4PBSYD9"

dataEventTransferList <- list()
continue <- 1
i <- 0

while(continue == 1){ # we will run trough the earliest blocks mentioning Weird whales to the most recent.
  i <- i + 1
  print(i)
  if(i == 1){fromBlock = 12856383} #first block mentioning Weird Whale contract

  # load the transfer events from the Weird Whale contract
  resEventTransfer <- GET("https://api.etherscan.io/api",
                          query = list(module = "logs",
                                       action = "getLogs",
                                       fromBlock = fromBlock,
                                       toBlock = "latest",
                                       address = "0x96ed81c7f4406eff359e27bff6325dc3c9e042bd", # address of the Weird Whale contract
                                       topic0 = "0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef", # hash of the transfer event
                                       apikey = EtherScanAPIToken))

  dataEventTransferList[[i]] <- fromJSON(rawToChar(resEventTransfer$content), flatten = T)$result %>%
    select(-gasPrice, -gasUsed, -logIndex) # reformat the data in a dataframe

  if(i > 1){
    if(all_equal(dataEventTransferList[[i]], dataEventTransferList[[i-1]]) == T){continue <- 0}
  } # at some point, we reached the latest transactions and we can stop

  fromBlock <- max(as.numeric(dataEventTransferList[[i]]$blockNumber)) # increase the block to start looking at for the next iteration
}

dataEventTransfer <- bind_rows(dataEventTransferList) %>% # coerce the list to dataframe
  distinct() # eliminate potential duplicated rows

# data needs to be reshaped
dataEventTransfer <- dataEventTransfer %>%
  rename(contractAddress = address) %>%
  mutate(dateTime = as.POSIXct(as.numeric(timeStamp), origin = "1970-01-01")) %>% # convert the date in a human readable format
  mutate(topics = purrr::map(topics, setNames, c("eventHash","fromAddress","toAddress","tokenId"))) %>% # it is important to set the names otherwise unnest_wider will print many warning messages.
  unnest_wider(topics) %>% # reshape the topic column (list) to get a column for each topic.
  mutate(tokenId = as.character(as.numeric(tokenId)), # convert Hexadecimal to numeric
         blockNumber = as.numeric(blockNumber),
         fromAddress = paste0("0x", str_sub(fromAddress,-40,-1)), # reshape the address format
         toAddress = paste0("0x", str_sub(toAddress,-40,-1))) %>%
  mutate(tokenId = factor(tokenId, levels = as.character(sort(unique(as.numeric(tokenId)))))) %>%
  select(-data, -timeStamp, -transactionIndex)

saveRDS(dataEventTransfer, "data/dataEventTransfer.rds")



dataEventTransfer <- readRDS("data/dataEventTransfer.rds")
glimpse(dataEventTransfer)
