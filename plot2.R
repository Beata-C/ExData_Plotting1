plot2 <- function(zipfile){
  
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
  
  png(filename = "plot2.png")
  plot(Sub$DateAndTime, Sub$Global_active_power, type = "n", ylab = "Global Active Power (kilowatts)", xlab = "", main = NULL)
  lines(Sub$DateAndTime, Sub$Global_active_power)
  dev.off()
}
