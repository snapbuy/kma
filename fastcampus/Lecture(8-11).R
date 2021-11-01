#                                    #
#       패스트 캠퍼스 온라인         #
#   금융 공학 / 퀀트 올인원 패키지   #
#    R 프로그래밍 - 강사. 박찬엽     #
#                                    #

# 데이터의 기본  ----
## 8. 단일 종류의 데이터 ----

## 벡터의 생성
a <- c(1,2,3)

## 벡터값 확인
a

## 벡터의 정보 확인
str(a)

## 벡터의 길이 출력
lneght(a)

## 8.1 논리형 벡터  ----
lgl_v <- c(T, F, TRUE, FALSE)
lgl_v

typeof(lgl_v)

## 8.2 숫자형 벡터 ----
# double 은 실수형 이라는 뜻이다. 
typeof(1)

# integer는 정수형이라는 뜻이다.
typeof(1L)

num_v <- c(10, -100, 0.6, 0.333)
num_v
typeof(num_v)

## nan은 Not a Number 의 약자로 표현이 불가능한 연산에 대한 답으로 사용한다.
## sqrt() 함수는 루트 연산을 수행한다.
sqrt(-4)

## na는 Not Available 의 약자로 결측된 값, 혹은 사용할 수 없음을 뜻한다.
c(10/0, 0/0, NA)

0/0 == NaN
is.nan(0/0)
is.na(0/0)

## 8.3 글자형 벡터 ----

# 글자형은 따옴표(')나 쌍따옴표(")로 감싸서 표현한다.
chr_v <- c("글자형","a","T","1")
typeof(chr_v)

"따옴표를 글자로 인식하려면 ' 쌍따옴표로 감싼다."
'쌍따옴표를 글자로 인식하려면 " 따옴표로 감싼다.'

"같은 것으로 처리하고 싶을 때는 \" 같이 표시한다."



## 9 단일 종류의 데이터 다루기 ----
## 9.1 강제로 다른 종류의 데이터로 바꾸기 ----
# 강제형변환 이라는 용어를 사용함
# 논리형 -> 숫자형 -> 글자형 방향으로 바꿔준다.
tem <- c(1, T, F, TRUE)
tem
typeof(tem)

tem <- c("글자", 1, -1)
tem
typeof(tem)

tem <- c("글자", T, FALSE)
tem
typeof(tem)

## 9.2 강제로 데이터의 길이를 맞추기 ----
# 스칼라란 1개의 데이터를 뜻함
# 벡터는 스칼라를 포함함
# 데이터가 여러 개인 데이터와 하나의 데이터를 연산하면?
1:10
1:10 + 10

# 데이터의 길이가 다른 데이터들을 연산하면?
# 재활용 규칙이라고 함
1:10 + 1:5

1:10 + 1:3

## 9.3 벡터내의 데이터에 이름을 지정하기 ----
# key-value 라고 부르며 여기서 key가 이름, value가 데이터를 뜻함
# R에서 모든 벡터는 key-value로 데이터의 이름을 지정할 수 있음
# key = value 의 형식을 따르며 key는 이름이기 때문에 따옴표를 생략할 수 있음
# 이름은 데이터의 일부를 사용하고 싶을 때 유용함

c("a" = "k")
c(a = "k", b = "kk", c = "kkk")


## 9.4 데이터의 일부를 사용하기 ----
# 서브셋(subset) 이라고 부르며 가지고 있는 데이터에서 일부만을 사용할 때의 문법을 뜻함.
# 벡터는 벡터[] 의 형태로 뒤에 대괄호를 붙이며 대괄호 안에 벡터를 넣어서 일부의 데이터만 사용한다.
subs <- c("하나", "둘", "셋", "넷", "다섯")

## 9.4.1 논리형 벡터로 데이터의 일부를 사용하기 ----
# 데이터의 갯수에 맞게 논리형 데이터를 넣어야 하며, 부족하게 입력하면 재활용 규칙이, 많이 입력하면 NA를 붙여서 결과를 줌
subs[c(T,F,T,F,T)]

subs[c(T,F)]

subs[c(T,F,T,F,T,T,T)]

