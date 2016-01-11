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

# I use hist() to create the histogram, with the arguments col, main, xlab and ylab to get the right colors and labels,
# I use the argument breaks to get the right amount of bars, and the arguments xlim and ylim to get the right limits
hist(powerdata$Global_active_power, breaks = 20, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
# Copy the output to png file and close the device
dev.copy(png, file = "plot1.png")
dev.off()