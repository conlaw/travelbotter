library(twitteR)
 
  
consumer_key = "4KRnmqupgawz6TvfrfQvpw8Nb"
consumer_secret = "c50I0xEl1YZGIPMEajrFNDo2KyVJDffFAfLiC5f74hAjaa4T6D"
access_token = "742027849104797697-TjdkGQUK9LgQh8QOyf19TITqkzLuyCH"
access_secret = "PqNFcgvmYpctoSQAbiqKBSfXFMjVqRL0qXKCEP0x1qWWq"
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
  
msg <- lapply(countryTweets(vectorOfCities()),tweet)
load("country.RData")
rCity <- sample(1:length(country),1)
msg2 <- tweet(paste("Thinking about heading to ", countryTweets(country$country[rCity]), sep=""))
