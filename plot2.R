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

##Plotting
png(filename = "plot2.png",width = 480, height = 480, units = "px")
with(data, plot( date_time, Global_active_power, 
                 type="line", ylab="Global Active Power (kilowatts)",
                 xlab=""))
dev.off()
