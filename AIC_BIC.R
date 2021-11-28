library(datasets)

cars <- mtcars
head(cars)

cars.lm <- lm(mpg ~ disp, data=cars)
summary(cars.lm)


broom::glance(cars.lm)


mtcars.lm <- lm(mpg ~ disp + wt, data=cars)
broom::glance(mtcars.lm)


#So we started with a simple linear regression model and gradually increased the #number of parameters until the AIC and BIC stopped falling.