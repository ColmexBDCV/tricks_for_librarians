#install.packages("VennDiagram")
#install.packages("eulerr")

library(VennDiagram)
library(dplyr)

#getwd()
# set working directory:
#setwd("/home/USER/FOLDER/")
asc = read.csv("asc3.csv", sep=",", header=T, fill=TRUE, encoding = "utf-8", stringsAsFactors=FALSE)
usa = read.csv("usa.csv", sep=",", header=T, fill=TRUE, encoding = "utf-8", stringsAsFactors=FALSE)
paa = read.csv("paa.csv", sep=",", header=T, fill=TRUE, encoding = "utf-8", stringsAsFactors=FALSE)

#View(paa)

asc_pub <- c(asc$Publication.Name)
usa_pub <- c(usa$Publication.Name)
paa_pub <- c(paa$Publication.Name)

length(asc_pub) # 16,971
length(usa_pub) # 218
length(paa_pub) # 215

en_usa_no_asc <- setdiff(usa_pub, asc_pub)
length(en_usa_no_asc) #106
en_asc_y_usa <- intersect(usa_pub, asc_pub)
en_asc_y_usa #112

en_paa_no_asc <- setdiff(paa_pub, asc_pub)
length(en_paa_no_asc) #103
en_asc_y_paa <- intersect(paa_pub, asc_pub)
en_asc_y_paa #112

maxlen = max(length(en_paa_no_asc), length(en_usa_no_asc))

paa_no_asc = c(en_paa_no_asc, rep(NA, maxlen - length(en_paa_no_asc)))
usa_no_asc = c(en_usa_no_asc, rep(NA, maxlen - length(en_usa_no_asc)))
fuera_de_asc <- data.frame(paa_no_asc, usa_no_asc)
View(fuera_de_asc)



#Intersecciones entre USA y PAA que no están en ASC
en_usa_y_paa_no_asc <- intersect(en_usa_no_asc, en_paa_no_asc)
en_usa_y_paa_no_asc #28


#Intersecciones entre USA, PAA y ASC
en_asc_paa_usa <- intersect(intersect(usa_pub,paa_pub),asc_pub)
en_asc_paa_usa #23


en_paa_no_usa <- setdiff(en_paa_no_asc, en_usa_no_asc)
en_paa_no_usa #75
en_usa_no_paa <- setdiff(en_usa_no_asc, en_paa_no_asc)
en_usa_no_paa #78


library(eulerr)
fit2 <- euler(c(A = 16770, B = 167, C = 164, 
                "A&B" = 89, "A&C" = 89, "B&C"= 28,"A&B&C" = 23))
plot(fit2,
     fill = c("#F2CBFF", "#B3E9F9", "#B3E9BB"),
     border = "transparent",
     fontsize = 8,
     counts = list(fontsize = 8),
     labels = c("ASC", "PAA", "USA"))

?plot

write.csv(fuera_de_asc, file="fuera_de_asc.csv", row.names = FALSE)
en_paa_no_asc

en_ascft_y_hicft <- intersect(hic_ft_pub, asc_ft_pub)
length(en_ascft_y_hicft) #468

View(asc)
hic_pub <- c(hic$Publication.Name)
asc_pub <- c(asc$Publication.Name)

en_hic_no_asc <- setdiff(hic_pub, asc_pub)
length(en_hic_no_asc) #1850

en_asc_y_hic <- intersect(hic_pub, asc_pub)
length(en_asc_y_hic) #1031

length(asc$endftyear)


View(table(hic$startftyear))

View(table(unique(asc$Publication.Name)))
length(unique(asc$Publication.Name)) #16,971
length(hic$Publication.Name) #2882

#8968 (52%) con texto completo en asc
#1829 (64%) con texto completo en hic
