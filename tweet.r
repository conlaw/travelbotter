library(twitteR)

#creates and authenticates the twitter credentials for the bot
loadCredentials <- function(){
  consumer_key = "4KRnmqupgawz6TvfrfQvpw8Nb"
  consumer_secret = "c50I0xEl1YZGIPMEajrFNDo2KyVJDffFAfLiC5f74hAjaa4T6D"
  access_token = "742027849104797697-TjdkGQUK9LgQh8QOyf19TITqkzLuyCH"
  access_secret = "PqNFcgvmYpctoSQAbiqKBSfXFMjVqRL0qXKCEP0x1qWWq"
  setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
}

update <- function() {
  loadCredentials()
  
  #tweets out in response to people that used the @travelbotter handle
  if(countryTweets(vectorOfCities())!=-1){
    msg <- lapply(countryTweets(vectorOfCities()),tweet)
  }
  #tweets out a random new city
  load("country.RData")
  rCity <- sample(1:nrow(country),1)
  intros <- c("Thinking about heading to ",
              "Want somewhere new to fall in love with? How about ",
<<<<<<< HEAD
=======
              "Our new favorite country is ",
>>>>>>> 58856e9b7b399032774d5378af486b97f0bd62f1
              "Starting to plan your next vacation to ",
              "Flying out to "
              )
  country.init <- as.character(country$country[rCity])
  countryFIN <- paste(toupper(substr(country.init,1,1)), substr(country.init, 2, nchar(country.init)), sep ="")
  msg2 <- tweet(paste(intros[sample(1:length(intros),1)], countryTweets(countryFIN), sep=""))
}