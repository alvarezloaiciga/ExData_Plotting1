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

png("plot4.png")

par(mfrow = c(2, 2))

with(consumption, plot(DateTime, Global_active_power, ylab = "Global Active Power", xlab = "", type = "l"))
with(consumption, plot(DateTime, Voltage, ylab = "Voltage", type = "l"))

with(consumption, plot(
  DateTime, Sub_metering_1, 
  type = "l",
  ylab = "Energy sub metering",
  xlab = ""
))

with(consumption, lines(DateTime, Sub_metering_2, col = "red"))
with(consumption, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(consumption, plot(DateTime, Global_reactive_power, type = "l"))

dev.off()