{{ config(
    materialized='view'
) }}

select
    cast(codigo_empresa as integer) as cod_empresa,
    cast(nome_empresa as varchar(100)) as desc_empresa,
    cast(continente as varchar(50)) as continente
from {{ source('public', 'empresas') }}