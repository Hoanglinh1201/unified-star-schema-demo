select
    bridge.uss_stage,
    -- orders
    orders.order_id,
    orders.order_status,
    orders.order_purchase_timestamp,
    orders.order_approved_at,
    orders.order_delivered_carrier_date,
    orders.order_delivered_customer_date,
    orders.order_estimated_delivery_date,
    -- order items
    items.order_item_id,
    items.shipping_limit_date,
    items.price,
    items.freight_value,
    -- customers
    customers.customer_id,
    customers.customer_city,
    customers.customer_state,
    customers.customer_zip_code_prefix,

    -- sellers
    sellers.seller_id,
    sellers.seller_city,
    sellers.seller_state,
    sellers.seller_zip_code_prefix,

    -- products
    products.product_id,
    products.product_category_name,
    products.product_name_lenght,
    products.product_description_lenght,
    products.product_photos_qty,
    products.product_weight_g,
    products.product_length_cm,
    products.product_height_cm,
    products.product_width_cm,
    products.product_category_name_english,
    -- reviews
    reviews.review_id,
    reviews.review_score,
    reviews.review_comment_title,
    reviews.review_comment_message,
    reviews.review_creation_date,
    reviews.review_answer_timestamp,
    -- payments
    payments.payment_id,
    payments.payment_type,
    payments.payment_installments,
    payments.payment_value

from {{ ref('bridge_orders') }} as bridge
left join {{ ref('orders') }} as orders
    on bridge._key_order_id = orders._key_order_id
left join {{ ref('customers') }} as customers
    on bridge._key_customer_id = customers._key_customer_id
left join {{ ref('products') }} as products
    on bridge._key_product_id = products._key_product_id
left join {{ ref('sellers') }} as sellers
    on bridge._key_seller_id = sellers._key_seller_id
left join {{ ref('order_reviews') }} as reviews
    on bridge._key_order_review_id = reviews._key_order_review_id
left join {{ ref('order_payments') }} as payments
    on bridge._key_order_payment_id = payments._key_order_payment_id
left join {{ ref('order_items') }} as items
    on bridge._key_order_item_id = items._key_order_item_id
