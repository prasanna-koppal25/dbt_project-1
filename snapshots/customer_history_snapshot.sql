{% snapshot customers_history_snapshot %}
    {{
        config(
          target_schema='snapshots',     
          unique_key='customer_id',      
          strategy='check',         
          check_cols='all',
          invalidate_hard_deletes=True
        )
    }}
    select
    *
    from public.customers

{% endsnapshot %}
