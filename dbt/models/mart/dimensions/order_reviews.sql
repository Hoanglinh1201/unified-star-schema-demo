select
    review_id as _key_order_review_id,
    review_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp
from {{ ref('stg_order_reviews') }}
