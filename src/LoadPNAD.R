#LEITURA DA PNAD 2018: 
# Please cite: Lara Soares Menezes, Jeancarlo Campos Leão, Eduarda Soares Menezes, Aline Ramalho dos Santos V Seminário de Iniciação Científica e V Mostra de Trabalhos Científicos do IFNMG, Instituto Federal do Norte de Minas Gerais - IFNMG, Montes Claros/MG, , 2016. Bibtex: http://research.jcloud.net.br/bib/?q=Fatores
#make sure to set correctly your working directory Ex: setwd("~/Projetcs/R/PNADRegression/")
# mostrar até 8 casas decimais options("scipen" = 8) 
#Arquivo de metadados (propriedades dos campos de dados)
#sourceMeta<-'https://raw.githubusercontent.com/JCLSoftware/PNADRegression/master/data/meta.csv'
#target<-paste(source, '.txt', sep='')
sourceMeta<-'https://raw.githubusercontent.com/JCLSoftware/PNADRegression/master/data/meta.zip'
selectedFields<-c("UF","V2007","V2009","V2010","VD3002","VD4020","V1023","V1022","V1028")
source('https://raw.githubusercontent.com/JCLSoftware/PNADLoader/master/src/LoadPNAD.R?a=12333')
##
target<-'metaclear.txt'
#Arquivo de dados
#sourceData<-'data/PNADC_012017_20180816.zip'


readMeta<-function(src){
  tx  <- readLines(src)
  tx2  <- gsub(pattern = " $", replace = " ", x = tx, fixed=T)
  tx2  <- gsub(pattern = "  ", replace = " ", x = tx2)
  tx2  <- gsub(pattern = "  ", replace = " ", x = tx2)
  tx2  <- gsub(pattern = "  ", replace = " ", x = tx2)
  tx2  <- gsub(pattern = ". ", replace = " ", x = tx2, fixed=T)
  tx2
  writeLines(tx2, con=target)
  read.csv(file=target, sep = ' ', header = F)
}
getTxtFromZiped<-function(url){
  getFromZiped(url, '.txt')
}
getFromZiped<-function(url, ext){  
  result<-gsub(pattern = '.zip$', replace = ext, x = (basename(url))) 
  if(!file.exists(result)){
    if(!file.exists(basename(url))){
      tmp<-download.file(url, basename(url), method= "auto", cacheOK = TRUE)
    }
    #write(unz(basename(url), result), result)
    unzip(basename(url))
  }
  return (result)
}
#downloadTxtZiped('https://raw.githubusercontent.com/JCLSoftware/PNADRegression/master/data/meta.zip')
selectFields<-function(srczip, srcmetazip, selectedFields){
      message("Carregando configurações...")
      config<-readMeta(getTxtFromZiped(srcmetazip))
      message("Carregando dados...")
      result <- read.fwf(file=getTxtFromZiped(srczip), widths=config$V3)
      names(result) <-config$V2
      #View(pes2018)
      summary(result) 
      #selectedCols<-read.csv(file = getDataFile())
      message("Selecionando dados...")
      selectedCols <- subset(result, select=selectedFields)      
      #Zip file .csv -> .zip  
      #if(!file.exists(sourceData)){
      #  zip(zipfile = sourceData, files = csvFile)
      #}  
      return (result)
}
buildSelectFieldsCSV<-function(srczip, srcmetazip, selectedFields){
  csvFile<-gsub(pattern = '.zip$', replace = '.csv', x = srczip)
  write.csv(selectFields(srczip, srcmetazip, selectedFields), file=csvFile, row.names = F)
  return (csvFile)
}
getDataFile<-function(){
    if(file.exists(sourceData)){
      f<-unz(sourceData, csvFile)
    }else{
      f<-csvFile
    } 
    return (f)
}
isURL<-function(s){
  grepl("www.|http:|https:", s)
}
isFilePath<-function(fpath){
   return (file.exists(fpath) || isURL(fpath))
}
checkConfig<-function(){
  if(!isFilePath(sourceData)){
     stop(paste("Caminho inválido para arquivo de dados: ", sourceData))
  }
  if(!isFilePath(sourceMeta)){
      stop(paste("Caminho inválido para arquivo de metadados: ", sourceMeta))
  }
  return (T)
}
if(checkConfig()){
  csvFile = gsub(pattern = '.zip$', replace = '.csv', x = sourceData)
  config<-readMeta(sourceMeta)
  selectedCols<-read.csv(file = getDataFile())
}
