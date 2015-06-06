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

# Convert Global_active_power to a number
feb1_2$Global_active_power <- as.numeric(feb1_2$Global_active_power)

# Plot a histogram of the power use and save it to a PNG
png(filename='plot1.png', width=480, height=480)

hist(
  feb1_2$Global_active_power,
  main='Global Active Power',
  xlab='Global Active Power (kilowatts)',
  ylab='Frequency',
  col='red')

dev.off()

