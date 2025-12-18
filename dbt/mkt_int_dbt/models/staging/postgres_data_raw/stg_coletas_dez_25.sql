{{ config(
    materialized='view'
) }}


select 
    cast(codigo_empresa as integer) as cod_empresa,
    cast(cliente as integer) as cod_cliente,
    cast(codigo_embalagem as integer) as cod_embalagem,
    cast(codigo_marca as integer) as cod_marca,
    cast(volume_caixas as numeric(10, 5)) as vol_cxs,
    cast(preco_varejo as numeric(5, 2)) as pv,
    cast(preco_ponta as numeric(5, 2)) as pp,
    cast('2025-12-01' as date) as mes_coletas
from {{ source('postgres_data_raw', 'coletas_12_25') }}
