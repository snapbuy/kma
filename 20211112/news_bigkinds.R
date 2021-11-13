library(dplyr)
library(ggplot2)
library(lubridate)
library(tidyr)
library(stringr)
library(KoNLP)
library(tidytext)
library(tidylo)
library(reshape2)


ai_news_df <- readxl::read_excel("Finance_NewsResult_20210812-20211112.xlsx") %>%
  select(일자, 제목, 본문, 언론사, cat = '통합 분류1')


ai_news_df %>% head()


# 열 재구성
ai_news_df %>%
  distinct(제목, keep_all = TRUE) %>%
  mutate(ID = factor(row_number()), 
         month = month(ymd(일자))) %>%
  unite(제목, 본문, col = "text", sep =  " ") %>%
  mutate(text = str_squish(text))%>%
  mutate(press = case_when(
    언론사 == "조선일보" ~ "일간지",
    
    
    TRUE ~ "경제지"
  )) %>%
  separate(cat, sep = ">", into = c("cat", "cat2")) %>%
  filter(str_detect(cat, "IT |과학")) %>%
  select(-cat2) -> ai_news2_df

ai_news2_df %>% head(5)
ai_news2_df %>% names()
ai_news2_df$cat %>% unique()
  

ai_news2_df %>% count(cat, sort = T)
ai_news2_df %>% count(month, sort = T)


ai_news2_df %>%
  mutate(text = str_remove_all(text, "{^(\\+)]")) %>%
  unnest_tokens(word, text, token = extractNoun, drop = F) -> ai_token

ai_toekn %>% glimpse()

ai_toekn %>%  
  filter(!word %in% c("인공지능", "AI")) %>%
  filter(str_detect(word, "[:alpha:]+")) -> ai_token

ai_token %>% count(word, sort = T)

ai_token %>% 
  count(cat, word, sort =  T) %>%
  bind_log_odds(set =  word, featrue = word, n = n )


ait_token %>% 
  count(cat, word, sort = T) %>%
  bind_tf_idf(term = word, document = word, n = n) %>%
  arrange(idf)

# 한글자 단어제거

#ai_token %>%
 # filter(word == "하") %>% pull(text())


ai_token %>% filter(str_length(word) > 1) -> ai_token2
ai_token2 %>%
  count(word, sort = T)


#stm 말뭉치
library(stm)

ai_news2_df 

ai_token2 %>%
  group_by(ID) %>%
  summarise(text2 = str_flatten(word, " ")) %>%
  ungroup() %>%
  inner_join(ai_news2_df, by = "ID") -> final_df

glimpse(final_df)


?textProcessor

processed <- ai_news2_df %>%
  textProcessor(documents = final_df$text2, metadata = .)

out <- prepDocuments(processed$documents, processed$vocab, processed$meta)

docs <- out$documents
vocab <- ouut$vocab
meta <- out$meta



topicN <- c(3, 10)
storage <- search(out$documents, out$vocab, K =  topicN)

plot(storage)


stm_fit <- stm(
  documents = docs,
  vocab = vocab,
  K = 10,
  data = out$meta,
  init.type = "Spectral",
  seed =37
)


summary(stm_fit) %>% glimpse()

td_beta <- stm_fit %>% tidy(matrix = "beta")

