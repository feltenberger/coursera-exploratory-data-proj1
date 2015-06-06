library(reshape2)

consumption <- read.csv(
  'household_power_consumption.txt',
  header=T,
  sep=';',
  colClasses=c(rep('character', 7)))

feb1_2 <- consumption[
  consumption$Date == '1/2/2007' | consumption$Date == '2/2/2007',]

feb1_2$DateTime <- apply(feb1_2, 1, function(x) paste(x[1], x[2]))
feb1_2$DateTime <- strptime(feb1_2$DateTime, format='%d/%m/%Y %H:%M:%S')
feb1_2$Date <- as.Date(feb1_2$Date, format='%d/%m/%Y')

