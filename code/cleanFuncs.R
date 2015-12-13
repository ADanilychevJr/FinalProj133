#This file contains functions that clean data

#Takes in foreignAid dataframe and countryname, returns total aid received
getTotalReceived <- function(country, df){
  if (!(country %in% df$RecipientNameE)){
    return(0)
  }
  received_df = subset(df, RecipientNameE == country)
  amt_received = sum(received_df$Amount)
  return(amt_received)
}


repCName <- function(wdi, old, new){
  if (old %in% wdi$Country){
    wdi$Country[wdi$Country == old] <- new
  }
  return(wdi)
}

cleanWDICountryNames <- function(wdi){
  wdi = wdi[complete.cases(wdi),]
  row.names(wdi) = 1:nrow(wdi)
  wdi$Country = unlist(lapply(wdi$Country, as.character))
  wdi = repCName(wdi, "Korea, Rep.", "Korea")
  wdi = repCName(wdi, "Russian Federation", "Russia")
  wdi = repCName(wdi, "Egypt, Arab Rep.", "Egypt")
  wdi = repCName(wdi, "Iran, Islamic Rep.", "Iran")
  wdi = repCName(wdi, "Lao PDR", "Laos")
  wdi = repCName(wdi, "Myanmar", "Burma (Myanmar)")
  wdi = repCName(wdi, "Venezuela, RB", "Venezuela")
  wdi = repCName(wdi, "Yemen, Rep.", "Yemen")
  wdi = repCName(wdi, "Kyrgyz Republic", "Kyrgyzstan")
  print("Cleaned country names")
  return(wdi)
}

cleanAidCountryNames <- function(aid){
  aid = repCName(aid, "Chinese Taipei", "China")
  aid = repCName(aid, "Kuwait (KFAED)", "Kuwait")
  aid = subset(aid,!(Country %in% c("EU Institutions" ,"Total DAC Countries")) )
  return(aid)
}

cleanCensorshipCountryNames <- function(censorship){
  censorship = repCName(censorship, "South Korea", "Korea")
  return(censorship)
}



removeRecipientCountries <- function(foreignAidRecipients){
  rmCountries = c("Africa, regional",
                  "America, regional", "South & Central Asia, regional",
                  "West Indies, regional", "South of Sahara, regional",
                  "North & Central America, regional",
                  "North of Sahara, regional",
                  "Bilateral, unspecified", "South Asia, regional",
                  "Far East Asia, regional",
                  "Middle East, regional", "C\xf4te d'Ivoire")
  foreignAidRecipients = subset(foreignAidRecipients,!(Country %in% rmCountries))
  foreignAidRecipients = foreignAidRecipients[-1,]
  row.names(foreignAidRecipients) = 1:nrow(foreignAidRecipients)
  return(foreignAidRecipients)
}

getRecipientDF <- function(){
  foreignAid     = read.csv("rawdata/foreignAidRaw.csv")
  foreignAid = subset(foreignAid, year == 2012)
 
  dropped_cols = c("year","DonorCode","src", "RecipientCode", 
                   "col", "incomegrid", "incomegrname", "rowname", "Row", 
                   "Defl", "NatCur", "currencyname", "odaGNI", "colname",
                   "share", "donornamee")
  foreignAid = foreignAid[,!names(foreignAid) %in% dropped_cols]
  
  
  colnames(foreignAid)[which(names(foreignAid) == "RecipientNameE")] <- "Country"
  foreignAid = aggregate(foreignAid$Amount, by = list(Country = foreignAid$Country), sum)
  colnames(foreignAid)[which(names(foreignAid) == "x")] <- "Amount"
  foreignAid = removeRecipientCountries(foreignAid)
  return(foreignAid)
}

