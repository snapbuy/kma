# lec9_3_QDA.R
# Quadratic Discriminant Analysis

# MASS package for LDA
# install.packages("MASS")
library(MASS)

#caret package for confusion Matrix
# install.packages("caret")
library(caret)
library(e1071)

# set working directory
setwd("D:/tempstore/moocr")

# read csv file# read csv file
iris<-read.csv("iris.csv",stringsAsFactors = TRUE)
attach(iris)

# training/ test data : n=150
set.seed(1000)
n <- nrow(iris)
# train set 100, test set 50
tr.idx <- sample.int(n, size = round(2/3* n))

# attributes in training and test
iris.train<-iris[tr.idx,-5]
iris.test<-iris[-tr.idx,-5]

# target value in training and test
trainLabels<-iris[tr.idx,5]
testLabels<-iris[-tr.idx,5]

train<-iris[tr.idx,]
test<-iris[-tr.idx,]

# Box's M-test for Homogenity of Covariance Matrices
install.packages("biotools")
library(biotools)
boxM(iris[1:4], iris$Species)

# Quadratic Discriminant Analysis (QDA)
iris.qda <- qda(Species ~ ., data=train, prior=c(1/3,1/3,1/3))
iris.qda
# iris.qda <- qda(Species=Setal.Length+Setal.Width+Petal.Length+Petal.Width, data=train, prior=c(1/3,1/3,1/3))Petal.Length ~ Petal.Width,

# predict test data set n=50
testpredq <- predict(iris.qda, test)
testpredq

# export to Excel file with test data
write.csv(testpredq,file="testpredq.csv", row.names = FALSE)

# accuracy of QDA
confusionMatrix(testpredq$class,testLabels)

# partimat() function for LDA & QDA
#install.packages("klaR")
#library(klaR)
#partimat(as.factor(iris$Species) ~ ., data=iris, method="lda")
#partimat(as.factor(iris$Species) ~ ., data=iris, method="qda")
