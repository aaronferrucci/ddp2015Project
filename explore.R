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


allData <- read.csv("data/w2w2015.csv", stringsAsFactors=F)
allData$sex <- as.factor(allData$sex)
allData[allData$country == "UMI", c("country")] <- c("USA")

allData[allData$country == "", c("country")] <- allData[allData$country == "", c("city")]
allData[grepl("^KEN", allData$country), c("country")] <- c("KEN")
allData[grepl("^ERI", allData$country), c("country")] <- c("ERI")
allData <- dplyr::filter(allData, age >= 5)

allData <- dplyr::filter(allData, elapsed < 2.75 * 3600 * 1000)
allData <- dplyr::filter(allData, start > 30090000)
