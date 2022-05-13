## Preamble ##
sav_dir <- paste0(source, "/Latex_Files/Main/Sections/ARIMA")
##          ##

## Plotting ACF and PACF ##
png(paste0(sav_dir, "/Plots/ACF.png"), i_sz[2], i_sz[1],
    units = "in", res = i_sz[3])
plot(acf(data_mean.ts, lag.max = 40),
     main = NA, xlab = "Lag (years)", cex.lab = i_sz[5])
title(main = "ACF of Quarterly Means", cex.main = i_sz[5])
dev.off()
png(paste0(sav_dir, "/Plots/PACF.png"), i_sz[2], i_sz[1],
    units = "in", res = i_sz[3])
plot(pacf(data_mean.ts, lag.max = 40),
     main = NA, xlab = "Lag (years)", cex.lab = i_sz[5])
title(main = "PACF of Quarterly Means", cex.main = i_sz[5])
dev.off()
##                       ##

## Brute Force testing (p,q) Combinations ##
p_vals <- 0:3
q_vals <- 0:7
aIc <- matrix(0, length(p_vals), length(q_vals))
bIc <- matrix(0, length(p_vals), length(q_vals))
sIc <- matrix(0, length(p_vals), length(q_vals))
#Calculating AIC and BIC for each different (p,q) combinations
for (i in c(1:length(p_vals))){
  for (j in c(1:length(q_vals))){
    tmp <- Arima(data_mean.ts, order = c(as.numeric(p_vals[i]), 0,
                                         as.numeric(q_vals[j])))
    aIc[i, j] <- AIC(tmp)
    bIc[i, j] <- BIC(tmp)
    sIc[i, j] <- aIc[i, j] + bIc[i, j]
  }
}
rm(j)
#Finding minimum value across combinations
mins = matrix(0, 3, 2)
mins[1, ] <- which(aIc == min(aIc), arr.ind = TRUE)
mins[2, ] <- which(bIc == min(bIc), arr.ind = TRUE)
mins[3, ] <- which(sIc == min(sIc), arr.ind = TRUE)
#Outputting minimum combinations
tmp <- c("AIC", "BIC", "Sum of AIC and BIC")
for (i in c(1:3)){
  output <- paste0("The minimum pair of $(p,q)$ when minimizing the ", tmp[i],
                   " is $p$ = ", mins[i, 1] - 1, " and $q$ = ", mins[i, 2] - 1)
  writeLines(output, paste0(sav_dir, "/Outputs/", "min", i, ".txt"))
}
output = sIc
colnames(output) <- 0:(length(q_vals) - 1)
rownames(output) <- 0:(length(p_vals) - 1)
rm(aIc, bIc, sIc, p_vals, q_vals, i)
write.table(as.data.frame(round(output, 2)) %>% rownames_to_column('p/q'),
            paste0(substr(sav_dir, 1, str_locate(sav_dir, "Main/")[2]),
            "S2tab1.csv"), quote = F, sep = ",", row.names = F)
rm(output)
##                                        ##

## Building and testing ARMA model ##
#Checking model
fit.sIc <- Arima(data_mean.ts, order = c(mins[3, 1] - 1, 0 , mins[3, 2] - 1))
png(paste0(sav_dir, "/Plots/manual_res.png"), i_sz[2], i_sz[1],
    units = "in", res = i_sz[3])
tmp <- checkresiduals(fit.sIc, plot = T)
dev.off()
capture.output(cat(round(tmp$p.value, 2)), file = paste0(sav_dir,
  "/Outputs/manual_res.txt"))
#Comparing to auto model
fit.auto <- auto.arima(data_mean.ts, max.d = 0, seasonal = F)
png(paste0(sav_dir, "/Plots/auto_res.png"), i_sz[2], i_sz[1],
    units = "in", res = i_sz[3])
tmp <- checkresiduals(fit.auto, plot = T)
dev.off()
capture.output(cat(round(tmp$p.value, 2)), file = paste0(sav_dir,
  "/Outputs/auto_res.txt"))
#Producing forecast
png(paste0(sav_dir, "/Plots/forecast.png"), i_sz[2], i_sz[1],
    units = "in", res = i_sz[3])
tmp <- autoplot(forecast(fit.auto, h = 6), ylab = "Overturning Stength (Sv)") +
 theme0 + theme(plot.margin = unit(c(0.5,0.5,0.5,0.7), "cm"))
print(tmp)
dev.off()
rm(mins, )
##                                 ##

## Building and testing ARIMA model ##
fit.auto.arima <- auto.arima(data_mean.ts, seasonal = F)
png(paste0(sav_dir, "/Plots/auto__arima_res.png"), i_sz[2], i_sz[1],
    units = "in", res = i_sz[3])
tmp <- checkresiduals(fit.auto.arima, plot = T)
dev.off()
capture.output(cat(round(tmp$p.value, 2)), file = paste0(sav_dir,
  "/Outputs/auto_arima_res.txt"))
fit.auto.arima2 <- auto.arima(data_mean.ts, seasonal = F, d = 2)
png(paste0(sav_dir, "/Plots/auto__arima_res2.png"), i_sz[2], i_sz[1],
    units = "in", res = i_sz[3])
tmp <- checkresiduals(fit.auto.arima2, plot = T)
dev.off()
capture.output(cat(round(tmp$p.value, 2)), file = paste0(sav_dir,
  "/Outputs/auto_arima_res2.txt"))
#Producing forecast
png(paste0(sav_dir, "/Plots/forecast_arima.png"), i_sz[2], i_sz[1],
    units = "in", res = i_sz[3])
tmp <- autoplot(forecast(fit.auto.arima2, h = 6), 
  ylab = "Overturning Stength (Sv)") + 
  theme0 + theme(plot.margin = unit(c(0.5,0.5,0.5,0.7), "cm"))
print(tmp)
dev.off()
rm(sav_dir, tmp, fit.sIc, fit.auto.arima, fit.auto.arima2)
##                                  ##