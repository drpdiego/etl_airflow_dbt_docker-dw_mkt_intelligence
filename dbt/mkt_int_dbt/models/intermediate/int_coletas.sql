{{ config(materialized='table') }}

select * from {{ ref('stg_coletas_ago_25') }}
union
select * from {{ ref('stg_coletas_mar_25') }}