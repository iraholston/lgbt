#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(ggplot2)

df <- read.csv("D:/lgbt/lgbt_new.csv", stringsAsFactors = FALSE)
myLabels <- c("ID", "State", "State Abbreviation" , "Sexual Orientation Tally" , "Gender Identity Tally" , "Overall Tally" , "Total Population of LGBT", "Percent of Population that is LGBT", "State Ideology (Higher = More Liberal)", "Number of Evangelicals (Per 1000))")


library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  selectedData <- reactive({
    df[, c(1, 
               which(myLabels == input$xcol), 
               which(myLabels == input$ycol))]
  })
  
  myDataset <- reactive({
    rename <- selectedData()
    colnames(rename) <- c('State', 'selectedX', 'selectedY')
    rename
  })        
  
  output$myPlot <- renderPlot({p <- ggplot(data = myDataset(), 
                                           aes(x = selectedX, y = selectedY)) +
    geom_text(aes(label=df$state.x), vjust=-1, hjust=0.5, size=4) +
    xlab(input$xcol) +
    ylab(input$ycol) 
  if (input$lmline) p <- p + stat_smooth(method = "lm")
  p <- p + geom_point(data = subset(myDataset(), State == input$county), 
                      size = 7, colour = "maroon")
  
  
  p})
  
  output$corText <- renderText({
    if (input$getcor) {
      myX = as.matrix(subset(myDataset(), select = selectedX))
      myY = as.matrix(subset(myDataset(), select = selectedY))
      myCor <- cor.test(myX, myY)
      paste("The correlation coefficient for these two health indicators is",
            round(myCor$estimate, digits = 3), "with a 95% confidence interval from",
            round(myCor$conf.int[1], digits = 3), "to",
            round(myCor$conf.int[2], digits = 3), ".")
    }
  })
})