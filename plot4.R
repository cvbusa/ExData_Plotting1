# setwd("C:/Users/Charles/Documents/RProgramming/ExData_Plotting1")

# if absent, create "data" subdirectory
subDirData <-file.path(getwd(),"data")
if(!file.exists(subDirData)) {dir.create(path = subDirData, showWarnings = FALSE)}
#subDirPng <-file.path(getwd(),"png")
#if(!file.exists(subDirPng)) {dir.create(path = subDirPng, showWarnings = FALSE)}

# if absent, download url file
strURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
strFile <- file.path(subDirData,"power.zip")
if(!file.exists(strFile)) {download.file(url = strURL, destfile = strFile, mode = "wb")}

# get list of zipped files
files <-unzip(zipfile = strFile, list = T)
# unzip all files into data subdirectory
unzip(zipfile = strFile, exdir = subDirData)
# get path and name of 1st unzipped file
strFiles1st <-file.path(subDirData,files[1])

# read 1st unzipped file into data frame
dfPower <- read.table(file = strFiles1st, header = T, sep = ";", stringsAsFactors = F)
head(dfPower)
dim(dfPower)

# create DateTime variable from Date variable and Time variable
dfPower$DateTime <-strptime(x = paste(dfPower$Date,dfPower$Time), format = "%d/%m/%Y %H:%M:%S")
dim(dfPower)
str(dfPower)

# subset dfPower to plot the 1st and 2nd day of Feb 2007
dfPowerPlot <-dfPower[grep(pattern = "^[12]/2/2007", x = dfPower$Date, value = F),]
dim(dfPowerPlot)
head(dfPowerPlot)
str(dfPowerPlot)

# convert to numeric from character for histogram plot
dfPowerPlot$Global_active_power <-as.numeric(dfPowerPlot$Global_active_power)
str(dfPowerPlot)

# plot 4 - multi-plot : active power - voltage - sub metering - reactive power
createPlot <- function() {
    mfrow.default <-par("mfrow")
    par(mfrow=c(2,2))
    # plot 2 - active power plot
    plot(x = dfPowerPlot$DateTime, y = dfPowerPlot$Global_active_power, xlab = "", ylab = "Global Active Power", type = "n")
    lines(x = dfPowerPlot$DateTime, y = dfPowerPlot$Global_active_power, type = "l")
    # plot 3B - voltage plot
    plot(x = dfPowerPlot$DateTime, y = dfPowerPlot$Voltage, xlab = "datetime", ylab = "Voltage", type = "n")
    lines(x = dfPowerPlot$DateTime, y = dfPowerPlot$Voltage, type = "l")
    # plot 3 - sub metering plot
    plot(x = dfPowerPlot$DateTime, y = dfPowerPlot$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")
    lines(x = dfPowerPlot$DateTime, y = dfPowerPlot$Sub_metering_1, type = "l", col = "Black")
    lines(x = dfPowerPlot$DateTime, y = dfPowerPlot$Sub_metering_2, type = "l", col = "Red")
    lines(x = dfPowerPlot$DateTime, y = dfPowerPlot$Sub_metering_3, type = "l", col = "Blue")
    legend.txt <-c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
    legend.color <-c("black","red","blue")
    legend.type <-c(1,1,1)
    legend.char <-c(NA,NA,NA)
    legend(x = "topright", legend = legend.txt, col = legend.color, lwd = 1, 
           lty = legend.type, pch = legend.char, bty = "n", cex = .8)
    # plot 3C - reative power plot
    plot(x = dfPowerPlot$DateTime, y = dfPowerPlot$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "n")
    lines(x = dfPowerPlot$DateTime, y = dfPowerPlot$Global_reactive_power, type = "l")
}

# send plot to screen
createPlot()

# save plot to png
strPathPng <-file.path(getwd(),"plot4.png")
png(strPathPng, width=480, height=480)
createPlot()
dev.off()

