library(readr)
library(tidyverse)
library(cld2)
library(cld3)

# Detect languages in titles and create column -----------------------------------------------------------

dh <- read_csv("dh_conferences_works.csv") #7113
dh <- dh %>% 
  mutate(cld3 = cld3::detect_language(work_title))%>% 
  mutate(cld2 = cld2::detect_language(work_title)) %>% 
  mutate(cld3vscld2 = ifelse(cld2 == cld3, "same", "different"))

write_csv(dh, "dh_conferences_cld3cld2_language_tags.csv")

# Create freq. tables for languages --------------------------------------------------

dhlang_cld2 <- dh %>% 
  count(cld2, sort = T)

dhlang_cld3 <- dh %>% 
  count(cld3, sort = T)

spa_dh <- dh %>% 
  filter(cld3 == "es"|cld2 == "es")

countries_spa <- spa_dh %>% 
  count(conference_country, sort=T)

errors <- spa_dh %>% 
  filter(cld3vscld2 == "different"|cld3vscld2 == "")

write_csv(errors, "errors.csv")
