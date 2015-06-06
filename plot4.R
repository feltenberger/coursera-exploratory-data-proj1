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

# Plot the four plots and save it to a PNG
png(filename='plot4.png', width=480, height=480)

# Specify a 2x2 grid of plots filled in by column order
#  (i.e. upper left, lower left, upper right, lower right)
par(mfcol=c(2,2))

# First plot (upper left quadrant)
plot(
  feb1_2$DateTime,
  feb1_2$Global_active_power,
  pch=NA_integer_,
  ylab='Global Active Power',
  xlab=NA)

lines(feb1_2$DateTime, feb1_2$Global_active_power)


# Second plot (lower left quadrant)
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
  bty='n',
  lyd(c(1, 1, 1)))


# Third plot of Voltage
plot(
  x=feb1_2$DateTime,
  y=feb1_2$Voltage,
  xlab='datetime',
  ylab='Voltage',
  pch=NA_integer_)

lines(x=feb1_2$DateTime, y=feb1_2$Voltage, col='black')


# Fourth plot (lower right quadrant)
plot(
  x=feb1_2$DateTime,
  y=feb1_2$Global_reactive_power,
  xlab='datetime',
  ylab='Global_reactive_power',
  pch=NA_integer_)

lines(x=feb1_2$DateTime, y=feb1_2$Global_reactive_power, col='black')

dev.off()
