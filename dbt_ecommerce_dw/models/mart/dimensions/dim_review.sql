{{ config(materialized='incremental', unique_key='review_id') }}

with src as (
    select * from {{ ref('int_review') }}
),
dim_customer as (
    select customer_id, customer_sk from {{ ref('dim_customer') }} where current_flag = true
),
dim_product as (
    select product_id, product_sk from {{ ref('dim_product') }} where current_flag = true
),
scd as (
    select
        src.resena_id as review_id,
        dp.product_sk,
        dc.customer_sk,
        src.calificacion as rating,
        src.comment_length,
        cast(src.fecha as date) as review_date
    from src
    left join dim_customer dc on src.usuario_id = dc.customer_id
    left join dim_product dp on src.producto_id = dp.product_id
)
select * from scd