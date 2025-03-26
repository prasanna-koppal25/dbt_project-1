{{ config(materialized='table') }}

select 
    lob_client_code,
    business_unit,
    application_number,
    approved_date,
    close_date,
    lob,
    account_status,
    {{ replace_null('deactivation_date') }} as deactivation_date, 
    {{ replace_null('emi_end_date') }} as emi_end_date  
from public.asset
