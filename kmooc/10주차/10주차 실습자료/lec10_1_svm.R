# lec10_1_svm.R
# Classification
# support vector machine (e1071)

# install package for support vector machine
install.packages("e1071")
library (e1071)
#help(svm)

# install package for confusionMatrix
#install.packages("caret")
library(caret)

# set working directory
setwd("D:/tempstore/moocr")

# read data
iris<-read.csv("iris.csv",stringsAsFactors = TRUE)
attach(iris)

## classification 
# 1. use all data 
# m1<- svm(Species ~Petal.Length+Petal.Width+Sepal.Length+Sepal.Width, data = iris)
m1<- svm(Species ~., data = iris)
summary(m1)

# classify all data using svm result (m1)
# first 4 variables as attribute variables
x<-iris[, -5]
pred <- predict(m1, x)

# Check accuracy (compare predicted class(pred) and true class(y))
# y <- Species or y<-iris[,5]
y<-iris[,5]
confusionMatrix(pred, y)

# visualize classes by color
plot(m1, iris,  Petal.Width~Petal.Length, slice=list(Sepal.Width=3, Sepal.Length=4))


