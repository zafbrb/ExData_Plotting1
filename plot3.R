# -----------------------------------------------------------------------------
# Coursera Code: exdata-030 
# Exploratory Data Analysis
# Course Project 1:
#    Using data from the UC Irvine Machine Learning Repository, we will 
#    produce 4 plots showing how household energy usage varies over a 2 day 
#    period
# Created 9/7/2015 by zafbrb
# Codebook:  
## -----------------------------------------------------------------------------
#  plot3: Generates Energy sub-metering by Day plot
#  Parameters: None
#  Result: Plots to PNG device to a file plot3.png in the local directory 
#  Will read source data in from internet if not present on local dir
## -----------------------------------------------------------------------------
    cat("*** Plot3 starting ***", "\n")
    wd <- getwd()
    fileURL <- "household_power_consumption.txt"
    
    cat("[Plot3] Checking if data is already present in local directory...")
    #if the txt file from UC Irvine Machine Learning Repository exists we use 
    # it otherwise we download it
    if(!file.exists("household_power_consumption.txt")) {
        downURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        myDest <- "exdata_data_household_power_consumption.zip"
        
        # Windows so do not need method="curl". Downloades to current working dir
        cat("\n", "[Plot3] Data not present - downloading from Internet...hold on", "\n")
        download.file(downURL, myDest)
        datedownLoaded <- Sys.Date()
        
        # Unzip the files into the working directory
        unzip(myDest)
        cat("[Plot3] Unpacked date source files into ", wd, "\n")
        dateLoaded <- Sys.Date()    
    } else {
        cat("Data present - using local content", "\n")
    }
    
    #lets read in the large file, remove NA's 
    cat("[Plot3] Reading large dataset - this may take a while...")
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
    # generate the graph to the device
    # Note: You may have a issue with Legend text truncating if you try generating
    # to the screen and then copying to the PNG file..so we do it directly
    cat("[Plot3] Plotting...", "\n")
    png(file="plot3.png", width=480, height=480)
    plot(dt2, energy2$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
    lines(dt2, energy2$Sub_metering_1, type="l", col="black")
    lines(dt2, energy2$Sub_metering_2, type="l", col="red")
    lines(dt2, energy2$Sub_metering_3, type="l", col="blue")
    legend("topright","", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           lwd=1, col=c("black", "red", "blue"))
    
    # Close off the device
    dev.off()
    
    cat("[Plot3] Plot written to Plot3.png in local directory", wd, "\n")
    cat("*** Plot3 completed ***", "\n")
