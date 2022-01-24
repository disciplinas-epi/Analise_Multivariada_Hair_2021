# Disciplina de Estudo Dirigido de Análise Multivariada

## Introdução

A disciplina de estudo dirigido de análise multivariada teve como livro base *Hair et al. (2009), Análise Multivariada de Dados*, mas outras fontes também foram utilizadas como material de apoio.

A proposta desse repositório é organizar e disponibilizar todo o material gerado ao longo da disciplina que foi ministrada no segundo semestre de 2021 pelo Programa de Pós-Graduação em Epidemiologia em Saúde Pública, ENSP/Fiocruz.

**Autores**: alunos e professoras do PPG Epidemiologia em Saúde Pública, ENSP/Fiocruz.

Bem vindos ao conteúdo da disciplina de estudo dirigido de **Analise Multivariada** edição 2021 (Hair et al. 2009)!

Nesta página apresentamos e indicamos onde encontrar o material organizado durante a disciplina. Esperamos que seja um conteúdo útil para quem deseja se aventurar no mundo da análise multivariada. Nem todas as análises foram abordadas ao longo da disciplina, afinal, são muitos os tipos de análises. Demos preferência as técnicas de interdependência, uma vez que técnicas que envolvem dependência, já são abordadas em outras disciplinas. Apenas Análise Discriminante Múltipla foi tratada dentre as técnicas de dependência.

### Conteúdo 0: Introdução e Exame de seus dados

