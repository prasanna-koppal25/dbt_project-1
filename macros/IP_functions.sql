
--IP Address to Integer:
{% macro ip_to_int(ip_column) %}
    CAST(
        SPLIT_PART(HOST({{ ip_column }}::INET), '.', 1)::BIGINT * 256^3 +
        SPLIT_PART(HOST({{ ip_column }}::INET), '.', 2)::BIGINT * 256^2 +
        SPLIT_PART(HOST({{ ip_column }}::INET), '.', 3)::BIGINT * 256^1 +
        SPLIT_PART(HOST({{ ip_column }}::INET), '.', 4)::BIGINT AS BIGINT
    )
{% endmacro %}

-- convert integer back to IP address
{% macro int_to_ip(int_column) %}
    CONCAT_WS('.',
        (({{ int_column }} >> 24) & 255)::TEXT,
        (({{ int_column }} >> 16) & 255)::TEXT,
        (({{ int_column }} >> 8) & 255)::TEXT,
        ({{ int_column }} & 255)::TEXT
    )::INET
{% endmacro %}

-- extract URL parameters
{% macro extract_url_param(url_column, param_name) %}
    SUBSTRING(
        {{ url_column }} FROM 
        CONCAT('(?<=', {{ param_name }}, '=)[^&]*')
    )
{% endmacro %}

