library(datasets)
png("plot1.png")
# Read data for Feb 1 and 2 in 2007
powerData <- read.table("household_power_consumption.txt", sep = ";", 
                        na.strings = "?", 
                        skip=grep("31/1/2007;23:59:00;0.326;0.126;242.800;1.400;0.000;0.000;0.000", 
                                  readLines("household_power_consumption.txt")),nrows=2880)

colnames(powerData) <- c("Date", "Time", "Global_active_power", 
                         "Global_reactive_power", "Voltage", 
                         "Global_intensity", "Sub_metering_1", 
                         "Sub_metering_2", "Sub_metering_3")
# Set column to date
powerData[,1] <- as.Date(powerData[,1], format = "%d/%m/%Y")

# Plot histogram
hist(powerData$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

dev.off()