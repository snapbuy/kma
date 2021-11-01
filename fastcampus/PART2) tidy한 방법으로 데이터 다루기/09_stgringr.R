#                                    #
#       패스트 캠퍼스 온라인         #
#   금융 공학 / 퀀트 올인원 패키지   #
#    R 프로그래밍 - 강사. 박찬엽     #
#                                    #

# 텍스트 데이터를 다루는 stringr
## stringr 패키지 소개

# stringr은 tidyverse 패키지에 포함되어 있는 글자 조작용 패키지로 ICU라고 불리는 C library의 wrapper인 stringi 패키지 기반
# 총 패턴 매칭, 공백 관리, 로케일에 따라 동작이 다른 함수, 헬퍼의 4가지 카테고리의 함수를 제공

# 함수 리스트
## 패턴 매칭
str_count() : 찾고자 하는 패턴이 몇 개가 있는지 셈
str_detect() : 찾고자 하는 패턴이 있는지 TRUE/FALSE로 반환
str_extract() str_extract_all() : 찾는 패턴을 뽑아서 출력
str_locate() str_locate_all() : 찾는 패턴의 글자내 시작점과 끝점을 출력
str_match() str_match_all() : 찾는 패턴을 뽑아주는데 캡쳐 그룹도 같이 제공
str_remove() str_remove_all() : 찾는 패턴을 제거하고 출력
str_replace() str_replace_all() : 찾는 패턴을 다른 내용으로 바꿈
str_starts() str_ends() :찾는 패턴으로 시작하거나 끝나는 것이 있는지 TRUE/FALSE로 반환
str_split() str_split_fixed() : 지정한 패턴으로 글자를 나눔
str_subset() str_which() : 찾는 패턴이 있는 위치나 그 데이터를 출력
str_view() str_view_all() : html로 매칭된 내용을 출력
fixed() coll() regex() boundary() : 패턴 매칭의 동작을 조정하는 함수들

## 공백 관리
str_pad() : 공백을 추가하여 글자의 길이를 맞춤
str_trim() str_squish() : 앞뒤에 쌓인 공백이나 글자들 사이에 여러 개인 공백을 제거
str_wrap() : 문자열을 멋지게 형식화된 단락으로 감쌈

## 로케일에 따라 동작이 다른 함수
str_order() str_sort() : 글자의 순서를 출력
str_to_upper() str_to_lower() str_to_title() str_to_sentence() : 글자를 각 명령에 맞게 바꿈

## Other helpers
invert_match() : 패턴 매칭 함수 중 위치에 대한 동작을 반대로 바꿈
str_c() : 여러개의 글자형 데이터들을 하나의 글자 데이터로 합침
str_conv() : 글자의 인코딩을 조절
str_dup() : 글자들을 반복하여 합침
str_flatten() : 여러개로 이루어진 글자형 벡터를 하나로 합침
str_glue() str_glue_data() : glue 패키지를 사용해서 형식을 만들어 글자를 출력 
str_length() : 글자의 길이를 셈
str_replace_na() :자료형 NA를 글자형 "NA"로 변경
str_trunc() : 일정 글자 길이 이후를 줄임표로 자름
str_sub() `str_sub<-`() : 글자의 시작점과 끝점을 지정하여 추출
word() : 띄어쓰기 기준으로 단어를 추출

## 설치
## stringr 패키지는 tidyverse에 포함되어 있음
if (!require(tidyverse)) install.packages("tidyverse")
library(stringr)

## 접두사 명명 규칙을 사용하는 패키지이므로 자동완성으로 함수를 찾기 좋음
str_

## 텍스트 분석은 여기서 다루기에는 범위가 넓음
## 참고 : https://mrchypark.github.io/textR/print.html


### 중요 함수 실습
## 데이터 패키지 소개 krwifi
library(remotes)
install_github("mrchypark/krwifi")

library(krwifi)
library(dplyr)

wifi


## mutate()와 함께 사용하는 함수
wifi %>% 
  distinct(소재지도로명주소) %>% 
  slice(1:10) %>% 
  mutate(len = str_length(소재지도로명주소),
         gun_count = str_count(소재지도로명주소, "군"),
         addr1 = str_split(소재지도로명주소, " ") %>% sapply(function(x) x[1]),
         addr2 = str_split(소재지도로명주소, " ") %>% sapply(function(x) x[2]),
         addr3 = str_split(소재지도로명주소, " ") %>% sapply(function(x) x[3]),
         trunc = str_trunc(소재지도로명주소, width = 14)) 

wifi %>% 
  distinct(설치시군구명) %>% 
  slice(1:10) %>% 
  mutate(repla = str_replace(설치시군구명, "군", "도로시"),
         extra = str_extract(설치시군구명, "주시"),
         start = str_locate(설치시군구명, "구|군") %>% .[,1],
         end = str_locate(설치시군구명, "구|군") %>% .[,2],
         remove = str_remove(설치시군구명, "구|군|시"),
         if_remove = if_else(
           str_length(설치시군구명) == 2,
           설치시군구명,
           str_remove(설치시군구명, "구|군|시")
         ))
         

## filter()와 함께 사용하는 함수
wifi %>% 
  filter(str_detect(소재지도로명주소, "군"))

wifi %>% 
  filter(str_starts(설치장소상세 , "민원")) %>% 
  distinct(설치장소상세)

wifi %>% 
  filter(str_starts(설치장소상세 , "민원")) %>% 
  group_by(설치장소상세) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n))


## 필요없는 공백 제거

str_trim(" 안녕  하세요 ")
str_trim(" 안녕  하세요 ", side = "left")
str_trim(" 안녕  하세요 ", side = "right")
str_squish(" 안녕  하세요 ") 


## 한글 인코딩 다루기
## 한글 인코딩은 윈도우용 인코딩인 cp949(ms949라고도 불림, 웹에서 사용하는 euc-kr도 있음)와 utf8(UTF-8)
## 인코딩은 데이터 자체인 바이트 단위 기록 그 자체와 해석하는 방법이라는 메타 데이터로 이루어짐
tem <- "안녕하세요"
tem
Encoding(tem)
tem_utf <- iconv(tem, to = "UTF-8")
tem_utf
Encoding(tem_utf)

Encoding(tem) <- "UTF-8"
tem

wifi %>% 
  distinct(설치시군구명) %>% 
  slice(1:10) %>% 
  transmute(iconv_utf8 = str_conv(설치시군구명 , "utf8"),
         iconv_cp949 = str_conv(설치시군구명 , "cp949"))

wifi %>% 
  with(Encoding(설치시군구명)) %>% 
  table() %>% 
  as_tibble()

wifi %>% 
  distinct(설치시군구명) %>% 
  filter(Encoding(설치시군구명) == "unknown")
