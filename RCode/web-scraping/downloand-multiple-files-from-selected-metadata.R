#### Load library ####

library(tidyverse)

#### Select metadata ####

mt <- read_csv("https://raw.githubusercontent.com/cligs/conha19/main/metadata_all.csv")

mt %>% 
  filter(country == "Mexico") %>% 
  count(`subgenre-theme`, sort = T)

mx <- mt %>% 
  filter(country == "Mexico" & `subgenre-theme`== "novela de costumbres")

##### Create urls from selected metadata #####

urls <- paste0("https://raw.githubusercontent.com/cligs/conha19/main/txt/", mx$idno, ".txt")

##### Create destination for files selected metadata #####
detfiles <- paste0("Text_Analysis/corpus/", mx$idno, ".txt")

#### Test download with one file ####
#download.file(url = urls[1], destfile = detfiles[1], mode='wb')

##### Apply function to all files #####
mapply(function(x, y) download.file(x,y, mode="wb"), x = urls, y = detfiles)