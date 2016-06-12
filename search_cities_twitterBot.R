library(twitteR)


getCity <- function(tweetList, numTweet){
  content <- tweetList[[numTweet]]$getText()
  # finds location of first @ symbol
  at_symbol <- str_locate(content, " @")[1]
  str_sub(content, at_symbol) <- ""
  (content)
}

get_ID_last_tweet <- function(){
  # Retrieves all tweets with our name in it
  tweets <- searchTwitter("twitterTravelBot")
  # Gets a vector showing TRUE for all tweets that we tweeted out
  ourTweets <- sapply(tweets, function(n) n$getScreenName() == "twitterTravelBot")
  # Returns a list of only the tweets we tweeted out
  ourTweets <- tweets[ourTweets]
  # returns a list of the ids for our tweets
  IDs <- (lapply(ourTweets, function(n) n$id)) %>% unlist() %>% as.numeric()
  last_tweet_id <- max(IDs)
}


vectorOfCities <- function(){
  
  last_tweet <- get_ID_last_tweet()
  # gets all the tweets since the last time we tweeted, which will be all
  # tweets of people tweeting at us with a city name
  tweets <- searchTwitter("@twitterTravelBot", sinceID = last_tweet)
    
  vector <- c()
  numTweets <- length(tweets)
  for (i in 1:numTweets){
    city <- getCity(tweets, i)
    vector[i] <- city
  }
  # return a vector of the cities that people have tweeted at us
  vector
  
}
  
  











                        