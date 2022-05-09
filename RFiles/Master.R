rm(list = ls())
############# Set as Source Directory #############
wd <- paste0("C:/Users/dj-lu/OneDrive - University of Exeter/University of Exe",
             "ter/05 - Fifth Year/Statistical Modelling in Space and Time/Cour",
             "seworks/Coursework 2")
#############                         #############
## Preamble ##
wd <- paste0(wd,"/RFiles")
setwd(wd)
#Required Packages
require(httpgd)
require(ggplot2)
require(car)
require(ggfortify)
require(zoo)
require(tibble)
#Initializing HTTPGD plot environment
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
##                     ##