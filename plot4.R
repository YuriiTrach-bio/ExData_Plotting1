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

data2 <- gather(data, key="metering", value="Energy sub metering", 
               Sub_metering_1,Sub_metering_2,Sub_metering_3, factor_key = TRUE)

##Plotting
png(filename = "plot4.png",width = 480, height = 480, units = "px")
        
        par(mfcol=c(2,2), mar=c(4,5,1,1))
        #plot 1
        with(data, plot( date_time, Global_active_power, 
                         type="l", ylab="Global Active Power",
                         xlab=""))
        #plot2
        plot( data2$date_time , data2$`Energy sub metering`, type="n", ylab="Energy sub metering",xlab="")
        lines(data2$date_time[data2$metering=="Sub_metering_1"],
              data2$`Energy sub metering`[data2$metering=="Sub_metering_1"],
              col="black")
        lines(data2$date_time[data2$metering=="Sub_metering_2"],
              data2$`Energy sub metering`[data2$metering=="Sub_metering_2"],
              col="red")
        lines(data2$date_time[data2$metering=="Sub_metering_3"],
              data2$`Energy sub metering`[data2$metering=="Sub_metering_3"],
              col="blue")
        legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3" ),
               lwd=2, col=c("black", "red", "blue"),
               border = "white")
        #plot3
        with(data, plot( date_time, Voltage, 
                         type="line", ylab="Voltage",
                         xlab="datetime"))
        #plot4
        with(data, plot( date_time, Global_reactive_power, 
                         type="line", ylab="Global_reactive_power",
                         xlab="datetime"))
dev.off()


