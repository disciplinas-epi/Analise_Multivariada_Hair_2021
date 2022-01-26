#************************************************************
# Análise de agrupamentos (clusters)
# Script adaptado dos vídeos:
# https://www.youtube.com/watch?v=034xoVfBVzU
# https://www.youtube.com/watch?v=BLW0LXjpnek&t=773s
# Discentes: Elizabeth e Isiyara
#*************************************************************

# Descrição: o objetivo da análise de agrupamentos, como o próprio nome sugere,
# é agrupar indivíduos com uma determinada característica em comum. Espera-se que
# haja homogeneidade entre as observações que constituem um grupo e que os grupos
# sejam heterogêneos entre si.


# Para executarmos a análise de agrupamentos, podemos seguir as seuintes etapas:

# 1. Análise das variáveis e dos objetos a serem agrupados;
# 2. Seleção do critério de semelhança;
# 3. Seleção do algoritmo de agrupamento;
# 4. Definição do número de agrupamentos;
# 5. Interpretação e validação dos agrupamentos.

#***********************************
# Descrição do banco de dados:
#***********************************

# Para ilustrar a aplicação da análise de agrupamentos no R usaremos o banco de 
# dados intitulado #FACTBOOK. Esses dados são referentes à pesquisa de Fader e 
# Lodish,intitulada “A Cross-Category Analysis of Category Structure and Promotional 
# Activity for Grocery Products”, publicada em 1990 no “Journal of Marketing”.

# No artigo: Os autores analisam as diferenças entre categorias derivadas de uma 
# fonte de dados da literatura de marketing. Para cada uma das 331 categorias separadas 
# de produtos de mercearia, os autores examinam dois conjuntos de variáveis: um conjunto 
# consistindo de características estruturais de cada categoria e o outro contendo 
# informações detalhadas do movimento promocional. Para cada conjunto de variáveis, 
# uma configuração de cluster separada foi derivada.


#_____________________________

#*** Objetivo do exemplo:*** 

# Analisar se é possível agrupar as categorias de produtos em políticas 
# promocionais diferentes.Apenas utilizaremos os dados promocionais.

#_______________________________

#*** Variáveis ESTRUTURAIS***

# Penetração domiciliar (PENET) : porcentagem de todos os agregados familiares 
# dos dados que fizeram pelo menos uma compra na categoria de produto durante o ano;

# Compras por agregado familiar (PURCH/HH) : número médio de ocasiões de compra 
# (viagens de compras) por categoria no núcleo familiar que fizeram pelo menos uma
# compra durante o ano;

# Ciclo de compra (PCYCLE): tempo médio entre compras (em dias) para famílias que 
# têm pelo menos duas ocasiões de compra na categoria de produto durante o ano;

# Quota de marca própria (PVLSHARE) : quota de mercado combinada (em termos de volume
# vendido) para todas as marcas própria e genéricas na categoria.

# Preço (PRICE) : Gasto médio, em dólares, gasto na categoria por ocasião de compra 
# (não por unidade) na categoria.

#__________________________

# Variáveis PROMOCIONAIS

# Porcentagem do volume vendido (FEAT): volume vendido durante as semanas em que 
# a marca comprada pelos indivíduos foi anunciada no panfleto da loja ou no jornal 
# local, dividida pelo volume total da categoria;

# Porcentagem de volume em exibição (DISP): volume vendido durante as semanas em 
# que a marca comprada recebeu exibição (suporte final) do varejista, dividido pela 
# categoria total;

# Porcentagem de volume com preço promocional (PCUT): volume vendido durante as 
# semanas em que a marca comprada foi vendida com uma redução temporária de preço, 
# dividida pelo volume total da categoria. Um preço promocional foi definido 
# como uma redução do preço de prateleira de pelo menos 5% do preço normal diário, 
# com base em uma média móvel de quatro semanas em cada loja;

# Porcentagem de volume com cupom do fabricante (MCOUP): volume comprado pelos 
# consumidores usando o cupom promocional do fabricante, dividido pelo volume total 
# da categoria. 

