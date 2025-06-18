select
    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value,
    md5(
        concat(
            order_id::text,
            payment_sequential::text
        )
    ) as payment_id

from {{ source('olist', 'order_payments') }}
