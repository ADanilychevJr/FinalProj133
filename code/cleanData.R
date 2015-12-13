#This file cleans the data in the rawdata dir and moves the clean data to data/
#TODO: might want to remove the non-country entries in the WDI dataframe
#TODO: be careful of different currencies

source("code/cleanFuncs.R")
source("code/cleanCensorship.R")
print("Cleaning code")

#Read in our raw data
censorship     = read.csv("rawdata/censorshipRaw.csv")
foreignAid     = read.csv("rawdata/foreignAidRaw.csv")
gdp_dat        = read.csv("rawdata/gdpUSD.csv")
gdp_per_capita = read.csv("rawdata/gdpPerCapUSD.csv")
populations    = read.csv("rawdata/populations.csv")
tax_revenue    = read.csv("rawdata/taxRevenue.csv")
pop_growth     = read.csv("rawdata/gdpGrowth.csv")

#Combine WDI frames

wdi_frame = data.frame(Country = gdp_per_capita$country, 
                       GDP = gdp_dat$NY.GDP.MKTP.CD, 
                       GDP_per_cap = gdp_per_capita$NY.GDP.PCAP.CD,
                       Population = populations$SP.POP.TOTL)
wdi_frame2 = data.frame(Country = tax_revenue$country,
                        Tax_Revenue = tax_revenue$GC.TAX.TOTL.GD.ZS)
wdi_frame3 = data.frame(Country =pop_growth$country,
                        PopGrowth = pop_growth$NY.GDP.MKTP.KD.ZG)

#Remove rows with missing information, re-number those rows, change the number of levels in Country factor
foreignAid = subset(foreignAid, year == 2012)
#wdi_frame = wdi_frame[complete.cases(wdi_frame),]
#row.names(wdi_frame) = 1:nrow(wdi_frame)
#wdi_frame$Country = unlist(lapply(wdi_frame$Country, as.character))
wdi_frame = cleanWDICountryNames(wdi_frame)
wdi_frame2 = cleanWDICountryNames(wdi_frame2)
wdi_frame3 = cleanWDICountryNames(wdi_frame3)


#Creating `net_foreignAid` DF which is the amount each country gave
net_foreignAid = foreignAid[grep(".*Net Disbursements.*", foreignAid$colname),]
row.names(net_foreignAid) = 1:nrow(net_foreignAid)
dropped_cols = c("year","DonorCode","src", "RecipientCode", "regionid",
                 "col", "incomegrid", "incomegrname", "rowname", "Row", 
                 "Defl", "NatCur", "currencyname", "odaGNI", "colname",
                 "RecipientNameE",  "share")
net_foreignAid = net_foreignAid[,!names(net_foreignAid) %in% dropped_cols]
colnames(net_foreignAid)[which(names(net_foreignAid) == "donornamee")] <- "Country"
net_foreignAid$Country = as.character(net_foreignAid$Country)
net_foreignAid = cleanAidCountryNames(net_foreignAid)

#Creating `foreignAidRecipients` which shows the amount of aid each country received
foreignAidRecipients = getRecipientDF()

#Censorship data cleaning
censorship = cleanCensorship(censorship)

#Add received aid to net_foreignAid
net_foreignAid$AmountReceivedUSD = 1:nrow(net_foreignAid)
for (country in net_foreignAid$Country){
   net_foreignAid[net_foreignAid$Country == country, ]$AmountReceivedUSD = getTotalReceived(country, foreignAid)
   
}

#Merge in GDP information to foreignAid and 
net_foreignAid = merge(x = net_foreignAid, y = wdi_frame, by = "Country", all.x = TRUE)
net_foreignAid = merge(x = net_foreignAid, y = wdi_frame2, by = "Country", all.x = TRUE)
net_foreignAid = merge(x = net_foreignAid, y = wdi_frame3, by = "Country", all.x = TRUE)
censorship = merge(x = censorship, y = wdi_frame, by = "Country", all.x = TRUE)
censorship = merge(x = censorship, y = wdi_frame2, by = "Country", all.x = TRUE)
censorship = merge(x = censorship, y = wdi_frame3, by = "Country", all.x = TRUE)

#print(intersect(net_foreignAid$Country, censorship$Country))
#print(setdiff(net_foreignAid$Country, censorship$Country))
#print(setdiff(censorship$Country, net_foreignAid$Country))
if (FALSE){
intersect(net_foreignAid$Country, wdi_frame$Country)
setdiff(net_foreignAid$Country, wdi_frame$Country)
setdiff(wdi_frame$Country,net_foreignAid$Country)

intersect(net_foreignAid$Country, censorship$Country)
setdiff(net_foreignAid$Country, censorship$Country)
setdiff(censorship$Country, net_foreignAid$Country)

intersect(censorship$Country, wdi_frame$Country)
setdiff(censorship$Country, wdi_frame$Country)
setdiff(wdi_frame$Country,censorship$Country)

intersect(foreignAidRecipients$Country, wdi_frame$Country)
setdiff(censorship$Country, foreignAidRecipients$Country)
intersect(censorship$Country, foreignAidRecipients$Country)
}

#Now we write out our clean data
write.csv(wdi_frame,cleanWDILoc, row.names = FALSE)
write.csv(net_foreignAid, cleanForeignAidLoc, row.names = FALSE)
write.csv(censorship, cleanCensorshipLoc, row.names = FALSE)
write.csv(foreignAidRecipients, cleanForeignAidRecipientsLoc, row.names = FALSE )
                           