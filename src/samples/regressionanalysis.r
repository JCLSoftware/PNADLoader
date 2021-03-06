# Preparo do ambiente
setwd("~/data/")

# Carga e seleção dos dados
source('https://raw.githubusercontent.com/JCLSoftware/PNADLoader/master/src/LoadPNAD.R')
sourceDataSelected<-'https://raw.githubusercontent.com/JCLSoftware/PNADLoader/master/data/PNADC_012017_20180816i.zip'
selectedCols<-readCSVZip(sourceDataSelected)

#renaming the columns
names(selectedCols)<-c("uf","sexo","idade","cor","anoestudo","renda","areacensitaria","situacaocensitaria","pesopes")

#Já foi feito no PNADLoader, não é necessário aqui: selectedColsb <- subset(selectedCols, select=c("uf","sexo","idade","cor","anoestudo","renda","areacensitaria","situacaocensitaria","pesopes"))
#listing states.
selectedCols<-subset(selectedCols, uf>=41 & uf<=43 )
summary(selectedCols)
#remove empty fiels from variables.
selectedCols <- subset(selectedCols, renda!=999999999999 & renda!=0 & cor!=9 &anoestudo!= 17 )
attach(selectedCols)
sexo<-str(sexo)
#creating new indicators manually.
l<-nrow(selectedCols)
sexomasc<-numeric(l)
ehrural<-numeric(l) 
naometropole<- numeric(l) 
preta<- numeric(l) 
amarelo<- numeric(l)
parda<- numeric(l) 
indigena<- numeric(l)
branca<- numeric(l)
for (cont in 1:l) { 
  if (selectedCols$sexo[cont] ==1){ 
    sexomasc[cont] <-1 }
  else { sexomasc[cont]<-0 } } 
for (cont in 1:l) { 
  if (selectedCols$situacaocensitaria[cont]==1){ 
    ehrural[cont] <-0 }else { ehrural[cont]<-1 } } 
for (cont in 1:l) { 
  if (selectedCols$areacensitaria[cont]==1){ 
    naometropole[cont] <-0 }
  else { naometropole[cont]<-1 } }

for (cont in 1:l) { 
if (selectedCols$cor[cont]==2){
preta[cont] <-1 
} 
#Creating the yellow indicator variable for all observations.
if (selectedCols$cor[cont]==3){ 
  amarelo[cont]<-1 }
#Create the brown indicator variable for all observations.
if (selectedCols$cor[cont]==4){ 
  parda[cont]<- 1 } 
if (selectedCols$cor[cont]==5){ 
  indigena[cont]<- 1 }
#Creating for all observations the indicative variable of indigenous color.
if (selectedCols$cor[cont]==0){ branca[cont]<- 1 } }

#Regressão
#Verifica se o pacote "car" está instalado e se não tiver efetua a instalação
list.of.packages <- c("car")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
library("car")
uf <- factor(uf)
lrenda<-log(renda)
summary(lrenda)
modelo1<- lm(lrenda~uf+sexomasc+idade+I(idade^2)+preta+amarelo+parda+indigena+anoestudo+ehrural+naometropole,weights=pesopes)
#Qual a melhor forma de apresentar o sumário no texto? Uma tabela?
summary(modelo1)

residualPlots(modelo1,type="rstudent")
