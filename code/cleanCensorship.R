#This script contains functions that clean the censorship data (individually)

source("code/cleanFuncs.R")

#Creates a new column which adds each countries censorship scores
addCombinedCensorship<- function(censorshipDF){
   newCol = as.numeric(censorshipDF$Political)+
            as.numeric(censorshipDF$Social)+
            as.numeric(censorshipDF$Internet)+
            as.numeric(censorshipDF$Military)
   newCol = newCol - 4
   censorshipDF$TotalCensorshipScore = factor(newCol)
   return(censorshipDF)
}

#Removes countries in country_vec from the censorship DF
removeCountries <- function(censorshipDF, country_vec){
  censorshipDF = censorshipDF[!(censorshipDF$Country %in% country_vec),]
  row.names(censorshipDF) = 1:nrow(censorshipDF)
  return(censorshipDF)
}

#Renames columns of Censorship dataframe
renameCensorshipCols <- function(censorship){
  colnames(censorship)[which(names(censorship) == "political_description")] <- "Political"
  colnames(censorship)[which(names(censorship) == "social_description")] <- "Social"
  colnames(censorship)[which(names(censorship) == "tools_description")] <- "Internet"
  colnames(censorship)[which(names(censorship) == "conflict_security_description")] <- "Military"
  return(censorship)
}

#Main entrypoint for cleaning the censorship dataframe
cleanCensorship <- function(censorshipDF){
  #Replace country column with Country
  censorshipDF$country = as.character(censorshipDF$country)
  colnames(censorshipDF)[which(names(censorshipDF) == "country")] <- "Country"
  
  #Drop appropriate columns
  dropped_cols = c("political_score","social_score","tools_score", "url", 
                   "testing_date","conflict.security_score")
  censorshipDF = censorshipDF[,!names(censorshipDF) %in% dropped_cols]
  
  #Drop appropriate rows
  censorshipDF = cleanCensorshipCountryNames(censorshipDF)
  censorshipDF = removeCountries(censorshipDF, 
                                 c("Gaza and the West Bank", "Syria"))
  censorshipDF = renameCensorshipCols(censorshipDF)
  censorshipDF = addCombinedCensorship(censorshipDF)
  return(censorshipDF)
}

