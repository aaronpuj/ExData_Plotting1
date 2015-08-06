rawdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";") ## read table
DateTime <- strptime(paste(rawdata$Date, rawdata$Time), "%d/%m/%Y %H:%M:%S") ## create time stamp 
data <- cbind(DateTime, rawdata) ## add time stamp to data

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
begin <- as.Date("2007-02-01") ## starting time period
end <- as.Date("2007-02-02") ## ending time period
subdata <- subset(data, Date >= begin & Date <= end) ## subset data

subdata$Global_active_power <- as.numeric(as.character(subdata$Global_active_power)) ## change column from factor to number
hist(subdata$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)") ## plot

dev.copy(png, file = "Plot 1.png", width = 480, height = 480) ## copy plot to png file
dev.off() ## exit png device