# Trucos para bibliotecas
Documentación para la solución de problemas que encontramos en la vida bibliotecaria

# Pequeños scripts en python

## Transformando los nombres de un archivo con acentos y eñes a ASCII

```python
import os
import unidecode #para esto habrá que hacer pip install unidecode

src_dir = #aquí se pone la dirección de la carpeta
for file_name in os.listdir(src_dir): 
    normalized = unidecode.unidecode(file_name)
    #print(file_name, normalized)
    os.rename(os.path.join(src_dir,file_name), os.path.join(src_dir, normalized))
```

## Agregando un prefijo a los nombres de archivo
```python
os.chdir("")  #aquí se pone la dirección de la carpeta
os.getcwd()

from glob import glob
pre = "2011_" #<- aquí se agrega el prefijo que se quiera poner
[os.rename(f, "{}{}".format(pre, f)) for f in glob("*.pdf")]
```

# Programas útiles

## Orange

1. Instalar
