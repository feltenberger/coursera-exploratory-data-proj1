library(reshape2)

# Load household consumption data
consumption <- read.csv(
  'household_power_consumption.txt',
  header=T,
  sep=';',
  colClasses=c(rep('character', 7)))

# Subset data to only include data for the first and second days of Feb 2007
feb1_2 <- consumption[
  consumption$Date == '1/2/2007' | consumption$Date == '2/2/2007',]

# Add a DateTime column generated from the Date and Time columns
feb1_2$DateTime <- apply(feb1_2, 1, function(x) paste(x[1], x[2]))
feb1_2$DateTime <- strptime(feb1_2$DateTime, format='%d/%m/%Y %H:%M:%S')
# Convert Global_active_power to a number
feb1_2$Global_active_power <- as.numeric(feb1_2$Global_active_power)

# Plot the data and save it to a PNG
png(filename='plot2.png', width=480, height=480)

plot(
  feb1_2$DateTime,
  feb1_2$Global_active_power,
  pch=NA_integer_,
  ylab='Global Active Power (kilowatts)',
  xlab=NA)

lines(feb1_2$DateTime, feb1_2$Global_active_power)

dev.off()

