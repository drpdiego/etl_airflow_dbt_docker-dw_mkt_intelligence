import os


def get_postgres_url():
    user = os.getenv('POSTGRES_USER')
    password = os.getenv('POSTGRES_PASSWORD')
    host = os.getenv('POSTGRES_HOST')
    port = os.getenv('POSTGRES_PORT')
    dbname = os.getenv('POSTGRES_DB')

    # Retorna a string de conexão formatada
    return f'postgresql+psycopg2://{user}:{password}@{host}:{port}/{dbname}'
