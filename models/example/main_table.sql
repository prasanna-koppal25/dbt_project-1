{{ config(materialized='table') }}

with current_data as (
    select *
    from public.customers
),

-- Keep only the latest valid record from the history snapshot
current_snapshot as (
    select *
    from {{ ref('customers_history_snapshot') }}
    where dbt_valid_to is null
)

select
    coalesce(current_data.customer_id, current_snapshot.customer_id) as customer_id,
    coalesce(current_data.customer_name, current_snapshot.customer_name) as customer_name,
    coalesce(current_data.customer_address, current_snapshot.customer_address) as customer_address,
    coalesce(current_data.customer_email, current_snapshot.customer_email) as customer_email,
    coalesce(current_data.updated_at, current_snapshot.updated_at) as updated_at
from current_data
full outer join current_snapshot
    on current_data.customer_id = current_snapshot.customer_id