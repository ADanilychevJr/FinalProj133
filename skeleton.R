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

#This calls code/cleanData.R, executing all commands it contains
source("code/cleanData.R") 

head(censorship)
str(censorship)
str(foreignAid)


