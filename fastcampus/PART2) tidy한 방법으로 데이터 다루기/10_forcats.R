#                                    #
#       패스트 캠퍼스 온라인         #
#   금융 공학 / 퀀트 올인원 패키지   #
#    R 프로그래밍 - 강사. 박찬엽     #
#                                    #

# factor 자료형을 다루는 forcats
## 실습 데이터 준비 

library(forcats)
library(krwifi)

wifi %>% 
  transmute(class = gsub("[^가-흭]","", 설치시설구분)) %>% 
  distinct(class)

wifi %>% 
  transmute(class = gsub("[^가-흭]","", 설치시설구분)) %>% 
  count(class, sort = T)

wifi %>% 
  transmute(class = gsub("[^가-흭]","", 설치시설구분)) -> 
  wifi_f

## fct_lump() factor leval의 갯수를 줄임

wifi_f %>%
  count(class, sort = T)

wifi_f %>%
  mutate(class_l = class %>% fct_lump(5)) %>%
  count(class_l)

## factor형으로 고치면

wifi_f %>%
  mutate(class_f = class %>% factor()) %>% 
  with(levels(class_f))

## 출현순서대로
wifi_f %>%
  mutate(class_o = class %>% fct_inorder()) %>% 
  with(levels(class_o))

## 빈도가 많은 순
wifi_f %>%
  mutate(class_l = class %>% fct_infreq()) %>% 
  with(levels(class_l))

## 기존의 역순
wifi_f %>%
  mutate(class_r = class %>% fct_rev()) %>% 
  with(levels(class_r))
