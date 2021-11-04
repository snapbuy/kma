# lec9_1_knn.R
# Classification
# k-Nearest Neighbor

# packages
install.packages("class")# for knn
install.packages("caret")#for confusion matrix
install.packages("e1071") 
#install.packages("scales")#for graph
library(class)
library(caret)
library(e1071)
#library(scales)

# set working directory
setwd("D:/tempstore/moocr")

# read csv file
iris<-read.csv("iris.csv", stringsAsFactors = TRUE)
# head(iris)
str(iris)
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

# knn (5-nearest neighbor)
md1<-knn(train=iris.train,test=iris.test,cl=trainLabels,k=5)
md1
help(knn)

# confusion matrix
# accuracy of 5-nearest neighbor classification
confusionMatrix(md1,testLabels)

##################################
# optimal k
# optimal k selection (1 to n/2)
##################################
accuracy_k <- NULL
# try k=1 to nrow(train)/2, may use nrow(train)/3(or 4,5) depending the size of n in train data
nnum<-nrow(iris.train)/2
for(kk in c(1:nnum))
{
  set.seed(1234)
  knn_k<-knn(train=iris.train,test=iris.test,cl=trainLabels,k=kk)
  accuracy_k<-c(accuracy_k,sum(knn_k==testLabels)/length(testLabels))
}

# plot for k=(1 to n/2) and accuracy
test_k<-data.frame(k=c(1:nnum), accuracy=accuracy_k[c(1:nnum)])
plot(formula=accuracy~k, data=test_k,type="o",ylim=c(0.5,1), pch=20, col=3, main="validation-optimal k")
with(test_k,text(accuracy~k,labels = k,pos=1,cex=0.7))

# minimum k for the highest accuracy
min(test_k[test_k$accuracy %in% max(accuracy_k),"k"])

#k=7 knn
md2<-knn(train=iris.train,test=iris.test,cl=trainLabels,k=7)
confusionMatrix(md2,testLabels)

# graphic display 
# k=7 knn
plot(formula=Petal.Length ~ Petal.Width,
     data=iris.train,col=alpha(c("purple","blue","green"),0.7)[trainLabels],
     main="knn(k=7)")
points(formula = Petal.Length~Petal.Width,
       data=iris.test,
       pch = 17,
       cex= 1.2,
       col=alpha(c("purple","blue","green"),0.7)[md2]
)
legend("bottomright",
       c(paste("train",levels(trainLabels)),paste("test",levels(testLabels))),
       pch=c(rep(1,3),rep(17,3)),
       col=c(rep(alpha(c("purple","blue","green"),0.7),2)),
       cex=0.9
)


