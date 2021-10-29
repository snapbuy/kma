# install.packages("xml2")
library(ggplot2)
library(rvest)
library(xml2)
library(dplyr)
library(httr)
html_df = read_html("data/intro.html", encoding = "utf-8")
html_df

xml_structure(html_df)

res = GET('https://en.wikipedia.org/wiki/Anscombe%27s_quartet')

print(x = res)

status_code(res)


df <- /html/body/div[3]/div[3]/div[5]/div[1]/table[2]


