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

shinyUI(
  pageWithSidebar(
    headerPanel("Wharf to Wharf 2015 Explorer"),
    sidebarPanel(
      selectInput('y', 'Y', useful_names, "elapsed"),
      selectInput('x', 'X', useful_names, "age"),
      selectInput('col', 'Color', useful_names, "sex"),
      selectInput(
        'max_rank',
        'Limit to rank',
        c(
          100,
          seq(1000, 13000, 1000),
          max(dataset$overall)
        ),
        max(dataset$overall)
      ),
      checkboxInput('smooth', 'Enable Smoother', FALSE),
      checkboxInput('jitter', 'Enable Jitter', FALSE),
      helpText(
        "This app lets you explore the results of the 2015 Wharf to Wharf 
        race in Santa Cruz, CA. Data from the race is plotted according to 
        chosen X and Y variables, with coloring based on a 3rd variable. 
        The data size can be limited by overall runner rank.",
        br(),
        br(),
        "If the smoother is enabled, trends are more visible. For example, 
        try elapsed time vs. age, colored by sex, with smoothing, and limit 
        the data to the top 100 runners.",
        br(),
        br(),
        "Jitter is useful when one of the axes is a factor variable, that is,
        sex or country."
      )
    ),
    mainPanel(plotOutput("plot"))
  )
)
