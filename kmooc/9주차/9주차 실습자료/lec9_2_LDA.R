# lec9_2_LDA.R
# Linear Discriminant Anlaysis

# set working directory
setwd("D:/tempstore/moocr")

# read csv file# read csv file
iris<-read.csv("iris.csv", stringsAsFactors = TRUE)
attach(iris)

# iris data n=150
# set.seed(1000, sample.kind="Rounding")
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

# install the MASS package for LDA
install.packages("MASS")
library(MASS)

# Linear Discriminant Analysis (LDA) with training data n=100
iris.lda <- lda(Species ~ ., data=train, prior=c(1/3,1/3,1/3))
iris.lda

# predict test data set n=50
testpred <- predict(iris.lda, test)
testpred

# export to Excel file with test data
write.csv(testpred,file="testpred.csv", row.names = FALSE)

# accuracy of LDA
# install.packages("caret")
library(caret)
library(e1071)
confusionMatrix(testpred$class,testLabels)

