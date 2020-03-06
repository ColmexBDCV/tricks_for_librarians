En esta página recolectamos "recetas" de OpenRefine para hacer ciertas tareas.
# 1. Fechas #

## Extraer el año de una frase ##
Si tienes la frase "1 de enero a 7 de noviembre 1914" y quieres obtener sólo el año puedes ir a 'Column->Add column based on this column' en el menú de opciones y usar la siguiente expresión GREL:
```
value.match(/.*?(\d{4}).*?/)[0]
```
