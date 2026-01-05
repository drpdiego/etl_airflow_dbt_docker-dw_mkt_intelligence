# Use the official Airflow image as base image
FROM apache/airflow:2.9.2-python3.10

# Set environment variables to optimeze Python and dbt behavior
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PATH="/home/airflow/.local/bin:${PATH}"

# Switch to root user to install system dependencies
USER root

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    gcc \
    build-essential \
    libpq-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Return to airflow user to install Python packages
USER airflow

# We copy requirements.txt first to leverage Docker layer caching
# If you change the DAG code but not the requirements, Docker skips this slow step
COPY --chown=airflow:root requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Install DuckDB extensions for Excel and Postgres in build time to avoid dependency of internet access in the DAG runtime
RUN python -c "import duckdb; con = duckdb.connect(':memory:'); con.execute('INSTALL excel; INSTALL postgres;')"

# Set Airflow working directory
WORKDIR ${AIRFLOW_HOME}