library(dplyr)
library(lubridate)

if(!file.exists("household_power_consumption.txt")) {
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
  unzip(temp, "household_power_consumption.txt", exdir = getwd())
  unlink(temp)
}

if (!("consumption" %in% ls())) {
  consumption <- read.csv("household_power_consumption.txt", sep = ";", na.strings = c("?")) %>%
    tbl_df() %>%
    filter(Date %in% c("1/2/2007", "2/2/2007")) %>%
    mutate(DateTime = dmy_hms(paste(Date, Time)))
}

png("plot1.png")

hist(consumption$Global_active_power,
     main = "Global Active Power",
     col = "red",
     xlab = "Global Active Power (kilowatts)")

dev.off()
