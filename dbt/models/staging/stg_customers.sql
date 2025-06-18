select
    customer_id,
    customer_unique_id as user_id,
    customer_zip_code_prefix as geolocation_id
from {{ source('olist', 'customers') }}
