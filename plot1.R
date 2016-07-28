# assign file name to the dataset to be read in

fname <- "household_power_consumption.txt"

# read in the dataset; assumes the text file has been unzipped and 
# located in the working directory

data <- read.table(file = fname, sep=';',header=T)

# convert date variable to date class

data$Date <- as.Date(data$Date,"%d/%m/%Y")

# retrieve only those dates equal to 2/1/2007 and 2/2/2007

data <- data[data$Date == "2007-02-02" | data$Date == "2007-02-01",]

# convert Global Active Power to a numeric

data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

# call png device driver to which histogram will be printed

png (file = "plot1.png",width=480,height=480)

# create histogram of Global Active Power

hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)",ylab = "Frequency",col = "red", main = "Global Active Power")

dev.off()