rm(list = ls())

library(RSelenium)
library(XML)
library(stringr)

checkForServer()
startServer()
remDr <- remoteDriver$new()
remDr<-remoteDriver(browserName="firefox")
remDr$open()

remDr$navigate('https://www.facebook.com/')

fblogin<-remDr$findElement(using = "xpath","//input[@id = 'email']")
fblogin$clearElement()
fblogin$sendKeysToElement(list("#############")) # Replace # with Userid

fbpwd<-remDr$findElement(using = "xpath","//input[@id = 'pass']")
fbpwd$clearElement()
fbpwd$sendKeysToElement(list("***************")) # Replace * with password

fbsub<-remDr$findElement(using = "xpath","//input[@id = 'u_0_0']")
fbsub$submitElement()



fbtrend<-remDr$findElement(using = "xpath","//div[@class='_5v0s _5my8']")
fbtrendtext<-xpathSApply(htmlTreeParse(unlist(fbtrend$getPageSource()), useInternalNodes = TRUE),"//div[@class='_5v0s _5my8']",xmlValue)
fbtrendlink<-xpathSApply(htmlTreeParse(unlist(fbtrend$getPageSource()), useInternalNodes = TRUE),"//span[@class='_3-9y']",xmlValue)
fbtrendlinkval<-xpathSApply(htmlTreeParse(unlist(fbtrend$getPageSource()), useInternalNodes = TRUE),"//a[@class='_4qzh _5v0t _7ge']",xmlGetAttr,"href")

df<-data.frame(fbtrendtext,fbtrendlink,fbtrendlinkval)
write.csv(df,"fb_scrape.csv")
