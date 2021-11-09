library(shiny)

shinyUI(
  pageWithSidebar(
    #header panel
    title(main ="shiny test", windowTitle = "slide")
    
    #side bar panel
    sideBarPanel(
      slidarInput("bin5"
                  , "Number of bins:"
                  , min =  1
                  , max = 50
                  , value = 20)#slideInput
      ), #sidebarInput
    
    mainPanel(
      plotOutput(outputId = "distPlot", height = 250))
      )#slidebarpanel  
    )#mainPaenl
  )#pageWithSidebar
) #shiny
