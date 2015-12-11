#133 Final Project README

###Team
======
* Alex Danilychev Jr
* Kristie Chang
* Megan Otsuka
* Rahul Shankar

###Directories
======
**rawdata/** contains the raw data. This is created by skeleton.R

**data/** contains clean data. This is created by skeleton.R

**code/** contains all supporting R scripts. These will be called by skeleton.R
* constants.R - This is where you should define variables like filenames/paths. Makes the code cleaner
* cleanData.R - This is where the data cleaning code is. 
* cleanFuncs.R - Contains helper functions for cleaning the data
* cleanCensorship.R - Contains additional helper functions for cleaning censorship data
* downloadRaw.R - This is where we download all the data and save it to the raw folder

###Data Sources
======
**Censorship Data** We pulled our censorship data from [OpenNet](https://opennet.net/research/data)

**Foreign Aid Data** We pulled our data for foreign aid from the [Organisation for Economic Co-operation and Development](http://www.oecd.org/dac/stats/aid-at-a-glance.htm)

**Economic Indicator Data** We pulled our economic indicator data from the [World Bank](http://databank.worldbank.org/data/home.aspx) using the WDI library. You can learn more [here](https://github.com/vincentarelbundock/WDI)

**Syrian Refugee Data** We pulled our data regarding Syrian Refugee admittance from [UNHCR](http://data.unhcr.org/syrianrefugees/asylum.php). We converted the data from pdf to csv and hosted it. 

###Git Help
======
Run this ONCE `git clone https://github.com/ADanilychevJr/FinalProj133.git`

Everytime you start working (before changing any files):
* `git pull origin master`

When you are satisfied that you finished work and want to send it to the master copy in the cloud:
* `git add "your file name"`
* `git commit -m "some comment about what you added" `
* `git push origin master` (This sends to Github)

#####Extra commands: 

To see your local status: 
* `git status` (this shows you what has been changed, committed etc)

