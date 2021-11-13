# 02-1 --------------------------------------------------------------------
install.packages("multilinguer")
library(multilinguer)
install_jdk()

install.packages(c("stringr", "hash", "tau", "Sejong", "RSQLite", "devtools"),
                 type = "binary")

install.packages("remotes")
remotes::install_github("haven-jeon/KoNLP",
                        upgrade = "never",
                        INSTALL_opts = c("--no-multiarch"))

library(KoNLP)
useNIADic()


# -------------------------------------------------------------------------
library(dplyr)
text <- tibble(
  value = c("금융이 미래다", "위드코로나 최대 실적"))

text

extractNoun(text$value)

# -------------------------------------------------------------------------
library(tidytext)
text %>%
  unnest_tokens(input = value,        # 분석 대상
                output = word,        # 출력 변수명
                token = extractNoun)  # 토큰화 함수


# -------------------------------------------------------------------------
# 뉴스기사 불러오기
raw_news <- readLines("data/economy_news.txt", encoding = "UTF-8")

# 기본적인 전처리
library(stringr)

news <- raw_news %>%
  str_replace_all("[^가-힣]", " ") %>%  # 한글만 남기기
  str_squish() %>%                      # 중복 공백 제거
  as_tibble()                           # tibble로 변환

# 명사 기준 토큰화
word_noun <- news %>%
  unnest_tokens(input = value,
                output = word,
                token = extractNoun)

word_noun


# 02-2 --------------------------------------------------------------------

word_noun <- word_noun %>%
  count(word, sort = T) %>%    # 단어 빈도 구해 내림차순 정렬
  filter(str_count(word) > 1)  # 두 글자 이상만 남기기

word_noun


# -------------------------------------------------------------------------
# 상위 20개 단어 추출
top20 <- word_noun %>%
  head(20)

# 막대 그래프 만들기
library(ggplot2)
ggplot(top20, aes(x = reorder(word, n), y = n)) +
  geom_col() +
  coord_flip() +
  geom_text(aes(label = n), hjust = -0.3) +
  labs(x = NULL) +
  theme(text = element_text(family = "nanumgothic"))


# -------------------------------------------------------------------------
# 폰트 설정
library(showtext)
font_add_google(name = "Black Han Sans", family = "blackhansans")
showtext_auto()

library(ggwordcloud)
ggplot(word_noun, aes(label = word, size = n, col = n)) +
  geom_text_wordcloud(seed = 1234, family = "blackhansans") +
  scale_radius(limits = c(3, NA),
               range = c(3, 15)) +
  scale_color_gradient(low = "#66aaf2", high = "#004EA1") +
  theme_minimal()


# 02-3 --------------------------------------------------------------------
sentences_news <- raw_news %>%
  str_squish() %>%
  as_tibble() %>%
  unnest_tokens(input = value,
                output = sentence,
                token = "sentences")

sentences_news


# -------------------------------------------------------------------------
str_detect("치킨은 맛있다", "치킨")
str_detect("치킨은 맛있다", "피자")


# -------------------------------------------------------------------------
sentences_news %>%
  filter(str_detect(sentence, "회복"))


# -------------------------------------------------------------------------
sentences_news %>%
  filter(str_detect(sentence, "에어비앤비"))

