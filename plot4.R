plot4 <- function(zipfile){
  
  ## load packages that will be used in the code
  
  library(data.table)
  library(lubridate)
  
  ## prepare directory, download and unzip data file
  
  if(!file.exists("data")){dir.create("data")}
  zipfile <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  dest <- "C:/Users/Craftemall/Desktop/datasciencecoursera/ExData_Plotting1/data/data.zip"
  mydir <- "C:/Users/Craftemall/Desktop/datasciencecoursera/ExData_Plotting1/data"
  download.file(url = zipfile, destfile = dest, mode = "wb")
  unzip(zipfile = dest, exdir = mydir)
  mydatafile <- "C:/Users/Craftemall/Desktop/datasciencecoursera/ExData_Plotting1/data/household_power_consumption.txt"
  
  ## read the data into R for the two dates and create new column for date/time
  
  Colnames <- as.character(fread(mydatafile, header = FALSE, nrows = 1))
  Sub <- fread(mydatafile, header = TRUE, stringsAsFactors = FALSE, na.strings = "?", skip = "1/2/2007", nrows = 2880, col.names = Colnames)
  Sub$DateAndTime <- paste(Sub$Date, Sub$Time)
  Sub$DateAndTime <- dmy_hms(Sub$DateAndTime)
  
  ## create png file with the plot
  
  png(filename = "plot4.png")
  par(mfrow = c(2, 2))
  
  plot(Sub$DateAndTime, Sub$Global_active_power, type = "n", ylab = "Global Active Power", xlab = "", main = NULL)
  lines(Sub$DateAndTime, Sub$Global_active_power)
  
  plot(Sub$DateAndTime, Sub$Voltage , type = "n", ylab = "Voltage", xlab = "datetime", main = NULL)
  lines(Sub$DateAndTime, Sub$Voltage)
  
  plot(Sub$DateAndTime, Sub$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "", main = NULL)
  lines(Sub$DateAndTime, Sub$Sub_metering_1)
  lines(Sub$DateAndTime, Sub$Sub_metering_2, col = "red")
  lines(Sub$DateAndTime, Sub$Sub_metering_3, col = "blue")
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(Sub$DateAndTime, Sub$Global_reactive_power, type = "n", ylab = "Global_reactive_power", xlab = "datetime", main = NULL)
  lines(Sub$DateAndTime, Sub$Global_reactive_power)
  
  dev.off()
}