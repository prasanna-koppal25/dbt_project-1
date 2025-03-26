{{ config(materialized='table') }}

select
    customer_id,
    customer_name,
    customer_address,
    customer_email,
    updated_at,
    dbt_valid_from,
    dbt_valid_to
from {{ ref('customers_history_snapshot') }}
where dbt_valid_to is not null
