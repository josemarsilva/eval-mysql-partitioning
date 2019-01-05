# README - eval-mysql-partitioning


## 1. Introdução ##

Este repositório contém os artefatos do projeto **eval-mysql-partitioning** que trata de uma **avaliação** da funcionalidade de particionamento do banco de dados MySQL.

### 1.1. Premissas ###

Este projeto tem como premissa:
* O objetivo é testar a funcionalidade de particionamento, aspectos relativos a tráfego de rede e demais itens serão considerados secundário e contingenciados
* Simular uma mesma volumetria e de forma comparativa testar tempo de acesso de acesso indexado (normal), indexado (composto), particionado, acesso completo
* Simular uma situação comum de negócio na vida de um sistema. Quando ele foi criado havia poucos dados, mas com o crescimento vegetativo do negócio, o passar do tempo e a falta de rotinas de expurgo de dados, o sistema começa a apresentar lentidão.


### 1.2. Planejamento ###

Atividades previstas:
* Obtenção de um servidor (virtualizado ou não) para o banco de dados MySQL
* Criação das tabelas e stored procedures no banco de dados MySQL
* Carregar as tabelas do teste com uma volumetria elevada e distribuição desejada para os testes
* Executar diversos cenários de testes, aferir as principais métricas e tabular os resultados


### 2. Documentação ###

### 2.1. Diagrama de Caso de Uso ###

![Diagrama de Caso de Uso](doc/Diagrama%20de%20Caso%20de%20Uso.png)


### 2.2. Diagrama de Implantação

![Diagrama de Implantacao](doc/Diagrama%20de%20Implantacao.png)


### 2.3. Diagrama Modelo de Dados ###

![Diagrama Modelo de Dados](doc/Diagrama%20Modelo%20de%20Dados.png)

* Detalhamento das Tabelas:

Tabela          |    Count() | Obs
--------------- | ---------- | ------------------------
tab_cliente     |      1.000 | Clientes do sistema
tab_empresa     |          2 | Empresas controladas
tab_vendas      | 10.000.000 | Vendas da empresa
tab_venda_part  | 10.000.000 | Tabela de vendas em um cenário de particionamento


* Detalhamento das Colunas mais relevantes:

Tabela          | Coluna     | Comentario        | Cardinalidade, Seletividade, obs, etc
--------------- | ---------- | ----------------- | ----------------------------------------------
tab_cliente     | id         | PK                |
tab_empresa     | id         | PK                |
tab_vendas      | empresa_id | FK -> tab_empresa | 95% das vendas são para a `empresa_id` = 1 e apenas 5% das vendas para a `empresa_id` = 2
tab_vendas      | cliente_id | FK -> tab_cliente | Distribuição _normal_ das vendas
tab_vendas      | dt_emissao |                   | Distribuição _normal_ vendas 1 por dia entre 01/01/2010 até data de hoje()
tab_vendas      | vlr_venda  |                   | Todos registros com mesmo valor: 1,00
tab_vendas      | dt_periodo |                   | Segue a coluna `dt_emissao`. Sempre o primeiro dia do mês da coluna dt_emissao



## 3. Projeto ##

### 3.1. Pré-requisitos ###

* Banco de dados MySQL 
* JMeter 5.0
* MySQL JDBC Driver 

### 3.2. Guia para Desenvolvimento ###

* n/a 

### 3.3. Guia para Configuração ###

* [Passo a passo do provisionamento de uma instância MySQL no Google Cloud SQL](README_GoogleCloudSQL_MySql.md)

### 3.4. Guia para Teste ###

* n/a


### 3.5. Guia para Implantação ###

* [Passo #1: Execute o script de criação do banco de dados - 00_ddl_create_database.sql](src/sql/00_ddl_create_database.sql)
* [Passo #2: Execute o script de criação das tabelas - 01_ddl_create_tables.sql](src/sql/01_ddl_create_tables.sql)
* [Passo #3: Execute o script de criação das procedures - 02_ddl_create_procedures.sql](src/sql/02_ddl_create_procedures.sql)
* [Passo #4: Execute o script de executa as procedures de carga inicial - 03_dml_execute_procedures.sql](src/sql/03_dml_execute_procedures.sql)
  * Tempo estimado para execução: Dur: **1h** - vCpu: 1; Memória: 3,75 GB; Armaz: 10 GB; CPU-Load: 96%;  
  * Observe o [monitoramento de recursos](README_GoogleCloudSQL_DetalheInstanciaDuranteCargaDados.md) durante a carga inicial
* [Passo #5: Execute o script de verificação das volumetrias carregadas inicialmente - 04_dql_consulta_dados.sql](src/sql/04_dql_consulta_dados.sql)
  * O resultado esperado dever ser semelhante a este abaixo (pode não ser idêntico porque MAX_DT_EMISSAO = CURDATE() )

```mysql
+---------------------+------------+
| ITEM                | VALOR      |
+---------------------+------------+
| TABELA              | tab_venda  |
| DISTINCT_ID         | 10000000   |
| MIN_ID              | 1          |
| MAX_ID              | 10000000   |
| DISTINCT_EMPRESA_ID | 2          |
| MIN_EMPRESA_ID      | 1          |
| MAX_EMPRESA_ID      | 2          |
| DISTINCT_CLIENTE_ID | 1000       |
| MIN_CLIENTE_ID      | 1          |
| MAX_CLIENTE_ID      | 1000       |
| DISTINCT_DT_EMISSAO | 3291       |
| MIN_DT_EMISSAO      | 2010-01-01 |
| MAX_DT_EMISSAO      | 2019-01-04 |
| DISTINCT_DT_PERIODO | 109        |
| MIN_DT_PERIODO      | 2010-01-01 |
| MAX_DT_PERIODO      | 2019-01-01 |
+---------------------+------------+
16 rows in set (7.90 sec)
```

### 3.6. Guia para Execução ###

* n/a


### 3.7. Guia de Credenciais de Acesso ###
* n/a


## Referências ##

* [Utilizando o MySQL Partitioning](https://www.devmedia.com.br/utilizando-o-mysql-partitioning/16825)
* [Using Google Cloud SQL with Compute Engine](https://www.youtube.com/watch?v=mvIE8LkXEEY&feature=youtu.be)
* [Configurando MySQL JDBC Connection com JMeter](https://github.com/josemarsilva/jmeter-beginner-tutorial/blob/master/doc/DatabaseConnection/README.md)