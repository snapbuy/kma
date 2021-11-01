#                                    #
#       패스트 캠퍼스 온라인         #
#   금융 공학 / 퀀트 올인원 패키지   #
#    R 프로그래밍 - 강사. 박찬엽     #
#                                    #

## 리스트 자료형과 반복문법 purrr
###  Ch 02. 데이터의 종류 및 다루기 - 04. 리스트 다루기

party <- list(
  corp1 = runif(10, 50, 100),
  corp2 = runif(10, 50, 100),
  corp3 = runif(10, 50, 100),
  corp4 = runif(10, 50, 100),
  corp5 = runif(10, 50, 100)
)

mean(party)
mean(party$corp1)
mean(party$corp2)
mean(party$corp3)
mean(party$corp4)
mean(party$corp5)

# install.packages("tidyverse)
library(purrr)

## map은 적용하고 싶은 함수의 이름을 인자로 받아 결과를 출력
map(party, mean)
party %>% map(mean)
party %>% map(var)

## apply 계열 함수와 같은 동작
lapply(party, mean)
lapply(party, var)

party %>% lapply(mean)


## 결과의 자료형을 강제할 수 있음
map(.x, .f, ...)
map_lgl(.x, .f, ...)
map_chr(.x, .f, ...)
map_int(.x, .f, ...)
map_dbl(.x, .f, ...)

party %>% map_dbl(mean)
party %>% map_dbl(var)

party %>% sapply(mean)


## map에 적용하는 함수
## 적용하고자 하는 함수의 인수를 사용하는 방법
party %>%
  map_dbl(quantile, prob = 0.8)

### Ch 03. 함수의 구조 및 작성 - 01. 함수의 구조 및 작성
### Ch 03. 함수의 구조 및 작성 - 05. apply 계열 함수

party <- list(
  corp1 = runif(10, 50, 100),
  corp2 = runif(10, 50, 100),
  corp3 = runif(10, 50, 100),
  corp4 = runif(10, 50, 100),
  corp5 = runif(10, 50, 100)
)

sapply(party, function(x) mean(x))
party %>% 
  map_dbl(function(x) mean(x))

party %>% 
  map_dbl( ~ mean(.x))

map_dbl(party, ~ mean(.x))

party %>%
  map_dbl(~ mean(.x) %>%
            round(2))


## dplyr 패키지와 함께 사용하기
## 예시 데이터 불러오기
## Ch 08. 텍스트 데이터를 다루는 stringr - 02. 실습데이터 소개

library(krwifi)
wifi

## 결과를 리스트로 주는 함수
library(stringr)
library(dplyr)
wifi %>% 
  pull(와이파이SSID) %>% 
  .[1] %>% 
  str_split(" ")

wifi %>% 
  distinct(와이파이SSID) %>% 
  pull(와이파이SSID) %>% 
  .[1:3] %>% 
  str_split(" ")


## mutate()와 함께 사용하기
wifi %>% 
  distinct(와이파이SSID) %>% 
  transmute(와이파이SSID, 
            spl = str_split(와이파이SSID, " "))

wifi %>% 
  distinct(와이파이SSID) %>% 
  transmute(spl = str_split(와이파이SSID, " ")) %>% 
  pull(spl) %>% 
  head()

wifi %>% 
  distinct(와이파이SSID) %>% 
  transmute(와이파이SSID,
            spl = str_split(와이파이SSID, " ") %>% 
              map(~.x[2]))

wifi %>% 
  distinct(와이파이SSID) %>% 
  transmute(와이파이SSID,
            spl = str_split(와이파이SSID, " ") %>% 
              map(~.x[2]) %>% 
              unlist())

wifi %>% 
  distinct(와이파이SSID) %>% 
  transmute(와이파이SSID,
                    spl = str_split(와이파이SSID, " ") %>% 
                      map_chr(~.x[2]))


## 모델의 결과를 tibble로 다루기

model <-  lm(Sepal.Length ~ Petal.Length + Petal.Width, data = iris) 
model
summary(model)
str(model)


# install.packages("tidyverse") 
library(broom)
model %>% 
  tidy()

model %>% 
  glance()

model %>%
  augment()

model %>%
  augment(data=iris)


## 컬럼내에 리스트로 데이터 다루기 nest()
library(tidyr)
library(dplyr)
library(tibble)

# install.packages("gapminder") 
library(gapminder)

gapminder

gapminder %>%
  group_by(country) %>%
  nest() -> 
  gap_nest

gap_nest$data[[1]]



library(purrr)
fit_model <- function(df) lm(lifeExp ~ year, data = df)
gap_nest %>%   
  mutate(model = map(data, fit_model))

gap_nest %>%
  mutate(model = map(data, ~ lm(lifeExp ~ year, data = .x)))

gap_nest %>%
  mutate(model = map(data, ~ lm(lifeExp ~ year, data = .x))) -> 
  gap_model

library(broom)
gap_model$model[[1]]
get_rsq <- function(mod) glance(mod)$r.squared
gap_model %>%   
  mutate(r.squared = map_dbl(model, get_rsq))


fit_model <- function(df) lm(lifeExp ~ year, data = df) 
get_rsq <- function(mod) glance(mod)$r.squared


(gapminder %>%
  group_by(country) %>%
  nest() %>%
  mutate(
    model = map(data, fit_model),
    r.squared = map_dbl(model, get_rsq),
    output = map(model, augment)
  ) -> output)

output %>% 
  unnest(data, output)

output %>% 
  unnest(data, output, names_sep = "_")

