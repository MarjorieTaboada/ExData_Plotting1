# Reading the data
data_energy <- read.table("/household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep =";"  )

# Changing the class of each column
data_energy <- data_energy %>%
  mutate(across(Date, as.Date, format="%d/%m/%Y"),
         across(Time, ~format(as.POSIXct(., format="%H:%M:%S"), format="%H:%M:%S")),
         across(c(Global_active_power, Global_reactive_power, Voltage, Global_intensity, Sub_metering_1, Sub_metering_2, Sub_metering_3), as.numeric))

# Subsetting data from 2007-02-01 and 2007-02-02
subsetdata <- subset(data_energy, Date == "2007-02-01" | Date =="2007-02-02")

# Create column in table with date and time merged together
timedate <- strptime(paste(data_energy$Date, data_energy$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
data_energy <- cbind(data_energy, timedate)

# Plotting the graph
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 
plot(timedate, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)
plot(timedate, voltage, type="l", xlab="timedate", ylab="Voltage")
plot(timedate, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(timedate, subMetering2, type="l", col="red")
lines(timedate, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")
plot(timedate, globalReactivePower, type="l", xlab="timedate", ylab="Global_reactive_power")
dev.off()
