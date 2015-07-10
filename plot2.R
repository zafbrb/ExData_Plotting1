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
#  plot2: Generates Global Active Power by Day plot
#  Parameters: None
#  Result: Plots to PNG device to a file plot2.png in the local directory 
#  Will read source data in from internet if not present in local dir
## -----------------------------------------------------------------------------
    cat("*** Plot2 starting ***", "\n")
    wd <- getwd()
    fileURL <- "household_power_consumption.txt"
    
    cat("[Plot2] Checking if data is already present in local directory...")
    #if the txt file from UC Irvine Machine Learning Repository exists we use 
    # it otherwise we download it
    if(!file.exists("household_power_consumption.txt")) {
        downURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        myDest <- "exdata_data_household_power_consumption.zip"
        
        # Windows so do not need method="curl". Downloades to current working dir
        cat("\n", "[Plot2] Data not present - downloading from Internet...hold on", "\n")
        download.file(downURL, myDest)
        datedownLoaded <- Sys.Date()
        
        # Unzip the files into the working directory
        unzip(myDest)
        cat("[Plot2] Unpacked date source files into ", wd, "\n")
        dateLoaded <- Sys.Date()    
    } else {
        cat("Data present - using local content", "\n")
    }
    
    #lets read in the large file, remove NA's 
    cat("[Plot2] Reading large dataset - this may take a while...")
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
    dt <- strptime(dt, "%Y-%m-%d %H:%M:%S", "GMT")
    
    # Now create the plot to the screen device
    cat("[Plot2] Plotting...", "\n")
    with(energy2, plot(dt, Global_active_power, type="l", xlab = "Datetime",
                       ylab = "Global Active Power (kilowatts)"))
    
    # Write this graph to a PNG file in local directory
    dev.copy(png, file="plot2.png", width = 480, height = 480)
    dev.off()
    
    cat("[Plot2] Plot written to Plot2.png in local directory", wd, "\n")
    cat("*** Plot2 completed ***", "\n")
