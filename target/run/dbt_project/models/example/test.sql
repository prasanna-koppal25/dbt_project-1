select
      None as failures,
      None None as should_warn,
      None None as should_error
    from (
      


select FirstName
from "metastore_db"."public"."customer_data"
      
    ) dbt_internal_test