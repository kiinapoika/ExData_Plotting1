##set working directory
setwd("~")

##create the filepath
filepath<-paste(getwd(),"/household_power_consumption.txt",sep="")

##read data
library(data.table)
data<-fread(filepath
            ,header=TRUE
            ,sep=";"
            ,dec="."
            ,na.strings = "?"
)
##change column class into Date
data$Date<-as.Date(data$Date, format="%d/%m/%Y")

##plot histogram
with(subset(data, data$Date>="2007-02-01" & data$Date<="2007-02-02")
     ,hist(Global_active_power
           ,main = "Global Active Power"
           ,xlab = "Global Active Power (kilowatts)"
           ,col = "red"))

##copy plot
dev.copy(png, file="plot1.png"
         ,width = 480
         ,height = 480)
dev.off()
