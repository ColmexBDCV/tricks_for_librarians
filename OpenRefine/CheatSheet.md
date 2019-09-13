This page collects OpenRefine recipes, small workflows and code fragments that show you how to achieve specific things with OpenRefine.

# 1. Dates #

## Extract year from a string ##
Say you have a string like the following: 1 de enero a 7 de noviembre 1914 and you want to get only the year: you need to use the 'Column->Add column based on this column' menu option.
And use the GREL:
```
value.match(/.*?(\d{4}).*?/)[0]
```
