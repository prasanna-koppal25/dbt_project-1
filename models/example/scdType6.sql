{{ config(materialized='table') }}

with snapshot_data as (
    select
        customer_id,
        customer_name,
        customer_address,
        customer_email,
        updated_at,
        dbt_valid_from,
        dbt_valid_to,
        row_number() over (partition by customer_id order by dbt_valid_from) as version,
        case when dbt_valid_to is null then 1 else 0 end as is_current
    from {{ ref('customers_history_snapshot') }}
),

first_version as (
    select
        customer_id,
        customer_name as original_customer_name,
        customer_address as original_customer_address,
        customer_email as original_customer_email
    from snapshot_data
    where version = 1
)

select
    s.customer_id,
    f.original_customer_name,
    f.original_customer_address,
    f.original_customer_email,
    s.customer_name as current_customer_name,
    s.customer_address as current_customer_address,
    s.customer_email as current_customer_email,
    s.updated_at,
    s.dbt_valid_from as valid_from,
    s.dbt_valid_to as valid_to,
    s.is_current,
    s.version
from snapshot_data s
join first_version f on s.customer_id = f.customer_id