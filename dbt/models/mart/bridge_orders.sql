{{
    config(
        materialized='ephemeral'
    )
}}

with
/*
-- Bridge Keys
_key_order_id
_key_product_id
_key_order_item_id
_key_order_payment_id
_key_order_review_id
_key_seller_id
_key_customer_id
_key_user_id
*/
orders as (

    select
        'Order' as uss_stage,
        order_id as _key_order_id,
        null as _key_product_id,
        null as _key_order_item_id,
        null as _key_order_payment_id,
        null as _key_order_review_id,
        null as _key_seller_id,
        customer_id as _key_customer_id,
        null as _key_user_id
    from {{ ref('stg_orders') }}

),

customers as (
    select
        'Customer' as uss_stage,
        null as _key_order_id,
        null as _key_product_id,
        null as _key_order_item_id,
        null as _key_order_payment_id,
        null as _key_order_review_id,
        null as _key_seller_id,
        customer_id as _key_customer_id,
        user_id as _key_user_id
    from {{ ref('stg_customers') }}
),

sellers as (
    select
        'Seller' as uss_stage,
        null as _key_order_id,
        null as _key_product_id,
        null as _key_order_item_id,
        null as _key_order_payment_id,
        null as _key_order_review_id,
        seller_id as _key_seller_id,
        null as _key_customer_id,
        null as _key_user_id
    from {{ ref('stg_sellers') }}
),

order_payments as (
    select
        'Order Payment' as uss_stage,
        order_id as _key_order_id,
        null as _key_product_id,
        null as _key_order_item_id,
        payment_id as _key_order_payment_id,
        null as _key_order_review_id,
        null as _key_seller_id,
        null as _key_customer_id,
        null as _key_user_id
    from {{ ref('stg_order_payments') }}
),

order_reviews as (
    select
        'Order Review' as uss_stage,
        order_id as _key_order_id,
        null as _key_product_id,
        null as _key_order_item_id,
        null as _key_order_payment_id,
        review_id as _key_order_review_id,
        null as _key_seller_id,
        null as _key_customer_id,
        null as _key_user_id
    from {{ ref('stg_order_reviews') }}
),

order_items as (
    select
        'Order Item' as uss_stage,
        order_id as _key_order_id,
        product_id as _key_product_id,
        order_item_id as _key_order_item_id,
        null as _key_order_payment_id,
        null as _key_order_review_id,
        seller_id as _key_seller_id,
        null as _key_customer_id,
        null as _key_user_id
    from {{ ref('stg_order_items') }}
),

users as (
    select
        'User' as uss_stage,
        null as _key_order_id,
        null as _key_product_id,
        null as _key_order_item_id,
        null as _key_order_payment_id,
        null as _key_order_review_id,
        null as _key_seller_id,
        null as _key_customer_id,
        user_id as _key_user_id
    from {{ ref('stg_users') }}

),

products as (
    select
        'Product' as uss_stage,
        null as _key_order_id,
        product_id as _key_product_id,
        null as _key_order_item_id,
        null as _key_order_payment_id,
        null as _key_order_review_id,
        null as _key_seller_id,
        null as _key_customer_id,
        null as _key_user_id
    from {{ ref('stg_products') }}
)

select * from orders
union
select * from products
union
select * from customers
union
select * from sellers
union
select * from order_payments
union
select * from order_reviews
union
select * from order_items
union
select * from users
