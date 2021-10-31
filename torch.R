#install.packages("torchvision")

library(torch)
library(torchvision)


# a 1d vector of length 2
t <- torch_tensor(c(1, 2))
t

# also 1d, but of type boolean
t <- torch_tensor(c(TRUE, FALSE))
t
torch_tensor 
1
2

torch_tensor 
1
0
