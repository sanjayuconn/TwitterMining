
# Use this if your application is not connecting to twitter
#library(devtools)
#library("curl")
#devtools::install_version("httr", version="0.6.0", repos="http://cran.us.r-project.org")
# library(httr)

install.packages('tm',repos='http://cran.us.r-project.org')
install.packages('twitteR',repos='http://cran.us.r-project.org')
install.packages('wordcloud',repos='http://cran.us.r-project.org')
install.packages('RColorBrewer',repos='http://cran.us.r-project.org')
install.packages('e1017',repos='http://cran.us.r-project.org')
install.packages('class',repos='http://cran.us.r-project.org')
install.packages("base64enc") 
install.packages("openssl")



ckey='*****'
skey='****'
token='****'
sectoken='*****'



library("twitteR")
library("openssl")
library("httpuv")
library("tm")
library("stringr")
library("dplyr")
library('wordcloud')
library('RColorBrewer')
library('base64enc')
install.packages("curl")
library("curl")
library(devtools)
devtools::install_version("httr", version="0.6.0", repos="http://cran.us.r-project.org")
library('httr')

sessionInfo() # gives you the session Info

setup_twitter_oauth(ckey,skey,token,sectoken)

#We will search twitter for the term 'ml'

ml.tweets <- searchTwitter("machine learning", n=2000, lang="en")
ml.text <- sapply(ml.tweets, function(x) x$getText())
#We'll remove emoticons and create a corpus
ml.text <- iconv(ml.text, 'UTF-8', 'ASCII') # remove emoticons
ml.corpus <- Corpus(VectorSource(ml.text)) # create a corpus

# We'll apply some transformations using the TermDocumentMatrix Function
term.doc.matrix <- TermDocumentMatrix(ml.corpus,
                                      control = list(removePunctuation = TRUE,
                                                     stopwords = c("ml","https", stopwords("english")),
                                                     removeNumbers = TRUE,tolower = TRUE))

term.doc.matrix <- as.matrix(term.doc.matrix)


# Get the word count
word.freqs <- sort(rowSums(term.doc.matrix), decreasing=TRUE) 
dm <- data.frame(word=names(word.freqs), freq=word.freqs)

#Create a word cloud

wordcloud(dm$word, dm$freq, random.order=FALSE, colors=brewer.pal(8, "Dark2"))














