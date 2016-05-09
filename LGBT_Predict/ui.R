

df  <- read.csv("lgbt2.csv")

myLabels <- c("ID", "State Name", "State", "Sexual Orientation Tally" , "Gender Identity Tally" , "Overall LGBT Tally" , "Total Population of LGBT", "Percent of Population that is LGBT", "Number of Mainline Protestants (Per 1000)", "Number of Evangelicals (Per 1000)", "State Ideology (Higher = More Liberal)", "Obama Vote Share - 2012", "Romney Vote Share - 2012", "Percent African American", "Percent Hispanic")





shinyUI(fluidPage(
  titlePanel("Predict LGBT Rights"),
  
  sidebarLayout(
    sidebarPanel("This interactive plot shows how different factors impact how supportive a state is of LGBT rights. ",
                 br(),
                 br(),
                 "Choose indicators for the x and y variables 
                             in the plot, display a regression line, and 
                             calculate the correlation coefficient. The scales created to gauge LGBT rights 
                             are publicly available at ", 
                 a("The Movement Advancement Project", 
                   href = "http://www.lgbtmap.org/equality-maps/legal_equality_by_state"),
                 br(),
                 br(),
                 selectInput('xcol', 'X Variable', myLabels[4:6],
                             selected = myLabels[6]),
                 selectInput('ycol', 'Y Variable', myLabels[7:15],
                             selected = myLabels[7]),
                 checkboxInput('lmline', label = 'Linear regression', value = FALSE),
                 checkboxInput('getcor', label = 'Correlation coefficient', value = FALSE)
    ),
    mainPanel(
      plotOutput('myPlot', height = 500),
      br(),
      br(),
      textOutput('corText')
    )
  )
))