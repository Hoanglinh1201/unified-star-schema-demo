select
    customer_id as _key_customer_id,
    customer_id
from {{ ref('stg_customers') }}
