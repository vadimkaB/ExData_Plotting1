dataT <- read.table('household_power_consumption.txt', header = T,sep=';')
dataT$Date <- strptime(dataT$Date, format = "%d/%m/%Y")
dataT <- subset(dataT, (Date >= "2007-02-01" & Date <= "2007-02-02"))
dataT$Global_active_power <- as.numeric(levels(dataT$Global_active_power)[dataT$Global_active_power])
dataT <- within(dataT, { timestamp=format(as.POSIXct(paste(Date, Time)), "%Y-%m-%d %H:%M:%S") })
dataT$timestamp <- strptime(dataT$timestamp,"%Y-%m-%d %H:%M:%S")

dataT$Sub_metering_1 <- as.numeric(levels(dataT$Sub_metering_1)[dataT$Sub_metering_1])
dataT$Sub_metering_2 <- as.numeric(levels(dataT$Sub_metering_2)[dataT$Sub_metering_2])
dataT$Sub_metering_3 <- as.numeric(levels(dataT$Sub_metering_3)[dataT$Sub_metering_3])

b <- range(c(dataT$Sub_metering_1, dataT$Sub_metering_2, dataT$Sub_metering_3))

plot(dataT$timestamp, dataT$Sub_metering_1, type = 'l', ylim = b, ylab = "Energy Sub Metering", xlab = "")
lines(dataT$timestamp,dataT$Sub_metering_2, type = 'l', col = 'red')
lines(dataT$timestamp,dataT$Sub_metering_3, type = 'l', col = 'blue')

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1))
