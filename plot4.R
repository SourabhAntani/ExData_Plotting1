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
dt[,date_collected_str := paste(as.Date(dt$Date, format = '%d/%m/%Y'), dt$Time)];

par(mfrow = c(2,2));
#plot 1
plot(as.POSIXlt(dt$date_collected_str), as.numeric(as.character(dt$Global_active_power)), type='l', xlab='', ylab = 'Global Active Power', );

#plot 2
plot(as.POSIXlt(dt$date_collected_str), as.numeric(as.character(dt$Voltage)), type='l', xlab='datetime', ylab = 'Voltage');

#plot 3
plot(as.POSIXlt(dt$date_collected_str), as.numeric(as.character(dt$Sub_metering_1)), type='l', xlab='', ylab = 'Energy sub metering', col='black');
lines(as.POSIXlt(dt$date_collected_str), as.numeric(as.character(dt$Sub_metering_2)), type='l', col='red');
lines(as.POSIXlt(dt$date_collected_str), as.numeric(as.character(dt$Sub_metering_3)), type='l', col='blue');
legend("topright", lty=c(1,1,1),col=c('black', 'Red', 'Blue'), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = 'n', cex=0.6, pt.cex = 2);

#plot 4
plot(as.POSIXlt(dt$date_collected_str), as.numeric(as.character(dt$Global_reactive_power)), type='l', xlab='datetime', ylab = 'Global_reactive_power');

dev.copy(png, file="plot4.png", width = 480, height=480, units="px");
dev.off();

