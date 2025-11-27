{{ config(materialized='view') }}

with source as (
    select * from {{ source('ecommerce', 'resenasproductos') }}
),
renamed as (
    select
        resena_id,
        usuario_id,
        producto_id,
        cast(calificacion as integer) as calificacion,
        lower(comentario) as comentario,
        cast(fecha as timestamp) as fecha
    from source
)
select * from renamed