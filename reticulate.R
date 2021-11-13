library(reticulate)
library(data.table)

py_config()

df <- data.table(py_load_object('df.pickle'))
summary(df)