#                                    #
#       패스트 캠퍼스 온라인         #
#   금융 공학 / 퀀트 올인원 패키지   #
#    R 프로그래밍 - 강사. 박찬엽     #
#                                    #

# tidy한 방법으로 데이터 다루기
## 패키지 설치
install.packages("tidyverse")
library(tidyverse)
tidyverse_logo()
tidyverse_packages() 
tidyverse_update()



## 사용할 데이터 설명

### github에 있는 패키지를 설치하기 위한 패키지 설치
install.packages("remotes")

### github에 있는 패키지를 설치하기 위한 패키지 설치
install.packages("devtools")
library(devtools)
install_github("r-lib/remotes")
## session 재시작이 필요함
## ctrl + shift + F10

### 한국 주식 데이터 패키지인 tqk 설치
library(remotes)
install_github("mrchypark/tqk")
library(tqk)

### 함수 설명 확인
?code_get
?tqk_get


tqk_get(
  005930,
  get = c("daum", "paxnet"),
  from = "1900-01-01",
  to = Sys.Date(),
  tqform = T
)###

### 종목 코드 데이터 가져오기
code <- code_get("all")

### 데이터 상태 확인하기
library(dplyr)
library(magrittr)
code %>% 
  glimpse()

code %>% 
  group_by(market) %>% 
  summarise(n())

### 주식 데이터 가져오기
code %>% 
  slice(grep("현대자동차", name)) %$% 
  tqk_get(code, from = "2019-01-01") -> 
  hdc 

hdc

## data.frame과 tibble
### data.frame은 리스트의 확장으로 2차원 테이블 형태의 자료구조다.
### tibble은 현대적인 방법으로 정리한 data.frame의 일종이다.
### 그래서 여러 class를 동시에 가지고 있음.
### 기본 출력에서 많은 정보를 볼 수 있어서 권장함.
class(iris)
class(hdc)
as_tibble(iris)


## dplyr 
### select(), filter(), arrange() 함수를 살펴볼 예정.

## select() 함수 소개

library(dplyr)
library(tqk)
code_get() %>% 
  slice(grep("현대자동차", name)) %>% 
  pull(code) %>% 
  tqk_get(from = "2019-01-01") -> 
  hdc 
hdc
### select()는 필요한 컬럼만 지정하여 데이터를 정리하는 함수.
### select(데이터, 필요한 컬럼1, 필요한 컬럼명2, ...) 으로 사용함.
select(hdc, date, volume)
### 컬럼명의 지정 순서를 따름
select(hdc, volume, date)
### 정수 생성 문법인 : 를 사용하여 시작컬럼:끝컬럼으로 컬럼을 선택
select(hdc, open:close)
### 필요 없는 컬럼 제거
select(hdc, -c(volume, adjusted))
### select() 함수에서 컬럼명을 지정하는 걸 도와주는 여러 도움함수들이 있음.
#### 어떤 글자로 시작하거나 끝나거나 포함하는 컬럼 전체
select(hdc, starts_with("h"))
select(hdc, ends_with("e"))
select(hdc, contains("o"))

### 정규표현식을 사용하여 컬럼명을 지정
select(hdc, matches("^.{4}$"))

### V1, V2, V3 같이 여러 숫자로 이루어진 컬럼명을 한번에 지정
select(hdc, num_range("V", 1:4))

### dplyr Cheatsheets를 보면 전체 함수를 확인할 수 있음
### rstudio > Help > Cheatsheets > Data Transforming with dplyr


## filter() 함수 소개
### filter()는 조건식을 활용하여 조건에 해당하는 row의 데이터만 정리함
### filter(데이터, 조건식1, 조건식2, ...) 으로 사용함.

### 조건식 복습!
#### 12.3 관계 연산자와 12.4 논리 연산자
### 논리 연산에 참고글
### https://mrchypark.github.io/post/%EB%85%BC%EB%A6%AC-%EC%97%B0%EC%82%B0%EC%9E%90-%EC%A0%95%EB%A6%AC/

filter(hdc, open == 121500)
### = 등호는 같다는 뜻이 아니다!
filter(hdc, open = 121500)

## 글자일 때는 잊지 말고 "(쌍따옴표)로 감싸야 한다.
code <- code_get("all")
code
filter(code, market == "KOSPI")
filter(code, market == KOSPI)

### 쉼표로 조건식을 추가할 수 있으며, 모든 조건식을 만족하는 row만 출력
filter(hdc, open == 121500, low > 120000)

