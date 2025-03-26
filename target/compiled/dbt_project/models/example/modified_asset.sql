

select 
    lob_client_code,
    business_unit,
    application_number,
    approved_date,
    close_date,
    lob,
    account_status,
    
    coalesce(deactivation_date, '#N/A')
 as deactivation_date, 
    
    coalesce(emi_end_date, '#N/A')
 as emi_end_date  
from public.asset