{{ config(materialized='view') }}

with source as (
    select * from {{ source('ecommerce', 'usuarios') }}
),
renamed as (
    select
        usuario_id,
        lower(nombre) as nombre,
        lower(apellido) as apellido,
        dni,
        lower(email) as email,
        contrasena,
        cast(fecha_registro as timestamp) as fecha_registro
    from source
)
select * from renamed