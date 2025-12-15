# Projeto de Orquestração e Modelagem de Dados de Mercado

Projeto de engenharia de dados que utiliza Apache Airflow para orquestrar a ingestão de dados de planilhas locais para um banco de dados PostgreSQL, seguido pela transformação e modelagem dos dados usando dbt (data build tool).

## 🚀 Arquitetura da Solução

O pipeline de dados é executado em um ambiente isolado com Docker e orquestrado pelo Apache Airflow. As principais tecnologias utilizadas são:

*   **Apache Airflow**: Orquestração do pipeline (ETL e dbt).
*   **Docker / Docker Compose**: Containerização e isolamento do ambiente de desenvolvimento.
*   **PostgreSQL**: Armazenamento dos dados brutos (RAW) e dos dados modelados (Staging, Intermediate até chegar à camada Mart).
*   **dbt (data build tool)**: Transformação e modelagem dos dados.
*   **Python**: Lógica para leitura e ingestão das planilhas (com `pandas` e `duckdb`).

## ⚙️ Instalação e Execução Local

Para rodar este projeto na sua máquina local, você precisará ter o [Docker](docs.docker.com) e o [Git](git-scm.com) instalados.

### 1. Clonar o repositório

```bash
git clone github.com
cd SeuRepositorio
```

### 2. Configurar variáveis de ambiente

Renomeie o arquivo ".env.exemplo" para ".env" e edite as variáveis de ambiente. O arquivo contém as seguintes variáveis (acrescente os valores às variáveis):

##### --- Inicio do conteúdo arquivo ---
POSTGRES_DB=<br>
POSTGRES_PASSWORD=<br>
POSTGRES_USER=<br>
POSTGRES_HOST=postgres<br>
POSTGRES_PORT=5432<br>

AIRFLOW_DB=<br>
AIRFLOW_DB_USER=<br>
AIRFLOW_DB_PASSWORD=<br>
AIRFLOW_DB_HOST=postgres_airflow<br>
AIRFLOW_DB_PORT=5432<br>

AIRFLOW_USER=<br>
AIRFLOW_PASSWORD=<br>
AIRFLOW_FIRST_NAME=<br>
AIRFLOW_LAST_NAME=<br>
AIRFLOW_EMAIL=<br>
##### --- Final do conteúdo arquivo ---

Nessa última variável, indique o caminho onde as planilhas foram salvas localmente<br>
SPREADSHEET_PATH=Where_is_your_spreadsheet_files<br>

### 3. Subir o ambiente Docker

O comando a seguir construirá as imagens do Docker e iniciará os serviços (PostgreSQL, Airflow).

```bash
docker-compose up -d --build
```

Em seguida, acesse o container do airflow-scheduler através do seguinte comando:

```bash
docker exec -it mkt_intel_airflow-scheduler bash
```

Dentro do container, acesse a pasta dbt:
```bash
cd dbt/mkt_int_dbt
```

Já dentro da pasta do projeto dbt, rode o dbt deps:

```bash
dbt deps
```

### 4. Acessar o Airflow UI
Após alguns minutos (o Airflow leva um tempo para inicializar), você pode acessar a interface do Airflow em:
http://localhost:8081
Faça login com as credenciais definidas no seu .env (airflow/airflowpass).

## 🚀 Uso e Execução do Pipeline
A DAG do projeto é handling_spreadsheets_market_data.

No Airflow UI, unpause DAG e aguarde o seu início.

O pipeline seguirá a seguinte ordem:

**- deleting_postgres_tables_task:** Limpa tabelas RAW existentes no PostgreSQL que possuem o mesmo nome das planilhas contidas na pasta sinalizada no arquivo .env.

**- importar_task:** Importa os dados de cada planilha e os salva no Postgres em uma tabela nomeada com o mesmo nome da planilha.

**- dbt_run_staging:** Executa a camada de preparação dos dados.

**- dbt_run_intermediate:** Faz a união das tabelas de coletas.

**- dbt_run_mart:** Finaliza a modelagem dos dados.

## 📂 Estrutura do Projeto

...

## 📄 Documentação do dbt

...

Feito por Diego / drpdiego



