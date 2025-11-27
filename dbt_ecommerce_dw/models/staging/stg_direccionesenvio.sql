{{ config(materialized='view') }}

with source as (
    select * from {{ source('ecommerce', 'direccionesenvio') }}
),
renamed as (
    select
        direccion_id,
        usuario_id,
        lower(calle) as calle,
        lower(ciudad) as ciudad,
        lower(departamento) as departamento,
        lower(provincia) as provincia,
        lower(distrito) as distrito,
        lower(estado) as estado,
        lower(codigo_postal) as codigo_postal,
        lower(pais) as pais
    from source
)
select * from renamed