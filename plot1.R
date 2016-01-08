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

## Open the device
png("plot1.png", width = 480, height = 480)

## Create the histogram
hist(power_data$Global_active_power,
        col = "red",
        xlab = "Global Active Power (kilowatts)",
        main = "Global Active Power")

## Close the device
dev.off()
