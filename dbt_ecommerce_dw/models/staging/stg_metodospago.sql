{{ config(materialized='view') }}

with source as (
    select * from {{ source('ecommerce', 'metodospago') }}
),
renamed as (
    select
        metodo_pago_id,
        lower(nombre) as nombre,
        lower(descripcion) as descripcion
    from source
)
select * from renamed