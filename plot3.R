## Downloading the data ====

#url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#download.file(url = url, destfile =paste(getwd(), "/data.zip", sep="")) # download the archive
#unzip("data.zip") # extract a folder from the archive
library(tidyr)
## Reading and cleaning the data====
data <- read.csv("household_power_consumption.txt", sep = ";",na.strings = "?")

data <- subset(data, Date=="1/2/2007" | Date=="2/2/2007")

data <- unite(data, col="date_time", sep=" ", Date, Time)

data$date_time <- strptime(data$date_time, format="%d/%m/%Y %T")
data$date_time <- as.POSIXct(data$date_time)

data <- gather(data, key="metering", value="Energy sub metering", 
       Sub_metering_1,Sub_metering_2,Sub_metering_3, factor_key = TRUE)

##Plotting

png(filename = "plot3.png",width = 480, height = 480, units = "px")
plot( data$date_time , data$`Energy sub metering`, type="n", ylab="Energy sub metering",xlab="")
lines(data$date_time[data$metering=="Sub_metering_1"],
      data$`Energy sub metering`[data$metering=="Sub_metering_1"],
      col="black")
lines(data$date_time[data$metering=="Sub_metering_2"],
      data$`Energy sub metering`[data$metering=="Sub_metering_2"],
      col="red")
lines(data$date_time[data$metering=="Sub_metering_3"],
      data$`Energy sub metering`[data$metering=="Sub_metering_3"],
      col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3" ),lwd=2, col=c("black", "red", "blue"))
dev.off()








