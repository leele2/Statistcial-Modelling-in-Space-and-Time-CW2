#https://otexts.com/fpp2/seasonal-arima.html
rm(list = ls())
############# Set as Source Directory #############
wd <- paste0("C:/Users/PC/OneDrive - University of Exeter/University of Exe",
             "ter/05 - Fifth Year/Statistical Modelling in Space and Time/Cour",
             "seworks/Coursework 2")
#############                         #############
## Preamble ##
wd <- paste0(wd, "/RFiles")
setwd(wd)
#Install required Packages
if (!require(pacman)){
    install.packages("pacman")
    library(pacman)
}
p_load("httpgd", "ggplot2", "car", "ggfortify", "zoo", "tibble", "stringr")
#Initializing plot enviroment for httpgd
ggplot()
#Graphical variables
i_sz <- 5 * (1)
i_sz <- c(i_sz[1], (60 / 35) * i_sz[1], 300, 14, 1.5)
theme0 <- theme(title = element_text(size = 1.2 * floor(i_sz[4]), hjust = 0.5),
                axis.title = element_text(size = i_sz[4]),
                axis.text = element_text(size = i_sz[4]))
##          ##

## Reading Data ##
source("Read_data.R")
##              ##

## Validating Data ##
source("Validate.R")
##                 ##

## Building ARMA Model ##
source("ARMA.R")
##                     ##