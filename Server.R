library('quantmod')

shinyServer(function(input, output, session) {
  data <- reactive({
    getSymbols(input$Symbol, 
               from = input$dates[1],
               to = input$dates[2],
               auto.assign=FALSE)
  })
  output$plotChart <- renderPlot({ 
   chartSeries(data(), 
           theme = chartTheme("white"),
           TA = NULL
    )
   invalidateLater(1000, session)
  })
  
  # Cl() function returns daily closing prices
  output$meanPrice <- renderText({
    paste("Price Mean: $", sprintf("%1.2f", mean(Cl(data()))))
  })
  output$maxPrice <- renderText({
    paste("Price Max: $", max(Cl(data())))
  })
  
  # Ad() function returns Adjusted prices for splits
  output$adjustedMeanPrice <- renderText({
    paste("Adjusted Price Mean: $", sprintf("%1.2f", mean(Ad(data()))))
  })
  output$adjustedMaxPrice <- renderText({
    paste("Adjusted Price Max: $", max(Ad(data())))
  })
  # last() function returns last observation and 
  # 6th element is the Adjusted price
  output$lastPrice <- renderText({
    paste("Last Price: $:", unclass(last(data())[[6]]))
  })
  output$direction <- renderText({
    if (unclass(last(data())[[6]]) - mean(Ad(data())) > 0) "Up" else "Down"
  })
})