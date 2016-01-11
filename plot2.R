## Loading the Data

# First, read the textfile, assign the first two columns as character variables and the others as numeric
# Also, assign all input for the character "?" as a NA value
powerdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", 
                        colClasses = c(rep("character",2), rep("numeric",7)) )
# Make a subset of the data by only using 1/2/2007 and 2/2/2007 as valid input for the Date variable
powerdata <- subset(powerdata, powerdata$Date == "1/2/2007" | powerdata$Date == "2/2/2007")
# Convert the Time variable to POSIXlt using the strptime() function
powerdata$Time <- strptime(paste(powerdata$Date, powerdata$Time), format = "%d/%m/%Y %H:%M:%S")
# Convert the Date variable to Date using the as.Date() function
powerdata$Date <- as.Date(powerdata$Time)

## Creating the plot

# I use plot() with the argument type = "l" to create a time series graph.
# The x-axis uses variable Time and the y-axis uses variable Global_active_power
# The values of the labels on the x-axis correspond to abbreviations of local date settings
with(powerdata, plot(Time, Global_active_power,type = "l", xlab = "Time", ylab = "Global Active Power (kilowatts)"))
# Copy the output to png file and close the device
dev.copy(png, file = "plot2.png")
dev.off()
