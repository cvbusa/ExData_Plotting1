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

# create plot
createPlot <-function() {
    par(mfrow=c(1,1))
    # plot 1 - active power histogram
    hist(x = dfPowerPlot$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "Red")
}

# send plot to screen
createPlot()

# save plot to png
#strPathPng <-file.path(subDirPng,"plot1.png")
strPathPng <-file.path(getwd(),"plot1.png")
png(strPathPng, width=480, height=480)
createPlot()
dev.off()

