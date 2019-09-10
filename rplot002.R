#set workind directory, save current working directory
WD0<- getwd()
WD2<- "C:/Users/mclea/Desktop/DataScienceR/Exploring Data"
setwd(WD2)
#manually reset data to have the UTC encyrption
hpcopy<-"household_power_copy.txt"

BetterPowerData<-read.csv(hpcopy, sep = ";", header = TRUE)
#the format of these columns seems to be messed up, can't pull summary data on them. 
#Build columns in proper format

# i...Date is fine as it is
BetterPowerData$Kitchen<-as.numeric(BetterPowerData$Sub_metering_1)
BetterPowerData$Laundry<-as.numeric(BetterPowerData$Sub_metering_2)
BetterPowerData$Heat<-as.numeric(BetterPowerData$Sub_metering_3)
BetterPowerData$Active<-as.numeric(BetterPowerData$Global_active_power)
BetterPowerData$Reactive<-as.numeric(BetterPowerData$Global_reactive_power)
BetterPowerData$Volt<-as.numeric(BetterPowerData$Voltage)
BetterPowerData$Intensity<-as.numeric(BetterPowerData$Global_intensity)
#having trouble with date and time, idk if I want to join them
BetterPowerData$HammerTime<-strptime(BetterPowerData$Time, "%H;%M:%S")
BetterPowerData$Clock<- paste(BetterPowerData$ï..Date, BetterPowerData$Time, sep=" ")
#today it looked like it worked. but we still need editing to be graphable
BetterPowerData$PosClock<-as.POSIXct(BetterPowerData$Clock)
#Did this fix it?
BetterPowerData$HammerTime<-strptime(BetterPowerData$Clock, "%d/%m/%Y %H:%M:%S")



#The data covers several years, this is too much to process any meaningful trends. We should cut it down into bite sized portions of a few days, like the examples, but there's no such instruction. 
#cex argument in plot doesn't work. I don't know how to scale it down to be visible. 

#Time v Sub1   Time of Day vs Kitchen usage   ID mealtimes, mealtime usage v non mealtime usage

#Plot Active vs. Reactive Power
  
  #Plot 1
# hist(BetterPowerData$Active, col="Red", breaks = 12,main = "Global Active History", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
#pdf("Plot1")

#Plot 2
 plot(BetterPowerData$HammerTime, BetterPowerData$Active, type = "l", xlab = "Time", ylab = "Active Power Data")  
# ylab = "Global Active Power (kilowatts)"   #time/day vs Active
# axis.POSIXct(1, BetterPowerData$HammerTime, format = "%d %H")  
#pdf("Plot2")

#it's a start to get a pretty axis. two ties is fancier
#THe example online looked like it would only be a few days, but I have years of data

  #Plot 3


#ylab = "Energy Sub Metering"   time.Day vs 3 NRG subs
#####plot(BetterPowerData$HammerTime, BetterPowerData$Kitchen, type = "l",)

#plot(BetterPowerData$HammerTime, BetterPowerData$Heat, type = "l", xlab = "Time", ylab = "Energy Sub Metering", col="blue") 
#points( BetterPowerData$HammerTime, BetterPowerData$Laundry, type = "l",  col="red")
#points(BetterPowerData$HammerTime, BetterPowerData$Heat, type = "l", col="black")
#legend("topright", pch="1", col=c("black","red", "blue"), legend = c("Kitchen", "Laundry", "Heat"))

#pdf("Plot3")

  #legend("topright",pch ="___", col = c("black", "red", "blue"),legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
  
#Plot 4  multi chart
  #multi chart Active, Volt, Sub, React  all by date/time
#par(mfrow = c(2,2), mar=c(2,2,2,2), oma=c(2,2,2,2))
#with(BetterPowerData, {
#           plot(BetterPowerData$HammerTime, BetterPowerData$Active, main = "Active Power", type = "l") 
#       plot(BetterPowerData$HammerTime, BetterPowerData$Volt, main = "Voltage", type = "l") 
#    plot(BetterPowerData$HammerTime, BetterPowerData$Reactive, main = "Reactive Power", type = "l") 
#  plot(BetterPowerData$HammerTime, BetterPowerData$Heat, type = "l", xlab = "Time", main = "Energy Sub Metering", col="blue") 
#  points( BetterPowerData$HammerTime, BetterPowerData$Laundry, type = "l",  col="red")
#  points(BetterPowerData$HammerTime, BetterPowerData$Heat, type = "l", col="black")

#  mtext("Power Quad Chart", outer = TRUE) 
#  })

#pdf("Plot4")


