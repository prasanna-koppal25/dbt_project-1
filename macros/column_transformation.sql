--Rename columns
{% macro rename_columns(columns_map) %}
    {% set renamed_cols = [] %}
    {% for old_col, new_col in columns_map.items() %}
        {% do renamed_cols.append(old_col ~ ' AS ' ~ new_col) %}
    {% endfor %}
    {{ renamed_cols | join(', ') }}
{% endmacro %}


-- move column to start
{% macro move_column_to_start(column_to_move, columns) %}
    {% set other_columns = [] %}
    {% for col in columns %}
        {% if col != column_to_move %}
            {% do other_columns.append(col) %}
        {% endif %}
    {% endfor %}
    {{ return(column_to_move ~ ', ' ~ other_columns|join(', ')) }}
{% endmacro %}

-- move column to end
{% macro move_column_to_end(column_to_move, columns) %}
    {% set other_columns = [] %}
    {% for col in columns %}
        {% if col != column_to_move %}
            {% do other_columns.append(col) %}
        {% endif %}
    {% endfor %}
    {{ return(other_columns|join(', ') ~ ', ' ~ column_to_move) }}
{% endmacro %}

-- move column to custom position
{% macro move_column_to_custom_position(column_to_move, insert_position, columns) %}
    {% set other_columns = [] %}
    {% for col in columns %}
        {% if col != column_to_move %}
            {% do other_columns.append(col) %}
        {% endif %}
    {% endfor %}
    {% set final_columns = other_columns[:insert_position] + [column_to_move] + other_columns[insert_position:] %}
    {{ return(final_columns|join(', ')) }}
{% endmacro %}



