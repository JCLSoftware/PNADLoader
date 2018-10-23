setwd('~/R/PNAD')
sourceData<-'https://github.com/JCLSoftware/PNADLoader/raw/master/data/PNADC_012017_20180816.zip'
sourceMeta<-'https://raw.githubusercontent.com/JCLSoftware/PNADRegression/master/data/meta.csv'
selectedFields<-c("UF","V2007","V2009","V2010","VD3002","VD4020","V1023","V1022","V1028")
source('https://raw.githubusercontent.com/JCLSoftware/PNADRegression/master/src/LoadPNAD.R?')
