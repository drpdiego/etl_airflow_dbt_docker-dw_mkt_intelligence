{{ config(materialized='table') }}

-- It's necessary to have positive values for volume and prices (business rule)

select * from {{ ref('stg_coletas_dez_25') }}
where vol_cxs > 0 and pv > 0 and pp > 0
union
select * from {{ ref('stg_coletas_set_25') }}
where vol_cxs > 0 and pv > 0 and pp > 0