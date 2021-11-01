#                                    #
#       패스트 캠퍼스 온라인         #
#   금융 공학 / 퀀트 올인원 패키지   #
#    R 프로그래밍 - 강사. 박찬엽     #
#                                    #

# 단정한 데이터 tidyr
## 실습 데이터 준비 
library(dplyr)
library(tqk)

### filter()와 같이 사용한 grepl() 함수는 데이터에 목표로하는 글자를 
### 포함하는지를 TRUE/FALSE로 결과를 제공함.
### grepl("현대자동차", code_get()$name)
code_get() %>% 
  filter(grepl("현대자동차", name)) %>% 
  select(code) %>% 
  tqk_get(from = "2019-01-01", to = "2019-02-28") %>% 
  mutate(comp = "현대자동차") -> 
  hdcm
hdcm

## tidyr 패키지의 gather() 함수 실습
### hdcm 데이터를 거래량을 제외하고 long form으로 변경하세요.
### open, high, low, close, adjusted가 값으로 들어가면 됩니다.
library(tidyr)

hdcm %>% 
  gather(key = "type", value = "price")

hdcm %>% 
  gather(key = "type", value = "price", -date, -comp) ->
  hdcm_v

hdcm %>% 
  select(-volume) %>% 
  gather(key = "type", value = "price", -date, -comp)  -> 
  hdcm_long
hdcm_long

hdcm %>% 
  gather(key = "type", value = "price", -date, -comp) %>% 
  filter(type != "volume") ->
  hdcm_vv

identical(hdcm_long, hdcm_vv)

## tidyr 패키지의 spread() 함수 실습
hdcm_long %>% 
  spread(type, price)

### 월, 일 컬럼을 만들고 개별 날을 컬럼으로 하는 wide form 종가 데이터를 만드세요.
library(lubridate)

hdcm %>% 
  mutate(month = month(date)) %>% 
  mutate(day = day(date)) %>% 
  select(comp, month, day, close) %>% 
  spread(day, close)


### stks18 실습 데이터 만들기
library(purrr)
code_get() %>% 
  slice(11:20) -> 
  code_info

code_info %>%
  select(code) %>% 
  map_dfr(
    ~ tqk_get(.x, from = "2018-01-01", to = "2018-12-31") %>%
      mutate(code = .x)
  ) %>% 
  left_join(code_info %>% select(code, name), by = "code") %>% 
  select(-code) -> 
  stks18 

### 각 회사의 월별 평균 종가를 출력하세요.
### wide form으로 출력하는 것이 한눈에 보기 좋습니다.

stks18 %>% 
  mutate(month = month(date)) %>% 
  group_by(name, month) %>% 
  summarise(mclose = mean(close)) %>% 
  spread(month, mclose)


## tidyr 패키지의 separate() 함수 실습
### 데이터 준비
library(readr)
url <- "https://github.com/mrchypark/sejongFinData/raw/master/dataAll.csv"
download.file(url,destfile = "./dataAll.csv")
findata <- 
  read_csv("./dataAll.csv", locale = locale(encoding = "cp949")) %>% 
  rename(company = country)

findata %>% 
  select(company, year) -> 
  findata

### year 컬럼을 separate() 함수로 별도의 컬럼들로 나눔
### sep 에 [^[:alnum:]]+ 정규표현식이 기본값으로 있어서 
### 글자, 숫자가 아닌 값으로 나누기를 제공
findata %>% 
  separate(year, into = c("year","month","standard")) 

### convert 옵션으로 자료형을 처리할 수 있음
findata %>% 
  separate(year, into = c("year","month","standard"), convert = T)

### 직접 sep에 나누기를 할 글자를 지정할 수 있음
### 정규표현식에서 "(" 괄호는 특별한 의미를 지니기 때문에
### \\ 이후에 작성해야 글자로 인식함.
findata %>% 
  separate(year, into = c("year","standard"), sep = "\\(")

### sep에 숫자를 넣을 수도 있는데, 글자 갯수를 기준으로 나누어 줌
findata %>% 
  separate(year, into = c("year","month","standard")) %>% 
  separate(standard, into = c("standard","Consolidated"), sep = 4)


## tidyr 패키지의 unite() 함수 실습
library(tqk)
code_info <- code_get()
code_info

### code와 name이 같은 의미를 지니므로 하나로 합칠 수 있음.
### 물론 실제로는 code가 key 역할이나 tqk_get() 함수의 입력 역할을 하기 때문에
### 최종 결과물에서 정리의 의미로 하나로 합치거나 하는 것이라고 가정.

### 여러 컬럼의 데이터를 합쳐서 하나의 컬럼으로 만드는 동작
### 새롭게 만들어지는 컬럼 이름을 먼저 작성
### 이후 대상이 되는 컬럼 이름을 나열.
code_info %>% 
  unite("company", name, code)

### sep 옵션으로 어떤 글자를 이용하여 연결할지 결정.
### 기본값은 _(언더바)
code_info %>% 
  unite("company", name, code, sep = "-")

code_info %>% 
  unite("company", name, code, sep = "(") %>% 
  mutate(company = paste0(company,")"))

### 개인적으로는 mutate() 함수와 paste0() 함수를 함께 사용하는 편.
### paste0() 함수는 글자를 합치는 기능을 제공.
code_info %>% 
  mutate(company = paste0(name, "(",code,")"))

### transmute() 함수로 필요한 컬럼만 출력
code_info %>% 
  transmute(company = paste0(name, "(",code,")"), market)