# Porcentagem de volume com cupom da loja (SCOUP): volume comprado pelos consumidores
# usando cupom promocional da loja do varejista, dividido pela categoria total;


#****************************************************
# Importação do banco de dados
#****************************************************

# Escolhendo diretório

setwd()

dir()

# Importando o banco de dados

factbook <- read.table("factbook.txt", header = T) 

View(factbook)


#***************************************************************
# 1. Análise das variáveis e dos objetos a serem agrupados
#***************************************************************

# Atribuindo nomes às categorias de produtos (linhas)

fact <-data.frame(factbook[,2:11], row.names = factbook$GROCERY)


# Criando um banco de dados apenas com as variáveis promocionais 


promo <- data.frame(fact[6:10]) ### esse é o banco que utilizaremos

#_______________________________________________________

# Detecção de variáveis atípicas

# Calculando a distância de Mahalonobis 

p.cov <- var(scale(promo)) # padronização das variáveis (coloca as variáveis na mesma escala de medida)
p.cov <- var(promo) # calcula a matriz de covariância
p.mean <- apply(promo,2,mean) # calcula o valor médio de cada coluna (variável)
p.mah <- mahalanobis(promo, p.mean, p.cov) # calcula a distância de mahalanobis

sort(p.mah, decreasing=TRUE) # ordenando as distâncias da maior para a menor

## Vemos valores discrepantes para as categorias de produto CANNED_HA e EGGS
## Iremos removê-las

remover <- c("CANNED_HA", "EGGS")

promo.r <-promo[!(row.names(promo) %in% remover), ] # salvando um novo dataframe

#___________________________________________________

# Analisando a variância

# Variáveis com escalas diferentes e variâncias diferentes podem distorcer 
# a análise

apply(promo.r, 2, var) # 2 representa as colunas - as variáveis

                      # Observou-se que as variâncias de SCOUP e MCOUP são discrepantes
                      # neste caso, o ideal é padronizar as variáveis

# Padronizando as variáveis

promo.p <-scale(promo.r) # função scale para padronizar, criando novo data.frame 


#*************************************************************************
# 2. Seleção da medida de similaridade

# As linhas do banco de dados deve representar as observações (indivíduos,
# categorias de produtos, municípios, etc.) que se deseja agrupar. 
# As colunas deve ser formadas por variáveis. 
#*************************************************************************


# Selecionar o critério de similaridade que determinará quais observações são 
# similares e, portanto, devem ser agrupadas em um dado grupo, e quais não são similares 
# e deveriam estar em grupos diferentes. Para uma medida de similaridade, quanto menor 
# o seu valor mais similar duas observações são.Utilizaremos a distância euclideana.

# Calculando a distância Euclidiana

d.eucl <- dist(promo.p, method = "euclidean")

# Vizualizando a distância euclidiana para as quatro primeiras categorias:

round(as.matrix(d.eucl)[1:4, 1:4],2)


#*******************************************************
# 3. Seleção do método de agrupamento
# Hierárquico x Não hierárquico
#*******************************************************

# Método hierárquico  

?hclust # descrição da função de agrupamento hierárquico
        

res.hc <- hclust(d = d.eucl, method = "ward.D2")

# Legenda: 
# hclust = função do R
# d.eucl = distância euclideana anteriormente calculada
# metodo = "ward.D2" - algoritmo de agrupamento de Ward


# Calculando a correlação cofenética - forma de mensurar quão bem o agrupamento
# reflete os dados.
# Compara as distâncias efetivamente observadas entre os objetos e
# as distâncias previstas a partir do processo de agrupamento.se o agrupamento é 
# válido as correlações devem ser altas.

res.coph <- cophenetic(res.hc)

# Correlação entre a distância cofenética e  a distância original

cor(d.eucl, res.coph) # valor baixo, dessa forma, deve-se procurar outro algotitmo de 
                      # agrupamento


# Comparando com o método da ligação média

hc.m <- hclust(d.eucl, method = "average")

# Correlação entre a distância cofenética e  a distância original

