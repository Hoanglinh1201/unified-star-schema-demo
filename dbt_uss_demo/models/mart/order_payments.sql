select
    _key_payment_id as payment_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value,
    md5(
        concat(
            order_id::text,
            payment_sequential::text
        )
    ) as _key_payment_id
from {{ source('landing', 'order_payments') }}
