## -----------------------------------------------------------------------------
# Coursera Code: exdata-030 
# Exploratory Data Analysis
# Course Project 1:
#    Using data from the rom the UC Irvine Machine Learning Repository, we will 
#    produce 4 plots showing how household energy usage varies over a 2 day 
#    period
# Created 9/7/2015 by zafbrb
# Codebook:  
## -----------------------------------------------------------------------------
# Test Harness
# Place plot source files in local directory and run plot_test()
## -----------------------------------------------------------------------------
plot_test <- function() {
    wd <- getwd()
    source(paste(wd,"/plot1.r", sep=""))
    source(paste(wd,"/plot2.r", sep=""))
    source(paste(wd,"/plot3.r", sep=""))
    source(paste(wd,"/plot4.r", sep=""))
}
