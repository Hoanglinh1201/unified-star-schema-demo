select
    p.product_id,
    p.product_category_name,
    p.product_name_lenght,
    p.product_description_lenght,
    p.product_photos_qty,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm,
    pcnt.product_category_name_english
from {{ source('olist', 'products') }} as p
left join {{ source('olist', 'product_category_name_translation') }} as pcnt
    on p.product_category_name = pcnt.product_category_name
