library(readr)
library(tidyverse)
library(DataExplorer) #Más sobre este paquete en: https://cran.r-project.org/web/packages/DataExplorer/vignettes/dataexplorer-intro.html
#excelente para echarle ojo rápido a los datos vía @TeresaOM

###### Opción 1. sapply ######

mi_df <- read_csv("aquívaladirección/detuarchivo.csv")

reporte_df <- mi_df %>%
  sapply(function(x) sum(is.na(x))) %>% #para contar todos los NAs por columna, sapply es de R base
  as_tibble(rownames = NA) #este parámetro es para que no ignore los nombres de fila, ¡gracias @josschavezf!

write.csv(reporte_df, "reporte_df.csv") #Cada fila es el nombre de una columna, y en seguida viene cuántos datos faltantes hay

###### Opción 2. profile_missing ######

elementtype %>% 
  DataExplorer::profile_missing() %>% 
  View()  #Crea un tibble con el número de faltantes y el porcentaje que representa


