#This file creates directories and downloads the raw data
source("code/constants.R")

#Create directories
dir.create("rawdata")
dir.create("cleandata")
dir.create("resources")

#This calls code/downloadRaw.R, which downloads our data
source("code/downloadRaw.R") 
#This calls code/cleanData.R, executing all commands it contains
source("code/cleanData.R") 



