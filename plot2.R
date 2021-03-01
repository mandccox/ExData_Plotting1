### script creates a line plot of Global Active Power on Jan 1st & 2nd, 2007
### Steps (1) reads in data, (2) add datetime column with POSIXct format 
### (3) removes all data except rows with 2 target dates 
### (4) converts global active power variables to numeric,
### (6) plots to .png file

library(dplyr)
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                   colClasses = "character")
data <- mutate(data, datetime = as.POSIXct(paste(Date, Time), 
                                           format = "%d/%m/%Y %H:%M:%S"))

data1 <- filter(data, datetime >= "2007-02-01" & datetime < "2007-02-03")
data1$Global_active_power <- as.numeric(data1$Global_active_power)

png(file = "~/R/Coursera Data Science Projects/ExData_Plotting1/plot2.png", 
    width=480, height=480)

with(data1, plot(datetime, Global_active_power, type="l", xlab="", 
                 ylab="Global Active Power (kilowatts)"))

dev.off()
