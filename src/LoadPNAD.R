#LEITURA DA PNAD 2018: 
#make sure to set correctly your working directory Ex: setwd("~/Projetcs/R/PNADRegression/")
# mostrar até 8 casas decimais options("scipen" = 8) 
#Arquivo de metadados (propriedades dos campos de dados)
source<-'https://raw.githubusercontent.com/JCLSoftware/PNADRegression/master/data/meta.csv'
tx  <- readLines(source)
tx2  <- gsub(pattern = " $", replace = " ", x = tx, fixed=T)
tx2  <- gsub(pattern = "  ", replace = " ", x = tx2)
tx2  <- gsub(pattern = "  ", replace = " ", x = tx2)
tx2  <- gsub(pattern = "  ", replace = " ", x = tx2)
tx2  <- gsub(pattern = ". ", replace = " ", x = tx2, fixed=T)
tx2
#target<-paste(source, '.txt', sep='')
target<-'meta.txt'
writeLines(tx2, con=target)
config<-read.csv(file=target, sep = ' ', header = F)
#Arquivo de dados
#sourceData<-'data/PNADC_012017_20180816.zip'
csvFile = gsub(pattern = '.txt$', replace = '.csv$', x = sourceData)
if(!file.exists(sourceData)){
  pes2018 <- read.fwf(file='data/PNADC_012017_20180816/PNADC_012017_20180816.txt', widths=config$V3)
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
  selectedCols <- subset(pes2018, select=c("UF","V2007","V2009","V2010","VD3002","VD4020","V1023","V1022","V1028"))
  write.csv(pes2018b, file=csvFile, row.names = F)
  #Zip file PNADC_012017_20180816.csv -> PNADC_012017_20180816.zip  
  zipFile <- gsub(pattern = '.csv$', replace = '.zip$', x = sourceData)
  if(!file.exists(zipFile)){
    zip(zipfile = zipFile, files = csvFile)
  }
}

selectedCols<-read.csv(file = unz(sourceData, csvFile))
