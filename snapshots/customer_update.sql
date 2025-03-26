{% snapshot customer_update %}
    {{
        config(
          target_schema='snapshots',     
          unique_key='customer_id',      
          strategy='check',
          check_cols=['customer_address','customer_email'],
          invalidate_hard_deletes=True 
        )
    }}

   
    select
    *
    from public.customers

{% endsnapshot %}
