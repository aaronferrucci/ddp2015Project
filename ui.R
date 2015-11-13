library(shiny)
library(ggplot2)

useful_names = c(
  "age",
  "bib#" = "bib",
  "country",
  "elapsed time" = "elapsed",
  "overall ranking" = "overall",
  "overall ranking by sex" = "oversex",
  "sex",
  "start time" = "start"
  )
fluidPage(

  titlePanel("Wharf to Wharf 2015 Explorer"),

#  sidebarPanel(
#    checkboxInput('age', 'Age'),
#    checkboxInput('sex', 'Sex'),
#    checkboxInput('start', 'Start Time')
#  ),

  fluidRow(
    tabsetPanel(
      tabPanel("Documentation", "abcde"),
      tabPanel("Data Exploration", 
        fluidRow(
          column(3, offset=1,
            selectInput('x', 'X', useful_names, "age"),
            selectInput('y', 'Y', useful_names, "elapsed"),
            selectInput('col', 'Color', useful_names, "sex")
          ),
          column(8, plotOutput('plot'))
        )
      ),
      tabPanel("Linear Modeling", "modelmodel")
    )
  )
)
