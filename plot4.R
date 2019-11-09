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

# Set plot parameters and create empty canvas
png("plot4.png",width=480,height=480)
par(mfrow=c(2,2))

# Add plot 1
with(data,{
  plot(Global_active_power~Time,ann=F,type="n")
  title(ylab="Global Active Power")
  lines(Time,Global_active_power)
})

# Add plot 2
with(data,{
  plot(Voltage~Time,ann=F,type="n")
  title(xlab="datetime",ylab="Voltage")
  lines(Time,Voltage)
})

# Add plot 3
with(data,{
  plot(Sub_metering_1~Time,ann=F,type="n")
  title(ylab="Energy sub metering")
  lines(Time,Sub_metering_1)
  lines(Time,Sub_metering_2,col="red")
  lines(Time,Sub_metering_3,col="blue")
  legend("topright",legend=names(data)[7:9],col=c("black","red","blue"),lty=1,bty="n")
})

# Add plot 4
with(data,{
  plot(Global_reactive_power~Time,ann=F,type="n")
  title(xlab="datetime",ylab="Global_reactive_power")
  lines(Time,Global_reactive_power)
})

# Close device
dev.off()
