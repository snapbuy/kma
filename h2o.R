library(DALEX)
library(DALEXtra)
library(dplyr)
library(titanic)
library(fastDummies)
library(h2o)
??DALEXtra
??gdal

set.seed(2021)
titanic_train %>%
  select(
    Sex,
    Survived,
    Pclass,
    Age,
    SibSp,
    Parch,
    Fare,
    Embarked) %>%
  mutate_at(c("Survived", "Sex", "Embarked"), as.factor) %>%
  mutate(fam_members = SibSp + Parch) %>%
  na.omit() %>%
  dummy_cols() %>%
  select(-Sex, -Embarked, -Suvived_0, -Survived_1, -Parch, -SibSp) -> titanic_small

titanic_y <- titanic_small %>%
  select(-Suvived) %>%
  as.matrix()

h2o.init()
h2o.no_progress()


titanic_h2o <- as.h2o(titanic_small, destination_frame = "titanic_small")


model_h2o <- h2o.deeplearning(
  x = 2:11,
  y = 1,
  
)

