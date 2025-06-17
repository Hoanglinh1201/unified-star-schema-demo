select distinct
    customer_unique_id as user_id,
    -- This is a placeholder for user details,
    -- which are not available in the source data
    null as user_name,
    null as user_email,
    null as user_phone
from {{ source('olist', 'customers') }}
