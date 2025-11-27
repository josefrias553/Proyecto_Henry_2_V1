{{ config(materialized='view') }}

with source as (
    select * from {{ source('ecommerce', 'detalleordenes') }}
),
renamed as (
    select
        detalle_id,
        orden_id,
        producto_id,
        cast(cantidad as integer) as cantidad,
        cast(precio_unitario as numeric(10,2)) as precio_unitario
    from source
)
select * from renamed