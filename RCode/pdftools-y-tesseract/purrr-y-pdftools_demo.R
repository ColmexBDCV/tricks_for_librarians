library(purrr)
library(pdftools)
library(glue)

## Crear listas de URLs para descargar PDFs con glue::glue  -----------------------------------------------------

anios <- c(2017:2019)
urls_cl <- glue("https://www.camara.cl/camara/doc/archivo_historico/mensaje_{anios}.pdf")
lista_pdfs_cl <- glue("cl_{anios}.pdf")

## Descargar múltiples pdfs con purrr::walk2 ------------------------------------------------
urls_cl %>% 
  walk2(., lista_pdfs_cl, download.file, mode="wb")

## Cargar múltiples pdfs con purrr::map -----------------------------------------------------

cl_pdfs <- list.files(path= "./pdfs_cl", pattern ="^cl.*pdf", full.names = T) #acá usamos path por si se guardan los pdfs en una carpeta
cl_textos <- map(.x = cl_pdfs, .f= pdf_text)
