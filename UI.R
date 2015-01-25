shinyUI(pageWithSidebar(
  headerPanel("Shiny Stocks"),
  sidebarPanel( 
    wellPanel(
      textInput(inputId="Symbol", "Ticker:", "AAPL"),
      dateRangeInput("dates", 
                     "Date range",
                     start = as.character(seq(Sys.Date(), length=2, by="-2 month")[2]), 
                     end = as.character(Sys.Date()))
    ),
    textOutput("meanPrice"),
    textOutput("maxPrice"),
    textOutput("adjustedMeanPrice"),
    textOutput("adjustedMaxPrice"),
    textOutput("lastPrice"),
    textOutput("direction")
  ),
  
  mainPanel(
    plotOutput(outputId = "plotChart")
  )
))