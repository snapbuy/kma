# lec4_1.r : Basic Graphics I 
# Histogram

# set working directory
# change working directory 
setwd("D:/tempstore/moocr/wk4")

# Read brain data (lec3_1.R)
brain<-read.csv(file="brain2210.csv")

head(brain)
dim(brain)

attach(brain)

# 1. histogram 

# 1-1. histogram with no options    
# hist(brain$wt)
hist(wt)

help(hist)

hist(wt, col = "lightblue")

# 1-2. histogram with color and title, legend
hist(wt, breaks = 10, col = "lightblue", main="Histogram of Brain weight" , xlab="brain weight")

# see rgb values for 657 colors, choose what you like
colors()

# select colors including "blue" 
grep("blue", colors(), value=TRUE)

# 1-3. fit function (find density function)
par(mfrow=c(1,1))
d <- density(brain$wt)
plot(d)

# 1-4. histogram with same scale  
#library(dplyr)
# multiple plot
#par(mfrow=c(2,1))
#brainf<-filter(brain,brain$sex=='f') 
#hist(brainf$wt, breaks = 12,col = "green", xlim=c(900,1700),ylim=c(0,20),cex=0.7, main="Histogram for Female", xlab="brain weight")

#brainm<-filter(brain,brain$sex=='m') 
#hist(brainm$wt, breaks = 12,col = "orange",xlim=c(900,1700),ylim=c(0,20), main="Histogram for Male", xlab="brain weight")

