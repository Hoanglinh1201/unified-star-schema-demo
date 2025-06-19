select
    customer_id as _key_customer_id,
    customer_id,
    customer_city,
    customer_state,
    customer_zip_code_prefix
from {{ ref('stg_customers') }}
