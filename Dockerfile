# Use Airflow official image as foundation
FROM apache/airflow:2.9.2

ENV PATH="/home/airflow/.local/bin:${PATH}"

# With a root user, install git to avoid errors when installing dbt-postgres
# Just to mention, this didn't work. I had to switch to root user to install git manually
USER root
RUN apt-get update && apt-get install -y git && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install necessary lib to process the spreadsheets
USER airflow
RUN pip install pandas duckdb openpyxl dbt-postgres psycopg2-binary
