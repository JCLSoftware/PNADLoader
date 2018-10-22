# PNAD Loader

Uma vez atribuidos os parâmetros, basta carregar o arquivo LoadPNAD.R em seu código para que tenha acesso aos dados na variável ´´´R selectedCols ´´´. Veja o exemplo abaixo.

```R
setwd('~/R/PNAD')
sourceData<-'PNADC_012017_20180816.zip'
file.exists(sourceData)
sourceMeta<-'https://raw.githubusercontent.com/JCLSoftware/PNADRegression/master/data/meta.csv'
#VD4020: Renda - rendimento mensal efetivo de todos os trabalhos para os maiores de 14 anos
#V1023: Área censitária é se o domicílio fica na capital, região metropolitana ou em outros lugares do estado
#V1022: Situação censitária é se o domicílio fica na zona urbana ou rural
#V1028: É o peso da pessoa. No caso da PNAD Contínua tem uma variável única de peso da pessoa e peso do domicílio
#V2007: Sexo
#V2009: Idade
#VD3002: Anos de estudo
selectedFields<-c("UF","V2007","V2009","V2010","VD3002","VD4020","V1023","V1022","V1028")
source('https://raw.githubusercontent.com/JCLSoftware/PNADRegression/master/src/LoadPNAD.R')
```

License
This software is licensed under the following terms (GPLv3):

Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use. 

Please cite:
Lara Soares Menezes, Jeancarlo Campos Leão, Eduarda Soares Menezes, Aline Ramalho dos Santos
V Seminário de Iniciação Científica e V Mostra de Trabalhos Científicos do IFNMG, Instituto Federal do Norte de Minas Gerais - IFNMG, Montes Claros/MG, , 2016. Bibtex: http://research.jcloud.net.br/bib/?q=Fatores

# External Links

PNAD datasets: ftp://ftp.ibge.gov.br/Trabalho_e_Rendimento/Pesquisa_Nacional_por_Amostra_de_Domicilios_continua/