### 논리 연산자인 |, &, ! 등을 사용할 수 있음
filter(hdc, open == 121500 & low > 120000)
filter(hdc, !(open == 121500 & low > 120000))
filter(hdc, open == 121500 | low > 120000)

### 부등호를 연결해서 사용할 수 없다!
filter(hdc, 130000 > low, low > 120000)
filter(hdc, 130000 > low > 120000)


## arrange() 함수 소개
### arrange()는 컬럼 이름을 지정하여 오름차순 혹은 내림차순으로 정렬함.
### arrange(데이터, 정렬 기준 컬럼명1, 정렬 기준 컬럼명2, ...) 으로 사용함.
### 기본은 오름차순임.
arrange(hdc, open)

### 내림차순으로 바꾸기 위해서 desc() 함수를 사용함
arrange(hdc, desc(open))

### 컬럼의 작성 순서대로 정렬함
arrange(hdc, open, low)
arrange(hdc, open, desc(low))



## 파이프 연산자 %>% 
### 파이프 연산자는 여러번 작성해야 하는 중간 변수를 생략하고
### 코드를 읽기 쉽게 해줌

### 현대자동차의 거래액이 100만보다 컸을 때, 종가가 가장 큰 날은?


#### 거래액이 100만 보다 큰 날을 filter()로 가져옴
hdc_v <- filter(hdc, volume > 1000000)
#### 그 중 종가와 날짜 데이터가 필요해서 select()로 컬럼 2개만 출력
hdc_v <- select(hdc_v, date, close)
#### 종가 기준 내림차순으로 데이터를 정렬
hdc_v <- arrange(hdc_v, desc(close))
#### 결과 확인
hdc_v

hdc_v <- filter(hdc, volume > 1000000)
hdc_v <- select(hdc_v, date, close)
hdc_v <- arrange(hdc_v, desc(close))
hdc_v

### 함수를 중첩해서 사용할 수도 있음.
hdc_r <- arrange(select(filter(hdc, volume > 1000000), date, close), desc(close))
hdc_r

### 파이프 연산자 %>%
#### windows : ctrl + shift + m
#### macos : commend + shift + m
filter(hdc, volume > 1000000)
hdc %>% 
  filter(volume > 1000000)

### 현대자동차의 거래액이 100만보다 컸을 때, 종가가 가장 큰 날은?
hdc_v <- filter(hdc, volume > 1000000)
hdc_s <- select(hdc_v, date, close)
hdc_a <- arrange(hdc_s, decs(close))
hdc_a

### pipe 연산자로 함수 연결
hdc %>% 
  filter(volume > 1000000) %>% 
  select(date, close) %>%
  arrange(close) -> 
  hdc_p

hdc_p



## summarize
### summarize()는 컬럼과 함수를 사용하여 집계 데이터를 만듬.
### 기존의 데이터 중 일부를 사용하는 것이 아니라
### 새로운 집계 데이터를 만드는 
### summarize(데이터, 집계컬럼명1 = 집계함수1(컬럼명1), ...) 로 사용함.

hdc %>% 
  summarize(open_avg = mean(open), 
            vol_max = max(volume),
            vol_min = min(volume))

### 많이 사용하는 집계 함수

hdc %>%
  summarize(
    open_avg = mean(open),
    vol_max = max(volume),
    vol_min = min(volume),
    cnt = n(),
    unique_cnt = n_distinct(open),
    low_median = median(low),
    close_first = first(close),
    close_last = last(close),
    high_sd = sd(high),
    high_var = var(high)
  )


## group_by
### 각 연산이 해당 그룹별로 이루어지도록 그룹 정보를 저장함.

### 그룹을 확인하기 위해 새로운 데이터를 만듬.
library(dplyr)
library(tqk)
library(purrr)
code_get() %>% 
  slice(11:20) -> 
  code_info

code_info %>%
  pull(code) %>% 
  map_dfr(
    ~ tqk_get(.x, from = "2017-01-01", to = "2018-12-31") %>%
        mutate(code = .x)
    ) %>% 
  left_join(code_info, by = "code") -> 
  stks 


### stks 변수는 기업 7개의 17년~18년 데이터가 있음.
### 기업은 code 컬럼으로 구분할 수 있음.
stks 
stks %>% 
  group_by(code)

stks %>% 
  summarise(close_max = max(close),
            close_min = min(close))

stks %>% 
  group_by(name, open) %>% 
  summarise(close_max = max(close),
            close_min = min(close))

