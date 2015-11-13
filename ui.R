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

  titlePanel("Wharf to Wharf 2015 Linear Model Explorer"),

#  sidebarPanel(
#    checkboxInput('age', 'Age'),
#    checkboxInput('sex', 'Sex'),
#    checkboxInput('start', 'Start Time')
#  ),

  fluidRow(
    tabsetPanel(
      tabPanel("README", "abcde"),
      tabPanel("test",
        fluidRow(
          column(2, "sidebar"),
          column(10, "main")
        )
      ),
      tabPanel("test2",
        fluidRow(
          column(2, "sidebar"),
          column(10, "main")
        )
      ),
      tabPanel("Plot", 
        fluidRow(
          column(4, offset=1,
            selectInput('x', 'X', useful_names, "age"),
            selectInput('y', 'Y', useful_names, "elapsed"),
            selectInput('col', 'Color', useful_names, "sex")
          ),
          column(7, plotOutput('plot'))
        )
      ),
      tabPanel("Model", "modelmodel")
    )
  )
)
