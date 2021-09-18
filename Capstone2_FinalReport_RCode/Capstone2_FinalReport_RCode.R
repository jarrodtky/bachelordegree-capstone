# Install R Packages

install.packages("tm") # text mining and document management
install.packages("Hmisc") # descriptive statistics
install.packages("dplyr")
install.packages('proxy')
install.packages('dbscan')
install.packages('cluster')
install.packages("ggplot2")
install.packages("ggdendro")
install.packages("ngram")
install.packages("tokenizers")
install.packages('textdata')
install.packages("NbClust")

library(tm)
library(Hmisc)
library(dplyr)
library(purrr)
library(proxy)
library(stringi)
library(dbscan)
library(cluster)
library(ggplot2)
library(ggdendro)
library(quanteda)
library(wordcloud)
library(wordcloud2)
library(tidytext)
library(data.table)
library(reshape2)
library(textdata)
library(NbClust)
library(stringr)

#read.csv("Path where your CSV file is located on your computer\\File Name.csv")
df <- read.csv("Capstone2_FinalReport_Dataset_Clean.csv")

#df <- subset(df,Sentiment=='Positive')
#df <- subset(df,Sentiment=='Negative') (choose 1)

#CP2_text <- df$Country (To do country word cloud)
CP2_text <- df$Review_clean # (To do clean review word cloud)

CP2_text.corpus <- Corpus(VectorSource(CP2_text))

cleanedtext_df <- data.frame(text_clean = get("content", CP2_text.corpus), 
                             stringsAsFactors = FALSE)


# Most frequent terms function
frequentTerms <- function(text){
  #To build a document matrix table containing the most frequent words
  docs <- TermDocumentMatrix(text)
  docs <- removeSparseTerms(docs, 0.999)
  m <- as.matrix(docs)
  word_freqs <- sort(rowSums(m), decreasing=TRUE)
  dm <- data.frame(word=names(word_freqs), freq=word_freqs)
  return(dm)
  
}

# word cloud
dm2 <- frequentTerms(CP2_text.corpus)
pal <- brewer.pal(8,"Dark2")
set.seed(1234) 
wordcloud(dm2$word,freq=dm2$freq, min.freq = 1,
          max.words = 100,
          random.order=FALSE,
          random.color=TRUE,
          #rot.per=0.5,
          colors=pal,
          ordered.colors=FALSE, 
          use.r.layout=FALSE,
          fixed.asp=TRUE)
head(dm2,100)


# Sentiment Analysis

# Using unnest_tokens function to split text and stored it in tokens variable 
tokens <- cleanedtext_df %>%  
  unnest_tokens(word, text_clean) %>%
  select(word)


# NRC Sentiment Analysis
sent_nrc <- tokens %>% 
  inner_join(get_sentiments("nrc")) %>%
  count(word, sentiment, sort=TRUE) 

ggplot(data=sent_nrc, aes(x=reorder(sentiment, -n, sum), y=n)) + 
  geom_bar(stat="identity", aes(fill=sentiment), show.legend=FALSE) +
  ggtitle("Frequency of each sentiment") + theme(plot.title = element_text(hjust = 0.5)) +
  labs(x="Sentiment", y="Frequency") +
  theme_bw() 

sent_nrc %>%
  group_by(sentiment) %>%
  arrange(desc(n)) %>%
  slice(1:10) %>%
  ggplot(aes(x=reorder(word, n), y=n)) +
  geom_col(aes(fill=sentiment), show.legend=FALSE) +
  theme_bw() +
  theme(axis.text.x=element_text(angle=45, hjust=1)) +
  facet_wrap(~sentiment, scales="free_y") +
  labs(y="Frequency", x="Words") +
  coord_flip()

