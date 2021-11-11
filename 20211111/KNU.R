library(readr)
dic = read.csv("knu_sentiment_lexicon.csv")
glimpse(dic)


library(dplyr)

dic %>%
  filter(polarity ==1) %>%
  arrange(word)


dic %>%
  filter(word %in% c("기쁜", "슬픈"))

library(stringr)

dic %>%
  filter(!str_detect(word, "[가-힣]")) %>%
  arrange(word)

dic %>%
  mutate(sentiment =
           ifelse(
             polarity >= 1, "긍정"),
             
           ))
