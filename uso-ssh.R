## acessar e consultar o servidor Infodengue ##
## requer autorização ##

# ssh -f infodengue@info.dengue.mat.br -L 5432:localhost:5432 -nNTC
# 1. Para ver que alertas estao prontos no servidor
system("ssh infodengue@info.dengue.mat.br 'cd alertasRData && ls'")

# 2. Para baixar um desses arquivos

system("scp infodengue@info.dengue.mat.br:/home/infodengue/alertasRData/aleRio-202116.RData .")
system("mv *202116.RData ~/boletins/boletins_markdown/dados")

s# 1. Para copiar o boletim para o info.dengue.at.br/relatorios
# 1. Para copiar o boletim para o info.dengue.at.br/relatorios
# - atribuir o nome conforme esta no info.dengue.at.br/relatorios
# - enviar
#estado
system("scp ~/boletins/boletins_markdown/report/RJ/Estado/ERJ-202116.pdf infodengue@info.dengue.mat.br:/home/infodengue/Relatorio/RJ/Estado/")

#municipio
system("scp ~/boletins/boletins_markdown/report/RS/Municípios/RS-mn-PortoAlegre-202116.pdf infodengue@info.dengue.mat.br:/home/infodengue/Relatorio/RS/Municipios/PortoAlegre/")


# para matar a porta quando congela : lsof -ti:5432 | xargs kill -9
#################################

# 2. Para consultar o banco de dados: 
#   - abrir tunel para o servidor (rodar comando no terminal do sistema operacional) 
# ssh -f infodengue@info.dengue.mat.br -L 5432:localhost:5432 -nNTC  

library(devtools)
library(tidyverse)
library(assertthat)

library(RPostgreSQL)
library(lubridate)
#library(INLA)

#install_github("claudia-codeco/AlertTools")
library(AlertTools)


#con <- dbConnect(drv = dbDriver("PostgreSQL"), dbname = "dengue", 
#                 user = "infodengue_ro", host = "localhost", 
#                 password = "denguezika")

con <- dbConnect(drv = dbDriver("PostgreSQL"), dbname = "dengue", 
                 user = "dengue", host = "localhost", 
                 password = "flavivirus")

# Listar as tabelas disponiveis
dbListTables(con) 


#  *****  Para baixar o banco com as datas dos casos 


comando <- "SELECT municipio_geocodigo, dt_notific, dt_sin_pri, dt_digita 
FROM \"Municipio\".\"Notificacao\" WHERE cid10_codigo = \'A90\' and ano_notif > 2018"
dd <- dbGetQuery(con, comando)

dbDisconnect(con)


# Listar o ultimo dado disponivel no banco
lastDBdate(tab="sinan",cities = 3304557,cid10 = "A90",datasource = con) #casos
lastDBdate(tab="wu",stations = "SBRJ", datasource = con)