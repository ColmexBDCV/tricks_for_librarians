# Trucos para bibliotecas
Documentación para la solución de problemas que encontramos en la vida bibliotecaria


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
