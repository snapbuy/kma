#                                    #
#       패스트 캠퍼스 온라인         #
#   금융 공학 / 퀀트 올인원 패키지   #
#    R 프로그래밍 - 강사. 박찬엽     #
#                                    #

# 날짜와 시간을 다루는 lubridate

## 날짜 자료형 <date>
## 날짜시간 자료형 <dttm>
## 시간 자료형 <time> - hms 패키지가 추가로 필요

## 시간 자료형 
## 00:00:00 을 기준으로 몇초나 지났는가를 표현

library(hms)

hms::hms(56, 34, 12)

hms::hms(seconds = 56, 
         minutes = 34, 
         hours = 12,
         days = 3)

hms::hms(hours = 3)

unclass(hms::hms(hours = 3))
3*60*60


## 날짜 자료형, 날짜 시간 자료형으로 변경
# y 년 m 월 d 일 h 시 m 분 s 초

library(lubridate)
ymd_hms(), ymd_hm(), ymd_h()
ydm_hms(), ydm_hm(), ydm_h()
dmy_hms(), dmy_hm(), dmy_h()
mdy_hms(), mdy_hm(), mdy_h()

ymd(), ydm(), mdy()
myd(), dmy(), dym(), yq()

hms(), hm(), ms()

hms::hms
lubridate::hms

library(lubridate)

x <- c(20100101120101, 
       "2009-01-02 12-01-02", 
       "2009.01.03 12:01:03",
       "2009-1-4 12-1-4",
       "2009-1, 5 12:1, 5",
       "200901-08 1201-08",
       "2009 arbitrary 1 non-decimal 6 chars 12 in between 1 !!! 6",
       "OR collapsed formats: 20090107 120107 (as long as prefixed with zeros)",
       "Automatic wday, Thu, detection, 10-01-10 10:01:10 and p format: AM",
       "Created on 10-01-11 at 10:01:11 PM")
ymd_hms(x)

ymd("2017년 1월 4일")

## 실습
## 데이터 준비

library(dplyr)
library(krwifi)

wifi %>% 
  select(설치년월, 데이터기준일자) -> 
  lub_exam

## ymd 함수 실습

lub_exam %>% 
  transmute(ymd_try = ymd(데이터기준일자))

lub_exam %>% 
  transmute(ymd_try = ymd(데이터기준일자)) %>% 
  filter(is.na(ymd_try))

## parse_date_time 함수 실습

lub_exam %>%
  mutate(ym_try = parse_date_time(설치년월, "ym"))

lub_exam %>% 
  mutate(ym_try = parse_date_time(설치년월, "ym")) %>% 
  filter(is.na(ym_try))

lub_exam %>% 
  filter(!is.na(설치년월)) %>% 
  mutate(ym_try = parse_date_time(설치년월, "ym")) %>% 
  filter(is.na(ym_try))

lub_exam %>% 
  filter(!is.na(설치년월)) %>% 
  mutate(ym_try = parse_date_time(설치년월, c("ym", "my")))

lub_exam %>% 
  filter(!is.na(설치년월)) %>% 
  mutate(ym_try = parse_date_time(설치년월, c("ym", "my"))) %>% 
  filter(is.na(ym_try))

lub_exam %>% 
  filter(!is.na(설치년월)) %>% 
  mutate(ym_try = parse_date_time(설치년월, c("ym", "my","y")))



## 날짜시간 자료형으로 부터 데이터 추출
year() month() day() quarter()
week() mday() wday() qday() yday()
hour() minute() second()

sam_dttm <- Sys.time()
sam_dttm
year(sam_dttm)
month(sam_dttm)
day(sam_dttm)
week(sam_dttm)
## 달 중 몇번째 날인지
mday(sam_dttm)
## 주 중 몇번째 날인지
wday(sam_dttm)

## 요일 이름의 factor 자료형
wday(sam_dttm
     , label = T)

## 요약 이름을 사용할 것인지
wday(sam_dttm
     , label = T
     , abbr = F)

# 7 인 일요일이 기본값
wday(sam_dttm
     , label = T
     , abbr = F
     , week_start = 3)


## Periods와 Durations
## Durations은 수학적 의미의 기간을 뜻함
## Periods는 사람의 감각적 의미로써 기간을 뜻함

## leap_year()는 윤년인지 판단함

leap_year(2011)
ymd(20110101) + dyears(1)
ymd(20110101) + years(1)

leap_year(2012)
ymd(20120101) + dyears(1)
ymd(20120101) + years(1)

## 2013년 1월 31일 + 한달 은 언제인가?

jan31 <- ymd("2013-01-31")
jan31 + months(0:11)
jan31 %m+% months(0:11)

