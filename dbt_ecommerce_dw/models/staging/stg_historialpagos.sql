{{ config(materialized='view') }}

with source as (
    select * from {{ source('ecommerce', 'historialpagos') }}
),
renamed as (
    select
        pago_id,
        orden_id,
        metodo_pago_id,
        cast(monto as numeric(10,2)) as monto,
        cast(fecha_pago as timestamp) as fecha_pago,
        lower(estado_pago) as estado_pago
    from source
)
select * from renamed