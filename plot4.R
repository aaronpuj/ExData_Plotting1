rawdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";") ## read table
DateTime <- strptime(paste(rawdata$Date, rawdata$Time), "%d/%m/%Y %H:%M:%S") ## create time stamp 
data <- cbind(DateTime, rawdata) ## add time stamp to data

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
begin <- as.Date("2007-02-01") ## starting time period
end <- as.Date("2007-02-02") ## ending time period
subdata <- subset(data, Date >= begin & Date <= end) ## subset data

subdata$Global_active_power <- as.numeric(as.character(subdata$Global_active_power)) ## change column from factor to number
subdata$Global_reactive_power <- as.numeric(as.character(subdata$Global_reactive_power))
subdata$Voltage <- as.numeric(as.character(subdata$Voltage)) 
subdata$Sub_metering_1 <- as.numeric(as.character(subdata$Sub_metering_1)) 
subdata$Sub_metering_2 <- as.numeric(as.character(subdata$Sub_metering_2))

png(file = "Plot 4.png", width = 480, height = 480)
par(mfrow = c(2, 2)) ## change device to show 4 plots
plot(subdata$DateTime, subdata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)") ## first
plot(subdata$DateTime, subdata$Voltage, type = "l", xlab = "datetime", ylab = "Voltage") ##second
plot(subdata$DateTime, subdata$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering") ## third
lines(subdata$DateTime, subdata$Sub_metering_2, type = "l", col = "red") ## add lines to third
lines(subdata$DateTime, subdata$Sub_metering_3, type = "l", col = "blue") ## add lines to third
legend( x="topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lwd=1) ## add legend
plot(subdata$DateTime, subdata$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power") ## fourth
dev.off() ## exit png device