### ungroup()
### 그룹이 지정된 상태에서는 기대하지 않은 동작이 있을 수 있음.
### 그룹이 필요한 연산을 수행하고 나면 가능하면 반드시 ungroup()을 연결할 필요가 있음.

stks %>% 
  group_by(code)

stks %>% 
  group_by(code) %>% 
  ungroup()

## mutate
### 각 컬럼을 활용하여 계산한 결과물로 새로운 컬럼을 작성함.
### mutate(데이터, 새컬럼명1 = 계산함수1(컬럼명1), ...) 로 사용함.
### 산술 연산, log(), round() 등 변환 함수를 많이 적용함.
### 계산으로 새로운 컬럼을 만들거나, 소수점을 정리하거나, 자료형을 변환하는 등에 사용.
stks %>% 
  mutate(rate = open / close)

stks %>% 
  mutate(rate = open / close,
### min_rank 함수는 순위를 오름차순으로 작성해줌.
### 같은 값이 많으면 작은 순위로 작성함.
         rate_rank = min_rank(rate),
### desc() 함수로 내림차순 순위를 작성할 수 있음.
         rate_desc_rank = min_rank(desc(rate)))

stks %>% 
  mutate(
    rate = open / close,
    rate_rank = min_rank(rate),
    rate_desc_rank = min_rank(desc(rate))
  ) %>% 
  filter(rate_rank == 1)


### lead(), lag()로 새로운 컬럼 생성
### lead()는 컬럼 방향으로 데이터를 당겨서, lag()는 밀어서 컬럼을 만들어 줌.
### 미는 갯수도 조절할 수 있으며 기본값은 1.
stks %>% 
  # group_by(code) %>% 
  mutate(open_lead = lead(open),
         open_lag  = lag(open)) %>% 
  select(code, open, open_lead, open_lag) %>% 
  filter(is.na(open_lag))

### 누적 집계 함수들
### cumulative aggregates라고 함
### row를 순서대로 누적하여 합계, 최대값 등을 계산하여 처리함.

stks %>%
  mutate(
    open_cmax = cummax(open),
    open_cmin = cummin(open),
    open_cmean = cummean(open),
    open_csum = cumsum(open),
    open_cprod = cumprod(open)
  ) %>%
  select(open, 
         open_cmax, 
         open_cmean,
         open_cmin, 
         open_csum, 
         open_cprod)

### transmute() 함수는 계산한 컬럼만 남겨줌.
### mutate() %>% select() => transmute()

stks %>%
  transmute(
    open = open,
    open_cmax = cummax(open),
    open_cmean = cummean(open),
    open_cmin = cummin(open),
    open_csum = cumsum(open),
    open_cprod = cumprod(open)
  ) -> tran

stks %>%
  mutate(
    open_cmax = cummax(open),
    open_cmin = cummin(open),
    open_cmean = cummean(open),
    open_csum = cumsum(open),
    open_cprod = cumprod(open)
  ) %>%
  select(
    open,
    open_cmax,
    open_cmean,
    open_cmin,
    open_csum,
    open_cprod
  ) -> mps

identical(mps, tran)



## group_by(), summerize(), mutate() 실습
### 날짜 데이터를 다루는 libridate 패키지
library(lubridate)

### 날짜 자료형에서 년, 월, 일 데이터를 추출하는 함수
### 이름대로 year(), month(), day() 함수를 제공
stks %>% 
  transmute(
    date = date,
    year = year(date),
    month = month(date),
    day = day(date)
  )

stks %>% 
  mutate(
    date = date,
    year = year(date),
    month = month(date),
    day = day(date)
  ) -> 
  stks_d

## 그럼 년도별, 기업별 거래액 합계는 각각 얼마일까?

stks_d %>% 
  group_by(year, name) %>% 
  summarise(total_vol = sum(volume))


## 18년의 월별 기업별 종가 최소값은 얼마일까?

stks_d %>% 
  filter(year == 2018) %>% 
  group_by(month, name) %>% 
  summarise(minc = min(close))

## 17년의 월별 기업별 고가가 3등(min_rank 기준)인 날은 언제일까?

stks_d %>% 
  filter(year == 2017) %>% 
  group_by(month, name) %>% 
  mutate(rank = min_rank(high)) %>% 
  ungroup() %>% 
  filter(rank == 3)

stks_d %>% 
  filter(year == 2017) %>% 
  group_by(month, name) %>% 
  mutate(rank = min_rank(high)) %>% 
  filter(rank == 3)
