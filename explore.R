library(dplyr)
library(ggplot2)

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

      # geom_abline(col = "red", intercept = model$coef[1], slope = model$coef[2]) +
dataset <- read.csv("data/clean.csv", stringsAsFactors=F)
select_data <- dataset[dataset$overall <= 1000,]
fmla <- as.formula(paste0("elapsed", " ~ ", "age + sex"))
model <- lm(fmla, data=select_data)
pred <- data.frame(predict(model, interval = ("prediction")))
allDat <- cbind(select_data, pred)
p <- ggplot(allDat, aes_string(x="age", y="elapsed")) +
      geom_point(aes_string(col = "sex")) +
      geom_line(aes(x=age, y=fit)) +
      geom_ribbon(aes(ymin = lwr, ymax = upr), alpha = 0.2)

