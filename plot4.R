## Loading the Data

# First, read the textfile, assign the first two columns as character variables and the others as numeric
# Also, assign all input for the character "?" as a NA value
powerdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", 
                        colClasses = c(rep("character",2), rep("numeric",7)) )
# Make a subset of the data by only using 1/7/2007 and 2/7/2007 as valid input for the Date variable
powerdata <- subset(powerdata, powerdata$Date == "1/7/2007" | powerdata$Date == "2/7/2007")
# Convert the Time variable to POSIXlt using the strptime() function
powerdata$Time <- strptime(paste(powerdata$Date, powerdata$Time), format = "%d/%m/%Y %H:%M:%S")
# Convert the Date variable to Date using the as.Date() function
powerdata$Date <- as.Date(powerdata$Time)

## Creating the plot

# Use the par() function with the argument nfrow = c(2,2) to create a canvas for 2 x 2 plots
par(mfrow = c(2,2))
# The first plot is the same as plot #2, the second plot is a time series of Time vs Voltage
# The third is the same as plot #3 and the last is a time series of Time vs Global_reactive_power
with(powerdata, {
  plot(Time, Global_active_power,type = "l", xlab = "", ylab = "Global Active Power")
  plot(Time, Voltage, type = "l")
  plot(Time, Sub_metering_2,type = "n", xlab = "", ylab = "Energy sub metering")
  points(Time, Sub_metering_1, type = "l")
  points(Time, Sub_metering_2, type = "l", col = "red")
  points(Time, Sub_metering_3, type = "l", col = "blue")
  legend("topleft", pch = "_", col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Time, Global_reactive_power, type = "l")})

# Copy the output to png file and close the device
dev.copy(png, file = "plot4.png")
dev.off()