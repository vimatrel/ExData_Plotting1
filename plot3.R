
## IMPORTANT: File must exist in working directory, unziped.
## INSTRUCTIONS: type makeplot() in console for plot3

getinfo <- function(){
require(dplyr)
require(lubridate)

## read the file
## IMPORTANT: File must exist in working directory, unziped.
        print("Working...")
        bigfile <- read.table("household_power_consumption.txt", 
                      header = TRUE, sep = ";", na.strings = "?", 
                      stringsAsFactors = FALSE)
        condition <- c("1/2/2007", "2/2/2007")
#Subset observations and varables for this plot
        smallerfile <- bigfile %>% 
                        filter(Date %in% condition) %>% 
                        mutate(DateTime = paste(Date,Time,sep= " "), 
                               DateTime =  dmy_hms(DateTime), Date = dmy(Date))
## clean up
        rm(bigfile, condition)
        return(smallerfile)
}

makeplot <- function(plotnum = 3){
## check if we already have the data
## if not call function getinfo and make global enviroment data variable with <<-          
        if (!exists("datatouse")) datatouse <<- getinfo()
        pngfilename <- paste0("plot", plotnum, ".png")
## open png device        
        png(file = pngfilename, bg = "transparent", width = 480, height = 480)
## code for plot 1-----------------------------------------        
#         if (plotnum == 1){
#                 hist(datatouse$Global_active_power, 
#                      col = "Red",
#                      main = "Global Active Power", 
#                      xlab = "Global Active Power (kilowatts)")
#         }
## code for plot 2  ---------------------------------------     
#          if (plotnum == 2){
#                 plot(datatouse$DateTime, datatouse$Global_active_power, 
#                      type = "l", 
#                      ylab = "Global Active Power (kilowatts)",
#                      xlab = "")
#         }        

## code for plot 3 ----------------------------------------
        if (plotnum == 3){
                plot(datatouse$DateTime, datatouse$Sub_metering_1, type = "n", 
                     xlab = "", ylab = "Energy sub metering")
                lines(datatouse$DateTime, datatouse$Sub_metering_1, col = "black")
                lines(datatouse$DateTime, datatouse$Sub_metering_2, col = "red")
                lines(datatouse$DateTime, datatouse$Sub_metering_3, col = "blue")
                legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                       col = c("black", "red", "blue"), lty = 1 )
        }
        
## code for plot 4 ----------------------------------------        
#         if (plotnum == 4){
#                 par(mfrow = c(2,2))
#                 plot(datatouse$DateTime, datatouse$Global_active_power, 
#                      type= "l", xlab = "", ylab = "Global Active Power")
#                 
#                 plot(datatouse$DateTime, datatouse$Voltage, 
#                      type = "l", xlab = "datetime", ylab = "")                
#                 
#                 plot(datatouse$DateTime, datatouse$Sub_metering_1, type = "n", 
#                      xlab = "", ylab = "Energy sub metering")
#                 lines(datatouse$DateTime, datatouse$Sub_metering_1, col = "black")
#                 lines(datatouse$DateTime, datatouse$Sub_metering_2, col = "red")
#                 lines(datatouse$DateTime, datatouse$Sub_metering_3, col = "blue")
#                 legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
#                        col = c("black", "red", "blue"), lty = 1, bty = "n" )
#                 
#                 plot(datatouse$DateTime, datatouse$Global_reactive_power, 
#                      type = "l", xlab = "datetime")
#         }
    
## close devise and print final message------------------------
        garbage <- dev.off()
        paste(pngfilename, "created", sep=" " )
        
}


