#install.packages("ggplot2")
#install.packages("dplyr")
#install.packages("readr")
library(ggplot2)
#library(dplyr)
library(readr)
library(magrittr)

imdb <- readr::read_rds("data/imdb.rds")

ggplot(data = imdb)


my_data <- imdb %>%
  mutate(
    lucro = receita - orcamento,
    lucro = ifelse(lucro <= 0, "Não", "Sim")
  )  %>%
  filter(!is.na(lucro)) %>% 
  ggplot() +
  geom_point(mapping = aes(x = orcamento, y = receita, color = lucro)) +
  geom_abline(intercept = 0, slope = 1, color = "red") +
  labs(title="Filmes IMDB", x = "Orçamento", y = "Arrecadação", color = "Houve lucro?") 

plot(my_data)