## Notes: - this script should be run in the same working directory as where the data
##          file is located
##        - Make sure you select the whole script before running it

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
png("Plot1.png")
hist(data$Global_active_power, main = "Global Active Power",
     xlab="Global Active Power (kilowatts)", col="red" , ylim=c(0,1300))
dev.off()