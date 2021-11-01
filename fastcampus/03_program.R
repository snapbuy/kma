#                                    #
#       패스트 캠퍼스 온라인         #
#   금융 공학 / 퀀트 올인원 패키지   #
#    R 프로그래밍 - 강사. 박찬엽     #
#                                    #

# 프로그램의 기본  ----
## 12. R의 기본 연산자 ----
# 연산자란 지금까지 보았던 숫자의 계산 등을 뜻함
1 + 1
1:10 * 1:2

# 할당, 산술, 관계, 논리 연산자를 살펴볼 것

## 12.1 할당 연산자 ----
# 선언한다, 할당한다 등의 단어로 표현함
# assign 이라는 단어를 번역한 것
# R은 특별하게 <- 기호를 할당 연산자로 사용
# 다른 언어처럼 = 기호를 사용할 수는 있으나 권장하지 않음
a <- c("a","b","c")
b = c("a","b","c")

# 화살표 모양에 맞게 특별히 -> 연산자도 제공
c("a","b","c") -> d

## 12.2 산술 연산자 ----

1 + 1   # 더하기
2 - 1   # 빼기
1 * 2   # 곱하기
4 / 2   # 나누기
2^4     # 거듭제곱
5 %% 2  # 나머지
5 %/% 2 # 몫

## 12.3 관계 연산자 ----

4 == 5 # 같다
4 != 5 # 같다가 아니다 = 다르다
4 >  5 # 왼쪽이 크다
4 <  5 # 오른쪽이 크다
4 >= 5 # 왼쪽이 크거나 같다
4 <= 5 # 오른쪽이 크거나 같다

# == 과 = 이 다르다는 것을 꼭 명심!
# =< 과 <- 이 다르다는 것을 꼭 명심!

## 12.4 논리 연산자 ----

c(T,T,F) & T   # 논리곱
c(T,T,F) && T  # 논리곱의 첫번째 결과만
c(T,T,F) | T   # 논리합
c(F,T,F) || F  # 논리합의 첫번째 결과만
!F   # 논리부정(반대)
!T
all(c(T,T,T,T,T,T))
all(c(T,T,T,T,T,F))
all(c(F,F,F,F,F,F))
any(c(T,T,T,T,T,T))
any(c(T,T,T,T,T,F))
any(c(T,F,F,F,F,F))
any(c(F,F,F,F,F,F))
  
## 13. 함수의 구조 및 작성 ----
## 13.1 함수의 구조 ----

# 함수명 <- function(인자1, 인자2 = 기본값){
#   동작할 내용
# }

add_one <- function(x){
  x <- x + 1
  return(x)
}

add_one(10)

# 보통 함수에는 사용할 데이터와 동작의 세부 사항을 결정하는 설정들을 입력 인자로 사용함

add_some <- function(x, some = 1){
  x <- x + some
  return(x)
}

add_some(10)
add_some(10, some = 3)

args(add_some)

# 인자 없이 출력만 있는 함수도 가능하다.

one_to_ten <- function(){
  ot <- 1:10
  return(ot)
}
one_to_ten()

getwd()

# 전역과 지역
# 함수 내부에서 할당한 데이터는 외부에서 사용할 수 없음
one_to_ten <- function(){
  ot <- 1:10
  return(ot)
}
ot

# 외부의 데이터를 함수 내부에서 사용할 수는 있음
# 만약 개인적으로 함수를 작성한다면 절대 권장하지 않음
a <- 1
add_a <- function(x){
  return(x + a)
}

# 인자를 통해 전달하는 것을 추천
# 인자로 전달한 데이터는 인자 이름으로 함수 내부에서만 사용할 수 있음
add_b <- function(x, b){
  return(x + b)
}
b
add_b(13,4)
k <- 8
add_b(13,k)

## 14. 조건문 if ----
## 14.1 조건문의 구조 ----

# 조건 <- 논리형 스칼라
# 
# if (조건) {
#   조건이 맞을 때 실행해야 할 내용
# } else {
#   조건에 맞지 않을 때 실행해야 할 내용
# }
x <- 10
if (x > 5) {
  x <- x + 3
} else {
  x <- x - 3
}
x

x <- 3
if (x > 5) {
  x <- x + 3
} else {
  x <- x - 3
}
x

# if만 작성할 수 있습니다.
# if (조건) {
#   조건이 맞을 때 실행해야 할 내용
# }

# 관계 연산과 논리 연산을 통해 조건을 판단함
# if 내의 조건은 1개만 가능
# all(), any() 함수와 ||, && 연산자가 유용함

if (all(c(T,T,T,T))) {
  print("all True!")
}

