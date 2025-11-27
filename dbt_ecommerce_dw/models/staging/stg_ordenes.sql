{{ config(materialized='view') }}

with source as (
    select * from {{ source('ecommerce', 'ordenes') }}
),
renamed as (
    select
        orden_id,
        usuario_id,
        cast(fecha_orden as timestamp) as fecha_orden,
        cast(total as numeric(10,2)) as total,
        lower(estado) as estado
    from source
)
select * from renamed