install.packages('rsconnect')

rsconnect::setAccountInfo(name='snapbuy', token='81A28D3F3E20869E66C120E50E59F356', secret='NuXtOHBM6Mze/hnq4jHzVe4GnwNE5w6k5xmRjUge')

library(rsconnect)
rsconnect::deployApp('path/to/your/app')