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
	quarter_of_year,
	year_number
from {{ ref('stg_date') }}