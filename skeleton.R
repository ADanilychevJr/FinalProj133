#This file creates directories and downloads the raw data

install.packages('WDI')
library('WDI')
source("code/constants.R")

#Create directories
dir.create("rawdata")
dir.create("data")

#Download the raw data
download.file(foreignAidURL,rawAidLoc)
download.file(censorshipURL, rawCensorshipLoc)
#To search stats, WDIsearch("gdp") or WDIsearch("aid"). This is basically a grep
#Once you find your indicator code, do like this VVV
gdp_dat = WDI(indicator = "NY.GDP.MKTP.CD", start = 2012, end = 2012)
gdp_per_capita = WDI(indicator = "NY.GDP.PCAP.CD", start = 2012, end = 2012)

#This calls code/cleanData.R, executing all commands it contains
source("code/cleanData.R") 

head(censorship)
str(censorship)
str(foreignAid)


