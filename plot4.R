### script creates 4 plots based on data from Jan 1st & 2nd, 2007
### Steps (1) reads in data, (2) add datetime column with POSIXct format 
### (3) removes all data except rows with 2 target dates 
### (4) convert variables to numeric,
### (5) plots to .png file

library(dplyr)
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                   colClasses = "character")
data <- mutate(data, datetime = as.POSIXct(paste(Date, Time), 
                                           format = "%d/%m/%Y %H:%M:%S"))

data1 <- filter(data, datetime >= "2007-02-01" & datetime < "2007-02-03")

data1$Global_active_power <- as.numeric(data1$Global_active_power)
data1$Global_reactive_power <- as.numeric(data1$Global_reactive_power)
data1$Voltage <- as.numeric(data1$Voltage)
data1$Sub_metering_1 <- as.numeric(data1$Sub_metering_1)
data1$Sub_metering_2 <- as.numeric(data1$Sub_metering_2)
data1$Sub_metering_3 <- as.numeric(data1$Sub_metering_3)

png(file = "~/R/Coursera Data Science Projects/ExData_Plotting1/plot4.png", 
    width=480, height=480)

par(mfcol = c(2,2))

### plot 1
with(data1, plot(datetime, Global_active_power, type="l", xlab="", 
                 ylab="Global Active Power (kilowatts)"))   

### plot 2
with(data1, plot(datetime, Sub_metering_1, type = "n", xlab = "", 
                 ylab = "Energy sub metering"))
with(data1, lines(datetime, Sub_metering_1, type = "l", col = "black"))
with(data1, lines(datetime, Sub_metering_2, type = "l", col = "red"))
with(data1, lines(datetime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col= c("black", "red", "blue"), lty =1)

### plot 3
with(data1, plot(datetime, Voltage, type="l", xlab="datetime", 
                 ylab="Voltage"))

## plot 4
with(data1, plot(datetime, Global_reactive_power, type="l", xlab="datetime", 
                 ylab="Global_reactive_power"))

dev.off()