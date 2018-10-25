# Load Requried Packages
library("SnowballC") #text Mining and analysis
library("tm")        #text Mining and analysis
library("twitteR")   #For twitter account access
library("syuzhet")   # for sentiment analysis

# Authonitical keys to access twitter account
consumer_key <- 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
consumer_secret <- 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
access_token <- 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
access_secret <- 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'


setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
tweets <- userTimeline("hakan_samuel", n=200)

n.tweet <- length(tweets)

tweets.df <- twListToDF(tweets) 

tweets.df2 <- gsub("http.*","",tweets.df$text)

tweets.df2 <- gsub("https.*","",tweets.df2)

tweets.df2 <- gsub("#.*","",tweets.df2)

tweets.df2 <- gsub("@.*","",tweets.df2)



#Getting different emotions for each tweet
word.df <- as.vector(tweets.df2)

emotion.df <- get_nrc_sentiment(word.df) # getting sentiments, part of syuzhet package

emotion.df2 <- cbind(tweets.df2, emotion.df) 

#head(emotion.df2)

#getting the sentiment score
sent.value <- get_sentiment(word.df)

most.positive <- word.df[sent.value == max(sent.value)]

#most.positive

most.negative <- word.df[sent.value <= min(sent.value)] 
most.negative 

#Segregating positive and negative tweets
positive.tweets <- word.df[sent.value > 0]
negative.tweets <- word.df[sent.value < 0]
neutral.tweets <- word.df[sent.value == 0]

or

category_senti <- ifelse(sent.value < 0, "Negative", ifelse(sent.value > 0, "Positive", "Neutral"))
head(category_senti)

category_senti2 <- cbind(tweets,category_senti,senti) > head(category_senti2)

#counting sentiments results
table(category_senti)
