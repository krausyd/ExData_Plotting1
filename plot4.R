##Get the data 
file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dest_file <-"household_power_consumption.zip"
if (!file.exists(dest_file)){
  download.file(file_url, dest_file)
}
file_name <- "household_power_consumption.txt"
if (!file.exists(file_name)) {
  unzip(dest_file)
}

##Read entire dataset and convert dates for subsetting
entire_data <- read.table(file_name, header=TRUE, sep=";", na.strings = "?", stringsAsFactors=FALSE, dec=".")
entire_data$Date <- as.Date(entire_data$Date, format="%d/%m/%Y")

##Subset only the specific dates, and remove the big dataset
data <-subset(entire_data, Date>='2007-02-01' & Date <='2007-02-02')
rm(entire_data)

##Convert to Date/TIme
data$Datetime <- as.POSIXct(paste(as.Date(data$Date), data$Time))

##4 graphs
par(mfrow=c(2,2))
#First one: Global_active_power (same than script 2)
with(data,plot(Datetime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))
#Second one: Voltage
with(data,plot(Datetime, Voltage, type="l", ylab="Voltage", xlab="datetime"))
#Third one: sub meterings (same than script 3)
with(data,plot(Datetime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="", col="black"))
lines(data$Datetime, data$Sub_metering_2, type="l", col="red")
lines(data$Datetime, data$Sub_metering_3, type="l", col="blue")
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2)
#Fourth one: global_reactive_power
with(data,plot(Datetime, Global_reactive_power, type="l", xlab="datetime"))

##Save to png
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()