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
# plot 1 - active power histogram
hist(x = dfPowerPlot$V3, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "Red")

png("plot1.png", width=480, height=480)
# plot 1 - active power histogram
hist(x = dfPowerPlot$V3, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "Red")
dev.off()

