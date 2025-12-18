{{ config(
    materialized='view'
) }}

select
    cast(codigo_empresa as integer) as cod_empresa,
    cast(codigo_cliente as integer) as cod_cliente,
    cast(canal as varchar(50)) as canal,
    cast(cidade_area as varchar(100)) as cidade
from {{ source('postgres_data_raw', 'pontos_de_venda') }}