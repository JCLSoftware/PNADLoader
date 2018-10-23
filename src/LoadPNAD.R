#LEITURA DA PNAD 2018: 
# Please cite: Lara Soares Menezes, Jeancarlo Campos Leão, Eduarda Soares Menezes, Aline Ramalho dos Santos V Seminário de Iniciação Científica e V Mostra de Trabalhos Científicos do IFNMG, Instituto Federal do Norte de Minas Gerais - IFNMG, Montes Claros/MG, , 2016. Bibtex: http://research.jcloud.net.br/bib/?q=Fatores
#make sure to set correctly your working directory Ex: setwd("~/Projetcs/R/PNADRegression/")
# mostrar até 8 casas decimais options("scipen" = 8) 
#Arquivo de metadados (propriedades dos campos de dados)
#sourceMeta<-'https://raw.githubusercontent.com/JCLSoftware/PNADRegression/master/data/meta.csv'
#target<-paste(source, '.txt', sep='')
target<-'meta.txt'
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
selectFields<-function(srczip, selectedFields){
      result <- read.fwf(file=unz(srczip, gsub(pattern = '.zip$', replace = '.txt', x = basename(srczip)), widths=config$V3))
      names(result) <-config$V2
      #View(pes2018)
      summary(result) 
      selectedCols <- subset(result, select=selectedFields)
      #write.csv(pes2018b, file=csvFile, row.names = F)
      #Zip file .csv -> .zip  
      #if(!file.exists(sourceData)){
      #  zip(zipfile = sourceData, files = csvFile)
      #}  
      return (result)
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
