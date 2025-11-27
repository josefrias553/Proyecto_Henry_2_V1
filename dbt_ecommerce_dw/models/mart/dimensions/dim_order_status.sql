{{ config(materialized='incremental', unique_key='status_code') }}

with src as (
    select distinct lower(estado) as status_code
    from {{ ref('stg_ordenes') }}
)

select
    src.status_code,
    case src.status_code
        when 'pendiente' then 'Orden pendiente'
        when 'procesando' then 'Orden en proceso'
        when 'completada' then 'Orden completada'
        else 'Otro estado'
    end as description
from src
