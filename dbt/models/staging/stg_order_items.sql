select
    order_id,
    order_item_id as sequential_item_number,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value,
    md5(
        concat(
            cast(order_id as string),
            cast(order_item_id as string)
        )
    ) as order_item_id
from {{ source('olist', 'order_items') }}
