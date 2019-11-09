# Download data if necessary
file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file_zip <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"
file_unzip <- "household_power_consumption.txt"

if (!file.exists(file_unzip)) { 
  if (!file.exists(file_zip)) { download.file(file_url,destfile=file_zip,mode="wb") }
  unzip(file_zip)
  file.remove(file_zip)
  }

# Load and clean data
data <- read.csv(file_unzip,sep=";",dec=".",na.strings="?")
data$Date <- with(data,as.POSIXct(Date,format="%d/%m/%Y"))
data <- subset(data,Date>="2007-02-01"&Date<="2007-02-02")
data$Time <- as.POSIXct(with(data,paste(Date,Time)),format="%Y-%m-%d %H:%M:%S")

# Make plot
png("plot1.png",width=480,height=480)
with(data,hist(Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power"))
dev.off()
