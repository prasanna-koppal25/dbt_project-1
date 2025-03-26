
  
    

  create  table "metastore_db"."public"."employee__dbt_tmp"
  
  
    as
  
  (
    /*
    This model creates the 'employees' table and inserts sample records.
    You can modify the inserted records as needed.
*/

--This model creates the 'employees' table using a SELECT statement


select 
    id, 
    name, 
    
    coalesce(position, '#N/A')
 as position, 
    salary
from (
    select 
        1 as id, 
        'Alice Smith' as name, 
        'Software Engineer' as position, 
        75000.00 as salary
    union all
    select 
        2, 'Bob Johnson', NULL, 65000.00
    union all
    select 
        3, 'Charlie Brown', 'Project Manager', 85000.00
    union all
    select 
        4, 'Diana Prince', NULL, 75250.25
)
  );
  