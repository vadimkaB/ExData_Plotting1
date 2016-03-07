dataT <- read.table('household_power_consumption.txt', header = T,sep=';')
dataT$Date <- strptime(dataT$Date, format = "%d/%m/%Y")
dataT <- subset(dataT, (Date >= "2007-02-01" & Date <= "2007-02-02"))

dataT <- within(dataT, { timestamp=format(as.POSIXct(paste(Date, Time)), "%Y-%m-%d %H:%M:%S") })
dataT$timestamp <- strptime(dataT$timestamp,"%Y-%m-%d %H:%M:%S")

dataT$Global_active_power <- as.numeric(levels(dataT$Global_active_power)[dataT$Global_active_power])
dataT$Sub_metering_1 <- as.numeric(levels(dataT$Sub_metering_1)[dataT$Sub_metering_1])
dataT$Sub_metering_2 <- as.numeric(levels(dataT$Sub_metering_2)[dataT$Sub_metering_2])
dataT$Sub_metering_3 <- as.numeric(levels(dataT$Sub_metering_3)[dataT$Sub_metering_3])
dataT$Voltage <- as.numeric(levels(dataT$Voltage)[dataT$Voltage])
dataT$Global_reactive_power <- as.numeric(levels(dataT$Global_reactive_power)[dataT$Global_reactive_power])

b <- range(c(dataT$Sub_metering_1, dataT$Sub_metering_2, dataT$Sub_metering_3))

par(mfcol = c(2,2))

#First plot
plot(dataT$timestamp, dataT$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

#Second plot
plot(dataT$timestamp, dataT$Sub_metering_1, type = 'l', ylim = b, ylab = "Energy Sub Metering", xlab = "")
lines(dataT$timestamp,dataT$Sub_metering_2, type = 'l', col = 'red')
lines(dataT$timestamp,dataT$Sub_metering_3, type = 'l', col = 'blue')

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1), cex = .5)

#Third plot
plot(dataT$timestamp, dataT$Voltage, type = "l", xlab = "", ylab = "Voltage")

#Fourth plot
plot(dataT$timestamp, dataT$Global_reactive_power, type = "l", xlab ="", ylab = "Global_reactive_power")