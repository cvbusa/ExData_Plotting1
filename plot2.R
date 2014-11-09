#
subDirData <-file.path(getwd(),"data")
subDirFigure <-file.path(getwd(),"figure")
if(!file.exists(subDirData)) {dir.create(path = subDirData, showWarnings = FALSE)}
if(!file.exists(subDirFigure)) {dir.create(path = subDirFigure, showWarnings = FALSE)}

strURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
strFile <- file.path(subDirData,"power.zip")
if(!file.exists(strFile)) {download.file(url = strURL, destfile = strFile, mode = "wb")}
files <-unzip(zipfile = strFile, list = T)
unzip(zipfile = strFile, exdir = subDirData)
strFiles1st <-file.path(subDirData,files[1])

# read all of file from zip into data frame
dfPower <- read.table(file = strFiles1st, header = T, sep = ";", stringsAsFactors = F)

head(dfPower)
dim(dfPower)
#
dfPower$DateTime <-strptime(x = paste(dfPower$Date,dfPower$Time), format = "%d/%m/%Y %H:%M:%S")
dim(dfPower)
str(dfPower)

#
dfPowerPlot <-dfPower[grep(pattern = "^[12]/2/2007", x = dfPower$Date, value = F),]
dim(dfPowerPlot)
head(dfPowerPlot)
str(dfPowerPlot)
dfPowerPlot$Global_active_power <-as.numeric(dfPowerPlot$Global_active_power)
str(dfPowerPlot)

createPlot <-function() {
    par(mfrow=c(1,1))
    # plot 2 - active power plot
    plot(x = dfPowerPlot$DateTime, y = dfPowerPlot$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "n")
    lines(x = dfPowerPlot$DateTime, y = dfPowerPlot$Global_active_power, type = "l")
}

# send plot to screen
createPlot()

# save plot to png
strPathPng <-file.path(subDirFigure,"plot2.png")
png(strPathPng, width=480, height=480)
createPlot()
dev.off()

