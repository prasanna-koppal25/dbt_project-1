{{ config(materialized='table') }}

with current_snapshot as (
    select *
    from {{ ref('customers_snapshot') }}
    where dbt_valid_to is null
),
previous_snapshot as (
    select distinct on (customer_id)
        *
    from {{ ref('customers_snapshot') }}
    where dbt_valid_to is not null
    order by customer_id, dbt_valid_to desc
)
select
    current_snapshot.customer_id,
    current_snapshot.customer_name,
    current_snapshot.customer_address as current_address,
    previous_snapshot.customer_address as previous_address,
    current_snapshot.customer_email,
    current_snapshot.updated_at as current_updated_at,
    previous_snapshot.updated_at as previous_updated_at
from current_snapshot
left join previous_snapshot using (customer_id)