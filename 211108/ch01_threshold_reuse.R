# https://bookdown.org/cardiomoon/roc/

# threshold usage
# optimal cut off value

library(caret)
library(ModelMetrics)
library(dplyr)
library(mlbench)
library(tidyr)


data("PimaIndiansDiabetes", package = "mlbench")
idx = createDataPartition(PimaIndiansDiabetes$diabetes, 0.7)
train = PimaIndiansDiabetes[idx$Resample1, ]
test = PimaIndiansDiabetes[-idx$Resample1, ]


ctrl = trainControl(method = "cv"
                    , number = 5
                    , returnResamp = "none"
                    , summaryFunction = twoClassSummary
                    , classProbs = TRUE
                    , savePredictions = TRUE
                    , verboseIter = FALSE
                    )


glimpse(train)
??gbm
modelLookup("gbm")
gbmGrid = expand.grid(interaction(.depth =10
                                  ))



gbm_model = train (diabetes ~.,
                   , n.trees = 100
                   , shrinkage = 0.01
                   , n.minobsinnode =2)

probs <- seq(.1, 0.9, by = 0.02)
ths_df <- thresholder(gbm_model
                      , threshold = probs
                      , final = TRUE
                      , statistics = "all")



library(pROC)




