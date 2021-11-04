# lec13_3_clus_DBscan.R
# Clustering
# Non-hierarchical Clustering
# k-means, PAM, DBSCAN

# set working directory
setwd("D:/tempstore/moocr")

# read csv file
wages1833<-read.csv(file="wages1833.csv", stringsAsFactors = TRUE)
head(wages1833)

# preprocessing
# delete ID variable
dat1<-wages1833[ , -1]
# delete missing data
dat1<-na.omit(dat1)
head(dat1)

# to choose the optimal k, silhouette
install.packages("factoextra")
library(factoextra)
library(ggplot2)

fviz_nbclust(dat1, kmeans, method = "wss")
fviz_nbclust(dat1, kmeans, method = "gap_stat")

# 1. kmeans 
set.seed(123)
km <- kmeans(dat1, 3, nstart = 25)
km
table(km$cluster)

km <- kmeans(dat1, 3, nstart=10)
km

km <- kmeans(dat1, 3)
km

# visualize
fviz_cluster(km, data = dat1, 
             ellipse.type="convex", 
             repel = TRUE)

# 2. PAM
library("cluster")
pam_out <- pam(dat1, 3)
pam_out

# freq of each cluster
table(pam_out$clustering)

# visualize
fviz_cluster(pam_out, data = dat1,
             ellipse.type="convex", 
             repel = TRUE)

# 3. DBSCAN
install.packages("fpc")
library(fpc)
db<-dbscan(dat1, eps=70, MinPts=3)

# result of clustering
db
db$cluster

#visualization
fviz_cluster(db, data = dat1, 
             ellipse.type="convex", 
             repel = TRUE)

# compare clustering performance : silhouette
# library(cluster) 
sil_pam<- silhouette(pam_out$clustering, dist(dat1))
mean(sil_pam)
sil_db<- silhouette(db$cluster, dist(dat1))
mean(sil_db)

# plot silhouette
fviz_silhouette(sil_pam)
fviz_silhouette(sil_db)

