#LEITURA DA PNAD 2018: 
#make sure to set correctly your working directory Ex: setwd("~/Projetcs/R/PNADRegression/")
# mostrar até 8 casas decimais options("scipen" = 8) 
#Arquivo de metadados (propriedades dos campos de dados)
#sourceMeta<-'https://raw.githubusercontent.com/JCLSoftware/PNADRegression/master/data/meta.csv'
#target<-paste(source, '.txt', sep='')
target<-'meta.txt'

buildMeta<-function(src){
  tx  <- readLines(src)
  tx2  <- gsub(pattern = " $", replace = " ", x = tx, fixed=T)
  tx2  <- gsub(pattern = "  ", replace = " ", x = tx2)
  tx2  <- gsub(pattern = "  ", replace = " ", x = tx2)
  tx2  <- gsub(pattern = "  ", replace = " ", x = tx2)
  tx2  <- gsub(pattern = ". ", replace = " ", x = tx2, fixed=T)
  tx2
  writeLines(tx2, con=target)
}
readMeta<-function(){
  read.csv(file=target, sep = ' ', header = F)
}
buildMeta(sourceMeta)
config<-readMeta()
#Arquivo de dados
#sourceData<-'data/PNADC_012017_20180816.zip'
csvFile = gsub(pattern = '.zip$', replace = '.csv', x = sourceData)
if(!file.exists(sourceData)){
  pes2018 <- read.fwf(file=gsub(pattern = '.zip$', replace = '.txt', x = sourceData), widths=config$V3)
  names(pes2018) <-config$V2
  #View(pes2018)
  summary(pes2018) 
  #VD4020: Renda - rendimento mensal efetivo de todos os trabalhos para os maiores de 14 anos
  #V1023: Área censitária é se o domicílio fica na capital, região metropolitana ou em outros lugares do estado
  #V1022: Situação censitária é se o domicílio fica na zona urbana ou rural
  #V1028: É o peso da pessoa. No caso da PNAD Contínua tem uma variável única de peso da pessoa e peso do domicílio
  #V2007: Sexo
  #V2009: Idade
  #VD3002: Anos de estudo
  selectedCols <- subset(pes2018, select=selectedFields)
  write.csv(pes2018b, file=csvFile, row.names = F)
  #Zip file PNADC_012017_20180816.csv -> PNADC_012017_20180816.zip  
  if(!file.exists(sourceData)){
    zip(zipfile = sourceData, files = csvFile)
  }
}
if(file.exists(sourceData)){
  f<-unz(sourceData, csvFile)
}else{
  f<-csvFile
}

selectedCols<-read.csv(file = f)
