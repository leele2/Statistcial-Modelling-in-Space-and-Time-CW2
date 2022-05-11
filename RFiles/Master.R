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
##          ##

## Reading Data ##
source("Read_data.R")
##              ##

## Validating Data ##
source("Validate.R")
##                 ##

## Building ARMA Model ##
source("ARMA.R")
grep()
##                     ##