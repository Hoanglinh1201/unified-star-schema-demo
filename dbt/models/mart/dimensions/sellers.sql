select
    seller_id as _key_seller_id,
    seller_id,
    seller_city,
    seller_state,
    seller_zip_code_prefix
from {{ ref('stg_sellers') }}
