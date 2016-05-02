

df <- read.csv("D:/lgbt/lgbt_new.csv", stringsAsFactors = FALSE)
myLabels <- c("ID","State", "State Abbreviation" , "Sexual Orientation Tally" , "Gender Identity Tally" , "Overall Tally" , "Total Population of LGBT", "Percent of Population that is LGBT", "State Ideology (Higher = More Liberal)", "Number of Evangelicals (Per 1000)")





shinyUI(fluidPage(
  titlePanel("Predict LGBT Rights"),
  
  sidebarLayout(
    sidebarPanel("This interactive plot shows ",
                 br(),
                 br(),
                 "Choose health indicators for the x and y variables 
                             in the plot, highlight a specific county (if values 
                             have been reported for both x and y health 
                             indicators), display a regression line, and 
                             calculate the correlation coefficient. The data 
                             used in these plots are publicly available at ", 
                 a("Utah's Open Data Catalog.", 
                   href = "https://opendata.utah.gov/Health/Health-Care-Indicators-By-Counties-In-Utah-2014/qmsu-gki4"),
                 br(),
                 br(),
                 selectInput('xcol', 'X Variable', myLabels[4:6],
                             selected = myLabels[6]),
                 selectInput('ycol', 'Y Variable', myLabels[7:10],
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