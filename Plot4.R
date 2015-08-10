## Notes: - this script should be run in the same working directory as where the data
##          file is located
##        - Make sure you select the whole script before running it
##        - My OS default dates are in french, therefore the weekdays appear in French
##          "jeudi vendredi samedi" = "Thursday Friday Saturday"

## 1. Reading the data

data<-read.table("household_power_consumption.txt", stringsAsFactors=FALSE,
                 header=TRUE, na.strings="?", sep=";",nrows=70000)

## 2. Creating a date column of "Date" R-class
data <- cbind(NewDate = paste(data$Date,data$Time), data)
data$NewDate <- strptime(data$NewDate, format = "%d/%m/%Y %H:%M:%S")

## 3. Deleting the obsolete columns
data$Date <- NULL
data$Time <- NULL

## 4. Selecting the relevant period
period <- ("2007-02-01 00:00:00" <= data$NewDate) &
    (data$NewDate< "2007-02-03 00:00:00")
data <- data[period,]

## 5. Plotting and saving Plot1
x  <- data$NewDate
y1 <- data$Sub_metering_1
y2 <- data$Sub_metering_2
y3 <- data$Sub_metering_3

png("Plot4.png")
par(mfrow=c(2,2))

## 5.1 Subplot 1
plot(data$NewDate, data$Global_active_power,
     xlab = "", ylab="Global Active Power (kilowatts)", ylim=c(0,8), typ ="l")

## 5.2 Subplot 2
plot(data$NewDate, data$Voltage,
     xlab = "datetime", ylab="Voltage", typ ="l")

## 5.3 Subplot 3
plot(x, y1, xlab = "", ylab="Energy sub metering", col = "black", ylim=c(0,40), type="l")
par(new=TRUE)
plot(x, y2, xlab = "", ylab="", col = "red", ylim=c(0,40), type="l")
par(new=TRUE)
plot(x, y3, xlab = "", ylab="", col = "blue", ylim=c(0,40), type="l")
leg <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
legend("topright", leg, pch="_", col=c("black", "red", "blue"))

## 5.4 Sibplot 4
par(new=FALSE)
plot(data$NewDate, data$Global_reactive_power,
     xlab = "datetime", ylab="Global_reactive_power", typ ="l")

dev.off()