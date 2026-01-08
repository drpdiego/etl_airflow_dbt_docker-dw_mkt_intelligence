{{ config(severity = 'warn') }}

select 
    *
from {{ ref('int_coletas') }}
where not (
  case
    when cod_embalagem = 102030 then vol_cxs between 1 and 20000
    when cod_embalagem = 203040 then vol_cxs between 1 and 500000
    when cod_embalagem = 304050 then vol_cxs between 1 and 40000
    when cod_embalagem = 405060 then vol_cxs between 1 and 80000 else true
  end
)