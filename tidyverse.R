# Load packages
library(tidyverse)
library(viridis)
library(ggdark)
library(ggplot2)


circleFun <- function(center = c(0, 0), diameter = 1, npoints = 100){
  r = diameter / 2
  tt <- seq(0,2*pi,length.out = npoints)
  xx <- center[1] + r * cos(tt)
  yy <- center[2] + r * sin(tt)
  return(data.frame(x = xx, y = yy))
}
dat <-
  circleFun(c(1, -1), 2.3, npoints = 100)
ggplot(dat,aes(x, y)) +
  geom_path()

genFun <- function(center = c(0, 0), npoints = 500, c1 = 2.5, c2 = -5, c3 = 4.28, c4 = 2.3){
  t <- seq(0, 2*pi, length.out = npoints)
  xx <- center[1] + c1*(sin(c2*t)*sin(c2*t))*(2^cos(cos(c3*c4*t)))
  yy <- center[2] + c1*sin(sin(c2*t))*(cos(c3*c4*t)*cos(c3*c4*t))
  a <- data.frame(x = xx, y = yy)
  return(a)
}

dat <-
  genFun(c(1,-1), npoints = 100)
ggplot(dat, aes(x, y)) +
  geom_path()


dat <-
  genFun(c(1,-1), npoints = 500, c1 = 5, c2 = -3, c3 = 5, c4 = 2)
ggplot(dat, aes(x, y)) +
  geom_path()

dat <-
  genFun(c(1,-1), npoints = 5000)
ggplot(dat, aes(x, y)) +
  geom_line()

set.seed(1234)
dat <-
  genFun(c(1,-1), npoints = 500)
dat %>%
  \ggplot2(aes(x, y)) +
  geom_point()