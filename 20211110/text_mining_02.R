library(dplyr)
library(KoNLP)
library(stringr)
library(ggplot2)
library(showtext)
library(ggwordcloud)
library(tidytext)

def_car = readLines("def_news_car.txt", encoding = "UTF-8")


car = def_car %>%
  as_tibble() %>%
  mutate(category = "def_car")

car

def_china = readLines("def_news_china.txt", encoding = "UTF-8")
china <- def_china %>%
  as_tibble() %>%
  mutate(category = "def_china")


bind_news = bind_rows(car, china) %>% select(category, value)
head(bind_news)


news_df = bind_news %>%
  mutate(value = str_replace_all("")
    
  )

news_df

library(tidyr)

df_long <- 