# Plots global active power (kilowatts) over time

plot2 <- function() {
  ds <- loadDataForPlot() # Load data for plot
  
  png(filename="plot2.png", width=480, height=480, unit="px") # Open PNG device
  
  par(mfrow = c(1, 1)) # Just one plot
  
  plot(ds$datetime, ds$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  
  dev.off() # Close device
}



# Load data for the plot (it also discards any data that is not from the dates 2007-feb-01 and 2007-feb-02)
#
# This function requires that the file "household_power_consumption.txt" is in the working directory.
# "household_power_consumption.txt" can be downloaded from "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# "Individual household electric power consumption Data Set" from UC Irvine Machine Learning Repository.
#
# This function has been copied to each plot file due to the Course Project instructions. However, it could be saved
# in separate file (e.g. loadDataForPlot.R). This way, all four plot files could "share" the same piece of code.

loadDataForPlot <- function() {
  # Check whether the dataset file is in the current directory
  if (!file.exists("household_power_consumption.txt")) {
    stop("This function requires that the file household_power_consumption.txt is in the working directory.")
  }
  
  # Set locale to English (required for datetime operations, like showing day of the weeks as "Thu", "Fri", ...)
  Sys.setlocale("LC_TIME", "English")
  
  # Read data
  ds <- read.table(file="household_power_consumption.txt", sep=";", header=TRUE, na.strings="?", stringsAsFactors=FALSE)
  ds = as.data.frame(ds)
  
  # Discards any data that is not from the dates 2007-feb-01 and 2007-feb-02
  tempDate = as.Date(ds$Date, "%d/%m/%Y")
  date1 = as.Date("2007-02-01", "%Y-%m-%d")
  date2 = as.Date("2007-02-02", "%Y-%m-%d")
  ds = ds[tempDate==date1 | tempDate==date2, ]
  
  # Include a new column "datetime" in a format suitable for date and time operations in R
  datetime = strptime(paste(ds[,1], ds[,2]), "%d/%m/%Y %H:%M:%S")
  ds = cbind(datetime, ds)
  
  # Return loaded dataset
  return(ds)
}