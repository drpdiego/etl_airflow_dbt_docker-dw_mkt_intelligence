{{ config(
    materialized='table'
) }}

select 
	date_day,
	day_of_week,
	day_of_week_name,
	day_of_week_name_short,
	day_of_month,
	month_of_year,
	month_name,
	month_name_short,
	cast(right(year_number::text, 2) as integer) as year_number_short,
    month_name_short || '-' || cast(right(year_number::text, 2) as integer) as month_year_short,
	case when month_of_year <= 9 then cast(year_number::text || '0' || month_of_year::text as integer) else cast(year_number::text || month_of_year::text as integer) end as year_month_number, 
	quarter_of_year,
	year_number
from {{ ref('stg_date') }}