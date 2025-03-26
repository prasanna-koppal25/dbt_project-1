WITH employee_data AS (
    SELECT
        id,
        name,
        position,
        salary,
        {{ ip_to_int('"ip"') }} as ip_as_int,  -- Step 1: Create ip_as_int
        {{ extract_url_param('"url"', "'id'") }} as url_id,
        {{ extract_url_param('"url"', "'name'") }} as url_name
    FROM public.employee
),
converted_data AS (
    SELECT
        *,
        {{ int_to_ip('ip_as_int') }} as ip_converted_back  -- Step 2: Use ip_as_int to convert back to IP
    FROM employee_data
)
SELECT * FROM converted_data
