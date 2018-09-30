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

png("plot4.png", width=480, height=480)

par(mfrow = c(2,2))

# Construct plot 1
plot(x = powerData$dateTime,
     y = powerData$Global_active_power,
     xlab = "", 
     ylab = "Global Active Power", 
     type = "l")

# Construct plot 2
plot(x = powerData$dateTime,
     y = powerData$Voltage,
     xlab = "datetime", 
     ylab = "Voltage", 
     type = "l")

# Construct plot 3
plot(powerData$dateTime, powerData$Sub_metering_1,
     type = "l", xlab = "", ylab = "Energy sub metering")
lines(powerData$dateTime, powerData$Sub_metering_2, col = "red")
lines(powerData$dateTime, powerData$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1), bty = "n", cex = 0.5)

# Construct plot 4
plot(x = powerData$dateTime,
     y = powerData$Global_reactive_power,
     xlab = "datetime", 
     ylab = "Global_reactive_power", 
     type = "l")


dev.off()
