# Note: This code assumes that the zip file has been downloaded and unzipped,
# and that household_power_consumption.txt has been placed in the working
# directory.

# read in the data . We skip 66637 rows and read 2880 to load dates needed
# and avoid loading all data
cnames <- colnames(read.table("household_power_consumption.txt",
                             sep=";", nrow = 1,header = TRUE))
cclasses <- c(rep("character", 2), rep("numeric", 7))

power <- read.table("household_power_consumption.txt",
                  sep = ";", skip = 66637, nrows = 2880, 
                  col.names = cnames, na.strings = "?", 
                  colClasses = cclasses)

# create a new column "DateTime"
datetime <- paste(power$Date, power$Time)
power$DateTime <- strptime(datetime, "%d/%m/%Y %H:%M:%S")

# create a PNG file
png(file="plot2.png",width=480,height=480)

# Draw a plot
plot(power$DateTime, power$Global_active_power, xlab =  "",
     ylab="Global Active Power (kilowatts)", type="l")

# Close the PNG file
dev.off()
