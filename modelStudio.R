data("titanic_imputed", package = "DALEX")
head(titanic_imputed)

library(DALEX)
library(modelStudio)


set.seed(2021)

rf_model <- ranger::ranger(survived ~ ., data = titanic_imputed, classification = TRUE, probability = TRUE)

explainer_rf_model <- DALEX::explain(rf_model, data = titanic_imputed[, -8], y = titanic_imputed[, 8])


ms <- modelStudio::modelStudio(explainer_rf_model, B = 50)



library(r2d3)
r2d3::save_d3_html(ms, file = "modelstudio.html")
