library(shiny)
library(shinydashboard)
library(tidyverse)
library(tidymodels)


load("model/loan_model.RData")

function(input, output) {
  output$Loan_Status_Prediction <- renderValueBox({
    print("text")
  })
  
}
