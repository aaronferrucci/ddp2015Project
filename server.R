library(shiny)
library(ggplot2)

function(input, output) {
  output$plot <- renderPlot({
#    fit <- switch(
#      1 + 4 * input$age + 2 * input$sex + 1 * input$start,
#      NULL, # 0
#      lm(elapsed ~ start, data=dataset), # 1
#      lm(elapsed ~ sex, data=dataset), # 2
#      lm(elapsed ~ sex + start, data=dataset), # 3
#      lm(elapsed ~ age, data=dataset), # 4
#      lm(elapsed ~ age + start, data=dataset), # 5
#      lm(elapsed ~ age + sex, data=dataset), # 6
#      lm(elapsed ~ age + sex + start, data=dataset) # 7
#    )

    p <- ggplot(dataset, aes_string(x=input$x, y=input$y, col=input$col)) + geom_point()

    print(p)

  }, height=700)

}

