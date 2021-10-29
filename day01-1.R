#파일 입출력

이름 = c("홍길동", "심청이", "임꺽정")
나이 = c(25, 30, 34)
결석 =c(TRUE, FALSE, FALSE)

student = data.frame(name = 이름)

getwd()
setwd("")
write.csv()


install.packages("writexl")
library(writexl)


student = read.csv()


install.packages("readxl")
library(readxl)

student2 = read_xlsx(path = "student.xlsx", sheet = 1)
class(student2)

data.table