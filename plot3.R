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

# convert the three Sub Metering variables to a numeric

data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))

# call png device driver to which graph will be printed

png (file = "plot3.png",width=480,height=480)

# create line graph of Date_Time and the three Sub Metting variables

plot(data$Date_Time, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", main = "")
lines(data$Date_Time, data$Sub_metering_2, col="red")
lines(data$Date_Time, data$Sub_metering_3, col="blue")

# create legend in the upper right hand corner

legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1))

dev.off()