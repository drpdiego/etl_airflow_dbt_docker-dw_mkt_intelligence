{{ config(
    materialized='view'
) }}

select
    cast(codigo_empresa as integer) as cod_empresa,
    cast(nome_empresa as varchar(100)) as desc_empresa,
    cast(nome_continente as varchar(50)) as continente
from {{ source('postgres_data_raw', 'empresas') }}