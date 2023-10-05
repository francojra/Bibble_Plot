
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

# Controlar o tamanho do círculo com scale_size() ------------------------------------------------------------------------------------------

### A função scale_size premite estabelecer o tamanho dos menores e maiores círculos
### usando o agurmnto range. Note que você pode customizar o nome da legenda com
### o argumento name.

### Os círculos frequentemente se sobrepoem. Para evitar ter grandes círculos no topo
### do gráfico, você pode reordenar seu conjunto de dados primeiro.

### Dê mais detalhes no mapeamento da variável numérica para o tamanho do círculo.
### Use scale_radius, scale_size e scale_size_area.

data %>%
  arrange(desc(pop)) %>%
  mutate(country = factor(country, country)) %>%
  ggplot(aes(x = gdpPercap, y = lifeExp, size = pop)) +
    geom_point(alpha = 0.5) +
    scale_size(range = c(.1, 24), name = "Population (M)")

# Adicionando uma quarta dimensão: cor -----------------------------------------------------------------------------------------------------

### Se você tem mais uma variável em seu dataset, por que não mostrar ela usando
### cores? Aqui, o continente de cada país é usado para controlar a cor do círculo.

data %>%
  arrange(desc(pop)) %>%
  mutate(country = factor(country, country)) %>%
  ggplot(aes(x = gdpPercap, y = lifeExp, size = pop, colour = continent)) +
    geom_point(alpha = 0.5) +
    scale_size(range = c(.1, 24), name = "Population (M)") +
    scale_color_brewer(palette = "Set1", name = "Continentes",
                       labels = c("África", "Américas", "Ásia", 
                                  "Europa", "Oceania")) +
    labs(x = "Renda per capita", y = "Expectativa de vida")

# Torne o gráfico mais bonito --------------------------------------------------------------------------------------------------------------

### Como melhorar:
### - Use cores interessantes do pacote viridis;
### - Use theme_ipsum() do pacote hrbrthemes;
### - Customize os eixos com xlab e ylab;
### - adicione traço ao círculo: mude a forma para 21 e 
### especifique a cor (traço) e preenchimento.

### Pacotes

library(hrbrthemes)
library(viridis)

data %>%
  arrange(desc(pop)) %>%
  mutate(country = factor(country, country)) %>%
  ggplot(aes(x = gdpPercap, y = lifeExp, size = pop, fill = continent)) +
    geom_point(alpha = 0.5, shape = 21, color = "black") +
    scale_size(range = c(.1, 18), name = "Population (M)") +
    scale_fill_viridis(discrete = TRUE, option = "A",
                       name = "Continentes",
                       labels = c("África", "Américas", "Ásia", 
                                  "Europa", "Oceania")) +
    theme_ipsum() +
    ylab("Life Expectancy") +
    xlab("Gdp per Capita") 

# Versão Interativa ------------------------------------------------------------------------------------------------------------------------

### Aqui está um gráfico de bolhas interativo construído no R com a função ggplotly()
### do pacote plotly. Tente passar o mouse sobre os círculos para obter informações
### específicas de cada variável, ou selecione uma área de interesse dando um zoom.

### Você também pode salvar o gráfico interativo como uma imagem em .png, deslizar
### sobre os eixos para ver pontos específicos e dá dois cliques com mouse para 
### para reiniciar o gráfico.

### A função ggplotly() pode tornar qualquer gráfico feito com ggplot2 interativo.
### A interação permite você obter informações específicas e detalahdas de cada ponto.

### Pacotes

library(ggplot2)
library(dplyr)
library(plotly)
library(viridis)
library(hrbrthemes)

### Carregar dados

library(gapminder)
data <- gapminder %>% filter(year == "2007") %>% dplyr::select(-year)
View(data)

### Manipular dados

p <- data %>%
  mutate(gdpPercap = round(gdpPercap,0)) %>%
  mutate(pop = round(pop/1000000,2)) %>%
  mutate(lifeExp = round(lifeExp,1)) %>%
  arrange(desc(pop)) %>%
  mutate(country = factor(country, country)) %>%
  mutate(text = paste("Country: ", country, 
                      "\nPopulation (M): ", pop, 
                      "\nLife Expectancy: ", lifeExp, 
                      "\nGdp per capita: ", gdpPercap, 
                      sep = "")) %>%
  
# Clássico ggplot
  
  ggplot(aes(x = gdpPercap, y = lifeExp, 
              size = pop, color = continent, 
              text = text)) +
    geom_point(alpha = 0.7) +
    scale_size(range = c(1.4, 19), name = "Population (M)") +
    scale_color_viridis(discrete = TRUE, guide = FALSE) +
    theme_ipsum() +
    theme(legend.position = "none")
p  

# Fazer o ggplot interativo com plotly

pp <- ggplotly(p, tooltip = "text")
pp
