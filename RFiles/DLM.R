## Preamble ##
sav_dir <- paste0(source, "/Latex_Files/Main/Sections/DLM")
##          ##

## Building DLM Model ##
#Defining prior
dlmSv <- dlmModPoly(order=2) + dlmModSeas(4)
buildFun <- function(x) {
    diag(W(dlmSv))[2:4] <- exp(x[1:3])
    V(dlmSv) <- exp(x[4])
    return(dlmSv)
}
#Fit data using MLE
(fit <- dlmMLE(data_mean.ts, parm = rep(0, 4), build = buildFun))$conv
dlmSv <- buildFun(fit$par)
drop(V(dlmSv))
diag(W(dlmSv))[2:3]
#Smoothing estimates and plot
SvSmooth <- dlmSmooth(data_mean.ts, mod = dlmSv)
xs <- cbind(data_mean.ts, dropFirst(SvSmooth$s[,c(1,4)]))
colnames(xs) <- c("Sv", "Trend", "Seasonal")
png(paste0(sav_dir, "/Plots/trends.png"), i_sz[2], i_sz[1],
    units = "in", res = i_sz[3])
plot(xs, type = 'o', main = "Overturning Strength (Sv)")
dev.off()
#Filter and forcast
Svfilt <- dlmFilter(data_mean.ts,mod=dlmSv)
Svfore <- dlmForecast(Svfilt,nAhead=6)
#Plotting forcast
sqrtR <- sapply(Svfore$R, function(x) sqrt(x[1,1]))
pl <- Svfore$a[,1] + qnorm(0.025, sd = sqrtR)
pu <- Svfore$a[,1] + qnorm(0.975, sd = sqrtR)
x <- ts.union(window(data_mean.ts), window(SvSmooth$s[,1]),Svfore$a[,1], pl, pu)
png(paste0(sav_dir, "/Plots/forecast.png"), i_sz[2], i_sz[1],
    units = "in", res = i_sz[3])
plot(x, plot.type = "single", type = 'o', pch = c(1, 0, 20, 3, 3),col = c("darkgrey", "darkgrey", "brown", "yellow", "yellow"), ylab = "Overturning Strength (Sv)")
title(main = "DLM Forcast for Overturning Strength")
legend("bottomleft", legend = c("Observed", "Smoothed (deseasonalized)", "Forecasted level", "95% probability limit"), bty = 'n', pch = c(1, 0, 20, 3, 3), lty = 1,col = c("darkgrey", "darkgrey", "brown", "yellow", "yellow"))
dev.off()
##                    ##