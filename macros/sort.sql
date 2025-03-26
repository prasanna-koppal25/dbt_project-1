

--Change data type
{% macro change_data_type_to_string(column) %}
    CAST({{ column }} AS TEXT)
{% endmacro %}

{% macro change_data_type_to_int(column) %}
    CAST({{ column }} AS INT)
{% endmacro %}


--Ascending and Descending
{% macro sort_by_column(column, direction='ASC') %}
  {% set sort_sql %}
    ORDER BY {{ column }} {{ direction }}
  {% endset %}
  {{ return(sort_sql) }}
{% endmacro %}

-- drop duplicates
{% macro drop_duplicates(subset_columns) %}
    {% if subset_columns is string %}
        {% set columns = [subset_columns] %}
    {% else %}
        {% set columns = subset_columns %}
    {% endif %}
    
    DISTINCT ON ({{ columns | join(', ') }})
{% endmacro %}


--drop column
{% macro drop_column(column_to_drop) %}
    SELECT * EXCEPT({{ column_to_drop }})
{% endmacro %}
