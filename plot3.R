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

# Plot the data and save it as a PNG
png(filename='plot3.png', width=480, height=480)

plot(
  x=feb1_2$DateTime,
  y=feb1_2$Sub_metering_1,
  pch=NA_integer_,
  ylab='Energy sub metering',
  xlab=NA)

lines(feb1_2$DateTime, feb1_2$Sub_metering_1, col='black')
lines(feb1_2$DateTime, feb1_2$Sub_metering_2, col='red')
lines(feb1_2$DateTime, feb1_2$Sub_metering_3, col='blue')

legend(
  "topright",
  col=c('black', 'red', 'blue'),
  legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
  pch=c(NA, NA, NA),
  lwd=1,
  lyd(c(1, 1, 1)))

dev.off()
#
