## Caltech faculty publication analysis
## Kristin A. Briney, 2020-07-15



library(tidyverse)
library(stringr)
library(lubridate)
library(RefManageR)
library(jsonlite)


# Relevant file paths, change as necessary
fpath <- getwd()
fname <- "pubs.tsv"


# Read faculty CaltechAUTHORS handles
finput <- paste(fpath, fname, sep="/")
facPubs <- read_tsv(finput)


## Top titles ( >= 5 publications per title)
topTitles <- group_by(facPubs, PublicationTitle) %>%
  mutate(total=n()) %>% select(PublicationTitle, total) %>%
  unique() %>% filter(total>=5) %>% arrange(desc(total))

#ggplot(data=topTitles, mapping=aes(x=PublicationTitle, y=total, label=PublicationTitle)) +
#  theme_light() + 
#  coord_flip() +
#  theme(legend.position="none") +
#  geom_col(fill="#999999") + 
#  geom_text() +
#  labs(x="Publication", y="Number of Articles")


# Write top titles
foutput <- paste(fpath, "topTitles_over5.csv", sep="/")
write_csv(topTitles, foutput)





## Top publishers
topPublishers <- group_by(facPubs, Publisher) %>%
  mutate(total=n()) %>% select(Publisher, total) %>%
  unique() %>% arrange(desc(total))


# Write top titles
foutput <- paste(fpath, "topPublishers.csv", sep="/")
write_csv(topPublishers, foutput)






## Titles by publisher
PublisherTitles <- group_by(facPubs, Publisher, PublicationTitle) %>%
  mutate(total=n()) %>% select(Publisher, PublicationTitle, total) %>%
  unique() %>% arrange(Publisher, desc(total), PublicationTitle)


# Write top titles
foutput <- paste(fpath, "PublisherTitles.csv", sep="/")
write_csv(PublisherTitles, foutput)