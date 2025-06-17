select
    _key_order_item_id as order_item_id,
    shipping_limit_date,
    price,
    freight_value,
    md5(
        concat(
            cast(order_id as string),
            cast(order_item_id as string)
        )
    ) as _key_order_item_id
from {{ source('landing', 'order_items') }}
