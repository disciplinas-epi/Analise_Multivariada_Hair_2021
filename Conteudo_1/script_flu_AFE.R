#########################################################
### Analise da Pesquisa de Adesao a Vacina contra Flu
### Paula Luz, Claudia Codeco, Camila Neves
#########################################################

# ===========================
# ABRINDO o banco do excel 
# ===========================
#install.packages("openxlsx")
library(openxlsx)
library(tidyverse)
library(plyr)
library(epiDisplay)
library(psych)

banco<-read.xlsx("dados/flu_vaccine_red.xlsx")
names(banco)
dim(banco)  # 407 registros


# -----------------------------------------------------------
# DICIONARIO DE VARIAVEIS
# -----------------------------------------------------------
# Parte dos Dados do artigo: Neves et al (2020) Preditores de aceitação da vacina contra 
# influenza: tradução para o português e validação de um questionário
# Cad. Saúde Pública 36 (Suppl 2) • 2020 

# Variaveis sobre vacina:
# vacinou em 2017? Sim, Nao
# Vacinou alguma vez antes de 2017? Sim, Nao
# Pretente vacinar ano que vem? Sim, Nao

# Variaveis do modelo de crenca em saude: esse modelo propoe que existem variaveis 
# latentes (construtos ou fatores) que determinam o comportamento de tomar vacina:
# percepção de susceptibilidade, gravidade da doença, eficácia da vacina,
# barreira para vacinar, entre outros. Essas grandezas nao sao medidas diretamente 
# mas sao captadas por meio de multiplas perguntas (itens) que "sondam" o fator. A analise 
# fatorial ira nos dizer que os itens do questionario realmente medem
# esses fatores. Se sim, entao pessoas que compatilham o mesmo nivel de percepção de
# gravidade ou susceptibilidade, etc, responderao de forma semelhante esses itens,
# criando uma correlacao entre as respostas.

# Modelo: pessoas que percebem maior susceptibilide e menor barreira para vacinar
# tem maior probabilidade de tomar a vacina

# Itens propostos para medir susceptibilidade
# susc1 : Trabalhar com muitas pessoas todo dia aumenta minhas chances de pegar gripe
# susc2 : Apenas pessoas com mais de 60 anos de idade pegam gripe
# susc3 : Eu tenho grande chance de pegar gripe
# susc4 : Pessoas saudáveis podem pegar gripe
# susc5 : Eu acho que minha chance de pegar gripe no futuro próximo é grande
# susc6 : Eu me preocupo muito com a possibilidade de pegar gripe
# susc7 : Eu vou pegar gripe no próximo ano

# barreiras
# barr1: Vacinar-me contra gripe não é fácil para mim
# barr2: Para me vacinar contra gripe, eu precisaria abrir mão de muitas coisas
# barr3: Vacinar-me contra gripe pode ser doloroso
# barr4: Vacinar-me contra gripe dispenderia muito do meu tempo
# barr5: Vacinar-me contra gripe interfere nas minhas atividades diárias
# barr6: Existem muitos riscos associados à vacina da gripe
# barr7: Fico preocupado em ter uma reação à vacina da gripe


# -----------------------------------------------------------
## TRANSFORMANDO A ESCALA DE LIKERT DE NOMINAL PARA NUMERICA
# -----------------------------------------------------------
str(banco)

labels  = c("Concordo totalmente"= 5, "Concordo" = 4, "Não concordo nem discordo" = 3, 
            "Discordo" = 2, 
            "Discordo totalmente" = 1, "Não quero responder" = NA)

## SUSCETIBILIDADE
# quanto mais suscetivel , maior o numero
banco$susc01 <- as.numeric(as.character(revalue(banco$susc01,  labels)))
banco$susc02 <- as.numeric(as.character(revalue(banco$susc02,  labels)))
banco$susc03 <- as.numeric(as.character(revalue(banco$susc03,  labels)))
banco$susc04 <- as.numeric(as.character(revalue(banco$susc04,  labels)))
banco$susc05 <- as.numeric(as.character(revalue(banco$susc05,  labels)))
banco$susc06 <- as.numeric(as.character(revalue(banco$susc06,  labels)))
banco$susc07 <- as.numeric(as.character(revalue(banco$susc07,  labels)))

