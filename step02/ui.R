library(shiny)
library(shinydashboard)
library(tidyverse)


dashboardPage(
  dashboardHeader(title = "title"),
  dashboardSidebar(
    menuItem(
      "Loan Application Result",
      tabName = "Loan Status Tab",
      icon = icon("snowflake")
    )#menu
  ),
  dashboardBody(
    tabItem(
      tabName = "temp",
      box(valueBoxOutput("Loan_Status_Prediction")),
      box(selectInput("v_sex", label = "Gender", choices = c("Female", "Male"))),
      box(selectInput("v_married", label = "Married", choices = c("No", "Yes"))),
      box(selectInput("v_application_income", label = "Married", choices = c("No", "Yes"))),
    )
  )#dash
)

