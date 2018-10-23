#LEITURA DA PNAD: 
# Please cite: Lara Soares Menezes, Jeancarlo Campos Leão, Eduarda Soares Menezes, Aline Ramalho dos Santos V Seminário de Iniciação Científica e V Mostra de Trabalhos Científicos do IFNMG, Instituto Federal do Norte de Minas Gerais - IFNMG, Montes Claros/MG, , 2016. Bibtex: http://research.jcloud.net.br/bib/?q=Fatores

#make sure to set correctly your working directory Ex: setwd("~/Projetcs/R/PNADRegression/")
# mostrar até 8 casas decimais options("scipen" = 8) 

# Import this code: source('https://raw.githubusercontent.com/JCLSoftware/PNADLoader/master/src/LoadPNAD.R')


#Nome do arquivo temporário de configuração
target<-'metaclear.txt'


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
      message("Selecionando dados...")
      selectedCols <- subset(result, select=selectedFields)      
      return (selectedCols)
}
newExt<-function(from, to, name){
  gsub(pattern = from, replace = to, x = name)
}
buildSelectFieldsCSV<-function(srczip, srcmetazip, selectedFields, force=F){
  csvFile<-newExt('.zip$', '.csv', basename(srczip))
  write.csv(selectFields(srczip, srcmetazip, selectedFields), file=csvFile, row.names = F)
  #Zip file .csv -> .zip  
  csvFileZiped<-newExt('.csv$', '.zip', csvFile)
  if(!file.exists(csvFileZiped || force)){
    zip(zipfile = csvFileZiped, files = csvFile)
  }
  return (csvFile)
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
readCSVZip<-function(srcZip){
  srcZFile<-basename(srcZip)
  csvFile = newExt('.zip$', '.csv', srcZFile)
  read.csv(file = unz(srcZFile, csvFile))
}
