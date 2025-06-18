select
    payment_id as _key_order_payment_id,
    payment_id,
    payment_type,
    payment_installments,
    payment_value
from {{ ref('stg_order_payments') }}
