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

  fluidRow(
    tabsetPanel(
      tabPanel("README",
        fluidRow(
          br(),
          column(8, offset=2,
"The Wharf to Wharf race happens every July in Santa Cruz. The mostly flat,
6-mile course hugs the coastline between Santa Cruz and Capitola. The 
race has grown in popularity since its beginning in 1973, with more than 13,000
registered participants in 2015.",
br(),
br(),
"Race results are available online. You
can look up runners' results by bib number, name, city and state. This
is ok, but it's not very handy for anyone wanting to do real data analysis.",
br(),
br(),
"This web application facilitates exploration of the 2015 race results. On 
the 'Data Exploration' tab, you can plot the data in various ways."
          )
        )
      ),
      tabPanel("Data Exploration", 
        fluidRow(
          br(),
          column(3, offset=1,
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
            checkboxInput('jitter', 'Enable Jitter', FALSE)
          ),
          column(8, plotOutput('plot'))
        )
      )
    )
  )
)
