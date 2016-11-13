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

##Plot the kilowatts per date-time
with(data,plot(Datetime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)"))

##Save to png
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()