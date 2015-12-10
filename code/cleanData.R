#This file cleans the data in the rawdata dir and moves the clean data to data/
#TODO: might want to remove the non-country entries in the WDI dataframe
#TODO: be careful of different currencies

print("Cleaning code")

#Read in our raw data
censorship     = read.csv("rawdata/censorshipRaw.csv")
foreignAid     = read.csv("rawdata/foreignAidRaw.csv")
gdp_dat        = read.csv("rawdata/gdpUSD.csv")
gdp_per_capita = read.csv("rawdata/gdpPerCapUSD.csv")
populations    = read.csv("rawdata/populations.csv")

#Combine WDI frames
wdi_frame = data.frame(Country = gdp_per_capita$country, 
                       GDP = gdp_dat$NY.GDP.MKTP.CD, 
                       GDP_per_cap = gdp_per_capita$NY.GDP.PCAP.CD,
                       Population = populations$SP.POP.TOTL)

#Remove rows with missing information, re-number those rows, change the number of levels in Country factor
wdi_frame = wdi_frame[complete.cases(wdi_frame),]
row.names(wdi_frame) = 1:nrow(wdi_frame)
wdi_frame$Country = factor(unlist(lapply(wdi_frame$Country, as.character)))
write.csv(wdi_frame,"cleandata/wdiFrame.csv", row.names = FALSE)

net_foreignAid = foreignAid[grep(".*Net Disbursements.*", foreignAid$colname),]
row.names(net_foreignAid) = 1:nrow(net_foreignAid)
dropped_cols = c("year","DonorCode","src", "RecipientCode", "regionid",
                 "col", "incomegrid", "incomegrname", "rowname", "Row")
net_foreignAid = net_foreignAid[,!names(net_foreignAid) %in% dropped_cols]
                           