## 9.4.2 숫자형 벡터로 데이터의 일부를 사용하기 ----
# 특별히 인덱싱(indexing)이라고 하며 데이터의 위치를 순서대로 1, 2, 3 ... 이라고 지정하기 때문에 필요한 위치를 숫자로 지정하여 일부를 선택할 수 있음

subs[c(1,2,3)]

# 숫자형으로 하면 위치를 지정할 수도, 계속 같은걸 더 사용할 수도 있음
subs[c(3,2,1)]

subs[c(1,1,1,1,1)]

# 음수로 작성하면 그 위치의 데이터를 제외한 나머지를 사용함
subs[c(-1,-2)]

# 대신 양수, 음수를 동시에 사용할 수 없음
subs[c(-1,1)]

# 원래 데이터 범위를 벗어나면 NA를 사용함
subs[c(6)]


## 9.4.3 글자형 벡터로 데이터의 일부를 사용하기 ----
# 글자형 벡터로 일부를 사용하기 위해서는 데이터에 이름을 지정해 두어야 함.

subs_name <- c(a = "하나", b = "둘", c = "셋", d = "넷", e = "다섯")

# 앞서 숫자형 벡터와 같이 동작함.
subs_name[c("a","c","f", "a")]

# 특별히 벡터[[]] 로 이중 대괄호라는 방법이 있음
# 하나의 데이터만 호출할 수 있고, 이름은 빼고 사용함

subs_name[["a"]]
subs_name[[c("a","b")]]
subs_name[[1]]
subs_name[[1]]


## 10 리스트 다루기 ----
## 10.1 리스트 자료형이란 ----
# 다양한 종류의 데이터를 가지는 데이터 묶음
# 심지어 리스트 자료형도 데이터로 가질 수 있음
# 그래서 재귀형(recursive)이라고 하기도 함

mul_l <- list(1, 2, 3)
mul_l

# ?str을 실행해서 도움말을 확인해보세요!
str(mul_l)

# 리스트 역시 벡터이므로 데이터에 이름을 지정할 수 있음
mul_ln <- list(a = 1,b = 2,c = 3)
mul_ln
str(mul_ln)

# 리스트는 여러 다양한 자료형을 가질 수 있음
mul_ll <- list("a", 1L, 1.5, T, list(1,2))
mul_ll
str(mul_ll)

## 10.2 리스트 자료형의 데이터 일부 사용하기 ----
# 벡터와 문법이 같다.
# 특별히 대괄호와 이중 대괄호의 동작 차이가 중요함
# 대괄호의 결과는 항상 리스트
mul_ll[c(1,2)]
str(mul_ll[c(1,2)])

mul_ll[5]
str(mul_ll[5])

# 이중 대괄호는 리스트의 한단계를 없앤 결과를 줌
mul_ll[[1]]
str(mul_ll[[1]])

mul_ll[[c(1,2)]]

mul_ll[[5]]
str(mul_ll[[5]])

# 리스트의 데이터에 이름이 달려 있다면 이중 대괄호와 같은 의미인 $를 사용할 수 있음
mul_ln <- list(a = 1,b = 2,c = 3, d = list(3,4))
mul_ln[[3]]
mul_ln[["c"]]
mul_ln$c

# 리스트에 리스트가 가능하므로 이중 대괄호의 대괄호, 이중 대괄호의 이중 대괄호 등이 가능함
mul_ln[["d"]][1]
mul_ln[["d"]][[1]]


## 11. 속성을 가지는 확장 벡터 ----
## 11.1 데이터에 속성을 추가 ----
# 속성(attribute)이란 메타 데이터로써 `데이터의 데이터`란 뜻이다
x <- 1:10
attr(x, "test")
attr(x, "test") <- "ok!"
attr(x, "done") <- "not yet!"
attributes(x)

# R에서 많이 사용하는 속성은 아래와 같다
# names
# class
# 많이 사용하기 때문에 각 속성을 확인하는 함수도 제공한다.

mul_ln <- list(a = 1,b = 2,c = 3, d = list(3,4))
attributes(mul_ln)
names(mul_ln)

df_ln <- data.frame(a = 1,b = 2,c = 3)
attributes(df_ln)
class(df_ln)

