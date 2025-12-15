{{ config(materialized='table') }}

select * from {{ ref('stg_coletas_dez_25') }}
union
select * from {{ ref('stg_coletas_set_25') }}