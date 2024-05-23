library(tm)
library(wordcloud)
library(wordcloud2)

wordsremove <- c("tá", "pra", "app", "pois","fica", "fazer", "vcs", "motorista", "tudo", 
                 "alguns", "faz", "poderia", "ser","ter", "dá", "todo", "cada", "assim", 
                 "passageiro", "ainda", "sendo", "vai", "deveria",  "apenas",  "após",
                 "nessa", "muito", "fiz", "muitos",  "forma",  "carro",  "muitas", 
                 "vez", "passageiros")

aux<- read.csv2("/Users/Welynton/Downloads/zedelivery_frases.csv")

docs <- Corpus(VectorSource(aux))

docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, stripWhitespace)
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeWords, stopwords("pt"))
docs <- tm_map(docs, removeWords, wordsremove)

dtm <- TermDocumentMatrix(docs) 
matrix <- as.matrix(dtm) 
words <- sort(rowSums(matrix),decreasing=TRUE) 
df <- data.frame(word = names(words),freq=words)

set.seed(1234) # for reproducibility 
wordcloud(words = df$word, freq = df$freq, min.freq = 1, max.words=100, random.order=FALSE, scale=c(3.5,0.25), rot.per=0.35, colors=brewer.pal(8, "Dark2"))

wordcloud2(data=df, size=1.3, color='random-dark')
