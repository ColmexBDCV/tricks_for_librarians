###### Código para juntar múltiples CSVs con un patrón en el nombre 
### notas de cómo juntar múltiples documentos: https://www.masterdataanalysis.com/r/working-with-files-and-folders-in-r/

library(readr)
library(plyr)

CEAA <- plyr::rbind.fill(
  lapply(
    list.files(
      "2015_2019", #nombre de la carpeta
      pattern = "^CEAA(.*)csv$", #patrón del nombre, los csvs se llaman: CEAA_Banerjee_2015_Menus.csv / CEAA_Banerjee_2015_Religion.csv, etc
      full.names = TRUE
    ), 
    read_csv
  )
)


CEH <- plyr::rbind.fill(
  lapply(
    list.files(
      "2015_2019", 
      pattern = "^CEH(.*)csv$", 
      full.names = TRUE
    ), 
    read_csv
  )
)


CEI <- plyr::rbind.fill(
  lapply(
    list.files(
      "2015_2019", 
      pattern = "^CEI(.*)csv$", 
      full.names = TRUE
    ), 
    read_csv
  )
)


CELL <- plyr::rbind.fill(
  lapply(
    list.files(
      "2015_2019", 
      pattern = "^CELL(.*)csv$", 
      full.names = TRUE
    ), 
    read_csv
  )
)


PEI <- plyr::rbind.fill(
  lapply(
    list.files(
      "2015_2019", 
      pattern = "^PEI(.*)csv$", 
      full.names = TRUE
    ), 
    read_csv
  )
)



CES <- plyr::rbind.fill(
  lapply(
    list.files(
      "2015_2019", 
      pattern = "^CES(.*)csv$", 
      full.names = TRUE
    ), 
    read_csv
  )
)


CEDUA <- plyr::rbind.fill(
  lapply(
    list.files(
      "2015_2019", 
      pattern = "^CEDUA(.*)csv$", 
      full.names = TRUE
    ), 
    read_csv
  )
)

CEE <- plyr::rbind.fill(
  lapply(
    list.files(
      "2015_2019", 
      pattern = "^CEE(.*)csv$", 
      full.names = TRUE
    ), 
    read_csv
  )
)

CEH$Centro <- "CEH"
CEAA$Centro <- "CEAA"
CEI$Centro <-"CEI"
CELL$Centro <- "CELL" 
PEI$Centro <- "PEI"
CES$Centro <- "CES"
CEDUA$Centro <- "CEDUA"
CEE$Centro <- "CEE"

citantes <- rbind.fill(PEI, CES, CEDUA, CEE, CEH, CEAA, CEI, CELL)

write_csv(citantes, "citantes2015_2019.csv")

