select
    seller_id as _key_seller_id,
    seller_id
from {{ ref('stg_sellers') }}
