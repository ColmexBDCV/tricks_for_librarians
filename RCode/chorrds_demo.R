install.packages("chorrrds")
install.packages("tidyverse")


library("chorrrds")
library("tidyverse")


# Step 1: Getting the chords for some Beatles songs
songs <- "the-beatles" %>% 
  chorrrds::get_songs() %>% 
  dplyr::sample_n(100)        # Just selecting a random sample of 5 songs 

View(songs)

# Step 2: getting the chords for the selected songs
chords <- songs %>% 
  dplyr::pull(url) %>%                     
  purrr::map(chorrrds::get_chords) %>%     # Mapping the function over the 
  # selected urls
  purrr::map_dfr(dplyr::mutate_if, is.factor, as.character)   %>% 
  chorrrds::clean(message = FALSE)         # Cleans the dataset, in case
# strange elements, as music lyrics, 
# are present when they shouldn't

chords %>% slice(1:10)

chords %>% 
  dplyr::group_by(song) %>% 
  dplyr::count(chord) %>%
  dplyr::top_n(n, n = 3) %>%
  dplyr::mutate(prop = scales::percent(n/sum(n)))
