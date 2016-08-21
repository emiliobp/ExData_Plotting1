##import used libraries
library(data.table)

##Create directory if it doesnt exists
if(!file.exists("./W1PA")){
    dir.create("./W1PA")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## add if working on Mac OS (,method="curl")
download.file(fileUrl,destfile="./W1PA/EPC.zip") 

##unzip the file downloaded
unzip(zipfile="./W1PA/EPC.zip",exdir="./W1PA")

data <- read.table("W1PA/household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?",
                    colClasses = c("character", "character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

data$Time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, format= "%d/%m/%Y")

DT <- data[data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02"), ]

##default
##par(mfrow=c(1,1))
png(filename="./W1PA/plot1.png", width=480, height=480)
with(DT, hist(Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red"))

dev.off()

