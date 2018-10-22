#LEITURA DA PNAD 2018: 
#make sure to set correctly your working directory Ex: setwd("~/Projetcs/R/PNADRegression/")
# mostrar até 8 casas decimais options("scipen" = 8) 
#Arquivo de metadados (propriedades dos campos de dados)
#sourceMeta<-'https://raw.githubusercontent.com/JCLSoftware/PNADRegression/master/data/meta.csv'
#target<-paste(source, '.txt', sep='')
target<-'meta.txt'
#Arquivo de dados
#sourceData<-'data/PNADC_012017_20180816.zip'


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
getDataFile<-function(){
    #Tenta ler o arquivo de dados descompactado
    if(!file.exists(sourceData)){
      pes2018 <- read.fwf(file=gsub(pattern = '.zip$', replace = '.txt', x = sourceData), widths=config$V3)
      names(pes2018) <-config$V2
      #View(pes2018)
      summary(pes2018) 
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
    return (f)
}
checkConfig<-function(){
  if(!file.exists(sourceData)){
    stop(paste("Arquivo de dados não encontrado: ", sourceData))
  }
  return (True)
}
if(checkConfig()){
  csvFile = gsub(pattern = '.zip$', replace = '.csv', x = sourceData)

  buildMeta(sourceMeta)
  config<-readMeta()
  selectedCols<-read.csv(file = getDataFile())
}
