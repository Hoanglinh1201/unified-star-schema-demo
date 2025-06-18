select
    seller_id,
    seller_zip_code_prefix as geolocation_id,
    null as seller_name,
    null as seller_phone,
    null as seller_email
from {{ source('olist', 'sellers') }}
