select
    seller_id as _key_seller_id,
    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state
from {{ source('landing', 'sellers') }}
