library(dplyr)
library(data.table)

setwd("C:/Users/mremaley/Desktop/Coursera")

# Read in the text file & format as a data table
# Ensure all relevant columns are numeric to avoid graphical errors
# Change Dates to Date type & filter for only 2007-02-01 to 2007-02-02
powerData <- data.table::fread("household_power_consumption.txt", na.strings = "?") %>%
        mutate(Date = as.Date(Date, "%d/%m/%Y")) %>%
        mutate(Global_active_power=as.numeric(Global_active_power)) %>%
        filter(Date >= "2007-02-01" & Date <= "2007-02-02")

png("plot1.png", width=480, height=480)

# Construct histogram
hist(powerData$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", 
     col="Red")

dev.off()

