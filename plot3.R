#wdir <-"C:/Users/Charles/Documents/RProgramming"
#setwd(wdir)
#

strURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
strFile <- "power.zip"
if(!file.exists(strFile)) {download.file(url = strURL, destfile = strFile, mode = "wb")}
unzip(zipfile = strFile, list = T)
unzip(zipfile = strFile)
files <-unzip(zipfile = strFile, list = T)

#
dfPowerNames <- read.table(file = as.character(files[1]), sep = ";", stringsAsFactors = F, nrows = 1)
head(dfPowerNames)

#
dfPower <- read.table(file = as.character(files[1]), sep = ";", stringsAsFactors = F, skip = 1)
head(dfPower)
dim(dfPower)
#
dfPower$V0 <-strptime(x = paste(dfPower$V1,dfPower$V2), format = "%d/%m/%Y %H:%M:%S")
dim(dfPower)
str(dfPower)

#
dfPowerPlot <-dfPower[grep(pattern = "^[12]/2/2007", x = dfPower$V1, value = F),]
dim(dfPowerPlot)
head(dfPowerPlot)
str(dfPowerPlot)
dfPowerPlot$V3 <-as.numeric(dfPowerPlot$V3)
str(dfPowerPlot)

par(mfrow=c(1,1))
# plot 3 - sub metering plot
plot(x = dfPowerPlot$V0, y = dfPowerPlot$V7, xlab = "", ylab = "Energy sub metering", type = "n")
lines(x = dfPowerPlot$V0, y = dfPowerPlot$V7, type = "l", col = "Black")
lines(x = dfPowerPlot$V0, y = dfPowerPlot$V8, type = "l", col = "Red")
lines(x = dfPowerPlot$V0, y = dfPowerPlot$V9, type = "l", col = "Blue")
legend.txt <-c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
legend.color <-c("black","red","blue")
legend.type <-c(1,1,1)
legend.char <-c(NA,NA,NA)
legend(x = "topright", legend = legend.txt, col = legend.color, lwd = 1, lty = legend.type, pch = legend.char )

png("plot3.png", width=480, height=480)
# plot 3 - sub metering plot
plot(x = dfPowerPlot$V0, y = dfPowerPlot$V7, xlab = "", ylab = "Energy sub metering", type = "n")
lines(x = dfPowerPlot$V0, y = dfPowerPlot$V7, type = "l", col = "Black")
lines(x = dfPowerPlot$V0, y = dfPowerPlot$V8, type = "l", col = "Red")
lines(x = dfPowerPlot$V0, y = dfPowerPlot$V9, type = "l", col = "Blue")
legend.txt <-c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
legend.color <-c("black","red","blue")
legend.type <-c(1,1,1)
legend.char <-c(NA,NA,NA)
legend(x = "topright", legend = legend.txt, col = legend.color, lwd = 1, lty = legend.type, pch = legend.char )
dev.off()
