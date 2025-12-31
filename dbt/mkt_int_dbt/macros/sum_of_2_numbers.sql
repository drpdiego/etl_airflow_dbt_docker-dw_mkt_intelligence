-- Macro apenas para testar o resultado através do: 
-- (dentro do container) dbt run-operation loop_for --args '{number: 7}' --project-dir /opt/airflow/dbt/mkt_int_dbt --profiles-dir /opt/airflow/dbt


{% macro sum_of_2_numbers(num1, num2) %}
    {% set result = num1 + num2 %}
    {{ log('O resultado é ' ~ result, info=True) }}
    {{ return(result) }}
{% endmacro %}