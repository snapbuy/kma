# lec8_1_MLR.r
# Multiple Regression
# stepwise method

# set working directory
setwd("D:/tempstore/moocr")

# autompg data
car<-read.csv("autompg.csv", stringsAsFactors = TRUE)
head(car)
str(car)
attach(car)

# multiple regression : 1st full model 
r1<-lm(mpg ~ disp+hp+wt+accler, data=car)
summary(r1)

# pariwise plot - Explanatory Data Analysis
var1<-c("mpg","disp","hp","wt", "accler" )
pairs(car[var1], main ="Autompg",cex=1, col=as.integer(car$cyl))

plot(hp, mpg, cex=1, col=as.integer(car$cyl))

# Variable selection method
# step(r1, direction="forward")
# step(r1, direction="backward")
# stepwise selection
s1<-step(r1, direction="both")
summary(s1)
#step(lm(mpg ~ disp+hp+wt+accler, data=car), direction="both")

# final multiple regression
r2<-lm(mpg ~ disp+wt+accler, data=car)
summary(r2)

# check correlation between independent variables
var2<-c("disp","hp","wt", "accler" )
cor(car[var2])

# get correlation for each pair
# cor(disp, wt)
# cor(disp, accler)
# cor(wt, accler)

# check multicollinearity 
# variance inflation factor(VIF)
install.packages("car")
library(car)
vif(lm(mpg ~ disp+hp+wt+accler, data=car))

# residual diagnostic plot 
layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page 
plot(r2)
