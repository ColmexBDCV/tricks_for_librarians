# Taller de introducción al procesamiento de textos con R
# Autora: Silvia Gutiérrez (@espejolento)
# Licencia: CC BY 4.0
# Inspirado en el taller con @rivaquiroga: https://github.com/silviaegt/RLadiesCDMX_talleres/blob/master/extraccion_pdfs/importacion-y-limpieza-textos.R

# En esta lección usaremos cuatro paquetes de R, si no los tienen instalados
# pueden instalarlos con la función: instal.packages("nombre del paquete entrecomillado")

library(pdftools)
library(stringr)
library(readr)
library(tesseract)

# Ejemplo 1: Texto nativo digital (que se escribió en computadora y guardó como pdf) ---------------------------------

# Leemos el texto con la siguiente función de pdftools:
ley <- pdftools::pdf_text("Ley_Federal_Refugiados.pdf")
ley #siempre podemos ver qué hay en nuestra variable escribiendo su nombre y dando Ctrl+Enter (o bien desde nuestras variables de entorno)

# La función guardó cada página en vectores distintos
# para guardar todo el texto en la misma variable usamos la función de stringr, str_c() y el parámetro "collapse"
ley <- stringr::str_c(ley, collapse = "")
ley #ver línea 14

# Guardarlo en un archivo de texto plano con la función de readr: write_lines() 
readr::write_lines(ley, "ley.txt")

############# Ejemplo 2: Texto/imagen (escaneado) #################

tesseract::tesseract_download("spa") # se bajan los datos de entrenamiento del idioma que nos interesa

yanez <- pdftools::pdf_ocr_text("yanez_declaraciones.pdf", lang="spa") #se aplica OCR usando el idioma que bajamos

yanez <- stringr::str_c(yanez, collapse = "") #ver líneas 16-18

readr::write_lines(yanez, "yanez.txt") #con la función write_lines podemos crear un documento de texto plano con el texto extraído con OCR
