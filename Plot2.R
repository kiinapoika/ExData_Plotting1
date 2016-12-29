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

##subset data
select<-subset(data, data$Date>="2007-02-01" & data$Date<="2007-02-02")

##create datetime

x<-data.frame(strptime(paste(select[,Date], select[,Time])
            ,"%Y-%m-%d %H:%M:%S"))

colnames(x)<-"datetime"

select<-cbind(select,x)

##plot line graph
plot(select$datetime, select$Global_active_power
     ,type="l"
     ,xlab = " "
     ,ylab="Global Active Power (kilowatts)")

##copy plot
dev.copy(png, file="plot2.png"
         ,width = 480
         ,height = 480)
dev.off()
