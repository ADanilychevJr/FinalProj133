#This contains all functions to create graphs

library(RColorBrewer) #RColorBrewer helpful for color palettes
library(ggplot2) 
library(corrplot) #Helpful for plotting correlation matrices

#Plots Countries vs Donated Aid in million USD 
graphFullAid <- function(foreignAid){
  colors = c(rep("#0099FF",nrow(foreignAid)))
  d <- ggplot(foreignAid, aes(y = Amount, x = reorder(Country, Amount)))
  d+ geom_histogram(stat = "identity", fill = colors) + 
    labs(y = "Donated Aid (m USD)", x = "Country (names omitted)") +
    theme(axis.text.x = element_blank()) + ggtitle("All Donated Aid Histogram")
}

#
graphThirdQuartileAid <- function(foreignAid){
  third_q = summary(foreignAid$Amount)[5]
  upper_third_subset = subset(foreignAid, Amount >= third_q)
  d <- ggplot(upper_third_subset, aes(y = Amount, 
                                                                 x = reorder(Country, Amount)))
  colors = c(rep("#0099FF",nrow(upper_third_subset)))
  d+ geom_histogram(stat = "identity", fill = colors) +
    labs(y = "Donated Aid (m USD)", x = "Country") +
    theme(axis.text.x = element_text(angle = 325)) + ggtitle("Upper Quartile of Aid Donors")
}

fourteenHighestReceived <- function(foreignAid){
  top14 = foreignAid[nrow(foreignAid) - rank(foreignAid$Amount) <= 13,]
  d <- ggplot(top14, aes(y = Amount, 
                                      x = reorder(Country, Amount)))
  colors = c(rep("#33cc00",nrow(top14)))
  d+ geom_histogram(stat = "identity", fill = colors) + labs(y = "Received Aid (m USD)", x = "Country") +
    theme(axis.text.x = element_text(angle = 325)) + ggtitle("Fourteen Highest Aid Recipients")
}

fullForeignAidSpread <- function(foreignAid){
  d <- ggplot(foreignAid, aes(y = Amount, 
                         x = reorder(Country, Amount)))
  colors = c(rep("#33cc00",nrow(foreignAid)))
  d+ geom_histogram(stat = "identity", fill = colors) + labs(y = "Received Aid (m USD)", x = "Country") +
    theme(axis.text.x = element_blank()) + ggtitle("Histogram of Aid Received per Country (all)")
}

highestCensorship <- function(censorship, category, vs=FALSE){
  if (is.numeric(censorship[[category]])){
    censorship[[category]] = factor(censorship[[category]])
  }
  if (vs == FALSE){
    plotCensorshipSingle(censorship, category)
  } else {
    plotCensorshipVs(censorship, category, vs)
  }
}

#Given the censorship DF and a category of censorship, plots a histogram of counts
plotCensorshipSingle <- function(censorship, category){
  col_scheme = brewer.pal(nlevels(censorship[[category]]), "YlOrRd")
  d <- ggplot(censorship) +  aes_string(x = category)
  d + geom_histogram(fill =col_scheme) +
    ggtitle(paste0(category, " Censorship Frequencies"))
}

#Plots countries that have atleast one censorship rating of "substantial". vs is the y-axis
plotSubstantialCensorshipCountries <- function(censorship, vs = "GDP_per_cap"){
  highCensorshipCountries = subset(censorship, Political == "substantial" |
         Social == "substantial" |
         Internet == "substantial" | 
         Military == "substantial")
  if(vs == "GDP_per_cap"){
     plotGDPperCapHighCensorship(highCensorshipCountries)
  } else if (vs == "Population"){
      plotPopHighCensorship(highCensorshipCountries)
  } 
}

#Plots GDP per capita vs highCensorshipCountries as a histogram. 
plotGDPperCapHighCensorship <- function(highCensorshipCountries){
  d<- ggplot(highCensorshipCountries)
  colors = c(rep("#ff0000", nrow(highCensorshipCountries)))
  d + aes(y = GDP_per_cap, x = reorder(Country, GDP_per_cap)) + 
  geom_histogram(stat = "identity", fill = colors)+
  labs(y = "GDP per Capita (USD)", x = "Country")+
  theme(axis.text.x = element_text(angle = 325)) + 
  labs(title = "GDP per capita for Countries w/ Substantial Censorship")
}

#Plots Population vs highCensorshipCountries as a histogram. 
plotPopHighCensorship <- function(highCensorshipCountries){
    d<- ggplot(highCensorshipCountries)
    colors = c(rep("#ffa500", nrow(highCensorshipCountries)))
    d + aes(y = Population, x = reorder(Country, Population)) + 
    geom_histogram(stat = "identity", fill = colors)+
    labs(y = "Population", x = "Country")+
    theme(axis.text.x = element_text(angle = 325)) + 
    labs(title = "Population for Countries w/ Substantial Censorship")
}

