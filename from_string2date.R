
## Obtener directorio donde se encuentra uno
getwd()

## Cambiar a directorio donde está el texto a corregir
setwd("C:/Users/segutierrez/Dropbox/a_trabajo")

#Leer datos de un txt en el que cada fila es un año formato YYYYMMDD
my_data <- read.delim("anios2.txt")

# Función para reemplazar string por YYYY/MM/DD
funny_replace = function(in_string){
  first_part = substr(in_string,1,4)
  second_part = substr(in_string,5,6)
  third_part = substr(in_string,7,8)
  out_string = paste0(first_part,"/",second_part,"/",third_part)
  return(out_string)
}


# Data frame que guarda las fechas corregidas

# Inicializar DF

data.frame_dates = funny_replace(my_data[i,1])

# Poblar DF
for(i in 2:1073){
  data.frame_dates = rbind(data.frame_dates,funny_replace(my_data[i,1]))
}

## Guardar resultados en un csv
write.csv(data.frame_dates, "anios2corregido.csv", row.names = FALSE)
