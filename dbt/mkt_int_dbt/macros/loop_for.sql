-- Macro apenas para testar o resultado através do: 
-- (dentro do container) dbt run-operation loop_for --args '{number: 7}' --project-dir /opt/airflow/dbt/mkt_int_dbt --profiles-dir /opt/airflow/dbt


{% macro loop_for(number) %}
  {% for i in range(number) %}
    {{ log('Número ' ~ i, info=True) }}
  {% endfor %}
{% endmacro %}