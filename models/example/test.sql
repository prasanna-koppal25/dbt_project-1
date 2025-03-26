{{config(materialized='test')}}


select FirstName
from {{ ref('customer_data') }}
