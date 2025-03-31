# Introdução
Este repositório contém o projeto de análise de dados desenvolvido para a Bellabeat. O objetivo é explorar dados obtidos através de dispositivos Fitbit para identificar padrões na atividade física, qualidade do sono e sedentarismo dos usuários, e assim fornecer insights para estratégias de marketing e melhorias em produtos.

# Objetivos do Projeto
* Analisar dados de atividade diária e sono para extrair informações relevantes.
* Visualizar correlações importantes, como entre passos e calorias queimadas e entre atividade física e qualidade do sono.
* Desenvolver um workflow reprodutível que serve como base para futuras análises e melhorias com base na coleta de dados de dispositivos inteligentes.

# Estrutura do Repositório
/ (raiz)
├── README.Rmd                  # Este arquivo de documentação
├── docs/                      # Diretório destinado ao GitHub Pages
│   ├── index.html             # Página principal gerada a partir do Rmd
├── dados/                      # Dados utilizados na análise
│   ├── atividade_diaria.csv
│   └── dia_de_sono.csv
└── codigo/                     # Arquivos de código comentados da análise
    |── bellabeat_analise.R
    └── estudo_de_caso_bellabeat.Rmd

# Como Executar o Projeto
* Requisitos: Instale o R e o RStudio. Certifique-se de ter os pacotes necessários instalados: tidyverse, janitor, ggplot2.
* Renderização: Abra o arquivo estudo_de_caso_bellabeat.Rmd no RStudio e clique em Knit para gerar o relatório com base em sua preferência.
* GitHub Pages: Ou então você pode ver o meu projeto através do [pages](https://gabrielcury30.github.io/bellabeat-analise/) criado.

# Licença
Este projeto está licenciado sob a MIT License.
