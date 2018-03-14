# TwitterMiningNLP
Let's mine twitter for some general data!
Step 1: Install and import Libraries

install.packages('tm',repos='http://cran.us.r-project.org')
install.packages('twitteR',repos='http://cran.us.r-project.org')
install.packages('wordcloud',repos='http://cran.us.r-project.org')
install.packages('RColorBrewer',repos='http://cran.us.r-project.org')
install.packages('e1017',repos='http://cran.us.r-project.org')
install.packages('class',repos='http://cran.us.r-project.org')
install.packages("base64enc") 
install.packages("openssl")

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

Step 2: Search for Topic on Twitter

We'll use the twitteR library to data mine twitter. First you need to connect by setting up your Authorization keys and tokens.

setup_twitter_oauth(consumer_key, consumer_secret, access_token=NULL, access_secret=NULL)

We will search twitter for the term 'ML'

ml.tweets <- searchTwitter("machine learning", n=7000, lang="en")
ml.text <- sapply(ml.tweets, function(x) x$getText())

Step 3: Clean Text Data

We'll remove emoticons and create a corpus

ml.text <- iconv(ml.text, 'UTF-8', 'ASCII') # remove emoticons
ml.corpus <- Corpus(VectorSource(ml.text)) # create a corpus

Step 4: Create a Document Term Matrix

We'll apply some transformations using the TermDocumentMatrix Function

term.doc.matrix <- TermDocumentMatrix(ml.corpus,
                                      control = list(removePunctuation = TRUE,
                                                     stopwords = c("ml","http", stopwords("english")),
                                                     removeNumbers = TRUE,tolower = TRUE))

Step 5: Check out Matrix

head(term.doc.matrix)

term.doc.matrix <- as.matrix(term.doc.matrix)

Step 6: Get Word Counts

word.freqs <- sort(rowSums(term.doc.matrix), decreasing=TRUE) 
dm <- data.frame(word=names(word.freqs), freq=word.freqs)

Step 7: Create Word Cloud

wordcloud(dm$word, dm$freq, random.order=FALSE, colors=brewer.pal(8, "Dark2"))

