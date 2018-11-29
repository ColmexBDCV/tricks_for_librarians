getwd()
#install.packages("lubridate")
library(plyr)
library(tidyr)
library(dplyr)
library(lubridate)

#1) Definir la ruta 
setwd("C:/Users/XXX/XXX/XXXX/2017_03_24_consultas")

#archivos = list.files(path)

#2) Leer el ics y crear df
#?readLines
#Aquí se escribe el nombre de tu archivo ICS (más información de cómo exportar tu calendario de Google en: https://support.google.com/calendar/answer/37111?hl=en)
x <- readLines("duda.ics", warn = FALSE, encoding = "UTF-8")
keyval <- do.call(rbind, regmatches(x, regexpr(":", x, fixed = TRUE), invert = TRUE))
keyval <- keyval[which.max(keyval[,1]=="BEGIN" & keyval[,2]=="VEVENT"):tail(which(keyval[,1]=="END" & keyval[,2]=="VEVENT"), 1),]
keyval <- cbind.data.frame(keyval, id=cumsum(keyval[,1]=="BEGIN" & keyval[,2]=="VEVENT"))
df <- reshape(keyval, timevar="1", idvar="id", direction = "wide")
View(df)

#3) Subset del df con sólo fecha y evento

fecha_evento <- df[,c(7,13)]
View(fecha_evento)

#4) Extraer fecha en un formato de tipo YYYYMMDD
d <- plyr::rename(fecha_evento, c("2.CREATED"="created", "2.SUMMARY"="event"))
d$datestring <- substring(d$created,1,8)

#5) Dar formato de fecha

#library("lubridate")
d$date <- as.Date(d$datestring, "%Y%m%d")
consultas <- d[,c(2,4)]
#View(consultas)
cons <- separate(consultas, event, c("procedencia", "nombre"), "_", fill="left")
#View(cons$date)

#6) Definir periodo que quieres reportar
feb_nov <- filter(cons, between(date, as.Date("2018-01-01"), as.Date("2018-11-30")))
?month

feb_nov$mes = month(feb_nov$date)
View(feb_nov)

write.csv(feb_nov,"2018_febnov.csv", row.names = FALSE)

febnovmes <- data.frame(table(feb_nov$mes))
febnovproc <- data.frame(table(feb_nov$procedencia))

write.csv(febnovproc,"2018_febnovproc.csv", row.names = FALSE)

View(febnovproc)
colnames(febnovmes) <- c("mes", "no_consultas")
sum(febnovmes$no_consultas)


#Abril Septiembre
abr_sep <- filter(cons, between(date, as.Date("2017-04-01"), as.Date("2017-09-30")))
abr_sep$mes = month(abr_sepp$date)
abrsepfreq <- data.frame(table(abr_sep$mes))
abrsepproc <- data.frame(table(abr_sep$procedencia))
View(abrsepproc)
abrsepprocdist = length(abrsepproc$Var1)
abrseptotal = sum(abrsepfreq$no_consultas)
abrsepprocdist / abrseptotal
colnames(abrsepfreq) <- c("mes", "no_consultas")

#Enero Septiembre
ene_sep <- filter(cons, between(date, as.Date("2017-01-01"), as.Date("2017-09-30")))
ene_sep$mes = month(ene_sep$date)
enesepfreq <- data.frame(table(ene_sep$mes))
enesepproc <- data.frame(table(ene_sep$procedencia))
View(enesepfreq)
View(enesepproc)
enesepprocdist = length(enesepproc$Var1)
eneseptotal = sum(enesepfreq$no_consultas)
enesepprocdist / eneseptotal
