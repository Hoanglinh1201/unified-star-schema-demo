select distinct
    customer_unique_id as _key_customer_id,
    customer_unique_id as customer_id,
    customer_zip_code_prefix,
    customer_city,
    customer_state
from {{ source('landing', 'customers') }}
