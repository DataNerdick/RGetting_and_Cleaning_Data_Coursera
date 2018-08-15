##HW1
#1.

if(!file.exists("data")){dir.create("data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = ".data/communities.csv", method = "curl")
theData <- read.csv("communities.csv", stringsAsFactors = FALSE, header = TRUE)
milDollaProperties <- nrow(subset(theData, VAL >= 24, na.rm = TRUE))

#3.
library(xlsx)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = "./data/gasdata.xlsx", sheetIndex = 1, header = 1)
colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx("./data/gasdata.xlsx", sheetIndex = 1, colIndex = colIndex, rowIndex = rowIndex)
sum(dat$Zip*dat$Ext,na.rm=T)

#4
library(XML)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
theFile <- xmlTreeParse(sub("s", "", fileUrl), useInternal = TRUE) ## remove "s" from https since function
                                                                  ## does not support https
rootNode <- xmlRoot(theFile)
tagZipcode <- getNodeSet(rootNode, "//zipcode")
zipValues <- xmlSApply(tagZipcode, xmlValue)
zipNumeric <- as.numeric(zipValues)
as.data.frame(table(zipNumeric)) # then just fine the tagret index




