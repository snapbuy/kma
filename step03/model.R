library(readr)
library(dplyr)
library(stringr)
library(forcats) 
library(magrittr) 
library(tidymodels)
library(themis)
library(doParallel)
library(treesnip)

detectCores()

train = read_csv("data/train_ctrUa4K.csv")


rf_ml <-- rand_forest(trees = tune(),
                      min_n = tune()
                      ) %>%
  set_engine("randomForest") %>%
  set_mode("classfication")

xgb_ml <- boost_tree(trees = tune(), min_n = tune(), tree_depth = tune()) %>%
  set_engine("randomForest") %>%
  set_mode("classfication")


#학습
rand_tune = tune_grid(rf_ml
                      , tidy_recipe
                      , resamples = tidy_kfolds
                      , grid = rand_grid)

xgb_tune = tune_grid(xgb_ml
                     , resamples = tidy_kfolds
                     , grid = xgb_grid)

#parameter 추출

