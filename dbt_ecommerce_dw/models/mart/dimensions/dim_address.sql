{{ config(materialized='incremental', unique_key='address_id') }}

with src as (
    select * from {{ ref('int_address') }}
)

select
    cast(direccion_id as int) as address_id,
    cast(usuario_id as int) as customer_id,
    calle,
    ciudad,
    provincia,
    pais,
    codigo_postal as postal_code,
    true as current_flag,
    current_timestamp as eff_from,
    null as eff_to
from src