cor(d.eucl, cophenetic(hc.m)) # o valor é maior, neste caso, para esses dados
                              # deve-se preferir o algoritmo de agrupamento 
                              # ligação média.



#**********************************************
# 4. Definição do número de agrupamentos
#**********************************************

# Carregando pacote

library("factoextra")


# Obtendo o dendograma

x11() # abrindo uma nova janela gráfica para visualizar melhor o dendograma

fviz_dend(hc.m, cex = 0.5)  #lembrando que hc.m é o objeto que guarda a análise 
                            # de cluster usando o algoritmo de agrupamento 
                            # ligação média.

# Legenda gráfico:

# No eixo y temos a distância e podemos estabelecer um número de clusters definindo
# um ponto de corte com base nessa informação. O dendograma não é muito útil quando
# possuímos muitas observações (objetos). 

# Pelo dendograma poderíamos ter de três a quatro grupos. 
# No estudo de Fader e Lodish (1990) utilizaram quatro agrupamentos. Sendo que os grupos
# foram classificados como:
# 1. Alta penetração com alta frequência de compras (ovos, leite e pão);
# 2. Alta penetração com baixa frequência de compras (condimentos e papelaria);
# 3. Baixa penetração com alta frequência de compras (ração, cigarros e produtos para bebês);
# 4. Baixa penetração com baixa frequência de compras;

#___________________________________________________

# Alternativa ao dendograma (importantes principalmente quando temos muitas obs)

# Pode-se utilizar alguns indicadores para auxiliar a escolha do número de agrupamentos. 
# Para calcular esses índices iremos utilizar o pacote NbClust

dev.off()  # para voltar a visualizar os gráficos sem abrir a janela gráfica

library("NbClust")
?NbClust

nb <- NbClust(promo.p, distance = "euclidean", min.nc = 2,
              max.nc = 10, method = "average", index = "all")


# Legenda:

# promo.p = é o nosso data.frame sem as observações atípicas e padronizado
# distance = matrix de dissimilaridade utilizada
# min.nc = número mínimo de clusters que eu considero como factível
# max.nc = número máximo de clusters que eu considero como factível
# method = algoritmo de agrupamento utilizado
# index = indiquei all, vai calcular todo índice disponível, mas eu posso 
#         selecionar o índice que desejar (ver opções e interpretação em help)


# O resultado dessa análise mostrou que de acordo com a maioria dos índices 
# o melhor número de clusters é 2.

# Obtendo os indicadores



fviz_nbclust(nb)  # Dertemina e visualiza o número ótimo de clusters usando 
                  # diferentes métodos: within cluster sums of squares, 
                  # average silhouette and gap statistics. Na conclusão diz o
                  # melhor número de clusters. Eixo x= número de clusters,
                  # eixo y = frequência do número ótimo de clusters considerando
                  # as diferentes métricas.Número ótimo de agrupamentos foi 2 ou 4.

nb[["All.index"]] # para mostrar os valores de todos os índices executados pela função



#********************************************************
# 5. Interpretação e validação dos agrupamentos
#********************************************************

# Obtendo os agrupamentos

g <- cutree(hc.m,k=4) 

# Legenda:
# hc.m é o objeto que guarda o método hierárquivo usando o algoritmo "ligação média" 
# k é o número de clusters

#Número de membros em cada agrupamento

table(g)

#Obtendo o nome dos membros nos agrupamento 1,2,3 e 4

rownames(promo.p)[g == 1]
rownames(promo.p)[g == 2]
rownames(promo.p)[g == 3]
rownames(promo.p)[g == 4]

# Podemos visualidar o resultado do agrupamento no dendograma

fviz_dend(hc.m, k = 4, # Cut in four groups
          cex = 0.5, # label size
          k_colors = c("#2E9FDF", "#00BB0C", "#E7B800", "#FC4E07"),
          color_labels_by_k = TRUE, # color labels by groups
          rect = TRUE # Add rectangle around groups
          )

# Calculado a média em cada grupo (para fazer a interpretação com base no valor médio)

# Utilizando uma função para em g cada grupo g em i

# Descrevendo a função

