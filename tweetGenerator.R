library(RSelenium)
library(stringr)
library(rvest)

#gets a country and returns its LP URL
nameToLP  <- function(feed){
  load("country.RData")
  countryCodes <- vector()
  j<- 1
  #loop through the countries and adds country codes to countryCodes vectors
  for(i in 1:length(country$country)){
    if(length(agrep(country$country[i], tolower(feed), max.distance = 0.001))!=0){
      countryCodes[j] <- as.character(country$countryLP[i])
      j <- j +1
    }
  }
  if(length(countryCodes)==0){
    return("No Match!")
  }
  #crafts the URLs
  paste("https://www.lonelyplanet.com/", countryCodes, sep="")
}

#Given a url for a country - returns a tweet with a recommended activity
tweetGenerator <- function(url){
  if(url=="No Match!" | is.null(url) | is.na(url)){
    return("I have no clue where you're talking about, but I'm sure it's awesome!")
  }
  #Use RSelenium to get the html for a dynamically loaded page
  startServer()
  browser <- remoteDriver()
  browser$open()
  browser$navigate(url)
  #gets HTML 
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
  tmp <- str_replace_all(tmp, ",", "")
  tmp <- str_trim(tmp)
  tmp <- str_replace_all(str_replace_all(tmp, "&", "and"), "\\b \\b" , "-")
  tmp <- str_replace_all(tmp, "[ ]{2,}", " ")
  tmp <- str_split(tmp, " ")
  tmp <- lapply(tmp, function(x) str_replace_all(x, "-", " "))

  #samples a random site in the country
  num <- sample(1:length(tmp), 1)
  site <- tmp[[num]]
  #vector of possible tweet intros
  possible_intros    <- c("Don't forget to visit the", "You have to check out the",
                          "My personal pick is the",
                          "No trip would be complete without a stop at the",
                          "I'd recommend you see the", "Definitely go to the", "I hear everyone likes visiting the",
                          "A highlight of any trip is definitely the"
  )
  #cobbles together a tweet
  tweet <- paste(possible_intros[sample(1:length(possible_intros),1)], site[1], "in", site[2], sep = " ")
  tweet <- paste(tweet, "!", sep ="")
  return(tweet)
}

#function that returns a vector of tweets to tweet out
countryTweets <- function(feed){
  if(feed == "No new tweets!"){
    return(-1)
  }
  tweets <- vector()
  for(i in 1:length(feed)){
    urls <- nameToLP(feed[i])
    tweets[i] <- paste(feed[i], "? ", tweetGenerator(urls[1]), sep="")
  }
  return(tweets)
}

