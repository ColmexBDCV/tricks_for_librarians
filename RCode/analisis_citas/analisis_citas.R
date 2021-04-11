library(readxl)
library(tidyverse)
library(janitor)
library(readr)


########### Análisis citados #########


citas2020 <- read_excel("citas2020.xlsx", #derivado de la hoja colaborativa donde se enlistan los artículos con sus números de citas
                        range = "A1:O1092", na = "0") #range: coordenadas de los datos / na ="0" para poder sumar columnas con espacios vacíos
View(citas2020)

##### Creación de tibble con el periodo a estudiar ######

citas2015_2019 <- citas2020 %>% 
  filter(año>=2015)

##### Tabla de artículos publicados por año / por centro ######


citas2015_2019 %>%
  dplyr::count(centro, año)%>%
  tidyr::spread(año, n)%>%
  janitor::adorn_totals("row") %>% 
  write.table("clipboard", sep="\t", na = "", row.names=FALSE)

#### Número de artículos por lugar de publicación (vertical) y por centro (horizontal) ####

citas2015_2019 %>%
  dplyr::count(lugar_publicacion, centro, sort = TRUE)%>%
  tidyr::spread(centro, n)%>%
  #función de janitor, añade los totales en una columna
  janitor::adorn_totals("col") %>%
  arrange(desc(Total)) %>% 
  #añade fila en la que cuenta todos las celdas que no tienen NA
  #empieza el vector en 2 para no contar la primera fila donde está el nombre de la misma
  rbind(c("Países diferentes",colSums(!is.na(.[2:length(.)])))) %>% 
  #View() %>% 
  write.table("clipboard", sep="\t", na = "", row.names=FALSE)


#### Porcentajes por lugar de publicación (vertical) y por centro (horizontal) ####

citas2015_2019 %>%
  dplyr::count(lugar_publicacion, centro, sort = TRUE)%>%
  spread(centro, n)%>%
  mutate_if(is.numeric, function(x) x*100/sum(x, na.rm = TRUE)) %>%
  #adorn_totals("row") %>%
  #View() #%>% 
  write.table("clipboard", sep="\t", na = "", row.names=FALSE)


#### Filtrado de artículos con citas ####

concitas2015_2019 <- citas2015_2019 %>%
  filter(validadas_2019>0)


#### Tabla de porcentajes de artículos con citas por país de publicación ####

paisconcitas <- concitas2015_2019 %>%
  dplyr::count(lugar_publicacion, centro, sort = TRUE)%>%
  spread(centro, n)%>%
  mutate_if(is.numeric, function(x) x*100/sum(x, na.rm = TRUE))

#### Tabla de número de artículos con citas por país de publicación ####

concitas2015_2019 %>%
  dplyr::count(lugar_publicacion, centro, sort = TRUE)%>%
  spread(lugar_publicacion, n)%>%
  View()

#### Tabla de número de artículos con citas por editorial ####

concitas2015_2019 %>%
  group_by(centro)%>%
  dplyr::count(editorial)%>%
  spread(centro, n)%>%
  janitor::adorn_totals("col") %>% 
  #filter(Total>4)%>% #quitar este comentario y añadir el filtro de cuántos artículos debe tener la editorial
  #View()
  write.table("clipboard", sep="\t", na = "", row.names=FALSE)


###########################################################################################################
#### Filtros para ver qué revistas son las que tuvieron artículos con citas (buscadas por editorial)####
###########################################################################################################

concitas2015_2019 %>% 
  #filter(centro=='CELL')%>% 
  filter(editorial=='Universidad Nacional Autónoma de México')%>%
  dplyr::count(nombre_revista, sort = TRUE) %>% 
  View()

concitas2015_2019 %>% 
  #filter(centro=='CELL')%>% 
  filter(editorial=='El Colegio de México, A. C.')%>%
  dplyr::count(nombre_revista, sort = TRUE) %>%
  janitor::adorn_totals("row") %>% 
  View()

concitas2015_2019 %>% 
  #filter(centro=='CELL')%>% 
  filter(editorial=='John Wiley & Sons')%>%
  dplyr::count(nombre_revista, sort = TRUE) %>%
  janitor::adorn_totals("row") %>% 
  View()

