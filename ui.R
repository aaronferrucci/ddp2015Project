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
"This web application facilitates analysis of the 2015 race results. On the 
'Data Exploration' tab, you can explore the data in a plot, with free choice of
variables for X and Y axes, and color. You can also limit the displayed data 
those under a specific overall rank. On the 'Modeling' tab, you can choose 
variables to be applied as predictor and outcome. For example, how well can we
predict elapsed time by using age and sex as covariates? The race data are
displayed in a plot, along with the predicted fit values."
          )
        )
      ),
# To do: provide summary info, maybe for the y axis variable? I have some
# unused space.
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
            )
          ),
          column(8, plotOutput('plot'))
        )
      ),
# To do: choose y ~ a + b + c (at least one, at most three covariates)
# Provide a graph of y ~ a, with error bands or other statistics
# Provide R^2, and an explanation of its meaning.
# Some explanatory text, for example if I'm modeling bib# ~ start, what
# does that mean, if anything?
      tabPanel("Modeling",
        fluidRow(
          br(),
          column(3, offset=1,
            selectInput('outcome', 'Outcome', useful_names, "elapsed"),
            selectInput('cov1', 'Covariate 1', useful_names, "age"),
            selectInput('cov2', 'Covariate 2', c("None", useful_names), "sex"),
            selectInput(
              'max_rank2',
              'Limit to rank',
              c(
                100,
                seq(1000, 13000, 1000),
                max(dataset$overall)
              ),
              1000 
            ),
            verbatimTextOutput("modelSummary")
          ),
          column(8, plotOutput('plot2'))
        )
      )
    )
  )
)
