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