clust.centroid = function(i, dat, g) {
  ind = (g == i)
  colMeans(dat[ind,])
}
# Obtendo a média dos valores padronizados por grupo

sapply(unique(g), clust.centroid, promo.p, g)

mat<- t(as.matrix(sapply(unique(g), clust.centroid, promo.p, g)))

# Obtendo a média dos valores originais (não padronizados) por grupo 

sapply(unique(g), clust.centroid, promo.r, g)

round(sapply(unique(g), clust.centroid, promo.r, g), 1) # podemos observar que o
                        # cluster 1 possui maiores médias para FEAT, DISP e PCUT, a
                        # partir daí é só interpretar.


#*****************************************************************
# Utilizando um método não hierárquico
# Ele pode ser usado tanto para determinar os agrupamentos
# ou após o número de agrupamentos ser identificado por
# meio de método hierárquico (como um segundo estágio da técnica)
#*****************************************************************

# Segundo estágio (Utilização de um método não hierárquico)

# Analisando se 4 é um número adequado de clusters

fviz_nbclust(promo.p, kmeans, method = "wss")+
  geom_vline(xintercept = 4, linetype = 2)  # estou verificando se 4 é um número
                                      # de agrupamentos aceitável usando método não
                                      # hirerárquico (kmeans)


# Legenda:
# promo.p = banco de dados padronizado
# kmeans = método não hierárquico
# eixo y do gráfico = variância
# Interpretação do gráfico: a variância de cada grupo diminui a medida que aumenta
# o número de clusters, contudo há uma ligeira mudança de inclinação a partir de 4
# clusters, o que dá a entender que aumentando o número de clusters para além de 4
# não reduz muito a variância. 4 parece ser um bom número de clusters.

# kmeans(x, centers, iter.max = 10, nstart = 1)
## Definindo uma semente. Isso permite que o resutlado seja 
## reproduzível, já que a semente interfere no resutlado final

set.seed(123) # busca permitir que os resultados sejam reproduzíveis por outras pessoas
              # o método de k médias começa com k centroides selecionados aleatoriamente,
              # definido o valor inicial, permitiremos a replicação dos resultados
              # por pessoas com o mesmo banco (por isso usar set.seed)

km.res <- kmeans(promo.p, 4, nstart = 25) # executando o método não hierárquico
                                        
# Legenda:
# promo.p = banco de dados padronizado e com outliers excluídos
# 4 = número de clusters
# nstart = número de partições aleatórias

print(km.res) # vemos que os 4 clusters tem tamanhos mais distribuídos do que os
              # clusters obtidos com a técnica hierárquica

# Utilizando os valores médios das variáveis em cada grupo
## para o método de k-medias - não entendi essa parte

mat<- t(as.matrix(sapply(unique(g), clust.centroid, promo.p, g)))

km.res2 <- kmeans(promo.p, mat, nstart = 25)

print(km.res2)

#**********************************************
# Interpretação e validação dos agrupamentos
#**********************************************

#Acrescentando a coluna de clusters do k-media nos dados originais

promo.k <- cbind(promo.r, Grupos=km.res$cluster)


# Calculando a média dos grupos para os dados originais

aggregate(promo.r, by=list(cluster=km.res$cluster), mean)

aggregate(promo.r, by=list(cluster=km.res2$cluster), mean)
round(aggregate(promo.r, by=list(cluster=km.res2$cluster), mean),1)

#
fviz_cluster(km.res, data = promo.r,
             palette = c("#2E9FDF", "#00BB0C", "#E7B800", "#FC4E07"),
             ellipse.type = "euclid", # Concentration ellipse
             star.plot = TRUE, # Add segments from centroids to items
             repel = TRUE, # Avoid label overplotting (slow)
             ggtheme = theme_minimal()
            )


library(cluster) # para ver representação bidimensional dos agrupamentos 
                 # não é ideal para um grande número de observações (objetos)

clusplot(promo.p, km.res$cluster, main='Representação bidimensional do agrupamento',
         color=TRUE, shade=TRUE,
         labels=2, lines=0)
