#This downloads the raw data
source("code/constants.R")

if (!("WDI" %in% rownames(installed.packages()))){
  install.packages('WDI')
}
library('WDI')

#Download the raw data
download.file(foreignAidURL,rawAidLoc)
download.file(censorshipURL, rawCensorshipLoc)
download.file(censorshipReadmeURL, censorshipReadmeLoc)

#To search stats, WDIsearch("gdp") or WDIsearch("aid"). This is basically a grep
#Once you find your indicator code, do like this VVV
gdp_dat = WDI(indicator = gdp_dat_indic, start = 2012, end = 2012)
gdp_per_capita = WDI(indicator = gdp_per_cap_indic, start = 2012, end = 2012)
populations = WDI(indicator = total_pop_indic, start = 2012, end = 2012)
tax_revenue = WDI(indicator = tax_revenue_indic, start = 2012, end = 2012)
gdp_growth = WDI(indicator = gdp_growth_indic, start = 2012, end = 2012)

write.csv(gdp_dat,"rawdata/gdpUSD.csv", row.names = FALSE)
write.csv(gdp_per_capita,"rawdata/gdpPerCapUSD.csv", row.names = FALSE)
write.csv(populations,"rawdata/populations.csv", row.names = FALSE)
write.csv(tax_revenue, "rawdata/taxRevenue.csv", row.names = FALSE)
write.csv(gdp_growth, "rawdata/gdpGrowth.csv", row.names = FALSE)

