{{ config(
    materialized='table',
) }}

select 
    c.cod_empresa,
    cast(concat(c.cod_empresa, '_', c.cod_cliente) as varchar(14)) as cod_emp_pdv,
    c.cod_embalagem,
    c.cod_marca,
    c.vol_cxs,
    cast(((e.vol_litros * c.vol_cxs) / 100) as numeric(12, 8)) as vol_hl,
    c.pv,
    c.pp,
    c.mes_coletas
from {{ ref('int_coletas') }} as c
left join {{ ref('mart_dim_embalagens') }} as e
    on c.cod_embalagem = e.cod_embalagem