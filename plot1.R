#
# 'plot1.R' is to create 'Plot1.png'
#

# Reads in data from a portion of the file: 2007-02-01 to 2007-02-02 
data <-read.table("household_power_consumption.txt", 
            sep = ";", 
            header = FALSE,
            skip = grep("31/1/2007;23:59:00", readLines("household_power_consumption.txt")),
            na.strings = "?",
            stringsAsFactors = FALSE,
            nrows = 2880) # nrows = 60 min x 24 hour x 2 days
col_names <- read.table("household_power_consumption.txt", sep=";", header = FALSE, nrows = 1)
col_names <- as.vector(t(col_names)) # or, c(t(col_names)) 
names(data) <- col_names
str(data); summary(data); head(data)

# Open PNG device
png(filename = "Plot1.png", width = 480, height = 480, units = "px")
# Create plot and send to file
hist(data$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")
# Close PNG device
dev.off()