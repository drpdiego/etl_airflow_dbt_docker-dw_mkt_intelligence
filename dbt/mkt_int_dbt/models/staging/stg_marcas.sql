{{ config(materialized='view') }}

select
    cast(codigo_marca as integer) as cod_marca,
    cast(nome_marca as varchar(50)) as desc_marca,
    cast(segmento_preco as varchar(50)) as seg_preco,
    cast(nome_fabricante as varchar(100)) as desc_fabricante
from {{ source('public', 'marcas') }}