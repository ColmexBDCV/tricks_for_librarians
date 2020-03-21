mi_df <- read_csv("aquívaladirección/detuarchivo.csv")

reporte_df <- mi_df %>%
  sapply(function(x) sum(is.na(x))) %>% #para contar todos los NAs por columna
  as_tibble(rownames = NA) #este parámetro es para que no ignore los nombres de fila, ¡gracias @josschavezf!

write.csv(reporte_df, "reporte_df.csv")
