{{ config(materialized='incremental', unique_key='product_id') }}

with src as (
    select * from {{ ref('int_product') }}
),
dim_category as (
    select category_id, category_sk
    from {{ ref('dim_category') }}
),
scd as (
    select
        p.producto_id as product_id,
        p.nombre as name,
        p.descripcion,
        dc.category_sk,
        p.categoria_nombre,
        p.precio as current_price,
        p.active_flag,
        true as current_flag,
        current_timestamp as eff_from,
        null as eff_to
    from src p
    left join dim_category dc on p.categoria_id = dc.category_id
)
select * from scd