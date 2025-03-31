# Instalação dos pacotes necessários para o projeto
install.packages("tidyverse")
install.packages("janitor")

library(tidyverse) # Biblioteca padrão para análise no R
library(janitor) # Biblioteca importante para a limpeza de dados
library(ggplot2) # Biblioteca para criação e manipulação de gráficos

# Leitura dos arquivos csv com a biblioteca readr e armazenando-os em dataframes
atividade_diaria <- read.csv("atividade_diaria.csv")
dia_de_sono <- read.csv("dia_de_sono.csv")

# Visão geral dos dataframes e verificar os nomes das colunas
head(atividade_diaria)
head(dia_de_sono)

colnames(atividade_diaria)
colnames(dia_de_sono)

# Limpeza das colunas dos dataframes e renomeação para padronização
atividade_diaria <- atividade_diaria %>%
  clean_names() %>% rename(
    data = activity_date,
    passos_totais = total_steps,
    distancia_total = total_distance,
    distancia_do_rastreador = tracker_distance,
    distancia_das_atividades_registradas = logged_activities_distance,
    distancia_muito_ativa = very_active_distance,
    distancia_moderadamente_ativa = moderately_active_distance,
    distancia_levemente_ativa = light_active_distance,
    distancia_ativa_sedentaria = sedentary_active_distance,
    minutos_muito_ativos = very_active_minutes,
    minutos_razoavelmente_ativos = fairly_active_minutes,
    minutos_pouco_ativos = lightly_active_minutes,
    minutos_sedentarios = sedentary_minutes,
    calorias = calories)

dia_de_sono <- dia_de_sono %>%
  clean_names() %>% rename(
    dia_do_sono = sleep_day,
    registros_de_sono_total = total_sleep_records,
    total_minutos_dormindo = total_minutes_asleep,
    tempo_total_na_cama = total_time_in_bed
  )

# Limpeza dos dados, removendo possíveis duplicatas e valores ausentes
atividade_diaria <- atividade_diaria %>%
  drop_na() %>% 
  distinct()

dia_de_sono <- dia_de_sono %>% 
  drop_na() %>% 
  distinct()

# Começo da análise, verificando estatísticas básicas
summary(atividade_diaria)
summary(dia_de_sono)

# Relação de passos totais com a queima de calorias
# Evidenciado por um gráfico de dispersão
cor(atividade_diaria$passos_totais, atividade_diaria$calorias)

ggplot(atividade_diaria, mapping = aes(x = passos_totais, y = calorias)) +
  geom_point(color = "blue", alpha = 0.5) + 
  labs(title = "Correlação entre Passos e Calorias", 
       x = "Passos Totais", y = "Calorias Queimadas") + 
  geom_smooth(method = "lm", color = "orange", se = FALSE)

# Criação de uma nova coluna dos minutos ativos totais para calcular
# O percentual sedentário
atividade_diaria <- atividade_diaria %>%
  mutate(minutos_ativos_totais = minutos_muito_ativos + 
           minutos_razoavelmente_ativos + minutos_pouco_ativos) %>%
  mutate(
    percentual_sedentario = (minutos_sedentarios / (minutos_ativos_totais + 
                                                    minutos_sedentarios)) * 100)

# Criação de um histograma para verificar a frequência do percentual sedentário
ggplot(atividade_diaria, mapping = aes(x = percentual_sedentario)) + 
  geom_histogram(fill = "blue", alpha = 0.7, bins = 20) + 
  labs(title = "Distribuição do Percentual Sedentário", 
       x = "Percentual Sedentário", y = "Frequência")

# Separar a data e hora em colunas separadas para facilitar
# A união de dataframes
dia_de_sono <- dia_de_sono %>%
  separate(dia_do_sono, into = c("data", "hora"), sep = " ")

# Conversão das colunas para o padrão correto, garatindo consistência dos dados
dia_de_sono$data <- as.Date(dia_de_sono$data, format = "%m/%d/%Y")
atividade_diaria$data <- as.Date(atividade_diaria$data, format = "%m/%d/%Y")

# Junção dos dataframes pela intersecção do id e data
df_combinado <- inner_join(atividade_diaria, dia_de_sono, by = c("id", "data"))

# Correlação entre passos totais e minutos dormidos
cor(df_combinado$passos_totais, df_combinado$total_minutos_dormindo)

ggplot(df_combinado, mapping = aes(x = passos_totais, 
                                   y = total_minutos_dormindo)) + 
  geom_point(color = "blue", alpha = 0.5) + 
  labs(title = "Relação Entre Passos Dados e Minutos Dormidos", 
                      x = "Passos Totais", y = "Minutos Dormidos") + 
  geom_smooth(method = "lm", se = FALSE, color = "orange")

# Criar nova coluna para calcular a eficiência do sono
df_combinado <- df_combinado %>%
  mutate(eficiencia_do_sono = (total_minutos_dormindo / tempo_total_na_cama) * 
           100)

# Histograma para analisar a frequência da eficiência do sono dos usuários
ggplot(df_combinado, mapping = aes(x = eficiencia_do_sono)) +
  geom_histogram(fill = "blue", alpha = 0.7, bins = 20) +
  labs(title = "Distribuição do Percentual de Sono", x = "Eficiência do Sono", 
       y = "Frequência")