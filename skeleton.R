#This file creates directories and downloads the raw data

install.packages('WDI')

getwd()
dir.create("rawdata")

download.file("http://www.oecd.org/dac/stats/documentupload/AAAG.csv","rawdata/foreignAidRaw.csv")
download.file("https://raw.githubusercontent.com/ADanilychevJr/myData/master/censorship/oni_country_data_2013-09-20.csv", "rawdata/censorshipRaw.csv")
