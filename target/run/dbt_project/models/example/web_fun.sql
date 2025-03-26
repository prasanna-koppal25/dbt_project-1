
  create view "metastore_db"."public"."web_fun__dbt_tmp"
    
    
  as (
    WITH employee_data AS (
    SELECT
        id,
        name,
        position,
        salary,
        
    CAST(
        SPLIT_PART(HOST("ip"::INET), '.', 1)::BIGINT * 256^3 +
        SPLIT_PART(HOST("ip"::INET), '.', 2)::BIGINT * 256^2 +
        SPLIT_PART(HOST("ip"::INET), '.', 3)::BIGINT * 256^1 +
        SPLIT_PART(HOST("ip"::INET), '.', 4)::BIGINT AS BIGINT
    )
 as ip_as_int,  -- Step 1: Create ip_as_int
        
    SUBSTRING(
        "url" FROM 
        CONCAT('(?<=', 'id', '=)[^&]*')
    )
 as url_id,
        
    SUBSTRING(
        "url" FROM 
        CONCAT('(?<=', 'name', '=)[^&]*')
    )
 as url_name
    FROM public.employee
),
converted_data AS (
    SELECT
        *,
        
    CONCAT_WS('.',
        ((ip_as_int >> 24) & 255)::TEXT,
        ((ip_as_int >> 16) & 255)::TEXT,
        ((ip_as_int >> 8) & 255)::TEXT,
        (ip_as_int & 255)::TEXT
    )::INET
 as ip_converted_back  -- Step 2: Use ip_as_int to convert back to IP
    FROM employee_data
)
SELECT * FROM converted_data
  );