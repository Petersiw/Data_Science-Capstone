#set working directory
setwd("/Users/Petersiw/Desktop/Capstone")

#download file
url1 <- "https://d396qusza40orc.cloudfront.net/
dsscapstone/dataset/Coursera-SwiftKey.zip"
if(!file.exists("Coursera-SwiftKey.zip")) {
  download.file(url1, destfile = "Coursera-Swiftkey.zip")
}

#unzip file
#unzip("Coursera-Swiftkey.zip")

#load packages
library(tidyverse)
library(tidytext)
library(Kmisc)
library(data.table)

#load data
blogs_path <- "final/en_US/en_US.blogs.txt"
news_path <- "final/en_US/en_US.news.txt"
twitter_path <- "final/en_US/en_US.twitter.txt"
data_blogs <- readlines(blogs_path)
data_news <- readlines(news_path)
data_twitter <- readlines(twitter_path)

d <- data.table(text = data_twitter)

#convert to dataframe format for analysis
d_b <- data_frame(text = data_blogs)
d_n <- data_frame(text = data_news)
d_t <- data_frame(text = data_twitter)

#unnest words
tidy_db <- d_b %>% 
  unnest_tokens(word, text)
tidy_dn <- d_n %>% 
  unnest_tokens(word, text)
tidy_dt <- d_t %>% 
  unnest_tokens(word, text)

#remove stop words
data("stop_words")
tidy_db <- tidy_db %>%
  anti_join(stop_words)
tidy_db %>%
  count(word, sort = T)

tidy_dn <- tidy_dn %>%
  anti_join(stop_words)
tidy_dn %>%
  count(word, sort = T)

tidy_dt <- tidy_dt %>%
  anti_join(stop_words)
tidy_dt %>%
  count(word, sort = T)



tidy_db %>%
  count(word, sort = T) %>%
  filter(n > 2000) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip()

  
  
  