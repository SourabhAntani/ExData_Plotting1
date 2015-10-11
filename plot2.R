download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "data.zip");
unzip(zipfile = "data.zip");
# We estimate size requirement with 50,000 rows to make the object overhead less significant factor so we can get a better estimate
# Running the same estimate with 100 rows gives about 3 times the estimate since the overhead is more significant with less data.
sampledata = read.table(file="household_power_consumption.txt", header = T, sep = ";", nrows = 50000);
estimatedMemReqInMB = (as.numeric(object.size(sampledata))*2075259/50000)/(2^20);
rm(sampledata);
# Estimated storage space reqd = 90 MB
data=read.table("household_power_consumption.txt", header = T, sep = ";");
actualMemReqInMB = as.numeric(object.size(data))/(2^20);
# Actual storate space reqd = 79.56 MB
library(data.table);
dt = data.table(data[as.Date(data$Date, format = '%d/%m/%Y')>'2007-01-31' & as.Date(data$Date, format = '%d/%m/%Y') < '2007-02-03',]);
dt[,date_collected_str := paste(as.Date(dt$Date, format = '%d/%m/%Y'), dt$Time
plot(as.POSIXlt(dt$date_collected_str), as.numeric(as.character(dt$Global_active_power)), type='l', xlab='', ylab = 'Global Active Power (kilowatts)', );
dev.copy(png, file="plot2.png", width = 480, height=480, units="px");
dev.off()
