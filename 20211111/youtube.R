library(dplyr)
library(ggplot2)
library(readr)
library(RcppMeCab)

cmt_3 =read_csv("youtube_comments.csv")


problems()
text = "안녕하세요!"

pos(sentence = text)

text2 = enc2utf8(text)
text2


cmt_pos_3 = posParallel(sentence = cmt_3$textOriginal,
                        format = "data.frame",
                        model =
                        )

glimpse(cmt_pos_3)
 
