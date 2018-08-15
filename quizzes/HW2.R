#HW2
##1
library(httr)
library(httpuv)
#a. Register an application on gitHub
myapp <- oauth_app("github", key = "aab241bcd9afeb49f2e5", secret = "fc21a683b67e4a76140f549a92f946d946fd7b07")

#b. Get Oauth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

#c. use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
output <- content(req)

#d. extract needed data from the list
names(output) <- sapply(output, function(x) x$name) #name the elements of the original list
                                                    # which will give a named vector output
sapply(output, function(x) x$created_at)


##2
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "./data/community_survey.csv", method = "curl")
acs <- read.csv("community_survey.csv", stringsAsFactors = F, header = T)
library(sqldf)
pwgtp1LessFifty <- sqldf("select * from acs where AGEP < 50")


##3
sqldf("select distinct AGEP from acs")


##4
connection = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(connection) #readLines returns A character vector 
                                #of length the number of lines read.
close(connection)
characters <- list(nchar(htmlCode[10]), nchar(htmlCode[20]), nchar(htmlCode[30]), nchar(htmlCode[100]))

##5
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(fileUrl, destfile = "./data/SStdata.for", method = "curl")
theData <- read.fwf("SStdata.for", widths = c(9, -5, 4, 4, -5, 4, 4, -5, 4, 4 ,-5, 4, 4), skip = 4, stringsAsFactors = FALSE)
result <- sum(theData[, "V4"])




