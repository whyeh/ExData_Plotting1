library(datasets)
png("plot4.png")
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
powerData$Time <- strptime(powerData[,10], format="%d/%m/%Y %T")

# Set column to date
powerData[,1] <- as.Date(powerData[,1], format = "%d/%m/%Y")

# Set 4 plots (2X2) figure
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

with(powerData, {
     # plot 1     
     plot(Global_active_power, type = "l", lty = 1, xaxt = "n", xlab = "", 
          ylab = "Global Active Power")
     axis(1, c(0, 1440, 2880), c("Thu", "Fri", "Sat"))
     
     # plot 2     
     plot(Voltage, type = "l", lty = 1, xaxt = "n", xlab = "datetime", 
          ylab = "Voltage")
     axis(1, c(0, 1440, 2880), c("Thu", "Fri", "Sat"))

     # plot 3
     plot(Sub_metering_1, type = "l", lty = 1, xaxt = "n", xlab = "", 
          ylab = "Energy sub metering")
     lines(Sub_metering_2, type = "l", lty = 1, col = "red", xaxt = "n")
     lines(Sub_metering_3, type = "l", lty = 1, col = "blue", xaxt = "n")
     axis(1, c(0, 1440, 2880), c("Thu", "Fri", "Sat"))
     legend("topright", bty = "n", lty = 1, 
            col = c("black", "red", "blue"), 
            legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     
     # plot 4     
     plot(Global_reactive_power, type = "l", lty = 1, xaxt = "n", 
          xlab = "datetime", ylab = "Global_reactive_power")
     axis(1, c(0, 1440, 2880), c("Thu", "Fri", "Sat"))
}
)

dev.off()