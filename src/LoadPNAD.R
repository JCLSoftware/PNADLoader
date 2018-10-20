source<-'C:/Users/nbwin/Downloads/Dicionario_e_input_20180815/Input_PNADC_trimestral.txt'
tx  <- readLines(source)
tx2  <- gsub(pattern = " $", replace = " ", x = tx, fixed=T)
tx2  <- gsub(pattern = "  ", replace = " ", x = tx2)
tx2  <- gsub(pattern = "  ", replace = " ", x = tx2)
tx2  <- gsub(pattern = "  ", replace = " ", x = tx2)
tx2  <- gsub(pattern = ". ", replace = " ", x = tx2, fixed=T)
#tx2 <- substr(tx2, 1, 100)
#tx2  <- gsub(pattern = "/(.)*/", replace = " ", x = tx2)
tx2
target<-paste(source, '.txt', sep='')
writeLines(tx2, con=target)
config<-read.csv(file=target, sep = ' ', header = F)

pes2018 <- read.fwf(file='C:/Users/nbwin/Downloads/PNADC_012017_20180816/PNADC_012017_20180816.txt', widths=config$V3)
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
pes2018b <- subset(pes2018, select=c("UF","V2007","V2009","V2010","VD3002","VD4020","V1023","V1022","V1028"))
