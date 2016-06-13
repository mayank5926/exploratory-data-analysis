## Read full data from csv
fulldata<-read.csv("household_power_consumption.txt",sep=";",header=TRUE)

## subset data to specific dates
usedata<-subset(fulldata,((Date=="1/2/2007") | (Date=="2/2/2007")))

## convert time
usedata$Time<-with(usedata,paste(Date,Time,sep=" "))
usedata$Time<-strptime(usedata$Time,format="%d/%m/%Y %H:%M:%S")

## convert date
usedata$Date<-as.Date(usedata$Date,format="%d/%m/%Y")

## convert data types of data appripriately
usedata$Global_active_power<-as.numeric(as.character(usedata$Global_active_power))
usedata$Global_reactive_power<-as.numeric(as.character(usedata$Global_reactive_power))
usedata$Voltage<-as.numeric(as.character(usedata$Voltage))
usedata$Global_intensity<-as.numeric(as.character(usedata$Global_intensity))
usedata$Sub_metering_1<-as.numeric(as.character(usedata$Sub_metering_1))
usedata$Sub_metering_2<-as.numeric(as.character(usedata$Sub_metering_2))
usedata$Sub_metering_3<-as.numeric(as.character(usedata$Sub_metering_3))

## Create labels to be used on X axis (weekday name labels)
sq<-seq(usedata$Time[1],usedata$Time[length(usedata$Time)]+86400,by=86400)
lbls<-strftime(sq,"%a")

## Draw plot 1
png(filename = "plot1.png", width = 480, height = 480, units = "px",
    pointsize = 12, bg = "white")
hist(usedata$Global_active_power,col="red",main="Global Active Power",
     xlab="Gloabl Active Power (kilowatts)")
dev.off()
