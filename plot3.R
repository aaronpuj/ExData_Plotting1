rawdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";") ## read table
DateTime <- strptime(paste(rawdata$Date, rawdata$Time), "%d/%m/%Y %H:%M:%S") ## create time stamp 
data <- cbind(DateTime, rawdata) ## add time stamp to data

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
begin <- as.Date("2007-02-01") ## starting time period
end <- as.Date("2007-02-02") ## ending time period
subdata <- subset(data, Date >= begin & Date <= end) ## subset data

subdata$Sub_metering_1 <- as.numeric(as.character(subdata$Sub_metering_1)) ## change column from factor to number
subdata$Sub_metering_2 <- as.numeric(as.character(subdata$Sub_metering_2)) ## change column from factor to number

png(file = "Plot 3.png", width = 480, height = 480)
plot(subdata$DateTime, subdata$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering") ## plot
lines(subdata$DateTime, subdata$Sub_metering_2, type = "l", col = "red") ## add lines to third
lines(subdata$DateTime, subdata$Sub_metering_3, type = "l", col = "blue") ## add lines
legend( x="topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lwd=1) ## add legend
dev.off() ## exit png device