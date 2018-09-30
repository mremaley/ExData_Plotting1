library(dplyr)
library(data.table)

setwd("C:/Users/mremaley/Desktop/Coursera")

# Read in the text file & format as a data table
# Ensure all relevant columns are numeric to avoid graphical errors
# Create a dateTime column so graphs can use time of day
# Change Dates to Date type & filter for only 2007-02-01 to 2007-02-02
powerData <- data.table::fread("household_power_consumption.txt", na.strings = "?") %>%
        mutate(Date = as.Date(Date, "%d/%m/%Y")) %>%
        mutate(dateTime = as.POSIXct(paste(Date, Time), "%d/%m/%Y %H:%M:%S")) %>%
        mutate(Global_active_power=as.numeric(Global_active_power)) %>%
        filter(Date >= "2007-02-01" & Date <= "2007-02-02")

png("plot3.png", width=480, height=480)

# Construct multiple line graphs
plot(powerData$dateTime, powerData$Sub_metering_1,
     type = "l", xlab = "", ylab = "Energy sub metering")
lines(powerData$dateTime, powerData$Sub_metering_2, col = "red")
lines(powerData$dateTime, powerData$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1), lwd = c(1,1))

dev.off()
