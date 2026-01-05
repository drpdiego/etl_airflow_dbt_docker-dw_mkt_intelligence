{% test embalagens_intervalo_qtds(model, column_name) %}

select 
    *
from {{ model }}
where not (
  case
    when cod_embalagem = 102030 then {{column_name}} between 0 and 20000
    when cod_embalagem = 203040 then {{column_name}} between 0 and 500000
    when cod_embalagem = 304050 then {{column_name}} between 0 and 40000
    when cod_embalagem = 405060 then {{column_name}} between 0 and 80000 else true
  end
)

{% endtest %}