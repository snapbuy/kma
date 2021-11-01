#                                    #
#       패스트 캠퍼스 온라인         #
#   금융 공학 / 퀀트 올인원 패키지   #
#    R 프로그래밍 - 강사. 박찬엽     #
#                                    #

# tidy한 방법으로 데이터 다루기
## 관계형 데이터를 다루기

## 사용할 데이터 소개
install.packages("nycflights13")

library(nycflights13)
library(dplyr)
# tar <- "https://d33wubrfki0l68.cloudfront.net/245292d1ea724f6c3fd8a92063dcd7bfb9758d02/5751b/diagrams/relational-nycflights.png"
# download.file(tar, destfile = "rel_nyc.png", mode = "wb")
grid::grid.raster(png::readPNG("rel_nyc.png"))

glimpse(flights)
glimpse(airports)
glimpse(weather)
glimpse(airlines)
glimpse(planes)

## 각 테이블을 연결하는 변수 key
## 기본키: 테이블의 개별 행(row)을 유일하게 인식할 수 있는 열(column) 혹은 열의 집합
## 왜래키: 다른 테이블의 기본키와 같은 의미를 지니는 열(column) 혹은 열의 집합

## 기본키임을 확인
planes %>% 
  count(tailnum) %>% 
  filter(n > 1) %>% 
  nrow()

## n > 1인 데이터가 있으므로 기본키로 활용하는데 제약이 있음
weather %>% 
  count(year, month, day, hour, origin) %>% 
  filter(n > 1)

## 기본키 조합을 상상하더라도 확인이 꼭 필요
flights %>% 
  count(year, month, day, flight) %>% 
  filter(n > 1)



## 변수를 추가하는 mutating join
## left_join

## 데이터 준비
flights2 <- flights %>% 
  select(year:day, hour, origin, dest, tailnum, carrier)
flights2

flights2 %>%
  select(-origin, -dest) %>% 
  left_join(airlines, by = "carrier")

## key를 열 이름 기반으로 
flights2 %>% 
  left_join(weather)

flights2 %>% 
  left_join(planes)

flights2 %>% 
  left_join(planes, by = "tailnum")

## 필요한 데이터만 남기는 filtering join
# tar <- "https://d33wubrfki0l68.cloudfront.net/028065a7f353a932d70d2dfc82bc5c5966f768ad/85a30/diagrams/join-semi.png"
# download.file(tar, destfile = "semi.png", mode = "wb")
grid::grid.raster(png::readPNG("semi.png"))
# tar <- "https://d33wubrfki0l68.cloudfront.net/e1d0283160251afaeca35cba216736eb995fee00/1b3cd/diagrams/join-semi-many.png"
# download.file(tar, destfile = "semi-many.png", mode = "wb")
grid::grid.raster(png::readPNG("semi-many.png"))
# tar <- "https://d33wubrfki0l68.cloudfront.net/f29a85efd53a079cc84c14ba4ba6894e238c3759/c1408/diagrams/join-anti.png"
# download.file(tar, destfile = "anti.png", mode = "wb")
grid::grid.raster(png::readPNG("anti.png"))


top_dest <- flights %>%
  count(dest, sort = TRUE) %>%
  head(10)
top_dest

flights %>% 
  filter(dest %in% top_dest$dest)

flights %>% 
  semi_join(top_dest)

flights %>%
  anti_join(planes, by = "tailnum") %>%
  count(tailnum, sort = TRUE)
