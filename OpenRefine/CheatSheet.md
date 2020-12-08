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

1) !Crear otra basada en esa[https://i.stack.imgur.com/8Pdz5.png]

2) Obtener los XML de VIAF con esta expresión GREL

```
"https://viaf.org/viaf/"+cell.recon.match.id+"/viaf.xml"
```

3) Crear otra basada en el XML con la siguiente expresión:

```
value.parseHtml().select('ns1|text')[0].htmlText()
```
