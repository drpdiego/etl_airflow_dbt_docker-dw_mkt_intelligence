{{ config(materialized='view') }}

select
    cast(codigo_embalagem as integer) as cod_embalagem,
    cast(nome_embalagem as varchar(100)) as desc_embalagem,
    cast(unidades as integer) as qtd_unidades, 
    cast(litros as numeric(10,5)) as qtd_litros
from {{ source('public', 'embalagens') }}
