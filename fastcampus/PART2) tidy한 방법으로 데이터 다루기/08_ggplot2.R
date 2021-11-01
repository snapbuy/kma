#                                    #
#       패스트 캠퍼스 온라인         #
#   금융 공학 / 퀀트 올인원 패키지   #
#    R 프로그래밍 - 강사. 박찬엽     #xxx

# 차트를 그리는 ggplot2
## 실습 데이터 소개

if (!require("gapminder")) {install.packages("gapminder")}
library(gapminder)
library(dplyr)

glimpse(gapminder)

library(ggplot2)
ggplot(data = gapminder) + 
  geom_point(aes(x = gdpPercap, y = lifeExp,
                 colour = continent))

## ggplot 객체와 계층 추가하기
## 용어 설명

# 기하 객체(geometric object) : 차트를 구성할 수 있는 그림의 형태들. bar, dot, line 등이 있음. geom_*() 형태의 함수로 layer를 구성함.
# 미적 속성(aesthetic attributes) : 각 기하 객체들의 모양을 결정하기 위한 요소들. 공통적으로 x, y, color 등이 있음.
# 연결(mapping) : 데이터의 컬럼을 필요한 미적 속성에 해당함을 명시적으로 작성하는 것.
# ggplot 자료형 : ggplot()함수로 생성하는 R 객체로 그림을 그리기 위한 정보를 포함하고 있음.
# 계층(layer) : 제공된 데이터와 연결 정보를 바탕으로 그려진 그림. + 연산자를 통해 계층을 추가하여 겹쳐서 그리는 것이 가능.
# `+` 연산자 : 계층을 추가할 때 데이터와 연결 정보, 지금까지 작성된 계층 정보를 전달하는 연산자. 파이프 연산자(`%>%`)와 비슷함.
# 축척(scale) : 데이터를 표시하는 방식으로 연속형 자료형에서 고려함.

## ggplot 객체 생성
p <- ggplot(gapminder, aes(x = gdpPercap, y = lifeExp))
p
summary(p)

## 점차트 형태의 계층을 추가
p_point <- p + geom_point()
p_point
summary(p_point)


## aes()로 데이터 연결하기
## 많이 사용하는 입력값
# x: x-y 좌표계에서 x축으로 표시할 데이터
# y: x-y 좌표계에서 y축으로 표시할 데이터
# color: 색 정보로써 각 기하 객체가 가질 색을 구분하는데 사용함.
# group: color의 하위 호환 aes로 데이터를 묶어서 표시
# alpha: 투명도를 뜻하며 기하 객체의 투명도를 연속형 데이터로 표시
# size : 크기를 뜻하며 기하 객체의 크기를 연속형 데이터로 표시

p <- ggplot(gapminder, aes(x = gdpPercap, y = lifeExp))
p
summary(p)

p_point_color <- p + 
    geom_point(aes(color = continent))
p_point_color

ggplot(gapminder, aes(x = gdpPercap, 
                      y = lifeExp, 
                      color = continent)) + 
  geom_point()

## 축적(scale) 바꾸기
ggplot(gapminder) +
  geom_point(aes(x = log10(gdpPercap),
                 y = lifeExp))

p_point_log10 <- p_point + scale_x_log10()
p_point_log10

## 추세선 추가
p_point + stat_smooth()

p_point + geom_smooth(lwd = 2, 
                      se = FALSE, 
                      method = "lm")

## 여러 차트 그리기
lp <- ggplot(gapminder) + 
  geom_jitter(aes(x = year, y = lifeExp ))
lp

lp + facet_wrap(~ continent)



## 여러 계층에 공통 정보를 전달하기
## global과 local
ggplot(gapminder) +
  aes(x = gdpPercap,
      y = lifeExp,
      color = continent) +
  geom_point() +
  geom_smooth(lwd = 1, se = FALSE)

ggplot(gapminder) +
  aes(x = gdpPercap,
      y = lifeExp) +
  geom_point(aes(color = continent)) +
  geom_smooth(lwd = 1, se = FALSE)

ggplot(gapminder) +
  aes(x = gdpPercap,
      y = lifeExp) +
  geom_point() +
  geom_smooth(lwd = 1, se = FALSE,
              aes(color = continent) )




## 차트 저장하기
dir.create("./ggsave", showWarnings = F)
ggsave("./ggsave/last.png")

## 여러 차트 저장하기
dir.create("./ggsave", showWarnings = F)
for (i in 1:length(unique(gapminder$country))) {
  print(i)
  gapminder %>% 
    filter(country == levels(gapminder$country)[i]) %>%
    ggplot(aes(x = year, y = lifeExp)) +
    geom_line() + geom_point() +
    ggsave(paste0("./ggsave/",levels(gapminder$country)[i],".png"))
}




## 글자 폰트를 다루는 showtext

ggplot(data = mpg) + 
  geom_point(aes(displ, hwy, 
                 colour = class)) +
  ggtitle("한글 테스트도 겸")

library(showtext)
font_add_google("Cute Font", "cute")
showtext_auto()
windows()
ggplot(data = mpg) + 
  geom_point(aes(displ, hwy, 
                 colour = class)) +
  ggtitle("한글 테스트도 겸") + 
  theme(plot.title = element_text(family = "cute", 
                                  size = 30))

ggsave("./ggsave/last.png")
