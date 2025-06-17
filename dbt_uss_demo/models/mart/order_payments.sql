select
    payment_sequential
        as payment_type,
    payment_installments,
    payment_value,
    md5(
        concat(
            order_id::text,
            payment_sequential::text
        )
    ) as payment_id,
    md5(
        concat(
            order_id::text,
            payment_sequential::text
        )
    ) as _key_payment_id
from {{ source('landing', 'order_payments') }}
