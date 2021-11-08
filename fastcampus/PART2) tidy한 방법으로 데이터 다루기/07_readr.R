#                                    #
#       패스트 캠퍼스 온라인         #
#   금융 공학 / 퀀트 올인원 패키지   #
#    R 프로그래밍 - 강사. 박찬엽     #
#                                    #

# 파일을 불러오는 readr
## readr 패키지가 제공하는 함수
library(readr)

read_csv()     # ,(쉼표) 로 구분됨 (comma-separated values)
read_csv2()    # ;(세미콜론) 로 구분됨
read_tsv()     # \t(탭) 으로 구분됨 (tab-separated values)
read_table()   # " "(스페이스) 로 구분됨
read_delim()   # delim 옵션으로 구분자를 지정할 수 있음 ex> delim = "|"

### csv, tsv 등 모두 사실은 텍스트 파일!
### 데이터를 저장할 때 어떤 기호로 구분했다는 것을 표시하기 위해
### 확장자명을 csv 등으로 지정해서 사용하는 것임.
### 재무등 숫자에 자릿수표시(ex> 1,000에서 쉼표) 는 csv에서 매우 부정적

## 실습 데이터 준비 

### 기업 재무데이터를 가지고 있는 csv 파일 다운로드
url <- "https://github.com/mrchypark/sejongFinData/raw/master/dataAll.csv"
download.file(url, destfile = "./data/dataAll.csv")

findata <- read_csv("./data/dataAll.csv")

### 인코딩 지정 방법
findata <- read_csv("dataAll.csv", locale = locale(encoding = "cp949"))

### 함수가 인식하는 문제를 확인하기
problems(findata)

### 글자 - 가 na를 뜻한다고 알려주기
findata <- read_csv("dataAll.csv", 
                    locale = locale(encoding = "cp949"),
                    na = c("","-"))
problems(findata)

### 컬럼의 자료형을 지정해서 불러오기
findata <- read_csv("dataAll.csv", 
                    locale = locale(encoding = "cp949"),
                    na = "-",
                    col_types = list(영업이익률 = col_number(),
                                    연결순이익률 = col_number()))

### 자료형을 지정하는 함수

col_character()     # 글자
col_date()          # 날짜
col_datetime()      # 날짜시간(POSIXct)
col_double()        # 실수형
col_factor()        # factor 
col_integer()       # 정수형
col_logical()       # 논리형
col_number()        # $, ., , 등 글자가 섞여 있는 숫자
col_numeric()       # 숫자(정수와 실수)
col_skip()          # 지정하는 컬럼은 넘김
col_time()          # 시간


## 파일 쓰기

write_csv()         # ,(쉼표) 구분 데이터 저장
write_excel_csv()   # 엑셀에서 바로 열수 있는 csv 파일로 저장
write_delim()       # 구분자를 지정해서 저장 
write_lines()       # 한 줄에 하나의 데이터가 있는 벡터를 저장
write_tsv()         # \t(탭) 구분 데이터 저장

### format_*() 함수들은 각 확장자로 어떻게 데이터가 저장되는지 미리 볼 수 있음.
### cat() 함수는 메모장에서 보는 모양으로 결과를 출력해줌.
cat(format_csv(head(mtcars)))
cat(format_tsv(head(mtcars)))
cat(format_delim(head(mtcars), "\\"))

## 엑셀 파일 읽기, 쓰기
### 파일 읽기는 tidyverse에 포함된 readxl 패키지를 사용
library(readxl)

read_xls()    # xls 확장자 파일 읽기
read_xlsx()   # xlsx 확장자 파일 읽기
read_excel()  # 어떤 확장자의 파일인지 추측하여 읽기

url <- "https://github.com/mrchypark/fcf-R-basic/raw/master/readxlsx.xlsx"
### windows 사용자
### download.file 중 mode = "wb" 가 아니면 파일 깨져서 에러가 나는 경우가 있음
download.file(url, destfile = "./data/readxlsx.xlsx", mode="wb")
### 기타 사용자
download.file(url, destfile = "./data/readxlsx.xlsx")

### read_xlsx 함수로 파일 불러오기
### 첫번째 시트가 기본값임
read_xlsx("./data/readxlsx.xlsx")
### 숫자로 몇번째 시트를 불러올지 지정할 수 있음
read_xlsx("./data/readxlsx.xlsx", sheet = 1)
read_xlsx("./data/readxlsx.xlsx", sheet = 4)
### 시트 이름으로 지정 가능
read_xlsx("./data/readxlsx.xlsx", sheet = "BYC")
### 시트 내의 데이터 중 위에 몇 줄을 건너뛰고 불러올지 skip으로 지정할 수 있음
### col_names 는 컬럼이 데이터 내에 있는지를 지정. TRUE가 기본값.
### col_names = FALSE 이면 숫자로 임의의 컬럼 이름을 사용함.
read_xlsx("./data/readxlsx.xlsx", skip = 5, col_names = F)

### 파일 쓰기는 writexl 패키지의 write_xlsx() 함수를 사용함.
### writexl 패키지는 tidyverse에 속한 패키지가 아님.
### 여러 엑셀 파일 쓰기 패키지 중 가장 가볍고 속도가 빠르며
### 작성한 파일 크기를 작게 만들어주는 패키지
library(remotes)
install_github("ropensci/writexl")
library(writexl)

write_xlsx(iris, "iris.xlsx")
read_xlsx("iris.xlsx")

### list 자료형의 개별 리스트를 파일내의 시트로 생성해줌
iris_list <- split(iris, iris$Species)
str(iris_list)
write_xlsx(iris_list, "iris_list.xlsx")

### 조심할 점
### 날짜시간 자료형을 글자로 바꿔 저장할 것
### 타임존을 UTC로 강제하기 때문에 날짜시간이 변경될 수 있음


## 다양한 데이터를 불러오고 저장하는 rio 패키지
### import(), import_list(), export() 함수를 제공
### 패키지 설치 및 기반 패키지 설치
install.packages("rio")
library(rio)
install_formats()

### 지원하는 파일 형식 리스트
### https://github.com/leeper/rio#supported-file-formats
