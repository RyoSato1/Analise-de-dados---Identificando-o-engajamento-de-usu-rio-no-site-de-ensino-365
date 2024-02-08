# Analise de dados - Indentificando o engajamento de usuário no site de ensino 365

Este projeto analisou os dados do site de ensino 365 com o intuito de entender se as implementações feitas no ano de 2021(novos cursos,exames e auxílio de carreira) influenciaram no aumento de engajamento de usuários, além disso foi analisado outras colunas para procurar possíveis correspondências com o nível de engajamento dos alunos.

A extração dos dados foi feita a partir de uma base de sql, que foi oferecida pelo próprio site, com dados do périodo do primeiro quarto do ano de 2021 e do primeiro quarto de 2022(com restrição de dados pessoais), feito a manipulação de dados para criar as tabelas desejadas, exportou-se essas bases para csv e nelas foram feitas outros preprocessamentos de dados pelo python, e assim a base de dados foi preparada para efetuação de analises que foram feitos tanto em excel quanto em python.
 
## Requisitos de Instalação:
Para a aplicação desse projeto foram utilizados as seguintes ferramentas:
* Python
* SQL
* Excel

## Estrutura do repositório
O projeto está dividido por algumas pastas para melhorar sua organização, a pasta sql estão os dados da database inicial, assim como o script para fazer toda a manipulação de dados. A pasta database é onde são soltados os outputs csv, tanto da parte soltada do sql, quanto da parte de preprocessamento de dados.E a parte de analise de excel é a pasta que contém as analises feitas por excel. Existem 2 scripts de python, no formato .ipynb, o primeiro Ajuste_de_dados_para_analise é o preprocessamento de dados, enquanto o Prediction with linear regression.ipynb é analise dados feita pelo python.

## Processo de Análise:

O primeiro passo do projeto era retirar os dados importantes para analise, para foi utilizado diversos métodos de verificação, agregação e criação de tabelas pelo mysql, todo o passo a passo da criação das tabelas está documentado no arquivo script que se encontra dentro da pasta sql. Assim obteve-se o output das tabelas com informações de tempo assistido em minutos de cada aluno no periodo de Q1 de 2021 e Q2 de 2022, e esses alunos foram divididos em alunos que assinam os serviços do site e os que não assinam. Além dessa tabela, foi criada mais uma que tem os minutos assistidos por cada aluno e a quantidade de certificados obtidos no site.

Após a criação da tabelas, fez-se sua vizualização pelo python, no código Ajuste_de_dados_para_analise.ipynb, e fez-se alguns ajustes nos outlier a partir da resposta da sua distribuição, foi decidido permanecer com, somente, os  99% maiores percentis e assim as tabelas estavam prontos para analise.

A primeira analise explorava a distribuição das tabelas que são separadas por períodos, e por meio do intervalo de confiança, pegar evidências, a partir das amostras de dados, de se o tempo assistido em Q2 2022 foi de fato maior que o tempo assistido em Q1 2021.A segunda analise, ainda com os mesmos dados, seria aplicar um teste de hipótese onde a hipótese nula implica que a média de minutos assistidos de Q1 2021 é igual ou maior que a de Q2 2022 e a hipótese alternativa é o complementar de que  a média de minutos assistidos de Q1 2022 é maior do que a de Q1 2021, essas analises são feitos separados para alunos com inscriçoes pagas e grátis.

A terceira analise já é feita com outra base e deseja-se verificar a correlação entre o tempo assistido de cada aluno e a quantidade de certificados, assim como tentar predizer a quantidade de certificado em uma regressão linear.

## Conjunto de dados

## Resultados

## Próximos passos

Como se trata de uma analise para mostrar o meu entendimento com as ferramentas utilizadas não pretendo fazer nenhuma mudança, mas crei
