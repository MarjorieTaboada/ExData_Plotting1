# Reading the data
data_energy <- read.table("/household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep =";"  )

# Changing the class of each column
data_energy <- data_energy %>%
  mutate(across(Date, as.Date, format="%d/%m/%Y"),
         across(Time, ~format(as.POSIXct(., format="%H:%M:%S"), format="%H:%M:%S")),
         across(c(Global_active_power, Global_reactive_power, Voltage, Global_intensity, Sub_metering_1, Sub_metering_2, Sub_metering_3), as.numeric))

# Subsetting data from 2007-02-01 and 2007-02-02
subsetdata <- subset(data_energy, Date == "2007-02-01" | Date =="2007-02-02")
        
# Plotting the first histogram
png("plot1.png", width=480, height=480)
        hist(subsetdata$Global_active_power, col="red", border="black", main ="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")
        dev.off()
