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

## Draw plot 4
png(filename = "plot4.png", width = 480, height = 480, units = "px",
    pointsize = 12, bg = "white")

par(mfcol=c(2,2))

## Plot 4.1
plot(x=usedata$Time,y=usedata$Global_active_power,type="l",
     ylab="Gloabl Active Power (kilowatts)",xaxt = "n",xlab="")
axis(side=1,at=sq,labels=lbls)

## Plot 4.2
plot(x=usedata$Time,y=usedata$Sub_metering_1,type="l",xaxt = "n",xlab="",
     ylab="Energy sub metering")
lines(x=usedata$Time,y=usedata$Sub_metering_2,type="l",col="red")
lines(x=usedata$Time,y=usedata$Sub_metering_3,type="l",col="blue")
legend('topright',lty=1,bty = "n",col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.75)
axis(side=1,at=sq,labels=lbls)

## Plot 4.3
plot(x=usedata$Time,y=usedata$Voltage,type="l",xaxt = "n", xlab="datetime",
     ylab="Voltage")
axis(side=1,at=sq,labels=lbls)

## Plot 4.4
plot(x=usedata$Time,y=usedata$Global_reactive_power,type="l",xaxt = "n", xlab="datetime",
     ylab="Global_reactive_power")
axis(side=1,at=sq,labels=lbls)

dev.off()
