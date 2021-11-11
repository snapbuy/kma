library(dplyr)
library(ggplot2)
library(readr)
library(reshape)


raw_reviews = read_csv("Womens Clothing E-Commerce Reviews.csv") #%%> select(-1)

glimpse(raw_reviews)

colnames(raw_reviews) <- c("ID", "Age", "Titel", "Review", "Rating", "Recommend", "Liked", "Division", "Dept", "Class")

glimpse(raw_reviews)


table(raw_reviews$Age)

cut(as.numeric(raw_reviews$Age),
    breaks = seq(10, 100, by =10),
    include.lowest = TRUE,
    right = FALSE
    lables = paste0(seq(10, 90, by = 10), "th") -> raw_reviews$age_group

table(raw_reviews$age_group)
raw_reviews$age_group <- NULL


set.seed(2021)
idx = sample(1:nrow(raw_reviews), nrow(raw_reviews) * 0.1, replace = FALSE)

reviews = raw_reviews[idx, ]

#Corpus
library(tm)
Corpus_df = Corpus(VectorSource(text_lower))
Corpus_tm = tm_map(Copus_df, removePunctuation)
Corpus_tm = tm_map(Corpus_tm, removeNumbers)
Corpus_tm = tm_map(Corpus_tm, removeWords, c(stopwords("english")))

#Term Document
tdm_df = TermDocumentMatrix(Copus_tm)
tdm_matrix = as.matrix(tdm_df)

str(tdm_matrix)

# 키워드 빈도 데이터셋

freq =rowSums(tdm_matrix)

data.frame(
  words =names(frew),
  freq = freq
) %>% arrange(-freq) -> freq_df

nrow(freq_df)


library(wordcloud)
worldclou(
  words = names(freq),
  freq = freq_df$freq,
  max.words = 300,
  random.color = FALSE,
  random.color + TRUE,
  colors = brewer.pal(8, "Dark2")
  )


library(tokenizers)
