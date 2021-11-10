library(shiny)
library(shinydashboard)
library(tidyverse)
library(tidymodels)


load("model/loan_model.RData")

function(input, output) {
  output$Loan_Status_Prediction <- renderValueBox({
    #print("text")
    prediction <- predict(
      final_clf_model, 
      tibble("Gender" = input$v_sex,
             "Married" = input$v_married,
             "Credit_History" = input$v_credit,
             "Application_Income" = input$v_application_income,
                              )
      #cat("prediction_class)
      prediction_prob <- predict(
        final_clf_model, 
        tibble("Gender" = input$v_sex,
               "Married" = input$v_married,
               "Credit_History" = input$v_credit,
              "Application_Income" = input$v_application_income),
        type = "prob"
        ) 
        
      gather() %>%
        
      )
    )
  })
  
}
