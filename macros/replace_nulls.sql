{% macro replace_null(value) %}
    coalesce({{ value }}, '#N/A')
{% endmacro %}
