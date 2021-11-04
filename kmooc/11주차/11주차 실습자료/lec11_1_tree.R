# lec11_1_tree.R
# Decision tree
# use package "tree"

#decision tree packages download
install.packages("tree")
library(tree)

#package for confusion matrix
#install.packages("caret")
library(caret)
#install.packages("e1071")
library(e1071)

# set working directory
setwd("D:/tempstore/moocr")

# read csv file
iris<-read.csv("iris.csv", stringsAsFactors = TRUE)
attach(iris)

# training (n=100)/ test data(n=50) 
set.seed(1000)
N<-nrow(iris)
tr.idx<-sample(1:N, size=N*2/3, replace=FALSE)
# split train data and test data
train<-iris[tr.idx,]
test<-iris[-tr.idx,]
#dim(train)
#dim(test)

help("tree")

# step1 : growing tree
treemod<-tree(Species~., data=train)
treemod
plot(treemod)
text(treemod,cex=1.5)

# step2 : pruning using cross-validation
cv.trees<-cv.tree(treemod, FUN=prune.misclass)
cv.trees
plot(cv.trees)

par(mfrow=c(1,2))
plot(cv.trees$size, cv.trees$dev, type="b")
plot(cv.trees$k, cv.trees$dev, type="b")

help(cv.tree)
help(prune.misclass)

# final tree model with the optimal node 
prune.trees<-prune.misclass(treemod, best=3)
plot(prune.trees)
text(prune.trees,pretty=0, cex=1.5)

# step 3: classify test data 
treepred<-predict(prune.trees,test,type='class')
# classification accuracy
confusionMatrix(treepred,test$Species)

