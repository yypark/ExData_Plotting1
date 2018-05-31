#
# 'plot2.R' is to create 'Plot2.png'
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
#str(data); summary(data); head(data)

# Conversion of the Date and Time variables to Date/Time classes in R:
data$date_time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S", tz = "EST")
#head(data$date_time)

# Open PNG device
png(filename = "Plot3.png", width = 480, height = 480, units = "px")
# Create plot and send to file
with(data, {plot(date_time, Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering",
                 cex.axis=0.9, cex.lab=0.9)
    lines(date_time, Sub_metering_2, type="l", col="red")
    lines(date_time, Sub_metering_3, type="l", col="blue")
    })

legend("topright",  lwd=1, col = c("black", "red", "blue"), legend=col_names[7:9])
# Close PNG device
dev.off()