#Plots censorship from a certain category versus another column (vs) for each country
plotCensorshipVs<- function(censorship, category, vs){
  col_scheme = brewer.pal(nlevels(censorship[[category]]), "YlOrRd")
  d<- ggplot(censorship) 
  d + aes_string(x = category, y = vs, colour = category) + 
  geom_point() + labs(y = "GDP per Capita (USD)") + scale_color_manual(values = col_scheme)+
  ggtitle(paste0(category, " Censorship vs GDP per Capita"))
}

#Returns a correlation matrix of the columns of censorship. Tax column isn't included by default
getCorrelationMatrix <- function(censorship, rmTax = TRUE){
  cols = c("Political", "Social", "Internet", "Military",
           "GDP_per_cap", "Population", "PopGrowth")
  if (rmTax == FALSE){
    cols = c(cols, "Tax_Revenue")
  }
  censorship = censorship[,cols]
  censorship = na.omit(censorship)
  censorship = sapply(censorship,as.numeric)
  return(cor(censorship))
}

#Takes in the censorship df, boolean indicating whether to include taxes, and a method 
#Plots a correlation matrix
plotCorrMatrix <- function(censorship, rmTax, method){
  corr_matrix = getCorrelationMatrix(censorship, rmTax)
  corrplot(corr_matrix, method = method)
}

#Takes in the censorship and foreignAidDonors dataframes and 
#returns a merged version that only includes countries in the intersection
createCensorAidIntersectDF <- function(censorship, foreignAidDonors){
   sect = intersect(foreignAidDonors$Country, censorship$Country)
   censorship = subset(censorship, Country %in% sect)
   foreignAidDonors = subset(foreignAidDonors, Country %in% sect)
   df = data.frame(Country = censorship$Country,
                   CensorshipScore = censorship$TotalCensorshipScore,
                   AmountDonated = foreignAidDonors$Amount,
                   GDP_per_cap = censorship$GDP_per_cap,
                   Population = censorship$Population)
   return(df)
}

#Takes in the censorship and foreignAidRecipients dataframes and 
#returns a merged version that only includes countries in the intersection
createCensorAidRIntersectDF <- function(censorship, aidRecipients){
  sect = intersect(aidRecipients$Country, censorship$Country)
  censorship = subset(censorship, Country %in% sect)
  aidRecipients = subset(aidRecipients, Country %in% sect)
  df = data.frame(Country = censorship$Country,
                  CensorshipScore = censorship$TotalCensorshipScore,
                  Amount = aidRecipients$Amount,
                  GDP_per_cap = censorship$GDP_per_cap,
                  Population = censorship$Population)
  return(df)
}

#Plots a density curve of the cumulative censorship distribution
plotCensorshipDensity <- function(censorship){
  d<- ggplot(censorship, aes(x = TotalCensorshipScore))
  d + geom_density(fill = "#ff0000") +
    geom_vline(xintercept = median(censorship$TotalCensorshipScore)) + 
    ggtitle("Density curve of Total Censorship Score")
}

#Plots total Censorship score vs aid donated for countries that donated aid
plotDonorVsCensorshipScore <- function(censorship, foreignAidDonors){
   df = createCensorAidIntersectDF(censorship, foreignAidDonors)
   
   d <- ggplot(df)
   d + aes(x = CensorshipScore, y = AmountDonated) + 
     geom_point(aes(size = GDP_per_cap,color = CensorshipScore)) +
     geom_smooth(method="lm", se = TRUE) + labs(y = "Aid Donated (USD)", size = "GDP per Capita (USD)") + 
     ggtitle("Censorship score vs Amount Donated (USD)") + 
     scale_colour_continuous(name = "Censorship Score", low = "#33cc00", high = "#ff0000",
                             labels = c("no evidence", "pervasive", "selective", "substantial"),
                             breaks = c(0,2.7,5.3,8)) 
}

#Plots total Censorship score vs aid received for countries that received aid
plotRecipientsVsCensorshipScore <- function(censorship, foreignAidRecipients){
  df = createCensorAidRIntersectDF(censorship, foreignAidRecipients)
  d <- ggplot(df)
  d + aes(x = CensorshipScore, y = Amount) + 
    geom_point(aes(size = GDP_per_cap,color = CensorshipScore)) +
    geom_smooth(method="lm", se = TRUE) + labs(y = "Aid Received (USD)",size = "GDP per Capita (USD)") + 
    ggtitle("Censorship score vs Aid Received (USD)") + 
    scale_colour_continuous(name = "Censorship Score", low = "#33cc00", high = "#ff0000",
                      labels = c("no evidence", "pervasive", "selective", "substantial"),
                      breaks = c(0,2.7,5.3,8)) 
}



