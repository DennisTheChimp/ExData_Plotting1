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

# I use plot() with the argument type = "n" to create a blank time series graph.
# The x-axis uses variable Time and the y-axis uses variable Sub_metering_2 (the highest) 
# The values of the labels on the x-axis correspond to abbreviations of local date settings
with(powerdata, plot(Time, Sub_metering_1,type = "n", xlab = "", ylab = "Energy sub metering"))
# I plot the values of Sub_metering_1, 2 and 3 using points() with the argumant col for color
with(powerdata, points(Time, Sub_metering_1, type = "l"))
with(powerdata, points(Time, Sub_metering_2, type = "l", col = "red"))
with(powerdata, points(Time, Sub_metering_3, type = "l", col = "blue"))
# I printed the label in the top left corner because it would obscure the data in the top right corner 
legend("topright", pch = "_", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Copy the output to png file and close the device
dev.copy(png, file = "plot3.png")
dev.off()