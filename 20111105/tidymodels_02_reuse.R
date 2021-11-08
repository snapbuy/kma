# 라이브러리 불러오기
library(tidymodels)
# 데이터 불러오기
data("penguins")
glimpse(penguins)


# 결측치 제거하기
penguins = na.omit(penguins)

# 데이터 분리
set.seed(100)
split <- initial_split(penguins, strata = sex)
train <- training(split)
test <- testing(split)

# 과제: loan 데이터로 바꿔서 진행해본다. 
library(xgboost)

xgb_sepc <- boost_tree(
  trees = 1000,
  tree_depth = tune(),
  min_n = tune(),
  loss_reduction = tune(),
  sample_size = tune(),
  learn_rate = tune(),
) %>%
  set_engine("xgboost") %>%
  set_mode("classification")

# 모델 개발 - XGBoost 


# 모델 설정


# 하이퍼 파라미터 튜닝 그리드 서치
xgb_grid <- grid_latin_hypercube(
  tree_depth()
  , min_n()
  , loss_reduction()
  , sample_size() sample_prop()
  , finalDefaultMethod(mtry(), train)
  , learn_rate()
  , size = 30
)

# 머신러닝 워크플로우 설정

xgb_wf <- workflow() %>%
  add_formula(sex ~ .) %>%
  add_model(xgb_sepc)

xgb_wf
# 교차검증 셋
vb_folds <- vfold_cv(train, strata = sex., v = 5)

# 모형 학습을 위한 클러스터 설정 


# 모형학습 결과 

# 최적의 파라미터 산출을 위한 시각화 


# 가장 좋은 파라미터 추출 


# 도출된 최적의 파라미터 적용 

# Feature Importance 


# 최종 테스트 셋 적용을 위한 마지막 설정 


# 최종 테스트 혼동행렬 분류표 

