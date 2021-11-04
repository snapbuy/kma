# lec7_3.r : Linear model 
# Regression with flight(NY->SF)

library(dplyr)
library(ggplot2)

# set working directory
setwd("D:/tempstore/moocr")

# subset of flight data in SFO (n=2974)
# dest="SFO", origin=="JFK", arr_delay<420, arr_delay>0
SF<-read.csv("SF_2974.csv",stringsAsFactors = TRUE)
head(SF)
str(SF)

summary(SF)

# Visulaization : boxplot
SF %>% 
  ggplot(aes(x=carrier, y=hour)) + geom_boxplot(aes(fill=carrier))
# boxplot(hour~carrier, data=SF, col=c("coral", "green", "orange", "yellow", "skyblue"))

# Visulaization : scatterplot
SF %>% 
  ggplot(aes(x=dep_delay,y=arr_delay,color=carrier)) + geom_point()

# Visulaization using dplyr : Histogram
SF %>% 
  ggplot(aes(arr_delay)) + geom_histogram(binwidth = 15)

# Visulaization using dplyr : Density Graph
SF %>% 
  ggplot(aes(arr_delay)) + geom_density(fill = "pink",binwidth = 15)


# Visulaization using dplyr : Box-Plot by departing time
SF %>%
  ggplot(aes(x = hour, y = arr_delay)) +
  geom_boxplot(alpha = 0.1, aes(group = hour)) + geom_smooth(method = "lm") + 
  xlab("Scheduled hour of departure") + ylab("Arrival delay (minutes)") + 
  coord_cartesian(ylim = c(0, 120))

# linear regression
m1<- lm(arr_delay ~ hour , data = SF)
summary(m1)
anova(m1)

# scatterplot with best fit lines
par(mfrow=c(1,1))
plot(SF$hour, SF$arr_delay, col=as.integer(SF$carrier), pch=19, xlab="hour",ylab="delay") 
# best fit linear line
abline(lm(SF$arr_delay~SF$hour), col="red", lwd=2, lty=1)

# residual diagnostic plot 
layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page 
plot(m1)


