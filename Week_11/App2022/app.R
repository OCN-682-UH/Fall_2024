library(shiny)
library(tidyverse)

ui<-fluidPage(
  sliderInput(inputId = "num", # ID name for the input
              label = "Choose a number", # Label above the input
              value = 50, min = 1, max = 100 # values for the slider
  ),
  textInput(inputId = "title", # new Id is title
            label = "Write a title",
            value = "Histogram of Random Normal Values"), 
  plotOutput("hist"),  # put the histogram here 
  verbatimTextOutput("stats")
) # my user interface

server<-function(input,output){
  
  data<-reactive({
    tibble(x = rnorm(input$num))
  })
  
  output$hist <- renderPlot({
  
    ggplot(data(), aes(x=x))+
      geom_histogram()+
      labs(title = input$title) # change the title name
    # R code to make the hist output goes here
  })
  
  output$stats <-renderPrint({
    summary(data())
  })
} # r code goes here

shinyApp(ui = ui, server = server)