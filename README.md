# PNAD Loader

O PNAD Loader possui funções que facilitam trabalhar com os dados da PNAD do IBGE. Basta carregar o arquivo `LoadPNAD.R` em seu código para que tenha acesso à API que permite extraír os dados`selectedCols`. Veja os exemplos que seguem.

```R
# LEITURA DA PNAD: 
## Please cite: Lara Soares Menezes, Jeancarlo Campos Leão, Eduarda Soares Menezes, Aline Ramalho dos Santos V Seminário de Iniciação Científica e V Mostra de Trabalhos Científicos do IFNMG, Instituto Federal do Norte de Minas Gerais - IFNMG, Montes Claros/MG, , 2016. Bibtex: http://research.jcloud.net.br/bib/?q=Fatores

setwd("~/Projetcs/R/PNADRegression/")

#Importa o código do PNADLoader
source('https://raw.githubusercontent.com/JCLSoftware/PNADLoader/master/src/LoadPNAD.R')

# Exemplo 1:
## criar arquivo csv compactado com variáveis de interesse
sourceData<-'http://servicodados.ibge.gov.br/Download/Download.ashx?u=ftp.ibge.gov.br/Trabalho_e_Rendimento/Pesquisa_Nacional_por_Amostra_de_Domicilios_continua/Trimestral/Microdados/2017/PNADC_012017_20180816.zip'
## Arquivo de metadados (propriedades dos campos de dados)
sourceMeta<-'https://raw.githubusercontent.com/JCLSoftware/PNADRegression/master/data/meta.zip'
## Campos selecionados
#VD4020: Renda - rendimento mensal efetivo de todos os trabalhos para os maiores de 14 anos
#V1023: Área censitária é se o domicílio fica na capital, região metropolitana ou em outros lugares do estado
#V1022: Situação censitária é se o domicílio fica na zona urbana ou rural
#V1028: É o peso da pessoa. No caso da PNAD Contínua tem uma variável única de peso da pessoa e peso do domicílio
#V2007: Sexo
#V2009: Idade
#VD3002: Anos de estudo
selectedFields<-c("UF","V2007","V2009","V2010","VD3002","VD4020","V1023","V1022","V1028")
buildSelectFieldsCSV(sourceData, sourceMeta, selectedFields)

# Exemplo 2:
## Lê o arquivo CSV com as variáveis de interesse
sourceDataSelected<-'https://raw.githubusercontent.com/JCLSoftware/PNADLoader/master/data/PNADC_012017_20180816i.zip'
selectedCols<-readCSVZip(sourceDataSelected)
```
Make sure to set correctly your working directory Ex: `setwd("~/data/")`.

Observe que os arquivos contendo os dados de entrada devem ser especificados nos parâmetros `sourceData` e `sourceMeta`. Você pode utilizar os dados com alguns campos específicos como os que disponibilizamos aqui. Ou, se desejar ler os dados com todos os campos originais a partir de um conjunto de dados obtido do repositório do IBGE, é preciso informar também quais campos deseja selecionar. Para isso, atribua à variável `selectedFields` uma lista com os nomes dos campos conforme documentação de layout do IBGE.

# License

This software is licensed under the following terms (GPLv3):

Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use. 

## Please cite:

Lara Soares Menezes, Jeancarlo Campos Leão, Eduarda Soares Menezes, Aline Ramalho dos Santos
V Seminário de Iniciação Científica e V Mostra de Trabalhos Científicos do IFNMG, Instituto Federal do Norte de Minas Gerais - IFNMG, Montes Claros/MG, , 2016. Bibtex: http://research.jcloud.net.br/bib/?q=Fatores

# External Links

PNAD datasets: ftp://ftp.ibge.gov.br/Trabalho_e_Rendimento/Pesquisa_Nacional_por_Amostra_de_Domicilios_continua/