## 11.2 확장 벡터란 ----
# 기존의 벡터에 속성을 추가해 사용하는 특별한 데이터의 종류
## 11.2.1 요인형(factor)  ----
fct <- factor(c("a","b","c"))
fct
typeof(fct)
attributes(fct)

fct <- factor(c("a","b","c","a","a"))

# 요인형에는 levels 가 있다!
levels(fct)

# 강제형변환
typeof(fct)
as.numeric(fct)
as.character(fct)

fct_m <- factor(c(4,8,3))
as.numeric(fct_m)
as.character(fct_m)

levels(fct_m)

## 11.2.2 메트릭스(matrix) ----
# 메트릭스는 2차원 원자 벡터
# 원자 벡터이기 때문에 모든 데이터가 같은 자료형
# 행과 열의 길이를 속성으로 가짐으로써 2차원 데이터로 동작함
nv1 <- 1:10
mtrx <- matrix(nv1, nrow = 5)
typeof(mtrx)
attributes(mtrx)

dim(mtrx)
length(mtrx)

# 행과 열의 방향으로 데이터의 결합 함수를 지원
nv2 <- 10:6
cbind(mtrx, nv2)
nv3 <- 1:2
rbind(mtrx, nv3)

mtrx_n <- cbind(mtrx, nv2)
nv4 <- 1:3
rbind(mtrx_n, nv4)

# 대괄호 내에 쉼표로 구분하여 인덱싱을 지원
mtrx_n[1:3, 1:2]

mtrx_n[1:2,]

mtrx_n[,-3]

mtrx_n[,c(-3,1)]

mtrx_n[,"nv2"]

mtrx_n
mtrx_n[6]
mtrx_n[12]

# byrow 옵션을 통해 데이터의 방향을 바꿀 수 있음
nv1 <- 1:10
matrix(nv1, nrow = 5)
matrix(nv1, nrow = 5, byrow = T)
args(matrix)

# 길이가 다른 데이터와의 연산을 재활용 규칙을 이용해 지원
mtrx_n * 10
mtrx_n + 10

mtrx_n + c(1,4,8,3,2)
mtrx_n + c(3,9,1)

## 11.2.3 데이터프레임(data.frame) ----
# 데이터프레임은 2차원 테이블 형태의 자료구조로써 리스트의 확장
# 리스트 같이 주머니 별로 데이터의 종류가 다를 수 있음
# 컬럼별로 다양한 데이터 종류를 가질 수 있다 라고 표현
lgl <- c(T,F,T,T)
chr <- c("영수", "영미", "철수", "철이")
num <- c(15,14,16,13)

school <- data.frame(이름 = chr, 성별 = lgl, 나이 = num)
str(school)

school <- data.frame(이름 = chr, 성별 = lgl, 나이 = num,
                       stringsAsFactors = F)
str(school)

typeof(school)
attributes(school)
names(school)
class(school)
row.names(school)
dim(school)
length(school)

# 리스트와 다른 점
# 행과 열을 이루는 2차원 데이터이기 때문에 주머니내의 데이터 길이가 같아야 함
lgl <- c(T,F,T,T)
chr <- c("영수", "영미", "철수", "철이")
num <- c(15,14,16,13, 18)
school2 <- data.frame(이름 = chr, 성별 = lgl, 나이 = num)

# 메트릭스 같이 cbind(), rbind() 함수를 지원
몸무게 <- c(35, 38, 40, 25)
cbind(school, 몸무게)

전학생 <- data.frame(성별 = F, 이름 = "영희", 나이 = 18)
rbind(school, 전학생)

# 메트릭스를 데이터프레임으로, 혹은 반대로 만들 수 있음
as.matrix(school)
mtrx <- matrix(1:10, nrow = 5)
as.data.frame(mtrx)

# 리스트와 같은 방식으로 일부의 데이터를 사용할 수 있음
school[,1]
school[,c(1,2)]
school[,-1]
school[,c("성별","이름")]

school[["이름"]]
school$이름

# <- 로 선언하면서 추가, 삭제할 수 있음
school$몸무게 <- c(35, 38, 40, 25)
school

school$몸무게 <- NULL
school
