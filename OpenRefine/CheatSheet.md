En esta página recolectamos "recetas" de OpenRefine para hacer ciertas tareas.
# 1. Fechas #

## Extraer el año de una frase ##
Si tienes la frase "1 de enero a 7 de noviembre 1914" y quieres obtener sólo el año puedes ir a 'Column->Add column based on this column' en el menú de opciones y usar la siguiente expresión GREL:
```
value.match(/.*?(\d{4}).*?/)[0]
```

# 2. Facetas muy comprimidas #

añadir .log() al final

# 3. Obtener los nombres de autoridades que están en VIAF #

Primero tienes que obtener el número VIAF en una columna y puedes hacer esto vía una reconciliación de datos. 

Una vez que están en una columna puedes:

1) Crear una columna basada la de los números VIAF con la función: "Add column by fetching URLS"

![Imagen de cómo llegar a esa función](https://mdl.library.utoronto.ca/sites/default/files/pictures/openrefineworkshop102.png)

2) Una vez que se abra la ventana en la que puedes ingresar tu expresión GREL escribir lo siguiente:

```
"https://viaf.org/viaf/"+cell.recon.match.id+"/viaf.xml"
```

3) En la columna de los XML obteneidos usar la función: "Add column based on this column"

![Imagen de cómo llegar a esa función](https://i.stack.imgur.com/8Pdz5.png)

# 4. Añadir coordenadas

Add column by fetching URL (add username, remember to have https://www.geonames.org/enablefreewebservice)

```
'http://api.geonames.org/searchJSON?q=' + value.split(" ").join("%20") + '&orderby=relevance&maxRows=1&username=yourname'
```

4) Escribir la siguiente expresión:

```
value.parseHtml().select('ns1|text')[0].htmlText()
```

5) Si se quiere obtener el "segundo" nombre de la lista escribir esta otra expresión

```
value.parseHtml().select('ns1|text')[1].htmlText()
```

# 3. Obtener el QID de una celda reconciliada #
Usar la función: "Add column based on this column"
```
cell.recon.match.id
```

# 4. Facetar por número de ocurrencias #
```
facetCount(value, "value", "COLUMN_NAME")  > 100
```

# 5. Colapsar varias filas con del mismo valor (por ejemplo países de una misma entidad#
Ir a "edit cells" -> join multivalued cells
