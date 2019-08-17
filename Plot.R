#install.packages("ggplot2")
#install.packages("magrittr")
#install.packages("xlsx")

# Para importar o aquivo com os dados do exel
library(xlsx)
# Para a formatação do gráfico 
library(ggplot2)
# Para o operador pipe  %>%
library(magrittr)

# Importando o arquivo com os dados de filmes do IMDb
data_imdb <- read.xlsx("data/data_imdb.xlsx", 1)

# Inicializando um objeto ggplot
ggplot(data = data_imdb)

my_data <- data_imdb %>%
  # Utilizando o mutate para criar a variável de lucro,
  # este que é a coluna de receita menos a de orçamento
  mutate(
    lucro = receita - orcamento,
    lucro = ifelse(lucro <= 0, "Não", "Sim")
  )  %>%
  # Se o lucro não for nulo
  filter(!is.na(lucro)) %>% 
  ggplot() +
  geom_point(mapping = aes(x = orcamento, y = receita, color = lucro)) +
  geom_abline(intercept = 0, slope = 1, color = "black") +
  labs(title="Filmes - IMDb", x = "Orçamento", y = "Arrecadação", color = "Houve lucro?") 

# Plotando o gráfico final
plot(my_data)