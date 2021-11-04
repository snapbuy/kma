# lec11_2_tree.R
# Decision tree
# use package rpart and party

# other package for tree
install.packages("rpart")
install.packages("party")
library(rpart)
library(party)

#package for confusion matrix
#install.packages("caret")
library(caret)

library(e1071)

# set working directory
setwd("D:/tempstore/moocr")

# read csv file
iris<-read.csv("iris.csv",stringsAsFactors = TRUE)
attach(iris)

# training (n=100)/ test data(n=50) 
set.seed(1000)
N<-nrow(iris)
tr.idx<-sample(1:N, size=N*2/3, replace=FALSE)
# split train data and test data
train<-iris[tr.idx,]
test<-iris[-tr.idx,]


##decision tree : use rpart package
help("rpart")

cl1<-rpart(Species~., data=train)
plot(cl1)
text(cl1, cex=1.5)

#pruning (cross-validation)-rpart
printcp(cl1)
plotcp(cl1)
help(printcp)

#final tree model -rpart
pcl1<-prune(cl1, cp=cl1$cptable[which.min(cl1$cptable[,"xerror"]),"CP"])
plot(pcl1)
text(pcl1)

#measure accuracy -rpart
pred2<- predict(pcl1,test, type='class')
confusionMatrix(pred2,test$Species)

##decision tree : use party package
#unbiased recursive partioning based on permutation test
help(ctree)

partymod<-ctree(Species~.,data=train)
plot(partymod)
partymod

#measuring accuracy(party)
partypred<-predict(partymod,test)
confusionMatrix(partypred,test$Species)