{% snapshot customers_custom_strategy %}

{{
    config(
      target_schema='snapshots',
      unique_key='customer_id',
      strategy='my_custom_snapshot_strategy',
      updated_at='updated_at',
      custom_field='customer_address',
      invalidate_hard_deletes=True
    )
}}

select
    customer_id,
    customer_name,
    customer_address,
    customer_email,
    updated_at
from public.customers

{% endsnapshot %}