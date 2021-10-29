install.packages("dplyr")
library(dplyr)


1 /200 
sin(pi/2)
sin(1)

x = 3*4
y <- 2*3

cat(x)

i_use_snake_case = 2
iCamelCase = 3

num_vector = c(1, 2, 3)
class(num_vector)

char_vector = c("a", "b", "c")

lo_vector = c(TRUE, FALSE)
class(lo_vector)


# 강제 형 변환

mix_vector = c(1, "1", 3)

cat(mix_vector)
print(mix_vector)
class(mix_vector)


#범주형 데이타

iris <- iris
head(iris)
str(iris)
str(iris$Species)


location_vector = c("서울", "인천", "부산")
fct_vector = factor(location_vector)
class(fct_vector)

ord_vector = factor(location_vector
                    , ordered = TRUE
                    , levels = c("서울", "인천", "부산"))

class(ord_vector)
