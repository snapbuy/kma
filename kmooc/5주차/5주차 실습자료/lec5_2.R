# lec5_2.r
# Data exploration : Numerical summary statistics

library(dplyr)

# set working directory
setwd("D:/tempstore/moocr")

### student math grade data ####

stud<-read.csv("stud_math.csv")
head(stud)
dim(stud)
str(stud)

# descriptive statistics :
summary(stud)

# character variable to factor
stud<-read.csv("stud_math.csv",stringsAsFactors = TRUE)
str(stud)

attach(stud)

# descriptive statistics : compare with the above
summary(stud)

# convert to factor variable
#stud$school<-as.factor(stud$school)
#stud$sex<-as.factor(stud$sex)

# Numerical analytics
mean(G3)
sd(G3)
sqrt(var(G3))

# summarize with interested variable list using dpylr(lec3_3.r)
a1 <- select(stud, c("G1", "G2", "G3")) %>% summarize_all(mean)
a2 <- select(stud, c("G1", "G2", "G3")) %>% summarize_all(sd)
a3 <- select(stud, c("G1", "G2", "G3")) %>% summarize_all(min)
a4 <- select(stud, c("G1", "G2", "G3")) %>% summarize_all(max)
table1 <- rbind(a1,a2,a3,a4)
rownames(table1) <- c("mean","sd","min","max")
table1

# creating interested variable list
# vars<-c("G1", "G2", "G3")
# summary(stud[vars])


# categorical data
table(health)

health_freq<-table(health)
names(health_freq) <- c ("very bad", "bad", "average", "good",
                      "very good")
barplot(health_freq, col=3)

# 2*2 contingency table
table(health,studytime)

##################

# chisq.test(health,studytime)

