library(dplyr)
library(KoNLP)
library(stringr)
library(ggplot2)
library(showtext)
library(ggwordcloud)
library(tidytext)
#library(RcppMeCab)

useNIADic()

text = tibble(
  value = c("금융이 미래다", "위드코로나")
)

text
extractNoun(text$value)


text %>%
  unnest_tokens(input =  value,
                output = word,
                token = extractNoun)


raw_news = readLines("economy_news.txt", encoding = "UTF-8")

news <- raw_news %>%
  str_replace("[^가-힣]", " ") %>%
  str_squish() %>%
  as_tibble()


word_noun = news %>%
  unnest_tokens(input =  value,
                output = word,
                token =  extractNoun)

word_noun2 <- word_noun %>%
  count(word, sort = TRUE) %>%
  filter(str_count(word)>1)

word_noun2  

top10 <- word_noun2 %>% head(10)

top10


ggplot(top10, aes(x = word, y = n)) +
  geom_col() +
  coord_flip()


ggplot(word_noun2, aes(label = word, size = n, col = n)) +
  geom_text_wordcloud(seed = 1234) +
  scale_radius(limits = c(3, NA),
               range = c(3, 15)) +
  scale_color_gradient(low = "#00ADA1", high = "#F79D6F") +
  theme_minimal()


sentences_news <- raw_news %>%
  str_squish() %>%
  as_tibble() %>%
  unnest_tokens(input = value,
                output = sentences,
                token = "sentences" #<---------핵심 포인트
    
  ) -> sentences_df

str_detect("한글", "시험")


sentences_df %>%
  filter(str_detect(sentences, "키워드"))

library(showtext)
font_add_google(name = "Nanum Gothic", family = "nanumgothic")
showtext_auto()
