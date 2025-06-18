select
    user_id as _key_user_id,
    user_id,
    user_name,
    user_email,
    user_phone
from {{ ref('stg_users') }}
