#### Instalar paquetes ####
#install.packages("tiff")

#### Cargar paquetes ####
library("jpeg")
library("tiff")

#### Obtener todos los archivos con extensión .tif ####
fileNames <- Sys.glob("*.tif")

#### Convertir esos archivos en .jpeg y guardarlos con el mismo nombre pero diferente extensión ####

for (f in fileNames){
  img <- readTIFF(f, native=TRUE)
  filename <- paste(gsub(pattern = "\\.tif$", "", f), ".jpeg", sep="")
  writeJPEG(img, target = filename, quality = 1) #mejor calidad
}