## BARREIRAS
# quanto maior a barreira, maior o numero
banco$barr01 <- as.numeric(as.character(revalue(banco$barr01,  labels)))
banco$barr02 <- as.numeric(as.character(revalue(banco$barr02,  labels)))
banco$barr03 <- as.numeric(as.character(revalue(banco$barr03,  labels)))
banco$barr04 <- as.numeric(as.character(revalue(banco$barr04,  labels)))
banco$barr05 <- as.numeric(as.character(revalue(banco$barr05,  labels)))
banco$barr06 <- as.numeric(as.character(revalue(banco$barr06,  labels)))
banco$barr07 <- as.numeric(as.character(revalue(banco$barr07,  labels)))
str(banco)

# VISUALIZACAO DOS DADOS
library(fields)
m = as.matrix(banco[,4:17])
image.plot(m,x = 1:407,y=1:15, xlab = "pessoas", ylab="itens", nlevel=5)
title("Mapa de respostas")

# ------------------------------
# ANALISE DE CORRELACAO DO banco
# ------------------------------

# documentacao em http://www.sthda.com/english/wiki/visualize-correlation-matrix-using-correlogram#correlogram-visualizing-the-correlation-matrix
#install.packages("corrplot")
library(corrplot)
# essa opcao retira os NAs
correlation <- cor(banco[,4:17], use = "pairwise.complete.obs")  # ESTAMOS USANDO PEARSON AQUI

##Computing the p-value of correlations
cor.mtest <- function(mat, ...) {
  mat <- as.matrix(mat)
  n <- ncol(mat)
  p.mat<- matrix(NA, n, n)
  diag(p.mat) <- 0
  for (i in 1:(n - 1)) {
    for (j in (i + 1):n) {
      tmp <- cor.test(mat[, i], mat[, j], ...)
      p.mat[i, j] <- p.mat[j, i] <- tmp$p.value
    }
  }
  colnames(p.mat) <- rownames(p.mat) <- colnames(mat)
  p.mat
}

# matrix of the p-value of the correlation
p.mat <- cor.mtest(correlation)

### Matriz de correlacaoo
par(mar=c(4,4,10,4))
corrplot(correlation, 
       p.mat = p.mat, sig.level = 0.01, insig = "blank",tl.col = "black", 
       cl.cex = 0.5,tl.cex=0.5)

biplot(pc)

library(devtools)
#install_github("vqv/ggbiplot")
library(ggbiplot)
g <- ggbiplot(pc,
              obs.scale = 1,
              var.scale = 1,
              groups = as.factor(bancocomp$vacina_2017),
              ellipse = TRUE,
              circle = TRUE,
              ellipse.prob = 0.68)
g <- g + scale_color_discrete(name = '')
g <- g + theme(legend.direction = 'horizontal',
               legend.position = 'top')
print(g)


## ------------------------------------------------------------------------
### PCA 
## ------------------------------------------------------------------------

# removendo dados faltantes
bancocomp <- banco[complete.cases(banco),]  # 392 
                   
pc <- prcomp(bancocomp[,4:17],
             center = TRUE,  
             scale. = TRUE)
screeplot(pc)

summary(pc) # sugere 2 componentes ou fatores, mas cobrem só 42%. 
# dois tbm é o indicado pela teoria

biplot(pc)

## ------------------------------------------------------------------------
### Factor analysis 
## ------------------------------------------------------------------------
#library(psy)


summary(banco)

# https://www.youtube.com/watch?v=Ilf1XR-K3ps
# Usando factanal, needs complete cases
bancocomp <- banco[complete.cases(banco), ]
dim(bancocomp) # perdemos 15 observacoes

resfa <- factanal(x = bancocomp[,4:17], factors = 2, rotation = "varimax")
resfa

# Analise sem a susc02

resfa2 <- factanal(x = bancocomp[,c(4,6:16)], factors = 2, rotation = "varimax")
resfa2



# Grafico das variaveis 


par(mfrow = c(1,1), mar = c(4,4,1,1))
plot(resfa2$loadings[,1], 
     resfa2$loadings[,2],
     xlab = "Factor 1", 
     ylab = "Factor 2", 
     ylim = c(-1,1),
     xlim = c(-1,1))
abline(h = 0, v = 0)

text(resfa2$loadings[,1]-0.08, 
     resfa2$loadings[,2]+0.08,
     colnames(bancocomp[,c(4,6:16)]),
     col="blue")
abline(h = 0, v = 0)


# gerando scores para os individuos (as coordenadas nos dois fatores)

resfa2 <- factanal(x = bancocomp[,c(4,6:16)], factors = 2, rotation = "varimax",
                   scores = "regression")

resfa2$scores

library(ggfortify)


autoplot(resfa2, colour = bancocomp$vacina_2017) 
  
