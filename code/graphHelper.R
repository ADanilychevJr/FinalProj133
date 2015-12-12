#This contains all functions to create graphs
library(RColorBrewer)
library(ggplot2)

graphFullAid <- function(foreignAid){
  colors = c(rep("#0099FF",nrow(foreignAid)))
  d <- ggplot(foreignAid, aes(y = Amount, x = reorder(Country, Amount)))
  d+ geom_histogram(stat = "identity", fill = colors) + 
    labs(y = "Donated Aid (m USD)", x = "Country (names omitted)") +
    theme(axis.text.x = element_blank())
}

graphThirdQuartileAid <- function(foreignAid){
  third_q = summary(foreignAid$Amount)[5]
  upper_third_subset = subset(foreignAid, Amount >= third_q)
  d <- ggplot(upper_third_subset, aes(y = Amount, 
                                                                 x = reorder(Country, Amount)))
  colors = c(rep("#0099FF",nrow(upper_third_subset)))
  d+ geom_histogram(stat = "identity", fill = colors) + labs(y = "Donated Aid (m USD)", x = "Country") +
    theme(axis.text.x = element_text(angle = 325))
}

tenHighestReceived <- function(foreignAid){
  top10 = foreignAid[nrow(foreignAid) - rank(foreignAid$Amount) <= 13,]
  d <- ggplot(top10, aes(y = Amount, 
                                      x = reorder(Country, Amount)))
  colors = c(rep("#33cc00",nrow(top10)))
  d+ geom_histogram(stat = "identity", fill = colors) + labs(y = "Received Aid (m USD)", x = "Country") +
    theme(axis.text.x = element_text(angle = 325))
}

fullForeignAidSpread <- function(foreignAid){
  d <- ggplot(foreignAid, aes(y = Amount, 
                         x = reorder(Country, Amount)))
  colors = c(rep("#33cc00",nrow(foreignAid)))
  d+ geom_histogram(stat = "identity", fill = colors) + labs(y = "Received Aid (m USD)", x = "Country") +
    theme(axis.text.x = element_blank())
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

plotCensorshipSingle <- function(censorship, category){
  
  col_scheme = brewer.pal(nlevels(censorship[[category]]), "YlOrRd")
  d <- ggplot(censorship) +  aes_string(x = category)
  d + geom_histogram(fill =col_scheme) +
    ggtitle(paste0(category, " Frequencies"))
}

plotCensorshipVs<- function(censorship, category, vs){
  col_scheme = brewer.pal(nlevels(censorship[[category]]), "YlOrRd")
  d<- ggplot(censorship) 
  d + aes_string(x = category, y = vs, colour = category) + 
  geom_point() + labs(y = "GDP per Capita (USD)") + scale_color_manual(values = col_scheme)+
  ggtitle(paste0(category, " Censorship vs GDP per Capita"))
}

getCorrelationMatrix <- function(censorship){
  cols = c("Political", "Social", "Internet", "Military", "GDP_per_cap", "Population")
}

