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
png("plot2.png", width = 480, height = 480)

## Create the plot
plot(power_data$DateTime, power_data$Global_active_power, 
        xlab = "", 
        ylab = "Global Active Power (kilowatts)",        
        type = "l")

## Close the device
dev.off()
