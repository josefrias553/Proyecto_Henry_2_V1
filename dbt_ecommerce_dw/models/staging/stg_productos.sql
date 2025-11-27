{{ config(materialized='view') }}

with source as (
    select * from {{ source('ecommerce', 'productos') }}
),
renamed as (
    select
        producto_id,
        lower(nombre) as nombre,
        lower(descripcion) as descripcion,
        cast(precio as numeric(10,2)) as precio,
        cast(stock as integer) as stock,
        categoria_id
    from source
)
select * from renamed