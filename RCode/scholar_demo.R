#Instalar paquete de Scholar.
install.packages("scholar")
#Documentación en: https://cran.r-project.org/web/packages/scholar/index.html

#Cargar paquetes que vamos a utilizar
library(scholar)
library(ggplot2)


#Tomar ids de google scholar de los académicos a indagar
raymundo <- 'ndY4R7kAAAAJ&hl'
esquivel <- 'XGc9W4gAAAAJ&hl'


#Crear gráfico
coauthor_network <- get_coauthors(raymundo)
plot_coauthors(coauthor_network)


coauthor_network <- get_coauthors(raymundo)
plot_coauthors(coauthor_network)
