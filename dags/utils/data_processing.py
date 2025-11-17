import os

import duckdb
from sqlalchemy import create_engine
from utils.db_connections import get_postgres_url


def deleting_postgres_tables(spreadsheets_path_airflow_volume):

    string_connection = get_postgres_url()

    # Creating engine connection
    engine = create_engine(
        string_connection, pool_pre_ping=True, pool_recycle=300)

    # List to hold table names to be excluded in postgres
    # based on files in the spreadsheets directory
    table_names_will_be_excluded = []

    # Iterate through files in the spreadsheets directory
    for file in os.listdir(spreadsheets_path_airflow_volume):

        # Through file name, getting table name that will be
        # excluded in postgres
        table_to_be_excluded = os.path.splitext(file)[0]
        print(
            f"Planilha '{table_to_be_excluded}' foi identificada no diretório.")

        # Adding table name to the list
        table_names_will_be_excluded.append(table_to_be_excluded)

        # Here I'll make a validation process with pydantic...

    # Deleting tables in Postgres that are in the exclusion list
    with engine.connect() as conn:
        tables = engine.table_names()
        for table in tables:
            if table in table_names_will_be_excluded:
                print(f"Deletando tabela '{table}'...")
#                time.sleep(1)  # Just to slow down the process
#                for visualization
                conn.execute(f"DROP TABLE IF EXISTS {table} CASCADE;")
                print(f"Tabela '{table}' deletada com sucesso!")

    conn.close()


def import_spreadsheets_duckdb(spreadsheets_path_airflow_volume):

    string_connection = get_postgres_url()

    engine = create_engine(
        string_connection, pool_pre_ping=True, pool_recycle=300)

    # DuckDB in-memory connection
    con = duckdb.connect(database=':memory:')

    # Iterate through files
    for file in os.listdir(spreadsheets_path_airflow_volume):
        # Inserting .csv just to test it afterward
        if file.endswith(".xlsx") or file.endswith(".csv"):
            path = os.path.join(spreadsheets_path_airflow_volume, file)
            table = os.path.splitext(file)[0]  # Taking off the file extension
            print(f"Importing {file} to {table}...")

            # Installing and loading the Excel extension
            con.execute("INSTALL excel;")
            con.execute("LOAD excel;")

            # Create temporary table in DuckDB reading the file
            con.execute(f"""
                CREATE OR REPLACE TABLE temp_table AS
                SELECT * FROM read_xlsx('{path}')
            """)

            # Sending data to Postgres
            df = con.execute("SELECT * FROM temp_table").df()
            df.to_sql(table, engine, if_exists='replace', index=False)

            print(f"Tabela '{table}' importada com sucesso!")

    con.close()
