from datetime import datetime

from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from utils.data_processing import (deleting_postgres_tables,
                                   import_spreadsheets_duckdb)

# Setting up constants
SPRSHEETS_PATH = "/opt/airflow/data"
DBT_PROFILES_DIR = "/opt/airflow/dbt/"
DBT_PROJECT_DIR = "/opt/airflow/dbt/mkt_int_dbt/"

# Defining DAG
with DAG(
    dag_id='handling_spreadsheets_market_data',
    start_date=datetime(2025, 10, 21),
    schedule='@daily',
    catchup=False,
    tags=['import', 'postgres', 'duckdb', 'spreadsheets', 'market_data']
) as dag:

    deleting_postgres_tables_task = PythonOperator(
        task_id='deleting_postgres_tables',
        python_callable=deleting_postgres_tables,
        op_args=[SPRSHEETS_PATH]
    )

    importar_task = PythonOperator(
        task_id='importing_spreadsheets_duckdb',
        python_callable=import_spreadsheets_duckdb,
        op_args=[SPRSHEETS_PATH]
    )

    dbt_run_staging = BashOperator(
        task_id='run_dbt_staging_layer',
        bash_command=f'dbt run --select staging --profiles-dir {DBT_PROFILES_DIR} --project-dir {DBT_PROJECT_DIR}',
        cwd=DBT_PROJECT_DIR
    )

    dbt_test_staging = BashOperator(
        task_id='run_dbt_staging_tests',
        bash_command=f'dbt test --select staging --profiles-dir {DBT_PROFILES_DIR} --project-dir {DBT_PROJECT_DIR}',
        cwd=DBT_PROJECT_DIR
    )

    dbt_run_intermediate = BashOperator(
        task_id='run_dbt_intermediate_layer',
        bash_command=f'dbt run --select intermediate --profiles-dir {DBT_PROFILES_DIR} --project-dir {DBT_PROJECT_DIR}',
        cwd=DBT_PROJECT_DIR
    )

    dbt_test_intermediate = BashOperator(
        task_id='run_dbt_intermediate_tests',
        bash_command=f'dbt test --select intermediate --profiles-dir {DBT_PROFILES_DIR} --project-dir {DBT_PROJECT_DIR}',
        cwd=DBT_PROJECT_DIR
    )

    dbt_run_mart = BashOperator(
        task_id='run_dbt_mart_layer',
        bash_command=f'dbt run --select mart --profiles-dir {DBT_PROFILES_DIR} --project-dir {DBT_PROJECT_DIR}',
        cwd=DBT_PROJECT_DIR
    )

    dbt_test_mart = BashOperator(
        task_id='run_dbt_mart_tests',
        bash_command=f'dbt test --select mart --profiles-dir {DBT_PROFILES_DIR} --project-dir {DBT_PROJECT_DIR}',
        cwd=DBT_PROJECT_DIR
    )

    deleting_postgres_tables_task >> importar_task >> dbt_run_staging >> dbt_test_staging >> dbt_run_intermediate >> dbt_test_intermediate >> dbt_run_mart >> dbt_test_mart