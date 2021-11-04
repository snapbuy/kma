# lec12_2_clus.R
# Clustering
# Hierarchical Clustering
# Linkage method, Dendrogram

# set working directory
setwd("D:/tempstore/moocr")

# read csv file
wages1833<-read.csv(file="wages1833.csv", stringsAsFactors = TRUE)
head(wages1833, n=10)

# preprocessing
# delete ID variable
dat1<-wages1833[ , -1]
# delete missing data
dat1<-na.omit(dat1)
str(dat1)

# calculate distance between each nodes
dist_data<-dist(dat1)

# prepare hierarchical cluster
# complete linkage method
hc_a <- hclust(dist_data, method = "complete")
plot(hc_a, hang = -1, cex=0.7, main = "complete")

# average linkage method
# check how different from complete method
hc_c <- hclust(dist_data, method = "average")
plot(hc_c, hang = -1, cex=0.7, main = "average")

# Ward's method
hc_c <- hclust(dist_data, method = "ward.D2")
plot(hc_c, hang = -1, cex=0.7, main = "Ward's method")

