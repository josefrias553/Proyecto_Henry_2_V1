{{ config(materialized='view') }}

with source as (
    select * from {{ source('ecommerce', 'ordenesmetodospago') }}
),
renamed as (
    select
        orden_metodo_id,
        orden_id,
        metodo_pago_id,
        cast(monto_pagado as numeric(10,2)) as monto_pagado
    from source
)
select * from renamed