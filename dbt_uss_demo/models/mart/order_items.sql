select
    order_item_id as _key_order_item_id,
    order_item_id,
    shipping_limit_date,
    price,
    freight_value
from {{ ref('stg_order_items') }}
