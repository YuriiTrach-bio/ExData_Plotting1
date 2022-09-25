## Downloading the data ====

#url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#download.file(url = url, destfile =paste(getwd(), "/data.zip", sep="")) # download the archive
#unzip("data.zip") # extract a folder from the archive

## Reading and cleaning the data====
data <- read.csv("household_power_consumption.txt", sep = ";")

data$Date <- as.Date(data$Date, tryFormats="%d/%m/%Y")
data$Global_active_power <- as.numeric(data$Global_active_power)

data <- subset(data, Date=="2007-02-01" | Date=="2007-02-02")

##Plotting
png(filename = "plot1.png",width = 480, height = 480, units = "px")
with(data, hist(Global_active_power, 
                col="red", 
                main="Global Active Power", 
                xlab="Global Active Power (kilowatts)"))
dev.off()