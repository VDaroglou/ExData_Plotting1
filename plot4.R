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
png(file="plot4.png",width=480,height=480)

# Set to make two rows and two columns of plots
par(mfrow=c(2,2))

# Draw top left plot
plot(power$DateTime, power$Global_active_power, type="l", xlab="",
     ylab="Global active power")

# Draw top right plot
plot(power$DateTime, power$Voltage, type="l", xlab="datetime",
     ylab="Voltage")

# Draw bottom left plot
plot(power$DateTime, power$Sub_metering_1, type="l", xlab="",
     ylab="Energy sub metering")
lines(power$DateTime, power$Sub_metering_2, col="red")
lines(power$DateTime, power$Sub_metering_3, col="blue")
legend("topright", lty=1, col=c("black","red","blue"),
       bty="n", cex = 0.9,
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Draw bottom right plot
plot(power$DateTime, power$Global_reactive_power, type="l", xlab="datetime",
     ylab="Global_reactive_power")

# Close the PNG file
dev.off()
