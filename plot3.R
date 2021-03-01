### script creates a line plot of Sub_metering_1 to _3 on Jan 1st & 2nd, 2007
### Steps (1) reads in data, (2) add datetime column with POSIXct format 
### (3) removes all data except rows with 2 target dates 
### (4) converts Sub_metering_1 to _3 variables to numeric,
### (5) plots to .png file

library(dplyr)
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                   colClasses = "character")
data <- mutate(data, datetime = as.POSIXct(paste(Date, Time), 
                                           format = "%d/%m/%Y %H:%M:%S"))

data1 <- filter(data, datetime >= "2007-02-01" & datetime < "2007-02-03")

data1$Sub_metering_1 <- as.numeric(data1$Sub_metering_1)
data1$Sub_metering_2 <- as.numeric(data1$Sub_metering_2)
data1$Sub_metering_3 <- as.numeric(data1$Sub_metering_3)

png(file = "~/R/Coursera Data Science Projects/ExData_Plotting1/plot3.png", 
    width=480, height=480)

with(data1, plot(datetime, Sub_metering_1, type = "n", xlab = "", 
                    ylab = "Energy sub metering"))
with(data1, lines(datetime, Sub_metering_1, type = "l", col = "black"))
with(data1, lines(datetime, Sub_metering_2, type = "l", col = "red"))
with(data1, lines(datetime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                    col= c("black", "red", "blue"), lty =1)

dev.off()