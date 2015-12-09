#This file cleans the data in the rawdata dir and moves the clean data to data/

getwd()
print("Hello world")

censorship = read.csv("rawdata/censorshipRaw.csv")
foreignAid = read.csv("rawdata/foreignAidRaw.csv")
head(censorship)
head(foreignAid)
