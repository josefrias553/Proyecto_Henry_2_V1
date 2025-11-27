{{ config(materialized='view') }}

with source as (
    select * from {{ source('ecommerce', 'categorias') }}
),
renamed as (
    select
        categoria_id,
        lower(nombre) as nombre,
        lower(descripcion) as descripcion
    from source
)
select * from renamed