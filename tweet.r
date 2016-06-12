library(twitteR)
 
  
consumer_key = "HYSlogBpzHG4LGaoEbgb9aC3H"
consumer_secret = "yGknkMJT1TylrJsO4t0ctJnNFAvpYHTOhQSgAJKV7yoe1lNQ2E"
access_token = "740480338007339008-y2OHxVmnmlsmcWGci0fBNafvTprjzRb"
access_secret = "5GBXCSVP29MxFRdKhfNW7qszHlRAkHRnwJctn5xh13ivh"
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
  
msg <- lapply(countryTweets(vectorOfCities()),tweet)
  
#https://twitter.com/Ji10TheRobhatt