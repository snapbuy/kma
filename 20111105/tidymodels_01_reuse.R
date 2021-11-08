# ---- tidymodels ----

library(tidymodels)
data("iris")
iris_species <- iris$Species
glimpse(iris_species)


iris2 = lda(Species ~ ., iris_species)

droplevels()







# 데이터 분리
summary(iris)
glimpse(iris)

set.seed()
# 교차검증 데이터셋 준비

split = initial_split(iris, prop = 0.7)
train = training(split)
test =testing(split)

# ---- Use default parameters in parsnip ---- 

fold_5 = vfold_cv(train, repeats = 2)


# randomForest
show_engines("rand_forest")

# Create Model 
rf_spec = rand_forest(mode = "classification") %>% set_engine("randomForest")

model_default = rf_spec %>% fit(Species ~ ., data = train)

# Fit Traning Data


# 예측 평가
model_default %>%
  predict(test) %>%
  bind_cols(test) %>%
  metrics(Species, .pred_class)


# 혼동 행렬
model_default %>%
  predict(test) %>%
  bind_cols(test) %>%
  conf_mat(Species, .pred_class)

# 다양한 모델 평가지표 
multimetric <- metric_set(accuracy, bal_accuracy, sens, precision, recall)

model_default %>%
  predict(test) %>%
  bind_cols(test) %>%
  multimetric(Species, estimate = .pred_class)


rf_spec = rand_forest(mode = "classification") %>% set_engine("randomForest")
rf_spec = rf_spec %>%
  update(mtry = tune(), trees = true())


# ---- Use tune to tune parsnip model ----
# 파라미터 추가
# 옵션 1
model_default %>%
  predict(test) %>%
  bind_cols(test) %>%
  multimetric(Species, estimate = .pred_class)

# 옵션 2


# Create Workflow
rf_workflow <- workflow() %>%
  add_variables(Species, predictors = everything()) %>%
  add_model(rf_spec_2)

# ---- Grid Search ----


# ---- show best model ----


# ---- Random Search ----
set.seed(300)
random_tune <- rf_workflow %>% tune_grid( re)


