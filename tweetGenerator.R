library(RSelenium)
library(stringr)
library(rvest)
#gets vector of LP urls of the countries
nameToLP  <- function(feed){
  load("country.RData")
  countryTweets <- vector()
  j<- 1
  for(i in 1:length(country$country)){
   if(length(agrep(country$country[i], feed))!=0){
     countryTweets[j] <- as.character(country$countryLP[i])
     j <- j +1
    }
  }
  urls <- paste("https://www.lonelyplanet.com/", countryTweets, sep="")
  urls
}

#Given a url for a country - returns a tweet with a recommended activity
tweetGenerator <- function(url){
  #Use RSelenium to get the html for a dynamically loaded page
  startServer()
  browser <- remoteDrive()
  browser$open()
  browser$navigate(url)
  page <- browser$getPageSource()
  browser$close()

  #gets all the activities for the page
  res <- vector()
  for(i in 1:3){
   for(j in 1:3){
     res[3*(i-1)+j] <- read_html(page[[1]]) %>% html_node(css = paste("#sights > article > div > div:nth-child(",i,") > a:nth-child(",j,")", sep="")) %>% html_text()
    }
  }
  #cleans up the results so the end format is a list where each list element
  #has the 1st element as the attraction and the second element as the location
  tmp <- str_replace_all(res, "\n", "")
  tmp <- str_trim(tmp)
  tmp <- str_replace_all(str_replace_all(tmp, "&", "and"), "\\b \\b" , "-")
  tmp <- str_replace_all(tmp, "[ ]{2,}", " ")
  tmp <- str_split(tmp, " ")
  tmp <- lapply(tmp, function(x) str_replace_all(x, "-", " "))

  #samples a random site in the country
  num <- sample(1:length(tmp), 1)
  site <- tmp[[num]]
  #vector of possible tweet intros
  possible_intros    <- c("You have to check out the",
                          "My personal pick is the",
                          "No trip would be complete without a stop at the",
                          "I'd recommend you see the",
                          "A highlight of any trip is definitely the"
  )
  #cobbles together a tweet
  tweet <- paste(possible_intros[sample(1:length(possible_intros),1)], site[1], "in", site[2], sep = " ")
  tweet <- paste(tweet, "!", sep ="")
  tweet
}

#function that returns a vector of tweets to tweet out
countryTweets <- function(urls){
  tweets <- vector()
  for(i in 1:length(urls)){
    tweets[i] <- tweetGenerator(urls[i])
  }
  tweets
}

