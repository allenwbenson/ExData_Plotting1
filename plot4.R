## Download unzip the zip file
fileUrl <- paste0("https://d396qusza40orc.cloudfront.net/",
        "exdata%2Fdata%2Fhousehold_power_consumption.zip")
download.file(fileUrl,destfile = "power.zip")
unzip("power.zip")

## Read in the data
power <- read.table("household_power_consumption.txt",
        header = TRUE,
        sep = ";",
        na.strings = c("?"))

## Subset out on the data for the two days
power_data <- power[(power$Date == "1/2/2007" | 
        power$Date == "2/2/2007"),]

## Remove the original large data object to save memory
rm(power)

## Add a column "DataTime" that is the date and time together
power_data$DateTime <- strptime(paste(
        power_data$Date, power_data$Time, 
        sep = " "), format = "%d/%m/%Y %H:%M:%S")

## Open the device
png("plot4.png", width = 480, height = 480)

## Set the rows and columns
par(mfrow = c(2, 2))

## First plot
plot(power_data$DateTime, power_data$Global_active_power,
     xlab = "", 
     ylab = "Global Active Power",
     type = "l")

## Second plot
plot(power_data$DateTime, power_data$Voltage, 
     xlab = "datetime", 
     ylab = "Voltage",
     type = "l")

## Third plot
plot(power_data$DateTime, power_data$Sub_metering_1, 
     xlab = "", 
     ylab = "Energy sub metering",
     type = "l")

lines(power_data$DateTime, power_data$Sub_metering_2, col = "red")
lines(power_data$DateTime, power_data$Sub_metering_3, col = "blue")
legend("topright", bty = "n", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Fourth plot
plot(power_data$DateTime, power_data$Global_reactive_power,
     xlab = "datetime", 
     ylab = "Global_reactive_power",
     type = "l")

## Close device
dev.off()
