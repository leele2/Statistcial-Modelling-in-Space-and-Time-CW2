## Preamble ##
sav_dir <- paste0(substr(wd, 1, 149), "Latex_Files/Statistical-Modelling-in-Sp",
                  "ace-and-Time---CW2/Main/Sections/ARIMA")
##          ##

## Plotting ACF and PACF ##
png(paste0(sav_dir, "/Plots/ACF.png"), 600, 350)
plot(acf(data_mean.ts, lag.max = 40),
     main = "ACF of Quarterly Means", xlab = "Lag (years)")
dev.off()
png(paste0(sav_dir, "/Plots/PACF.png"), 600, 350)
plot(pacf(data_mean.ts, lag.max = 40),
     main = "PACF of Quarterly Means", xlab = "Lag (years)")
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
    tmp <- arima(data_mean.ts, order = c(as.numeric(p_vals[i]), 0,
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
  output <- paste0("The minimum pair hello of $(p,q)$ when minimizing the ", tmp[i],
                   " is $p$ = ", mins[i, 1] - 1, " and $q$ = ", mins[i, 2] - 1)
  writeLines(output, paste0(sav_dir, "/Outputs/", "min", i, ".txt"))
}
output = sIc
colnames(output) <- 0:(length(q_vals) - 1)
rownames(output) <- 0:(length(p_vals) - 1)
rm(aIc, bIc, sIc, mins, tmp, p_vals, q_vals, i)
write.table(as.data.frame(round(output, 2)) %>% rownames_to_column('p/q'),
            paste0(substr(sav_dir, 1, 212),"S2tab1.csv"), quote = F,
            sep = ",", row.names = F)
rm(output, sav_dir)
##                                        ##