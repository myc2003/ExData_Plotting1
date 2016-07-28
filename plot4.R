# assign file name to the dataset to be read in

fname <- "household_power_consumption.txt"

# read in the dataset; assumes the text file has been unzipped and 
# located in the working directory

data <- read.table(file = fname, sep=';',header=T)

# convert date variable to date class variable

data$Date <- as.Date(data$Date,"%d/%m/%Y")

# retrieve only those dates equal to 2/1/2007 and 2/2/2007

data <- data[data$Date == "2007-02-02" | data$Date == "2007-02-01",]

# create a new variable with date and time combined

DateTime <- paste(data$Date, data$Time)
DateTime <- as.POSIXct(DateTime)
data["Date_Time"] <- DateTime

# convert the three Sub Metering, Voltage and Global Reactive Power 
# variables to a numeric

data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))
data$Voltage <- as.numeric(as.character(data$Voltage))
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))

# call png device driver to which graph will be printed

png (file = "plot4.png",width=480,height=480)

# set up a plotting space of two rows and two columns for the four graphs

par(mfrow = c(2,2))

# create line graph of Global Active Power and Date_Time

plot(data$Date_Time, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power", main = "")

# create line graph of Voltage and Date_Time

plot(data$Date_Time, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage", main = "")

# create line graph of Date_Time and the three Sub Metting variables

plot(data$Date_Time, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", main = "")
lines(data$Date_Time, data$Sub_metering_2, col="red")
lines(data$Date_Time, data$Sub_metering_3, col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),bty="n",lty=c(1,1,1))

# create line graph of Global Reactive Power and Date_Time

plot(data$Date_Time, data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", main = "")

dev.off()