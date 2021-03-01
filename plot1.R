### script creates a histogram of Global Active Power on Jan 1st & 2nd, 2007
### Steps (1) reads in data, (2) converts Data to data format, 
### (3) removes all data except for rows with 2 target dates 
### (4) converts global active power variables to numeric
### (5) plots histogram, (6) copies histogram to file "plot1.png"

library(dplyr)
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                   colClasses = "character")
data$Date <- as.Date(data$Date,format="%d/%m/%Y")
data1 <- filter(data, Date == "2007-02-01" | Date == "2007-02-02")
data1$Global_active_power <- as.numeric(data1$Global_active_power)

png(file = "~/R/Coursera Data Science Projects/ExData_Plotting1/plot1.png", 
      width=480, height=480)

hist(data1$Global_active_power, xlab = "Global Active Power (kilowatts)",
                            main = "Global Active Power", col = "red")

dev.off()


