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

##create timestamp

x<-data.frame(strptime(paste(select[,Date], select[,Time])
                       ,"%Y-%m-%d %H:%M:%S"))

colnames(x)<-"datetime"

select<-cbind(select,x)

##plot line graph
png("plot3.png", width=480, height=480)

plot(select$Sub_metering_1 ~ select$datetime
     ,select
     ,type="l"
     ,xlab = " "
     ,ylab="Energy sub metering")

lines(select$datetime, select$Sub_metering_2, col = "red")
lines(select$datetime, select$Sub_metering_3, col = "blue")

legend("topright"
       ,legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       ,lty = 1
       ,lwd = 2.5
       ,col = c("black", "red", "blue")
       )

dev.off()
