# lec4_2.r : Basic Graphics II
# Boxplot, Scatterplot

# set working directory
setwd("D:/tempstore/moocr/wk4")

brain<-read.csv(file="brain2210.csv")

head(brain)
dim(brain)

attach(brain)

# 2. boxplot
par(mfrow=c(1,2))
# 2-1 boxplot for all data
boxplot(wt, col=c("coral"))

# 2-2 boxplot by group variable (female, male)
boxplot(wt~sex, col = c("green", "orange"))

# 2-3 horizontal boxplot
par(mfrow=c(1,1))
boxplot(wt~sex, boxwex=0.5, horizontal=TRUE, col = c("grey", "red"))

# 2-4 box width boxwex (width of box)
par(mfrow=c(1,2))
boxplot(wt, boxwex = 0.25, col=c("coral"),  main="Boxplot for all data")
boxplot(wt, boxwex = 0.5, col=c("coral"), main="Boxplot for all data")

# 2-5 add text (n) over a boxplot
#par(mfrow=c(1,2))
#a<-boxplot(brain$wt~brain$sex, col = c("green", "orange"))
#text(c(1:nlevels(brain$sex)), a$stats[nrow(a$stats),]+30, paste("n = ",table(brain$sex),sep=""))

### example : add text (standard deviation) over  a boxplot
#brainf<-subset(brain,brain$sex=='f')
#brainm<-subset(brain,brain$sex=='m')

#sdout<-cbind(sd(brainf$wt),sd(brainm$wt))
#b<-boxplot(brain$wt~brain$sex, col = c("green", "orange"))
#text(c(1:nlevels(brain$sex)), b$stats[nrow(b$stats),]+30, cex=0.8, paste("sd = ",round(sdout, 2),sep="")  )


# Use autompg data (lec3_3.R)
car<-read.csv("autompg.csv")
head(car)

attach(car)

# 3. bar plot with cylinder count 
par(mfrow=c(1,1))
table(cyl)
freq_cyl<-table(cyl)
names(freq_cyl) <- c ("3cyl", "4cyl", "5cyl", "6cyl",
                      "8cyl")
barplot(freq_cyl, col = c("lightblue", "mistyrose", "lightcyan",
                          "lavender", "cornsilk"))

# 4. scatterplot with two variable (x, y) 

# 4-1 simple plot
par(mfrow=c(1,1))
x2<-c(1,4,9)
y2<-2+x2
plot(x2, y2)

# 4-2 another simple plot
par(mfrow=c(2,1))
x<-seq(0, 2*pi, by=0.001)
y1<-sin(x)
plot(x,y1, main="sin curve (0:2*pi)")

y2<-cos(x)
plot(x,y2,main="cosine curve (0:2*pi)" )

# scatterplot of autompg data (lec3_3.R)
# 4-3 autompg data (relationship between wt and mpg)
par(mfrow=c(2,1))
plot(wt, mpg)
plot(hp, mpg)

# 4-4 scatterplot coloring group variable
par(mfrow=c(2,1), mar=c(4,4,2,2))
plot(disp, mpg, col=as.integer(car$cyl))
plot(wt, mpg,  col=as.integer(car$cyl))

# 4-5 Conditioning plot : seperating scatterplot by factor(group) variable
car1<-subset(car, cyl==4 | cyl==6 | cyl==8)
coplot(car1$mpg ~ car1$disp | as.factor(car1$cyl), data = car1,
       panel = panel.smooth, rows = 1)

# 4-6 cross-tab Plot to see how explanatory variables are related each othe
pairs(car1[,1:6], col=as.integer(car1$cyl), main = "autompg")

# 4-7 scatterplot with best fit lines
par(mfrow=c(1,1))
plot(wt, mpg,  col=as.integer(car$cyl), pch=19)
# best fit linear line
abline(lm(mpg~wt), col="red", lwd=2, lty=1)

# lowess : smoothed line, nonparmetric fit line (locally weighted polynomial regression)
lines(lowess(wt, mpg), col="red", lwd=3, lty=2)
help(lowess)







