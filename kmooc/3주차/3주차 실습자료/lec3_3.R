# lec3_3.r
# Data handling
# Data analysis with autompg.csv

# data manipulation package
# select, filter, group by, summarise in dplyr package 
install.packages("dplyr")
library(dplyr)

# set working directory
setwd("D:/tempstore/moocr")

# Read txt file with variable name
# http://archive.ics.uci.edu/ml/datasets/Auto+MPG

# Data reading in R
car<-read.csv(file="autompg.csv")
attach(car)

head(car)
dim(car)
str(car)

# Summary
summary(car)

# Basic statistics

# frequency
table(origin)
table(year)

# mean and standard deviation
mean(mpg)
mean(hp)
mean(wt)

# Data handling using "dplyr"

# 1. subset data : selecting a few variables
set1<-select(car, mpg, hp)

# 2. subset data : Drop variables with -
set2<-select(car, -starts_with("mpg"))

# 3. subset data : filter mpg>30
set3<-filter(car, mpg>30) 
head(set3)

# 4. create a derived variable
set4<-car %>%
  filter(!is.na(mpg)) %>%
  mutate(mpg_km = mpg*1.609)

head(set4)

# mean and standard deviation
car %>%
  summarize(mean(mpg),mean(hp),mean(wt))

# mean of some variables
select(car, 1:6) %>%
  colMeans()

# table with descriptive statistics
a1 <- select(car, 1:6) %>% summarize_all(mean)
a2 <- select(car, 1:6) %>% summarize_all(sd)
a3 <- select(car, 1:6) %>% summarize_all(min)
a4 <- select(car, 1:6) %>% summarize_all(max)
table1 <- rbind(a1,a2,a3,a4)
rownames(table1) <- c("mean","sd","min","max")
table1

# summary statistics by group variable
car %>%
  group_by(cyl) %>%
  summarize(mean_mpg = mean(mpg, na.rm = TRUE))