Nesta sessão apresentamos o conteúdo teórico final do capítulo introdutório, em que é descrito, de forma genérica, o passo-a-passo de uma análise multivariada. Também abordamos o conteúdo do capítulo 2, intitulado "Exame de seus Dados". Você pode iniciar seus estudos acessando os slides "0 Introdução + Exame de seus dados" (<https://github.com/disciplinas-epi/Analise_Multivariada_Hair_2021/blob/main/0%20Introdu%C3%A7%C3%A3o%20%2B%20Exame%20de%20seus%20dados.pdf>) e a [vídeo-aula](???).

#### Os passos da análise multivariada

Compreender o tratamento em seis etapas para a construção de modelo multivariado. O processo de seis etapas para a construção de modelo fornece uma estrutura para desenvolver, interpretar e validar qualquer análise multivariada.

1. Definir o problema de pesquisa, os objetivos e a técnica multivariada a ser usada.
Elaborar um modelo conceitual com as representações das relações a serem estudadas, não precisa ser complexo e detalhado.

2. Desenvolver o plano de análise.
Para cada técnica, o pesquisador deve desenvolver um plano de análise que aborde as questões particulares a seu propósito e projeto., como tamanho mínimo de amostra, tipos de variáveis e métodos de estimação.

3. Avaliar as suposições.
Todas as técnicas multivariadas têm suposições inerentes, tanto estatísticas quanto conceituais, que influenciam muito suas habilidades para representar relações multivariadas.
4. Estimar o modelo multivariado e avaliar o ajuste.
A análise inicia a real estimação do modelo multivariado e uma avaliação do ajuste geral do modelo. No processo de estimação, o pesquisador pode escolher entre opções para atender características específicas dos dados ou maximizar o ajuste dos dados.

5. Interpretar as variáveis estatísticas.
A interpretação de efeitos para variáveis individuais é feita examinando-se os coeficientes estimados (pesos) para cada variável na variável estatística.

6. Validar o modelo multivariado.
As tentativas de validar o modelo são direcionadas no sentido de demonstrar a generalidade dos resultados para a população total.

#### Gráficos

#### Dados perdidos

Nesta subseção abordamos os erros na coleta e entrada de dados que resultam em dados perdidos, os tipos de dados perdidos e por que geram problemas para a análise. Por meio de uma série de passos, identificamos seus impactos e possíveis soluções para lidar com esse inconveniente.

#### Outliers

Nesta subseção conceituamos "outliers" e apresentamos formas de detecção univariada, bivariada e multivariada. 

#### Pressupostos

### Conteúdo 1: Análise de Componentes Principais (PCA) e Análise Fatorial

A **análise fatorial** e a **análise de componentes principais (PCA)** são técnicas de interdependência com objetivo de *"definir a estrutura inerente entre as variáveis"* (Hair et al., 2009). No capítulo 3 do livro de Hair *et al.* (2009), os autores dão ênfase a esses dois métodos de análise exploratória e apresentam também um passo a passo com 7 estágios dessas análises. Nós preparamos uma [apresentação](Conteudo_1/analise_fatorial_apresentacao.pdf) e um [resumo](Conteudo_1/resumo_Analise_Fatorial.pdf) desse capítulo.

Como a **PCA** é uma técnica muito utilizada, inclusive como base para outras análises multivariadas, esse conteúdo foi aprofundado em mais duas aulas, além da aula que utilizou o capítulo de Hair *et al*. (2009) como base. Você pode assistir a [vídeo-aula](https://www.youtube.com/watch?v=yQkT70lXwT4) e a [apresentação do conteúdo teórico](Conteudo_1/ACP_pardais.pdf), bem como a [apresentação](Conteudo_1/analise_fatorial_exploratoria.pdf) e o [script](Conteudo_1/script_flu_AFE.R) da aula prática, ministradas pelas Professoras \@claudia-codeco e \@raquelana.

### Conteúdo 2: Análise de agrupamentos

A **análise de agrupamentos** é uma técnica de interdependência que pode ser utilizada quando o objetivo é formar grupos de objetos (pessoas, produtos, entre outros) com características semelhantes entre si. No capítulo 8 do livro de Hair *et al.* (2009), os autores apresentam informações mais detalhadas sobre esta técnica. Após a leitura deste  capítulo, você pode acessar a [apresentação de slides](Conteudo_2/analise_agrupamento_parte1.pdf) e a [vídeo-aula](https://youtu.be/tFoW5vs4mOM). Para praticar no R os métodos de agrupamento hierárquicos, acesse o [script](Conteudo_2/analise_agrupamento_hierarquico.R) e baixe o banco de dados [factbook](Conteudo_2/factbook.txt).

### Conteúdo 3: Análise Discriminante Múltipla

A **análise discriminante múltipla** é uma técnica multivariada aplicável quando a variável dependente é dicotômica ou multicotômica. Seu principal objetivo é entender as diferenças entre os grupos analisados e observar se um objeto do estudo pertence realmente ao grupo prévio selecionado, baseando-se em diversas variáveis independentes métricas (Hair *et al.*, 2009). No capítulo 5 intitulado "Análise Discriminante Múltipla e Regressão Logística" do livro de Hair *et al.* (2009), os autores descrevem esse método e sua relação com a regressão logística. Você pode iniciar seus estudos sobre a técnica acessando o [pdf do conteúdo](https://github.com/disciplinas-epi/Analise_Multivariada_Hair_2021/blob/main/Conteudo_3/AN%C3%81LISE%20DE%20DISCRIMINANTE.pdf) e para aplicá-la aos seus dados no software R, acesse o [script](https://github.com/disciplinas-epi/Analise_Multivariada_Hair_2021/blob/main/Conteudo_3/An%C3%A1lise_discriminante.Rmd).

### Conteúdo 4: Escalonamento multidimensional

### Conteúdo 5: Análise de correspondência

Nesta sessão apresentamos o conteúdo teórico da segunda metade do capítulo 9 intitulado "Análise de correspondência". Você pode iniciar seus estudos acessando os slides "xxx" e a [vídeo-aula](https://www.youtube.com/watch?v=3aj2Tsc2Rns). Para praticar a análise de correspondência no R, acesse o script [xxx](xxx%20no%20git). O banco de dados utilizado está integrado ao R e foi carregado internamente ao script.
