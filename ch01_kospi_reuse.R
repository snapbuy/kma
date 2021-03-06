# Step 01 ---- KOSPI 데이터 불러오기 ---- 

install.packages("forecast")

library(quantmod)
library(ggplot2)
library(dplyr)


# KOSPI 지수의 ticker Symbol ^KS11
KOSPI = getSymbols("^KS11",
                   from = "2001-01-01",
                     to = Sys.time(),
                     auto.assign = FALSE)

head(KOSPI)
tail(KOSPI)


Apple = getSymbols("AAPL",
                   from = "2001-01-01",
                   to = Sys.time(),
                   auto.assign = FALSE)



str(KOSPI)
data =data.frame(date= time(KOSPI),
           KOSPI,
           isgrowth = ifelse(Cl(KOSPI) > Op(KOSPI), "up", 'down')
           )

glimpse(data)
colnames(data) = c("date", "Open", "High", "Low", "Close", "Volume", "Adjusted", "isgrowth") 

head(data)





# 애플: AAPL
# 삼성전자: 005930.KS


# 데이터 확인
# 날짜, 시가(Open), 고가(High), 저가(Low), 종가(Close), 거래량(Volume), 수정가(Adjusted)
# 기업의 활동을 주식의 가치에 반영하고자 종가를 보정하는 것을 수정가라 함
# 배당, 액변분할, 증자, 감자와 같은 이슈 (CRSP: Center for Research in Security Prices)
# 따라서 분석에서는 주로 수정가를 활용함. 



# 삼성전자


# Step 02 ---- 데이터 가공 ---- 


# 시가보다 종가가 높을 경우 "up", 시가가 종가보다 낮을 경우 "down"


# Step 03 ---- 데이터 시각화 ---- 
# 시각화
head(data %>% filter(date >= "2020-01-01"))
     
     
ggplot2((data %>% filter(date >= "2020-01-01"), aes(x = date)) +
        geom_linerange(aes(xmin = date - 0.3,
                           xmax = date + 0.3,
                           ymin = pmin(Open, close()
                                       
                                       
                                       
                                       
                                       
                                       )
        geom_line(aes(y = Close(), size = 2, colour = "red") +
                        theme_minimal()

                                    
                                                                       

# 날짜기간 정리


## 삼성전자 그래프 그려볼 것

## 애플주가 그래프 그려볼 것

# Step 04 ---- 시계열 데이터 이해 ----
# KOSPI는 다양한 요인에 의해 변동 (예: 금리, 통화 정책, 유가 등)
# 지수에 영향을 주는 대표적 요인
# -- KOSPI = f(금리, 통화 정책, 유가, 그외 요인)
# 미래 예측하는 형태의 모델 제시 
# 2일전 KOSPI 지수는 1일전, 1일전 KOSPI 지수는 오늘
# -- KOSPI = f(KOSPI-t-1, KOSPI-t-2, KOSPI-t-3, ..., 그외 요인)

# 시계열의 구성 요소
# 주요 참고자료: https://otexts.com/fppkr/
# 시계열 데이터: 계절성 요인(Seasonal), 추세-순환 요인(Trend-Cycle), 불규칙 요인(Remainder)
# 계절성 요인: 같은 해 또는 같은 분기 특정 기간에 유사한 패턴을 반복하는 경우 지칭
# -- 예) 따듯한 아메리카노 판매량 (여름 감소, 겨울 증가)
# 추세-순환요인: 주가 지수가 시간이 지남에 따라 꾸준히 상승하거나 하락하는 것
# 불규칙 요인: 측정하거나 예측하기 어려운 요인 의미 
# 코스피 지수 특징
# 2000년 이후에 꾸준히 상승
# 2008년 9월 국제금융위기 하락
# 2020년 전고대비 반으로 줄어듬 (코로나)



# frequency: https://otexts.com/fppkr/graphics-ts-objects.html


# [1] "ts"

# 가법모형 시계열 분해
# yt = 계절성 요인(S) + 추세 순환 요인(T) + 불규칙 요인(R)
?decompose


# 가법모형 시계열 분해 시각화


# 승법 모형 시계열 분해
# yt = 계절성 요인(S) x 추세 순환 요인(T) x 불규칙 요인(R)

# 승법모형


# 승법모형 시계열 분해 시각화


# 고전적인 시계열 분해 방법의 이슈 
# 참조: https://otexts.com/fppkr/classical-decomposition.html
# 계절성 요인, 한 해를 기준으로 반복해서 발생한다 가정 (일상생활에서?)
# 처음 몇개와 마지막 몇 개의 관측값에 대한 추세 추정값 얻을 수 없음

# Step 05  ---- 단순 선형 회귀 & 다중 선형 회귀 ----
# 단순 선형 회귀: y = b + b1*x + e 
# -- 계수 b는 x가 0일 때의 y의 값 (절편)
# -- b1는 기울기이며 x가 1단위만큼 증가했을 때 y의 변화

# Step 06 ---- 시계열 회귀 모형 ----
# 추세 요인 반영
# y = b0 + b1(추세 요인t) + b2(계절성 요인t) + et
# t = 1, ..., T(시간)
# tslm() 함수 이용 (trend) & 계절성 요인(Season)


??tslm

fit_lm = tslm(ts_)

summary(fit_lm)

## (1) ---- 추세 요인 반영 하기 ---- 


# ts 객체로 변환


# 예측값 대입


# 예측값 시각화


## (2) ---- 계절성 요인 반영 하기 ---- 


# 객체 변환


# 모형 적합



# 예측값 대입


# 예측값 시각화


## (3) ---- 가변수 활용하기 ---- 



# 코로나 급락시점은 0으로 맞춤


# 기존 방식


# 아카이케의 정보기준
# 참고자료: https://otexts.com/fppkr/selecting-predictors.html



# 가변수를 활용한 방식


# 두 데이터의 


# auto.arima를 이용하여 KOSPI 지수 예측하기
# 정상성과 차분
library(urca)



# auto.arima 활용하기
