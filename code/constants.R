#This file contains all string constants like URLs and relative paths. 
#Makes the code cleaner. This should be run at the top of each R script

foreignAidURL = "http://www.oecd.org/dac/stats/documentupload/AAAG.csv"
censorshipURL = "https://raw.githubusercontent.com/ADanilychevJr/myData/master/censorship/oni_country_data_2013-09-20.csv"
refugeeURL = "https://raw.githubusercontent.com/ADanilychevJr/myData/master/Syrian_Refugee_Resettlement_Stats.csv"
censorshipReadmeURL = "https://github.com/ADanilychevJr/myData/blob/master/censorship/README.txt"

rawAidLoc = "rawdata/foreignAidRaw.csv"
rawCensorshipLoc = "rawdata/censorshipRaw.csv"
rawRefugeeLoc = "rawdata/syrianRefugees.csv"
censorshipReadmeLoc = "resources/censorshipREADME.txt"

cleanWDILoc = "cleandata/wdiFrame.csv"
cleanForeignAidLoc = "cleandata/netForeignAid.csv"
cleanCensorshipLoc = "cleandata/censorship.csv"
cleanForeignAidRecipientsLoc = "cleandata/foreignAidRecipients.csv"

gdp_dat_indic = "NY.GDP.MKTP.CD"
gdp_per_cap_indic = "NY.GDP.PCAP.CD"
total_pop_indic = "SP.POP.TOTL"
tax_revenue_indic = "GC.TAX.TOTL.GD.ZS"
gdp_growth_indic = "NY.GDP.MKTP.KD.ZG"