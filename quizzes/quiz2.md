# Getting and Cleaning Data Quiz 2

Question 1
----------
Register an application with the Github API here https://github.com/settings/applications. 
Access the API to get information on your instructors repositories (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). Use this data to find the time that the datasharing repo was created. What time was it created? This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). 
You may also need to run the code in the base R package and not R studio. </br>

```R
library(httr)
library(httpuv)
# Register an application on gitHub
myapp <- oauth_app("github", key = "aab241bcd9afeb49f2e5", secret = "fc21a683b67e4a76140f549a92f946d946fd7b07")

#b. Get Oauth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
output <- content(req)

# extract needed data from the list
names(output) <- sapply(output, function(x) x$name) #name the elements of the original list
                                                    # which will give a named vector output
sapply(output, function(x) x$created_at)
```

Question 2
----------
The sqldf package allows for execution of SQL commands on R data frames. We will use the sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL. </br>
Download the American Community Survey data and load it into an R object called </br> acs <br>
https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv </br>
Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50? </br>

```R
library(sqldf)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile = "./data/community_survey.csv", method = "curl")

acs <- read.csv("community_survey.csv", stringsAsFactors = F, header = T)
pwgtp1LessFifty <- sqldf("select * from acs where AGEP < 50")

```

Question 3
----------
Using the same data frame you created in the previous problem, what is the equivalent function to 
```R
unique(acs$AGEP)
```

```R
sqldf("select distinct AGEP from acs")
```

Question 4
----------
How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:
http://biostat.jhsph.edu/~jleek/contact.html
(Hint: the nchar() function in R may be helpful)

```R
connection = url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlCode = readLines(connection) #readLines returns A character vector 
                                #of length the number of lines read.
close(connection)
characters <- list(nchar(htmlCode[10]), nchar(htmlCode[20]), nchar(htmlCode[30]), nchar(htmlCode[100]))
```

Question 5
----------
Read this data set into R and report the sum of the numbers in the fourth of the nine columns.
https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for
(Hint this is a fixed width file format)

```R
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(fileUrl, destfile = "./data/SStdata.for", method = "curl")

theData <- read.fwf("SStdata.for", widths = c(9, -5, 4, 4, -5, 4, 4, -5, 4, 4 ,-5, 4, 4), skip = 4, stringsAsFactors = FALSE)
result <- sum(theData[, "V4"])
```
