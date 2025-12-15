{{ config(materialized='view') }}

select
    cast(codigo_embalagem as integer) as cod_embalagem,
    cast(nome_embalagem as varchar(100)) as desc_embalagem,
    cast(unidades_na_caixa as integer) as qtd_unidades, 
    cast(volume_em_litros as numeric(10,5)) as vol_litros
from {{ source('public', 'embalagens') }}
