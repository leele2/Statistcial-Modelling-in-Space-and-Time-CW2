## Reading Data ##
#Importing data
data <- read.csv("Data/Overturning data.csv")
#Creating DateTime Column
data$DateTime <- as.POSIXct(with(data, paste(paste(year, month, day, sep = "-"),
                                             paste(hour, 0, 0, sep = ":")),
                                 "%Y-%m-%d %H:%M:%S"))
#Creating {year}-{Quarter} column
data$qy <- paste(data$year, data$Quarter, sep = "-")
#Creating time series from quarterly means
data_mean.ts <- ts(as.vector(tapply(data$Overturning_Strength, data$qy, mean)),
                   start = c(2004, 2), frequency = 4)
##              ##