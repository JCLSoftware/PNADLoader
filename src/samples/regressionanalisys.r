´´´R 
# Make sure to set correctly your working directory Ex: `setwd("~/data/")`.
setwd("~/data/")
´´´
source('https://raw.githubusercontent.com/JCLSoftware/PNADLoader/master/src/LoadPNAD.R')
sourceDataSelected<-'https://raw.githubusercontent.com/JCLSoftware/PNADLoader/master/data/PNADC_012017_20180816i.zip'
selectedCols<-readCSVZip(sourceDataSelected)
´´´R
#renaming the columns
names(selectedCols)<-c("uf","sexo","idade","cor","anoestudo","renda","areacensitaria","situacaocensitaria","pesopes")
´´´
selectedColsb <- subset(selectedCols, select=c("uf","sexo","idade","cor","anoestudo","renda","areacensitaria","situacaocensitaria","pesopes"))
selectedColsc<-subset(selectedColsb, uf>=31 & uf<=35 )

rm(selectedCols,selectedColsb)
summary(selectedColsc)
selectedColsd <- subset(selectedColsc, renda!=999999999999 & renda!=0 & cor!=9 &anoestudo!= 17 )
attach(selectedColsd)
str(sexo)
sexomasc<-numeric(62260)
ehrural<-numeric(62260) 
naometropole<- numeric(62260) 
preta<- numeric(62260) 
amarelo<- numeric(62260)
parda<- numeric(62260) 
indigena<- numeric(62260)
for (cont in 1:62260) { 
  if (selectedColsd$sexo[cont] ==2){ 
    sexomasc[cont] <-1 }
  else { sexomasc[cont]<-0 } } 
for (cont in 1:62260) { 
  if (selectedColsd$situacaocensitaria[cont]>=1 & selectedColsd$situacaocensitaria[cont]<=3 ){ 
    ehrural[cont] <-0 }else { ehrural[cont]<-1 } } 
for (cont in 1:62260) { 
  if (selectedColsd$areacensitaria[cont]==1){ 
    naometropole[cont] <-0 }
  else { naometropole[cont]<-1 } }
if (selectedColsd$cor[cont]==6){ 
  amarelo[cont]<-1 }
if (selectedColsd$cor[cont]==8){ 
  parda[cont]<- 1 } 
if (selectedColsd$cor[cont]==0){ indigena[cont]<- 1 } } 

lrenda<-log(renda)
summary(lrenda)
modelo1<- lm(lrenda~uf+sexomasc+idade+preta+amarelo+parda+indigena+anoestudo+ehrural+naometropole,weights=pesopes)
summary(modelo1)

residualPlots(modelo1,type="rstudent")
