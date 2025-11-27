{{ config(materialized='view') }}

with source as (
    select * from {{ source('ecommerce', 'carrito') }}
),
renamed as (
    select
        carrito_id,
        usuario_id,
        producto_id,
        cast(cantidad as integer) as cantidad,
        cast(fecha_agregado as timestamp) as fecha_agregado
    from source
)
select * from renamed