# lec5_1.r
# Data management : merge, sorting, subset 

# install.packages(dplyr)
library(dplyr)

# set working directory
setwd("D:/tempstore/moocr_k")

# practice data with dplyr
dat1<-read.csv(file="data1.csv")
dat2<-read.csv(file="data2.csv")

# using merge
dat12<-merge(dat1, dat2, by="ID")
dat12

# using dplyr library
dat12<-inner_join(dat1,dat2, by="ID")
dat12

full_join(dat1,dat3)

# add more data (combine in a row)
# dat123<-rbind(dat12, dat3)
dat3<-read.csv(file="data3.csv")
dat123<-rbind(dat12, dat3)
dat123

# using dplyr function
# dat123<-bind_rows(dat12,dat3)

# export to csv file
# write.csv(dat12,file="data12.csv", row.names = FALSE)

# data sorting
# dats1<-dat12[order(dat12$age),]
# dats2<-dat12[order(dat12$gender, dat12$age), ]
dats1<-arrange(dat12, age)
dats1
dats2<-arrange(dat12, gender, age)
dats2

# data subset (selecting data)
# newdat<-dat12[which(dat12$gender=="F" & dat12$age>15),]
# newdat<-subset(dat12, dat12$gender=="F" & dat12$age>15)
newdat<-filter(dat12, dat12$gender=="F" & dat12$age>15)
newdat

# excluding variables
# exdat<-dat12[!names(dat12) %in% c("age","gender")]
exdat<-select(dat12, -c("age","gender"))
exdat