if (any(c(T,F,F,F))) {
  print("any True!")
}

if (c(T,T,T) || c(F,F,F,F)) {
  print("|| works!")
}

# 중첩해서 작성할 수 있습니다.
# if (조건1) {
#   조건1이 맞을 때 실행해야 할 내용
# } else if (조건2) {
#   조건1은 맞지 않고 조건2는 맞을 때 실행해야 할 내용
# } else {
#   모든 조건에 맞지 않을 때 실행해야 할 내용
# }
x <- 6
if (x > 5) {
  x <- x + 3
} else if (x == 0) {
  x <- x
} else {
  x <- x - 3
}

## 15. 반복문 for ----
# 반복문의 기본

# for (for내부에서 사용할 지역 변수 in 전체 사용할 벡터) {
#   print(for내부에서 사용할 지역 변수)
# }

for (i in 1:10) {
  print(i)
}

chr_v <- c("a","b","c","d","e","f")
for (i in chr_v) {
  print(i)
}

# next는 다음 반복으로 넘어가라는 뜻
for (i in 1:10) {
  if (i == 4) {
    next
  }
  print(i)
}

# break는 이제 그만 하라는 뜻
for (i in 1:10) {
  if (i == 4) {
    break
  }
  print(i)
}


## 16. 반복문 작성 예시 ----
# 데이터 프레임과 함께 사용

df <- data.frame(a = c("a","b","c","d","e","f"), 
                 b = 1:6, 
                 stringsAsFactors = F)

for (i in 1:nrow(df)) {
  print(df[i, ])
}

# 데이터를 추가하고 싶을 때

df <- data.frame(a = c("a","b","c"), 
                 b = 1:3, 
                 stringsAsFactors = F)
df
add_a <- c("d","e","f","g")
add_b <- 4:7
for (i in 1:length(add_a)) {
  print("for start")
  tem <- data.frame(a = add_a[i], b = add_b[i], stringsAsFactors = F)
  df  <- rbind(df, tem)
  print(df)
}
df

# 파일 저장

df <- data.frame(a = c("a","b","c","d","e","f"), 
                 b = 1:6, 
                 stringsAsFactors = F)

for (i in 1:nrow(df)) {
  file_name <- paste0(df[i,"a"],".csv")
  write.csv(df[i, ], file_name)
}

## 17. apply 계열 함수 ----
# 메트릭스 연산 apply
args(apply)

mtrx <- matrix(1:30, nrow = 5, ncol = 6)
mtrx
apply(mtrx, 2, sum)
apply(mtrx, 1, sum)

# 함수를 직접 작성할 수 있음
# 이름 없이 함수를 정의하여 직접 사용한다고 해서 익명함수라고 함
apply(mtrx, 1:2, function(x) x/2)

# lapply는 리스트에 apply를 하여 결과를 리스트로 제공
l <- list(a = 1:10, b = 11:20)
l
lapply(l, mean)
lapply(l, sum)

# 그렇다면 데이터프레임에서는?
# 컬럼단위 연산 결과를 리스트로 제공
df <- data.frame(a = 1:10, b = 11:20)
lapply(df, mean)
lapply(df, sum)

# 리스트 결과는 다루기 어려움
# 결과를 원자 벡터로 제공하는 버전인 sapply가 있음
df <- data.frame(a = 1:10, b = 11:20)
sapply(df, mean)
sapply(df, sum)

# 그룹별로 tapply 
# 리스트별이나 컬럼 별이 아니라 그룹별로 동작하는 버전
iris
tapply(iris$Petal.Length, iris$Species, mean)


## 18. 에러 처리 ----
# for를 작성할 때 error가 발생하면 멈춤
# try 함수는 error가 발생하더라도 멈추지 않고 계속할 수 있게 해줌

dat <- data.frame(a = 5, b = c(1,2,3,4))

for (i in 1:4) {
  if (i == 3) {
    print(kt)
  }
  print(dat$a[i] / dat$b[i])
}

# 에러가 날 법한 코드 전체를 try() 함수로 감싸고 진행
for (i in 1:4) {
  if (i == 3) {
    try(print(kt))
  }
  print(dat$a[i] / dat$b[i])
}

# 에러 출력도 없애고 진행
for (i in 1:4) {
  if (i == 3) {
    try(print(kt), silent = T)
  }
  print(dat$a[i] / dat$b[i])
}

# 발생한 에러를 저장하여 확인
for (i in 1:4) {
  if (i == 3) {
    err <- try(print(kt), silent = T)
  }
  print(dat$a[i] / dat$b[i])
}
err

# tryCatch() 라는 복잡한 처리를 할 수 있는 함수

args(tryCatch)
?tryCatch