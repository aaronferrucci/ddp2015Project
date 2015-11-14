library(shiny)
library(ggplot2)
elapsed_ticks <- seq(0, max(dataset$elapsed), 900000)
hours_to_ms <- function(hours) {
  return(hours * 3600 * 1000)
}
start_ticks <- seq(hours_to_ms(8.5), max(dataset$start), hours_to_ms(2.5/60))

timestr <- function(elapsed) {
  # elapsed is in ms, convert to s
  seconds <- elapsed / 1000.0
  hours <- as.integer(seconds / 3600)
  seconds <- seconds - hours * 3600
  minutes <- as.integer(seconds / 60)
  seconds <- round(seconds - minutes * 60, digits=2)

  minute_prefix <- ifelse(minutes < 10, "0", "")
  minutes <- paste0(minute_prefix, minutes)
  second_prefix <- ifelse(seconds < 10, "0", "")
  seconds <- paste0(second_prefix, seconds)

  time <- paste(hours, minutes, seconds, sep=":")
  return(time)
}

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

    # Format an "age" axis.
    if (input$x == "age") {
      p <- p + scale_x_continuous(breaks = seq(0, 100, 10))
    } 
    if (input$y == "age") {
      p <- p + scale_y_continuous(breaks = seq(0, 100, 10))
    }
    if (input$x == "elapsed") {
      p <- p + scale_x_continuous(
        breaks = elapsed_ticks,
        labels = timestr(elapsed_ticks),
        name = "elapsed time (h:mm:ss)"
      )
    }
    if (input$y == "elapsed") {
      p <- p + scale_y_continuous(
        breaks = elapsed_ticks,
        labels = timestr(elapsed_ticks),
        name = "elapsed time (h:mm:ss)"
      )
    }
    if (input$x == "start") {
      p <- p + scale_x_continuous(
        breaks = start_ticks,
        labels = timestr(start_ticks),
        name = "start time (AM)"
      ) + expand_limits(x = hours_to_ms(8.5))
    }
    if (input$y == "start") {
      p <- p + scale_y_continuous(
        breaks = start_ticks,
        labels = timestr(start_ticks),
        name = "start time (AM)"
      ) + expand_limits(y = hours_to_ms(8.5))
    }

    print(p)

  }, height=600)

}

