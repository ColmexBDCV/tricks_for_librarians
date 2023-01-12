##### Load libraries #####
library(tidyverse)

##### Load function #####

#Taken from: https://github.com/wikimedia/WikidataQueryServiceR/issues/12
querki <- function(query,h="text/csv") {
  require(httr)
  response <- httr::GET(url = "https://query.wikidata.org/sparql", 
                        query = list(query = query),
                        httr::add_headers(Accept = h))
  return(httr::content(response))
}

##### Run query #####
poems_df <- querki('SELECT ?poem ?poemLabel ?author ?authorLabel ?wsPage WHERE {
  ?poem wdt:P31 wd:Q5185279.
    ?poem wdt:P50 ?author .
  ?author wdt:P21 wd:Q6581072 .
  ?wsPage schema:about ?poem;
    schema:isPartOf <https://es.wikisource.org/>.
  SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE],en". }
}
ORDER BY ?authorLabel')

##### Explore frequencies #####
poems_df %>% 
  count(authorLabel, sort = T)
