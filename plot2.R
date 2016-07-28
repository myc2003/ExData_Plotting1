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

# convert Global Active Power to a numeric

data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

# call png device driver to which graph will be printed

png (file = "plot2.png",width=480,height=480)

# create line graph of Global Active Power and Date_Time

plot(data$Date_Time, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)", main = "")

dev.off()