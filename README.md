# Trucos para bibliotecas
Documentación para la solución de problemas que encontramos en la vida bibliotecaria.

Si quisieras contribuir escribe un correo a segutierrez (arroba) colmex.mx

## Scripts en línea para ciertas tareas

### Para editar textos: https://onlinetexttools.com/

### Para editar CSVs https://onlinecsvtools.com/

### Para PNGs https://onlinepngtools.com/


## Scripts para la terminal de Windows

### Crear una lista con los nombres de archivos en una carpeta

1. Abrir terminal (botón windows + escribir "terminal")
2. Se copia la ruta del archivo donde están tus archivos, por ejemplo: "C:\Users\xxx\Dropbox\A_Proyectos\Zapata\xxx" (que está en la barra superior de tu explorador de archivos)
3. En la terminal se escribe "cd" y luego botón derecho (eso hace que se pegue la ruta "C:\...."). Por ejemplo: 
```winbatch
cd C:\Users\xxx\Dropbox\A_Proyectos\Zapata\xxx
```
4. Una vez hecho esto se escribe:
```winbatch
dir /s > nombres_de_mis_archivos.txt
```
(donde dir significa "enlistar archivos"; /s significa enlistar subcarpetas; > significa "guardar en"; y después se escribe el nombre de archivo donde se va a guardar)

### Crear una csv con los nombres de tus archivos (y sus rutas de carpeta)

Sigues los pasos 1, 2 y 3 del tutorial anterior

4. Una vez hecho esto se escribe:
```winbatch
dir /a /s /b > misarchivos.csv
```

(donde dir significa "enlistar archivos"; /a significa "muestra todos los archivos" (viene de "all" en inglés); /s significa "enlista las subcarpetas"; /b significa "muéstralos en formato simple" (viene de "bare" en inglés); > significa "guardar en"; y después se escribe el nombre de archivo donde se va a guardar)


### Quitar espacios y reemplazarlos por guiones bajos
```winbatch
cmd /e:on /v:on /c "for %f in ("* *.txt") do (set "n=%~nxf" & set "n=!n: =_!" & ren "%~ff" "!n!" )" 
```

### Convertir pdfs a texto
```winbatch
FORFILES /M *.pdf /C "cmd /c pdftotext @file" 
```
Primero se tienen que descargar https://www.xpdfreader.com/download.html y establecer correctamente las variables de entorno. Para más detalles ver: https://prezi.com/bqmznyehjtul/extraccion-de-texto/

## Scripts en R

### [Comparar dos colecciones y crear diagrama de Venn](https://github.com/ColmexBDCV/tricks_for_librarians/blob/master/RCode/CompareCollectionsData.R)

### [Convertir calendario (.ics) a dataframe](https://github.com/ColmexBDCV/tricks_for_librarians/blob/master/RCode/ICStoDataFrame.R)

### [Obtener número de vacíos por columna](https://github.com/ColmexBDCV/tricks_for_librarians/blob/master/RCode/obtener_numerodevacios_porcolumna.R)

### [Transformar YYYYMMDD a YYYY/MM/DD](https://github.com/ColmexBDCV/tricks_for_librarians/blob/master/RCode/from_string2date.R)

## Scripts en python

### Transformando los nombres de un archivo con acentos y eñes a ASCII

```python
import os
import unidecode #para esto habrá que hacer pip install unidecode

src_dir = #aquí se pone la dirección de la carpeta
for file_name in os.listdir(src_dir): 
    normalized = unidecode.unidecode(file_name)
    #print(file_name, normalized)
    os.rename(os.path.join(src_dir,file_name), os.path.join(src_dir, normalized))
```

### Agregando un prefijo a los nombres de archivo
```python
os.chdir("")  #aquí se pone la dirección de la carpeta
os.getcwd()

from glob import glob
pre = "2011_" #<- aquí se agrega el prefijo que se quiera poner
[os.rename(f, "{}{}".format(pre, f)) for f in glob("*.pdf")]
```

## Programas útiles

### Text Mining

#### Orange

1. Instalar Anaconda para tu sistema operativo https://www.anaconda.com/download/
2. Instalar orange3-text: https://github.com/biolab/orange3-text


a) En el Anaconda Prompt primero añadir "add conda-forge" a tus canalees:

    conda config --add channels conda-forge

b) Después se instala orange text

    conda install orange3-text

c) Luego se abre el programa con:

    python -m Orange.canvas
   
### Bibliometrías 

#### Citedby (API de Scielo con python)


1. Instalar con pip

```pip install citedbyapi```


2. Abrir en terminal python o abrir IDE con interpretador

```python

from citedby import client

client.RestfulClient()

cl.citedby_doi("10.1016/j.jenvp.2005.08.002")

```

#### Bibliometrix (paquete de R)

1. Instalar paquete

```install.packages("bibliometrix", dependencies= TRUE) ###instala el paquete bibliometrix y todas las dependencias```

2. Leer archivo bib exportado desde Scopus

```archivo <- readFiles("http://www.bibliometrix.org/datasets/savedrecs.bib")```

3. Convertir archivo bib a df

 ```df <- convert2df(archivo, dbsource = "scopus", format = "bibtex")```
