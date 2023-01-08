#install.packages("readr") #instalar paquete si no se tiene
#install.packages("plyr")

#### Paso 1. Cargar paquete
library(readr) #para correr la línea ctrl enter
library(plyr)


#### Paso 2. Cargar/asignar datos de cada Centro a una variable
CEH <- readr::read_csv("CEH_TODO.csv")
CEAA <- read_csv("CEAA_TODO.csv")
CEI <-read_csv("CEI_TODO.csv")
CELL <- read_csv("CELL_TODO.csv") 
PEI <- read_csv("PEI_TODO.csv")
CES <- read_csv("CES_TODO.csv")
CEDUA <- read_csv("CEDUA_TODO.csv")
CEE <- read_csv("CEE_TODO.csv")

#### Paso 3. Agregar columna "Centro" a cada base con el valor de cada Centro
CEH$Centro <- "CEH"
CEAA$Centro <- "CEAA"
CEI$Centro <-"CEI"
CELL$Centro <- "CELL" 
PEI$Centro <- "PEI"
CES$Centro <- "CES"
CEDUA$Centro <- "CEDUA"
CEE$Centro <- "CEE"

#### Paso 4. Conjugar todas las variables en un solo dataframe
citantes <- plyr::rbind.fill(PEI, CES, CEDUA, CEE, CEH, CEAA, CEI, CELL)

#Paso 5. Crear csv con el dataframe resultante
readr::write_csv(citantes, "citantes_2021.csv")
