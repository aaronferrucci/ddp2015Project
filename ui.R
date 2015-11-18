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
"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras ornare viverra
eros, et gravida mauris ornare in. Fusce in ex aliquam, vestibulum tortor non,
dapibus lectus. Nunc eget placerat risus, a euismod arcu. Maecenas non sem quis
justo venenatis vestibulum tempor et libero. Aenean pharetra aliquet blandit.
Integer eros massa, accumsan sit amet neque et, pretium dictum urna. Mauris
aliquet, velit vel suscipit varius, neque orci aliquam urna, vel convallis
nulla justo vitae quam. Mauris ac velit est.",
br(),
br(),
"Quisque ante massa, semper id magna ac, semper hendrerit risus. Mauris commodo
lectus vestibulum, consectetur neque non, gravida dolor. Nulla id lacus
venenatis, mattis lectus quis, gravida massa. Ut elementum posuere nunc a
tempor. Integer ac condimentum quam. Maecenas suscipit consectetur justo, sed
pretium mi. Etiam ut nulla odio. Ut quis aliquet urna, eget venenatis ex.
Aliquam lobortis augue risus, vitae vulputate tortor ullamcorper id. Aliquam
nisi nisi, auctor a pellentesque quis, facilisis sit amet mi.",
br(),
br(),
"Fusce varius diam ac velit porta, sit amet vulputate nibh congue. Sed
tristique ullamcorper nisl, non tempus est vestibulum tincidunt. Quisque
faucibus sapien lorem, non tempor dolor ullamcorper vel. Aliquam diam eros,
feugiat eu nunc eget, egestas vulputate dui. Proin dignissim eu leo non
imperdiet. Sed volutpat at felis eget tempus. In non nibh et mauris interdum
varius. Vestibulum porttitor rhoncus mattis. Sed vel nibh in lacus iaculis
semper. Aenean accumsan ornare augue id fermentum. Pellentesque habitant morbi
tristique senectus et netus et malesuada fames ac turpis egestas."
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
            )
          ),
          column(8, plotOutput('plot2'))
        )
      )
    )
  )
)
