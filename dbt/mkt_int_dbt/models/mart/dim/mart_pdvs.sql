{{ config(
    materialized='table'
) }}

select 
    cod_empresa,
    cod_cliente,
    cast(concat(cod_empresa, '_', cod_cliente) as varchar(14)) as cod_emp_pdv,
    canal,
    cidade
from {{ ref('stg_pontos_de_venda') }}