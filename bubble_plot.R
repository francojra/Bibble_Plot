
# Gráficos de Bolhas - Bubble Plot ---------------------------------------------------------------------------------------------------------
# Autora do script: Jeanne Franco ----------------------------------------------------------------------------------------------------------
# Data: 03/10/23 ---------------------------------------------------------------------------------------------------------------------------
# Referência: https://r-graph-gallery.com/bubble-chart.html --------------------------------------------------------------------------------

# Introdução -------------------------------------------------------------------------------------------------------------------------------

### Um gráfico de bolhas é um gráfico de dispersão com uma terceira variável que é
### mapeada através do tamanho de círculos. Essa postagem descreve vários métodos
### para construir um gráfico de bolhas.

# Passo a passo com ggplot2 ----------------------------------------------------------------------------------------------------------------

### O pacote ggplot2 permite criar um gráfico de bolhas usando a função geom_point().
### Os próximos exemplos irão mostrar o passo a passo.

### Essa postagem explica como construir um gráfico de bolhas com R e ggplot2.
### Ele promove vários exemplos reprodutíveis com a explicação dos códigos em R.

# O mais básico gráfico de bolhas ----------------------------------------------------------------------------------------------------------

### O gráfico de bolhas é um gráfico de dispersão onde uma terceira dimensão é
### adicionada: o valor de uma variável numérica adicional é representado através
### do tamanho dos pontos.

### Com o ggplot2, os gráficos de bolhas são construídos graças a função geom_point().
### No mínimo três variáveis deverão ser providas para o aesthetic aes(): x, y e size.
### A legenda irá ser automaticamente construída pelo ggplot2.

### Aqui, a relação entre expectativa de vida Y e renda per capita X de vários países
### do mundo é representada. A população dos países é representada pelo círculo cinza.

### Pacotes

library(ggplot2)
library(dplyr)

### Carregar dataset provido pelo pacote gapminder

library(gapminder)

data <- gapminder %>% 
  filter(year == "2007") %>% 
  dplyr::select(-year)
View(data)

### Gráfico

ggplot(data, aes(x = gdpPercap, y = lifeExp, size = pop)) +
    geom_point(alpha = 0.7)




