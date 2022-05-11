## Preamble ##
sav_dir <- paste0(source, "/Latex_Files/Statistical-Modelling-in-Space-and-Ti",
  "me---CW2/Main/Sections/DataIntegretity")
##          ##

## Validating Data ##
#Box-plot of data (Annual Quarters)
ggplot(data, aes(x = factor(Quarter), y = Overturning_Strength)) +
  geom_boxplot(outlier.colour = "red", outlier.size = 1, coef = 1.5) +
  ggtitle("Box Plot for Overturning Stength For Each Annual Quarter") +
  xlab("Quarter") + ylab("Overturning Stength (Sv)") +
  stat_boxplot(geom = "errorbar", width = 0.3) +
  theme0
ggsave(paste0(sav_dir, "/Plots/Box(yr).png"), device = NULL,
      height = i_sz[1], width = i_sz[2], units = "in", dpi = i_sz[3])
#Box-plot of data (Months)
ggplot(data, aes(x = factor(month), y = Overturning_Strength)) +
  geom_boxplot(outlier.colour = "red", outlier.size = 1, coef = 1.5) +
  ggtitle("Box Plot for Overturning Stength For Each Annual Month") +
  xlab("Month") + ylab("Overturning Stength (Sv)") +
  stat_boxplot(geom = "errorbar", width = 0.3) +
  theme0
ggsave(paste0(sav_dir, "/Plots/Box(mnth).png"),
      height = i_sz[1], width = i_sz[2], units = "in", dpi = i_sz[3])
#Extracting and plotting outliers
ggplot(data[as.numeric(Boxplot(data$Overturning_Strength ~ data$month,
  data = data)), ], aes(x = DateTime, y = Overturning_Strength)) +
  geom_point(colour = "red") +
  ggtitle("Monthly Overturning Strength Outliers Against Time") +
  xlab("Time") +
  ylab("Overturning Strength (Sv)") +
  theme0
ggsave(paste0(sav_dir, "/Plots/outliers.png"), device = NULL,
      height = i_sz[1], width = i_sz[2], units = "in", dpi = i_sz[3])
##Plotting original data
png(paste0(sav_dir, "/Plots/orig.png"), i_sz[2], i_sz[1],
    units = "in", res = i_sz[3])
tmp <- autoplot(data_mean.ts, main = "Overturning Strength Time Series",
                xlab = "Time", ylab = "Overturning Strength (Sv)") +
                theme0
print(tmp)
dev.off()
rm(tmp, sav_dir)
##                 ##