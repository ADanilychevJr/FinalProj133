#133 Final Project README

##Team

* Alex Danilychev Jr
* Kristie Chang
* Megan Otsuka
* Rahul Shankar

##Description

Our team got the idea for the project through a policy debate held by The Guardian newspaper several years ago regarding the relationship between __censorship__ and __foreign aid__. The debate focused on the importance of transparency with respect to foreign aid and how that would have an impact on government censorship and surveillance. Our team wanted to analyze this debate from a data-driven perspective. Consequently, the goal of our project was to determine the relationship between censorship and foreign aid in given countries. Specifically, we hypothesize that countries that heavily censor their constituents will likely not be high contributors of foreign aid to distressed countries.

Within this study, we saught to provide an overview of censorship by type and frequency amongst countries included in the Open Net Initiative’s censorship study. Then, we analyzed the key contributors and economic indicators for both foreign aid recipients and foreign aid donors. Finally, given prior contextual information, we delved further into the relationship between foreign aid recipients and donors with their respective levels and types of censorship.

##TLDR to run

* Run **skeleton.R** which will create all needed directories, download all raw data, and clean all data
* Knit **FinalReport.rmd** (which can be found in the code/ folder) to reproduce the report, and you're good to go

##Directories/Files

**skeleton.R** creates all directories, downloads all raw data, cleans all data

**rawdata/** contains the raw data. This is created and populated on the fly by skeleton.R
* censorshipRaw.csv - This contains all censorship data, found [**here**](https://opennet.net/research/data)
* foreignAidRaw.csv - Contains all foreign aid data. Check Data Sources section for more info
* gdpGrowth.csv - This is a data frame with stats on gdpGrowth **(from WDI)**
* gdpPerCapUSD.csv - Contains stats on gdpPerCapita **(from WDI)**
* gdpUSD.csv - Contains GDP numbers **(from WDI)**
* populations.csv - Contains population counts for all countries **(from WDI)**
* taxRevenue.csv - Contains tax revenue numbers. Isn't very complete but helpful **(from WDI)**

**cleandata/** contains clean data. This is created/populated by skeleton.R once rawdata has been downloaded
* censorship.csv - Clean version of censorship data merged with gdpGrowth, gdpPerCapUSD, populations, and taxRevenue data
* wdiFrame.csv - Clean version of WDI data, is made up of gdpGrowth, gdpPerCapUSD, populations, and taxRevenue data
* netForeignAid.csv - Cleaned version of foreign aid data. Contains information about donor countries along with merged stats with gdpGrowth, gdpPerCapUSD, populations, and taxRevenue
* foreignAidRecipients.csv - Similar to netForeignAid.csv, but includes foreign aid recipients rather than donors. 

**code/** contains all supporting R scripts. These will be called by skeleton.R
* constants.R       - This is where you should define variables like filenames/paths. Makes the code cleaner
* cleanData.R       - This is where the data cleaning code is. 
* cleanFuncs.R      - Contains helper functions for cleaning the data
* cleanCensorship.R - Contains additional helper functions for cleaning censorship data
* downloadRaw.R     - This is where we download all the data and save it to the raw folder
* graphHelper.R     - This file contains all graphing functions. It's called by FinalReport.rmd
* FinalReport.rmd   - This file reads in the cleaned data, calls graphHelper.R functions to create nice visuals/analysis

##Data Sources

**Censorship Data** We pulled our censorship data from [OpenNet](https://opennet.net/research/data)

**Foreign Aid Data** We pulled our data for foreign aid from the [Organisation for Economic Co-operation and Development](http://www.oecd.org/dac/stats/aid-at-a-glance.htm)

**Economic Indicator Data** We pulled our economic indicator data from the [World Bank](http://databank.worldbank.org/data/home.aspx) using the WDI library. This includes data on GDP, Population, Population Growth, and Tax Revenue. You can learn more [here](https://github.com/vincentarelbundock/WDI)


##Extra Libraries Used

[**World Bank Development Indicators for R**](https://github.com/vincentarelbundock/WDI)

[**corrPlot**](https://cran.r-project.org/web/packages/corrplot/corrplot.pdf) 

##Git Help

Run this ONCE `git clone https://github.com/ADanilychevJr/FinalProj133.git`

Everytime you start working (before changing any files):
* `git pull origin master`

When you are satisfied that you finished work and want to send it to the master copy in the cloud:
* `git add "your file name"`
* `git commit -m "some comment about what you added" `
* `git push origin master` (This sends to Github)

###Extra commands: 

To see your local status: 
* `git status` (this shows you what has been changed, committed etc)

