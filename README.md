# PNAD Loader

The PNADLoader has features that facilitate working with data from the IBGE National Household Survey (PNAD). Simply load the `LoadPNAD.R` file into your code so you have access to the API that allows you to extract the data. See the examples that follow.

```R
# Make sure to set correctly your working directory Ex: `setwd("~/data/")`.
setwd("~/data/")
```

## LEITURA DA PNAD:

```R
 
## Please cite:  Um Arcabouço para Integração de Microdados da Pesquisa Nacional por Amostra de Domicílios: Aplicação na Análise dos Fatores de Influência sobre a Renda do Trabalho na Região Sul do Brasil,
Lara Soares Menezes, Jeancarlo Campos Leão, Eduarda Soares Menezes, Aline Ramalho dos Santos, et al.
Anais dos Simpόsios de Informática do IFNMG-Campus Januária, 10, 6, 11, 2018. Avaliable on http://research.jcloud.net.br/bib/?q=Fatores

#Importa o código do PNADLoader
source('https://raw.githubusercontent.com/JCLSoftware/PNADLoader/master/src/LoadPNAD.R')

```
Once the PNADLoader has been imported, you can use codes like those shown below.

### Sample 1: create compressed csv file with variables of interest
```R
sourceData<-'http://servicodados.ibge.gov.br/Download/Download.ashx?u=ftp.ibge.gov.br/Trabalho_e_Rendimento/Pesquisa_Nacional_por_Amostra_de_Domicilios_continua/Trimestral/Microdados/2017/PNADC_012017_20180816.zip'
## Metadata file (properties of data fields)
sourceMeta<-'https://raw.githubusercontent.com/JCLSoftware/PNADRegression/master/data/meta.zip'
## Selected fields
selectedFields<-c("UF","V2007","V2009","V2010","VD3002","VD4020","V1023","V1022","V1028")
buildSelectFieldsCSV(sourceData, sourceMeta, selectedFields)

```
Note that the files containing the input data must be specified in the `sourceData` and` sourceMeta` parameters. To read the data with all the original fields from a set of data obtained from the IBGE repository. Then enter which fields you want to select (interest variables). To do this, assign the `selectedFields` variable a list of field names according to the IBGE layout documentation. Note that the fields used in this example were:

```R
#VD4020: Income - effective monthly income of all jobs for those over 14 years of age
#V1023: Census area is if the domicile is in the capital, metropolitan region or elsewhere in the state
#V1022: Census situation is whether the household is in the urban or rural area
#V1028: The person's weight. In the case of the Continuous PNAD has a unique variable of weight of the person and weight of the domicile
#V2007: Gender
#V2009: Age
#V2010: Skin color or race
#VD3002: Years of study
```
### Exemplo 2: reads the CSV file with the variables of interest
Once generated the file with the variables of interest (see Example 01), it is possible to read this archive. You can use the data to some specific fields such as those available in the url stored in `sourceDataSelected '.
```R
sourceDataSelected<-'https://raw.githubusercontent.com/JCLSoftware/PNADLoader/master/data/PNADC_012017_20180816i.zip'
selectedCols<-readCSVZip(sourceDataSelected)
```

# License

This software is licensed under the following terms (GPLv3):

Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use. 

## Please cite:

Please cite:  Um Arcabouço para Integração de Microdados da Pesquisa Nacional por Amostra de Domicílios: Aplicação na Análise dos Fatores de Influência sobre a Renda do Trabalho na Região Sul do Brasil,
Lara Soares Menezes, Jeancarlo Campos Leão, Eduarda Soares Menezes, Aline Ramalho dos Santos, et al.
Anais dos Simpόsios de Informática do IFNMG-Campus Januária, 10, 6, 11, 2018. Avaliable on http://research.jcloud.net.br/bib/?q=Fatores
[a link](https://github.com/user/repo/blob/branch/other_file.md)

# External References
Tabela de Código de UF do IBGE: http://www.lgncontabil.com.br/icms/Tabela-Codigo-de-UF-do-IBGE.pdf
PNAD datasets: ftp://ftp.ibge.gov.br/Trabalho_e_Rendimento/Pesquisa_Nacional_por_Amostra_de_Domicilios_continua/