###########################################################################################################
##################### Segunda parte del análisis: Artículos con citas ####################################
###########################################################################################################

###### Datos globales
sum(citas2015_2019$citasgs_2019, na.rm = T)
sum(citas2015_2019$validadas_2019, na.rm = T)
sum(citas2015_2019$sin_acceso, na.rm = T)
sum(citas2015_2019$autocitas, na.rm = T)
sum(citas2015_2019$no_arbitrado, na.rm = T)
sum(citas2015_2019$otro, na.rm = T)

##### Artículos con citas vs artículos sin citas

citas2015_2019 %>%
  group_by(centro)%>%
  count(validadas_2019>0)%>%
  rename(con_citas = 'validadas_2019 > 0') %>% 
  spread(con_citas, n) %>% 
  rename(con_citas = 'TRUE', sin_citas = '<NA>') %>% 
  adorn_totals("col")%>% 
  write.table("clipboard", sep="\t", na = "", row.names=FALSE)


##### Porcentaje de artículos con citas por centro

citas2015_2019 %>%
  group_by(centro)%>%
  count(validadas_2019>0)%>%
  spread(centro, n) %>%
  mutate_if(is.numeric, function(x) x*100/sum(x, na.rm = TRUE))%>%
  rename(concitas = 'validadas_2019 > 0')%>% 
  #View()
  write.table("clipboard", sep="\t", na = "", row.names=FALSE)


##### Artículos con más de 10 citas

citas2020 %>%
  group_by(centro)%>%
  filter(validadas_2019>10)%>%
  dplyr::count(lugar_publicacion)%>%
  spread(centro, n)%>%
  adorn_totals("col")%>%
  adorn_totals("row") %>% 
  #write.table("clipboard", sep="\t", na = "", row.names=FALSE)

  

#### Porcentaje de articulos por pais con citas
citas2020 %>%
  group_by(centro)%>%
  filter(validadas_2019>0)%>%
  dplyr::count(lugar_publicacion)%>%
  spread(centro, n)%>%
  mutate_if(is.numeric, function(x) x*100/sum(x, na.rm = TRUE))%>%
  #rbind(c("Países diferentes",colSums(!is.na(.[2:length(.)])))) %>% 
  #View()%>%
  #write.table("clipboard", sep="\t", na = "", row.names=FALSE)



  
###########################################################################################################
##################### Tercera parte del análisis: Artículos citantes ####################################
###########################################################################################################


citantes2015_2019 <- read_csv("citantes_2015-2019.csv")
View(citantes2015_2019)

##### Quitar columnas vacías
citantes2015_2019 <-citantes2015_2019 %>% 
  purrr::map(~.x) %>% #transforma su input y aplica una fución a cada elemento
  discard(~all(is.na(.x))) %>%
  map_df(~.x)

##### Otro modo de quitar columnas con un porcentaje de celdas vacías mayor al 70%
citantes2015_2019 <- citantes2015_2019[, which(colMeans(!is.na(citantes2015_2019)) > 0.7)]
            
##### Otro proceso para identificar columnas vacías
citantes2015_2019 %>% 
  profile_missing() %>% #
  filter(pct_missing == 1.00000000)


citantescei <-  filter(citantes2015_2019, Centro=="CEI")
citantescedua<-  filter(citantes2015_2019, Centro=="CEDUA")


##### Citantes por tipo de documento

citantes2015_2019 %>% 
  group_by(Centro) %>%
  dplyr::count(`Item Type`) %>%
  tidyr::spread(`Item Type`, n) %>%
  #adorn_totals("row") %>% 
  #mutate_if(is.numeric, function(x) x*100/sum(x, na.rm = TRUE))%>%
  View() #%>%
  #write.table("clipboard", sep="\t", na = "", row.names=FALSE)


##### Citantes por año de publicación

citantes2015_2019 %>% 
  group_by(Centro) %>%
  dplyr::count(`Publication Year`) %>%
  tidyr::spread(Centro, n) %>%
  #adorn_totals("row") %>% 
  #mutate_if(is.numeric, function(x) round(x*100/sum(x, na.rm = TRUE),digits = 2))%>%
  #View()
  write.table("clipboard", sep="\t", na = "", row.names=FALSE)
