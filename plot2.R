library(datasets)
png("plot2.png")
# Read data for Feb 1 and 2 in 2007
powerData <- read.table("household_power_consumption.txt", sep = ";", 
                        na.strings = "?", 
                        skip=grep("31/1/2007;23:59:00;0.326;0.126;242.800;1.400;0.000;0.000;0.000", 
                                  readLines("household_power_consumption.txt")),nrows=2880)

colnames(powerData) <- c("Date", "Time", "Global_active_power", 
                         "Global_reactive_power", "Voltage", 
                         "Global_intensity", "Sub_metering_1", 
                         "Sub_metering_2", "Sub_metering_3")

# create date and time column
Complete_Time <- paste(powerData[,1], powerData[,2])
powerData <- cbind(powerData, Complete_Time)

# Set column to date and time
powerData[,1] <- as.Date(powerData[,1], format = "%d/%m/%Y")

# Plot line graph
with(powerData,{plot(Global_active_power, type = "l", lty = 1, xaxt = "n", 
     xlab = "", ylab = "Global Active Power (kilowatts)")})
axis(1, c(0, 1440, 2880), c("Thu", "Fri", "Sat"))

dev.off()