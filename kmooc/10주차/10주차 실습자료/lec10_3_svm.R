# lec10_3_svm.r
# Classification
# Support vector machine using kernel
# Cancer data

# install package for support vector machine
# install.packages("e1071")
library (e1071)
# help(svm)

# install package for confusionMatrix
#install.packages("caret")
library(caret)

# set working directory
setwd("D:/tempstore/moocr")

# read data
cancer<-read.csv("cancer.csv", stringsAsFactors = TRUE)
head(cancer, n=10)

# remover X1 column(ID number)
cancer<-cancer[, names(cancer) != "X1"]
attach(cancer)

# training (455) & test set (228)
N=nrow(cancer)
set.seed(998)

# split train data and test data
tr.idx=sample(1:N, size=N*2/3)
train <- cancer[ tr.idx,]
test  <- cancer[-tr.idx,]

#svm using kernel
m1<-svm(Y~., data = train) # radial
summary(m1)
m2<-svm(Y~., data = train,kernel="polynomial")
summary(m2)
m3<-svm(Y~., data = train,kernel="sigmoid")
summary(m3)
m4<-svm(Y~., data = train,kernel="linear")
summary(m4)

#measure accuracy
pred11<-predict(m1,test) # radial basis
confusionMatrix(pred11, test$Y)

pred12<-predict(m2,test) # polynomial
confusionMatrix(pred12, test$Y)

pred13<-predict(m3,test) # sigmoid
confusionMatrix(pred13, test$Y)

pred14<-predict(m4,test) # linear
confusionMatrix(pred14, test$Y)
