# -----------------------------------------------------------------------------
# Coursera Code: exdata-030 
# Exploratory Data Analysis
# Course Project 1:
#    Using data from the rom the UC Irvine Machine Learning Repository, we will 
#    produce 4 plots showing how household energy usage varies over a 2 day 
#    period
# Created 9/7/2015 by zafbrb
# Codebook:  
## -----------------------------------------------------------------------------
#  plot4: Generates Lattice plots by Day plot (4)
#  Parameters: None
#  Result: Plots to PNG device to a file plot4.png in the local directory 
#  Will read source data in from internet if not present in local dir
## -----------------------------------------------------------------------------
    cat("*** Plot4 starting ***", "\n")
    wd <- getwd()
    fileURL <- "household_power_consumption.txt"
    
    cat("[Plot4] Checking if data is already present in local directory...")
    #if the txt file from UC Irvine Machine Learning Repository exists we use 
    # it otherwise we download it
    if(!file.exists("household_power_consumption.txt")) {
        downURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        myDest <- "exdata_data_household_power_consumption.zip"
        
        # Windows so do not need method="curl". Downloades to current working dir
        cat("\n", "[Plot4] Data not present - downloading from Internet...hold on", "\n")
        download.file(downURL, myDest)
        datedownLoaded <- Sys.Date()
        
        # Unzip the files into the working directory
        unzip(myDest)
        cat("[Plot4] Unpacked date source files into ", wd, "\n")
        dateLoaded <- Sys.Date()    
    } else {
        cat("Data present - using local content", "\n")
    }
    
    #lets read in the large file, remove NA's 
    cat("[Plot4] Reading large dataset - this may take a while...")
    energy1 <- read.table(fileURL, sep = ";", header = TRUE, na.strings= "?", stringsAsFactors = FALSE)
    cat("Done!", "\n")
    
    #Set the date column to the correct class
    energy1$Date <- as.Date(energy1$Date, "%d/%m/%Y")
    
    # Get subset of larger data frame for the days in question
    energy2 <- subset(energy1, Date >= "2007-02-01" & Date <= "2007-02-02")
    
    #Clean up
    rm(energy1)
    
    # Need to create a Date/Timestamp column for this plot
    dt <- paste(energy2$Date, energy2$Time)
    dt2 <- strptime(dt, "%Y-%m-%d %H:%M:%S", "GMT")
    
    # Now create the plot - note we open a PNG file device in this case and 
    # generate the graph to the device. Comment out next line to see output on screen
    png(file="plot4.png", width=480, height=480)

    # Setup the lattice of plots (2x2)
    par(mfrow = c(2,2), mar=c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
    with(energy2, {
        plot(dt2, Global_active_power, type="l", xlab = "Datetime", 
             ylab = "Global Active Power")
        plot(dt2, Voltage, type="l", xlab = "Datetime", ylab="Voltage")
        plot(dt2, energy2$Sub_metering_1, type="n", 
             ylab="Energy sub metering", xlab="Datetime")
        lines(dt2, energy2$Sub_metering_1, type="l", col="black")
        lines(dt2, energy2$Sub_metering_2, type="l", col="red")
        lines(dt2, energy2$Sub_metering_3, type="l", col="blue")
        legend("topright","", c("Sub_metring_1", "Sub_metering_2", "Sub_metering_3"), 
               lwd=1, col=c("black", "red", "blue"))
        plot(dt2, Global_reactive_power, type="l", xlab="Datetime", ylab = "Global Reactive Power")
        mtext("Exploratory Data Analysis - Project 1 Plotting", outer = TRUE)
    })    
    # Close off the device
    dev.off()
    
    cat("[Plot4] Plot written to Plot4.png in local directory", wd, "\n")
    cat("*** Plot4 completed ***", "\n")
